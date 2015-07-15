name             'mturkgrind'
maintainer       'Jeff LaPlante'
maintainer_email 'jeff@jefflaplante.com'
license          'All rights reserved'
description      'Installs/Configures web host for mturkgrind.com'
version          '0.0.1'

# Community cookbooks

# Base dependencies for all nodes
depends 'hostname'
depends 'apt'
depends 'chef-client'
depends 'build-essential'
depends 'git'
depends 'motd-tail'
depends 'ntp'
depends 'postfix'
depends 'logrotate'

# Application specific dependencies
# depends 'haproxy'
depends 'varnish'
depends 'nginx'
depends 'php-fpm'
depends 'mysql'
depends 'redis'
