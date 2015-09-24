# == Class: crowd::config 
#
#   Configure Crowd.
#
class crowd::config(
  $tomcat_port         = $crowd::tomcat_port,
  $tomcat_max_threads  = $crowd::tomcat_max_threads,
  $tomcat_accept_count = $crowd::tomcat_accept_count,
  $tomcat_proxy        = $crowd::tomcat_proxy,
  $tomcat_extras       = $crowd::tomcat_extras,
  $tomcat_context_path = $crowd::tomcat_context_path,
)  {

  File {
    owner => $crowd::user,
    group => $crowd::group,
  }

  file { "${crowd::webappdir}/crowd-webapp/WEB-INF/classes/crowd-init.properties":
    content => template('crowd/crowd-init.properties.erb'),
    mode    => '0644',
  }

  file {"${crowd::webappdir}/apache-tomcat/bin/setenv.sh":
    ensure  => present,
    content => template('crowd/setenv.sh.erb'),
    mode    => '0755',
  }
  
  file { "${crowd::webappdir}/apache-tomcat/conf/server.xml":
      content => template('crowd/server.xml.erb'),
      mode    => '0600',
  }
}
