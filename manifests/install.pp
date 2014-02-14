# == Class: crowd::install
#
# Full description of class crowd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { crowd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class crowd::install {

  require crowd

  deploy::file { "atlassian-${crowd::product}-${crowd::version}.${crowd::format}":
    target  => $crowd::webappdir,
    url     => $crowd::downloadURL,
    strip   => true,
    notify  => Exec["chown_${crowd::webappdir}"],
  } ->
  group { $crowd::user: ensure => present, gid => $crowd::gid } ->
  user { $crowd::user:
    comment          => 'Crowd daemon account',
    shell            => '/bin/bash',
    home             => $crowd::homedir,
    password         => '*',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
    system           => true,
    uid              => $crowd::uid,
    gid              => $crowd::gid,
  } ->
  file { $crowd::homedir:
    ensure  => 'directory',
    owner   => $crowd::user,
    group   => $crowd::group,
    recurse => true,
  } ->
  exec { "chown_${crowd::webappdir}":
    command     => "/bin/chown -R ${crowd::user}:${crowd::group} ${crowd::webappdir}",
    refreshonly => true,
    subscribe   => User[$crowd::user]
  }
}
