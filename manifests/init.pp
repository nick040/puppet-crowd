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
# Author Name <nick van der veeken>
#
# === Copyright
#
# Copyright 2013-2015 Merritt Krakowitzer
#
class crowd (

  # Crowd settings
  $version      = '2.7.0',
  $product      = 'crowd',
  $format       = 'tar.gz',
  $installdir   = '/opt/crowd',
  $homedir      = '/home/crowd',
  $user         = 'root',
  $group        = 'root',
  $shell        = '/sbin/nologin',

  # JVM settings
  $javahome,
  $java_opts    = '',
  $jvm_xms      = '256m',
  $jvm_xmx      = '512m',
  $jvm_permgen  = '256m',
  $jvm_support_recommended_args = '-XX:-HeapDumpOnOutOfMemoryError',

  # Tomcat settings
  $tomcat_port         = 8095,
  $tomcat_max_threads  = 150,
  $tomcat_accept_count = 100,
  # Reverse https proxy setting for tomcat
  $tomcat_proxy        = {},
  $tomcat_context_path = '',
  # Any additional tomcat params for server.xml
  $tomcat_extras       = {},

  # Database settings
  $db           = 'postgresql',
  $dbuser       = 'crowd',
  $dbpassword   = 'crowd123',
  $dbserver     = 'localhost',
  $dbname       = 'crowd',
  $dbport       = '5432',
  $dbdriver     = 'org.postgresql.Driver',
  $dbtype       = 'postgres72',
  $poolsize     = '15',

  # Misc Settings
  $downloadURL  = 'http://www.atlassian.com/software/crowd/downloads/binary/',

 # Manage service
  $service_name   = 'crowd',
  $service_manage = true,
  $service_ensure = running,
  $service_enable = true,

) {

  $webappdir    = "${installdir}/atlassian-${product}-${version}"
  $dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"

  anchor { 'crowd::start': } ->
  class { '::crowd::install': } ->
  class { '::crowd::config': } ~>
  class { '::crowd::service': } ->
  anchor { 'crowd::end': }

}
