#
# Cookbook:: adaptec_storman
# Recipe:: cmdline
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

# Installation of the command line tools
if node['adaptec_storman']['source_files'][card_type].attribute?('cmdline')
  if node['adaptec_storman']['source_files'][card_type]['cmdline'].attribute?(source_key)
    source_file = node['adaptec_storman']['source_files'][card_type]['cmdline'][source_key]

    ark 'adaptec_storman' do
      source node['adaptec_storman']['source_url']
      path '/tmp'
      creates source_file
    end

    if source_file =~ /\.(deb|rpm)$/
      package "/tmp/#{file_name}" do
        action :install
      end
    else
      Chef::Log.error('This platform does not provide a supported installation package for the command line utilities')
    end
  end
end
