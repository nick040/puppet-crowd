puppet-crowd
=================

This is a puppet module to install crowd

Requirements
------------
* Puppet 3.0+ tested 
* Puppet 2.7+
* dependency 'mkrakowitzer/deploy', '>= 0.0.1'

Example
-------
```puppet
  class { 'crowd':
    version        => '2.7.1',
    installdir     => '/opt/atlassian/atlassian-crowd',
    homedir        => '/opt/atlassian/application-data/crowd-home',
    user           => 'crowd',
    group          => 'crowd',
    javahome       => '/opt/java',
  }
```
Paramaters
----------
TODO

License
-------
The MIT License (MIT)

Contact
-------
Merritt Krakowitzer merritt@krakowitzer.com

Support
-------

Please log tickets and issues at our [Projects site](http://github.com/mkrakowitzer/puppet-crowd)
