class haxe::download (
    $link = $haxe::params::link,
    $file = $haxe::params::file
) inherits haxe::params {
    exec { "download-haxe" :
        command => "wget ${link} -P /tmp/",
        notify  => Class["haxe::install"],
    }
}

class haxe::install (
    $file = $haxe::params::file
) inherits haxe::params {
    exec { "install-haxe" :
        command => "tar -xvzf /tmp/${file} -C /tmp/ && sh /tmp/install-haxe.sh -y",
        require => Class["haxe::download"],
    }
}

class haxe {
    include haxe::download
    include haxe::install
}