name             'growthforecast'
maintainer       'futoase'
maintainer_email 'info@aiming-inc.com'
license          'MIT License.'
description      'Installs/Configures growthforecast'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'yum'
depends          'mysql'
depends          'build-essential'
depends          'perlbrew'

supports         'centos'
