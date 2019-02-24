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


control '1' do
	impact 'critical'
	title 'md0 created'
	desc ''
	tag duration: '10'
    tag help: ''
    describe filesystem('/mdadm') do
      its('type') { should cmp 'ext4' }
    end
end
