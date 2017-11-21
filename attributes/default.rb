# Version for an Adaptec 6445 and similar cards.
node.default['adaptec_storman']['source_url'] = 'http://download.adaptec.com/raid/storage_manager/msm_linux_x64_v2_05_22932.tgz'
node.default['adaptec_storman']['install_manager'] = true
node.default['adaptec_storman']['install_cmdline'] = true

# This should match an entry under node['adaptec_storman']['source_files'], e.g. '6445', '6405', etc.
node.default['adaptec_storman']['card_type'] = '6445'

node.default['adaptec_storman']['source_files']['6445']['manager'] = {
  'debian-x86_64' => 'msm/manager/StorMan-2.05-22932_amd64.deb',
  'debian-ppc64' => 'msm/manager/StorMan_2.05-22932_ppc64el.deb',
  'redhat-ppc64' => 'msm/manager/StorMan-2.05-22932.ppc64le.rpm',
  'other-x86_64' => 'msm/manager/StorMan-2.05-22932.x86_64.bin',
  'redhat-x86_64' => 'msm/manager/StorMan-2.05-22932.x86_64.rpm'
}

node.default['adaptec_storman']['source_files']['6445']['cmdline'] = {
  'redhat-x86_64' => 'msm/cmdline/rpm/Arcconf-2.05-22932.ppc64le.rpm',
  'redhat-ppc64' => 'msm/cmdline/rpm/Arcconf-2.05-22932.x86_64.rpm'
}
