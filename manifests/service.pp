# == Class: crowd::service
#
# Manage the service for crowd. Parameters defined through init.pp
#
class crowd::service {
  if $crowd::service_manage {
    file { "/etc/init.d/${crowd::service_name}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template('crowd/crowd-init.sh.erb'),
    }
    ->
    service { $crowd::service_name:
      ensure    => $crowd::service_ensure,
      enable    => $crowd::service_enable,
      require   => Class['crowd::config'],
    }
  }
}
