#
# Cookbook:: adaptec_storman
# Recipe:: cmdline
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

  # Installation of the command line tools
  if node['adaptec_storman']['source_files'][card_type].attribute?('cmdline') &&
     node['adaptec_storman']['source_files'][card_type]['cmdline'].attribute?(source_key)
    # Determine the source file to be extracted.
    source_file = node['adaptec_storman']['source_files'][card_type]['cmdline'][source_key]

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
      log 'This platform does not provide a supported installation package for the command line utilities' do
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
