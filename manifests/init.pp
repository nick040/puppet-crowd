# == Class: crowd
#
# Installs Atlassian Crowd
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
# Author Name <merritt@krakowitzer.com>
# Author Name <jvantonder@fnb.co.za>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class crowd (

  # JVM Settings
  $javahome,

  # Crowd Settings
  $version      = '2.7.0',
  $product      = 'crowd',
  $format       = 'tar.gz',
  $installdir   = '/opt/crowd',
  $homedir      = '/home/crowd',
  $user         = 'root',
  $group        = 'root',
  $uid          = '502',
  $gid          = '502',

# TODO: Configure the database as part of install
#  # Database Settings
#  $db           = 'postgresql',
#  $dbuser       = 'crowdadm',
#  $dbpassword   = 'mypassword',
#  $dbserver     = 'localhost',
#  $dbname       = 'crowd',
#  $dbport       = '5432',
#  $dbdriver     = 'org.postgresql.Driver',
#  $dbtype       = 'postgres72',
#  $poolsize     = '15',

  # Misc Settings
  $downloadURL  = 'http://www.atlassian.com/software/crowd/downloads/binary/',

  $manage_service = true,

) {

  $webappdir    = "${installdir}/atlassian-${product}-${version}"
# TODO:  $dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"

  include crowd::install
  include crowd::config
  include crowd::service

}
