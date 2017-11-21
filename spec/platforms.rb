def source_files
  {
    'chefspec' => {
      'manager' => {
        'debian-x86_64' => 'msm/manager/StorMan-2.05-22932_amd64.deb',
        # Purposely excluding Debian PPC64 so as to test logging when the appropriate package does not exist
        # 'debian-ppc64' => 'msm/manager/StorMan_2.05-22932_ppc64el.deb',
        'redhat-ppc64' => 'msm/manager/StorMan-2.05-22932.ppc64le.rpm',
        'other-x86_64' => 'msm/manager/StorMan-2.05-22932.x86_64.bin',
        'redhat-x86_64' => 'msm/manager/StorMan-2.05-22932.x86_64.rpm'
      },
      'cmdline' => {
        'redhat-x86_64' => 'msm/cmdline/rpm/Arcconf-2.05-22932.ppc64le.rpm',
        'redhat-ppc64' => 'msm/cmdline/rpm/Arcconf-2.05-22932.x86_64.rpm'
      }
    }
  }
end

def platforms
  {
    'ubuntu' => {
      'platform_family' => 'debian',
      'versions' => ['16.04'],
      'cpus' => %w[GenuineIntel PowerPC],
      'source_files' => source_files
    },
    # For testing 'other', which should log an error message that installation from the .bin file is not yet supported.
    'amazon' => {
      'platform_family' => 'amazon',
      'versions' => ['2017.09'],
      'cpus' => %w[GenuineIntel PowerPC],
      'source_files' => source_files
    },
    'centos' => {
      'platform_family' => 'rhel',
      'versions' => ['6.9', '7.4.1708'],
      'cpus' => %w[GenuineIntel PowerPC],
      'source_files' => source_files
    },
    'oracle' => {
      'platform_family' => 'rhel',
      'versions' => ['6.9', '7.4'],
      'cpus' => %w[GenuineIntel PowerPC],
      'source_files' => source_files
    }
  }
end
