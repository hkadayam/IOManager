set -eu

echo -n "Installing ELF tools..."
sudo apt-get install -y python3-pyelftools libaio-dev > /dev/null
#pipx install pyelftools > /dev/null
python -m pip install pyelftools > /dev/null
echo "done."


conan_major=`conan --version | awk '{print $3}' | awk -F'.' '{print $1}'`
echo "Using conan major version: ${conan_major}"

echo -n "Exporting custom recipes..."
if [ $conan_major -eq 1 ] ; then
    echo -n "dpdk."
    conan export 3rd_party/dpdk dpdk/nbi.21.05@
    echo -n "fio."
    conan export 3rd_party/fio fio/nbi.3.28@
    echo -n "spdk."
    conan export 3rd_party/spdk spdk/nbi.21.07.y@
    echo -n "pistache."
    conan export 3rd_party/pistache pistache/nbi.0.0.5.1@
else
    echo -n "dpdk."
    conan export --version nbi.21.05 3rd_party/dpdk 
    echo -n "fio."
    conan export --version nbi.3.28 3rd_party/fio
    echo -n "spdk."
    conan export --version nbi.21.07.y 3rd_party/spdk
    echo -n "pistache."
    conan export --version nbi.0.0.5 3rd_party/pistache
fi

echo "done."
