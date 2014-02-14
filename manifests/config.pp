# == Class: crowd::config 
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
class crowd::config {

  File {
    owner => $crowd::user,
    group => $crowd::group,
  }

  file { "${::homedir}/logs":
    ensure  => directory,
  } ->

  file { "${crowd::webappdir}/crowd-webapp/WEB-INF/classes/crowd-init.properties":
    content => template('crowd/crowd-init.properties.erb'),
    mode    => '0644',
  } ~>

  file {"${crowd::webappdir}/apache-tomcat/bin/setenv.sh":
    ensure  => present,
    content => template('crowd/setenv.sh.erb'),
    mode    => '0755',
  } ~>

  file { "${crowd::webappdir}/crowd.sh":
    ensure  => present,
    content => template('crowd/crowd.sh.erb'),
    mode    => '0700'
  } ~>

  file { '/etc/init.d/crowd':
    ensure => link,
    target => "${crowd::webappdir}/crowd.sh",
  }

}
