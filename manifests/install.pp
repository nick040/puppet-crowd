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
class crowd::install {

  require staging
  
  $package_source = "atlassian-${crowd::product}-${crowd::version}.${crowd::format}"

  staging::deploy { $package_source:
    source  => "${crowd::downloadURL}/${package_source}",
    target  => $crowd::installdir,
    creates => $crowd::webappdir,
    notify  => Exec["chown_${crowd::webappdir}"],
  }
  ->
  user { $crowd::user:
    shell            => $crowd::shell,
    password         => '*',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
    system           => true,
  }
  ->
  file { $crowd::homedir:
    ensure  => 'directory',
    owner   => $crowd::user,
    group   => $crowd::group,
  }
  ->
  exec { "chown_${crowd::webappdir}":
    command     => "/bin/chown -R ${crowd::user}:${crowd::group} ${crowd::webappdir}",
    refreshonly => true,
    subscribe   => User[$crowd::user]
  }
}
