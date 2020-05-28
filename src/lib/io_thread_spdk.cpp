/**
 * Copyright eBay Corporation 2018
 */

#include <sds_logging/logging.h>
#include "include/iomgr.hpp"
#include "include/iomgr_msg.hpp"
#include "include/io_thread_spdk.hpp"
#include <fds/obj_allocator.hpp>
#include <spdk/log.h>
#include <spdk/env.h>
#include <spdk/thread.h>
#include "spdk/bdev.h"

namespace iomgr {
static void _handle_thread_msg(void* _msg) { iomanager.this_reactor()->handle_msg((iomgr_msg*)_msg); }

bool IOReactorSPDK::iocontext_init() {
    // Create SPDK LW thread for this io thread
    m_sthread = spdk_thread_create(NULL, NULL);
    if (m_sthread == nullptr) {
        throw std::runtime_error("SPDK Thread Create failed");
        return false;
    }
    spdk_set_thread(m_sthread);

    // TODO: Add per thread timer object.
    return true;
}

void IOReactorSPDK::listen() { spdk_thread_poll(m_sthread, 0, 0); }

void IOReactorSPDK::iocontext_exit() {
    if (m_sthread) {
        spdk_thread_exit(m_sthread);
        spdk_thread_destroy(m_sthread);
        m_sthread = nullptr;
    }
}

int IOReactorSPDK::_add_iodev_to_reactor(const io_device_ptr& iodev) { return 0; }
int IOReactorSPDK::_remove_iodev_from_reactor(const io_device_ptr& iodev) { return 0; }

bool IOReactorSPDK::put_msg(iomgr_msg* msg) {
    // TODO: Once we support multiple threads, loop and send it to all spdk threads
    deliver_to_thread(m_sthread, msg);
    return true;
}

bool IOReactorSPDK::is_iodev_addable(const io_device_ptr& iodev) const {
    return (iodev->is_spdk_dev() && IOReactor::is_iodev_addable(iodev));
}

void IOReactorSPDK::deliver_to_thread(spdk_thread* to_thread, iomgr_msg* msg) {
    if (msg->m_is_sync_msg) { ((sync_iomgr_msg*)msg)->pending(); }
    spdk_thread_send_msg(to_thread, _handle_thread_msg, msg);
}
} // namespace iomgr