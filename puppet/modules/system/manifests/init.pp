class system {
    #UPDATE PACKAGES
    exec { "apt-update" :
        command => "apt-get update",
    }

    Exec["apt-update"] -> Package <| |>

    #MOTD
    file { "motd" : 
        path    => "/etc/motd",
        ensure  => "present",
        content => template('system/motd.erb'),
    }
}
