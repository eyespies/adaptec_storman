name 'adaptec_storman'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures adaptec_storman'
long_description 'Installs/Configures adaptec_storman'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://bitbucket.org/justinspies/adaptec_storman/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://bitbucket.org/justinspies/adaptec_storman/overview' if respond_to?(:source_url)

depends 'ark'

supports 'centos', '>= 6.0'
supports 'redhat', '>= 6.0'
supports 'oracle', '>= 6.0'
