script_folder="/sources/iomgr/3rd_party/spdk"
echo "echo Restoring environment" > "$script_folder/deactivate_conanautotoolstoolchain.sh"
for v in CPPFLAGS CXXFLAGS CFLAGS LDFLAGS PKG_CONFIG_PATH LD_TYPE
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanautotoolstoolchain.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanautotoolstoolchain.sh"
    fi
done


export CPPFLAGS="$CPPFLAGS"
export CXXFLAGS="$CXXFLAGS -std=c++2a -m64 -fPIC -g"
export CFLAGS="$CFLAGS -m64 -fPIC -g -I/home/hkadayam/.conan2/p/b/opens355ba9a3baf11/p/include -I/home/hkadayam/.conan2/p/b/libura0ac657ce7567/p/include"
export LDFLAGS="$LDFLAGS -m64 -L/home/hkadayam/.conan2/p/b/opens355ba9a3baf11/p/lib -L/home/hkadayam/.conan2/p/b/libura0ac657ce7567/p/lib"
export PKG_CONFIG_PATH="/sources/iomgr/3rd_party/spdk:$PKG_CONFIG_PATH"
export LD_TYPE="$LD_TYPE bfd"