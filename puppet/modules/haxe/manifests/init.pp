class haxe::download (
    $link = $haxe::params::link,
    $file = $haxe::params::file
) inherits haxe::params {
    exec { "download-haxe" :
        command => "wget ${link} -P /tmp/",
    }
}

class haxe::install (
    $file = $haxe::params::file
) inherits haxe::params {
    $libpath = "/usr/lib/haxe/lib"

    exec { "install-haxe" :
        command => "tar -xvzf /tmp/${file} -C /tmp/; sh /tmp/install-haxe.sh -y",
        require => Class["haxe::download"],
        returns => 1
    }

    exec { "haxelib-setup" :
        command => "haxelib setup ${libpath}",
        require => Exec["install-haxe"],
    }
}

class haxe {
    include haxe::download
    include haxe::install
}