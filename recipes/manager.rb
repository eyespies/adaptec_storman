#
# Cookbook:: adaptec_storman
# Recipe:: manager
#
# Copyright:: 2017, Justin Spies, All Rights Reserved.

source_prefix = case node['platform_family']
                when 'debian'
                  'debian'
                when 'redhat'
                  'redhat'
                else
                  'other'
                end

source_suffix = case node['cpu']['0']['vendor_id']
                when 'GenuineIntel'
                  'x86_64'
                else
                  'ppc64'
                end

source_key = "#{source_prefix}-#{source_suffix}"
card_type = node['adaptec_storman']['card_type']

# Installation of the web UI / management package
if node['adaptec_storman']['source_files'][card_type].attribute?('manager')
  if node['adaptec_storman']['source_files'][card_type]['manager'].attribute?(source_key)
    source_file = node['adaptec_storman']['source_files'][card_type]['manager'][source_key]

    ark 'adaptec_storman' do
      source node['adaptec_storman']['source_url']
      path '/tmp'
      creates source_file
      only_if { options['install'] }
    end

    if source_file =~ /\.(deb|rpm)$/
      package "/tmp/#{file_name}" do
        action :install
        only_if { options['install'] }
      end
    else
      Chef::Log.error('Installation of the manager files via standard binary executable is not yet supported')
    end
  end
end
