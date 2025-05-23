script_folder="/sources/iomgr/3rd_party/spdk"
echo "echo Restoring environment" > "$script_folder/deactivate_conanautotoolsdeps.sh"
for v in CPPFLAGS LIBS LDFLAGS CXXFLAGS CFLAGS
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanautotoolsdeps.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanautotoolsdeps.sh"
    fi
done


export CPPFLAGS="$CPPFLAGS -I/home/hkadayam/.conan2/p/b/opens355ba9a3baf11/p/include -I/home/hkadayam/.conan2/p/fio4d606b6f46c3c/p/include -I/home/hkadayam/.conan2/p/b/zlib2acc50b9804d4/p/include -I/home/hkadayam/.conan2/p/b/libura0ac657ce7567/p/include -I/home/hkadayam/.conan2/p/dpdk94d4a462035a9/p/include"
export LIBS="$LIBS -lssl -lcrypto -lz -luring -lrte_eal -lrte_timer -lrte_power -lrte_mempool -lrte_ring -lrte_mbuf -lrte_mempool_ring -lrte_telemetry -lrte_bus_pci -lrte_pci -lrte_kvargs -lrte_net -lrte_cryptodev -lrte_ethdev -lrte_rcu -ldl -lpthread -lrt"
export LDFLAGS="$LDFLAGS -L/home/hkadayam/.conan2/p/b/opens355ba9a3baf11/p/lib -L/home/hkadayam/.conan2/p/fio4d606b6f46c3c/p/lib -L/home/hkadayam/.conan2/p/b/zlib2acc50b9804d4/p/lib -L/home/hkadayam/.conan2/p/b/libura0ac657ce7567/p/lib -L/home/hkadayam/.conan2/p/dpdk94d4a462035a9/p/lib"
export CXXFLAGS="$CXXFLAGS"
export CFLAGS="$CFLAGS"