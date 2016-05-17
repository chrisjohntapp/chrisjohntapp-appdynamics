# appdynamics puppet module

## Overview

Module to install and configure AppDynamics agents from locally-built .deb packages

## Module Description

This module attempts to install and configure AppDynamics agents.  Currently
only Ubuntu 14.04 is supported though the module will be expanded to Windows
and eventually to other Linux distros.

It provides default values for all parameters, but the design goal is to provide
users with the ability to change all key settings from hiera, using the roles /
profiles paradigm.

This module requires the AppDynamics agents to be packaged into .deb packages,
available in an enabled repository. Packages must obey the naming convention
appdynamics-${agent_type}-agent.deb.  Package types are 'db', 'java', 'machine',
and 'php'.

The module uses the concept of an 'agent_type'.  This does not refer to the
AppDynamics agent type, but a higher-level object which may or may not map
directly to an AppDynamics agent type.  For example the 'db' agent_type maps
directly to the AppDynamics database agent, but the 'jboss' and 'tomcat'
agent_types both utilise the AppDynamics Java appserver agent.

### Beginning with AppDynamics

The module assumes that the node will have a top-scope array set ($agent_types)
which defines zero or more agent_types.  This could be set via an ENC or a
custom fact. In testing, an ENC was used.  Currently supported options are 'db',
'jboss', 'machine', 'php', 'tomcat'.  More options will likely be added in
future.

### Usage

Make the following class declaration to use defaults:

```puppet
class { 'appdynamics::agent': }
```

To override the install/runtime directories for the db agent:

```puppet
  class { 'appdynamics::agent':
    db_agent_base                       =>  '/usr/local/',
    db_agent_home                       =>  'appd_dbagent',
}
```

To set controller settings for machine agent:
```puppet
  class { 'appdynamics::agent':
    machine_app                         =>  'Web',
    machine_tier                        =>  'Frontend',
    machine_controller_host             =>  'ad.controller.example.com',
    machine_controller_port             =>  8080,
    machine_account_name                =>  'abc',
    machine_account_access_key          =>  'abc123abc123',
}
```

All configuration settings are visible in params.pp.

### Supported Operating Systems

Currently this module only supports Ubuntu 14.04.

### Limitations

This module is very young and in active development.  PHP agent functionality is
least tested currently.

TODO: Requires better tests.
Currently only basic smoke tests are included.

TODO: enable installation of specific package versions.
Currently package version is specified for all packages with one parameter,
therefore individual package versions cannot be specified.

If using tomcat, this module only supports one tomcat instance.