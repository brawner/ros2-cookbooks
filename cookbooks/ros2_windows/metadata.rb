name 'ros2_windows'
maintainer 'Stephen Brawner'
maintainer_email 'brawner@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures ros2_windows'
long_description 'Installs/Configures ros2_windows'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/osrf/chef-osrf/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/osrf/chef-osrf'
depends 'chocolatey', '3.0.0'
depends 'seven_zip', '3.2.0'
