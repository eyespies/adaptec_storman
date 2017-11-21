#
# Cookbook:: adaptec_storman
# Recipe:: manager
#
# Copyright:: 2017, Justin Spies, All Rights Reserved.

if node['os'] == 'linux'
  source_prefix = case node['platform_family']
                  when 'debian'
                    'debian'
                  when 'rhel'
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
  if node['adaptec_storman']['source_files'][card_type].attribute?('manager') &&
     node['adaptec_storman']['source_files'][card_type]['manager'].attribute?(source_key)
    # Determine the source file to be installed
    source_file = node['adaptec_storman']['source_files'][card_type]['manager'][source_key]

    ark 'adaptec_storman' do
      url node['adaptec_storman']['source_url']
      path '/tmp'
      creates source_file
      action :cherry_pick
    end

    if source_file =~ /\.(deb|rpm)$/
      package "/tmp/#{source_file}" do
        action :install
      end
    else
      log 'Installation of the manager files via standard binary executable is not yet supported' do
        action :write
        level :error
      end
    end
  else
    log "Installation file #{source_key} does not exist, the Adaptec Storage Manager will not be installed" do
      action :write
      level :error
    end
  end
else
  log "Installation of Adaptec Storage Manager software is currently only supported on Linux systems, #{node['os']} is not currently supported" do
    action :write
    level :error
  end
end
