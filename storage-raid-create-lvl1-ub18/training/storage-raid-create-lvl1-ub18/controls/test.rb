# encoding: utf-8

control '1' do
	impact 'critical'
	title 'mdadm installed'
	desc ''
	tag duration: '2'
    tag help: ''
	describe package('mdadm') do
		it { should be_installed }
	end
end

control '2' do
	impact 'critical'
	title 'md0 created'
	desc ''
	tag duration: '10'
    tag help: ''

    describe command('/sbin/mdadm /dev/md0') do
        its('stdout') { should match /raid1 2 devices/ }
    end
end

control '3' do
	impact 'critical'
	title 'md0 clean'
	desc ''
	tag duration: '0'
    tag help: ''

    describe command('/sbin/mdadm --misc --test /dev/md0') do
        its('exit_status') { should eq 0 }
    end
end

control '4' do
	impact 'critical'
	title 'filesystem is btrfs'
	desc ''
	tag duration: '5'
    tag help: ''

    describe filesystem('/dev/md0') do
      its('type') { should cmp 'btrfs' }
      its('size_kb') { should be >= 900 * 1024}
      its('percent_free') { should be >= 80 }
    end
end


control '5' do
	impact 'critical'
	title 'mount persistent across reboot'
	desc ''
	tag duration: '10'
    tag help: ''

    describe etc_fstab.where { mount_point == '/data' } do
      it { should be_configured }
      its('device_name') { should_not cmp '/dev/md0' }
      its('file_system_type') { should cmp 'btrfs' }
      its('mount_options') { should eq [['defaults']] }
      its('dump_options') { should cmp 0 }
    end
end

