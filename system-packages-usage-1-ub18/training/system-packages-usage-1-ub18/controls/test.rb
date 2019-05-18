# encoding: utf-8

# Add all tests in here
# Add a seperate test for each small task/stop

#control '1' do
#	impact 'critical'
#	title 'Install Apache' # task description
#	desc '' # detailed descriotion
#	tag duration: '10' # estimated time to complete task in min
#  tag help: '' # optional URL to help
#
#	describe package('apache2') do
#		it { should be_installed }
#	end
#	describe service('apache2') do
#		it { should be_installed }
#		it { should be_enabled }
#		it { should be_running }
#	end
#	describe port(80) do
#		it { should be_listening }
#	end
#	describe http('http://localhost', ssl_verify: false) do
#		its('status') { should eq 200 }
#		its('body') { should match /Hello World!/ }
#		its('headers.Content-Type') { should cmp 'text/html' }
#	end
#end

control '1' do
	impact 'critical'
	title 'Remove nano'
	desc '' # detailed descriotion
	tag duration: '5' # estimated time to complete task in min
    tag help: '' # optional URL to help

	describe package('nano') do
		it { should_not be_installed }
	end

end

control '2' do
	impact 'critical'
	title 'Install nginx 1.5.x'
	desc '' # detailed description
	tag duration: '10' # estimated time to complete task in min
    tag help: '' # optional URL to help

	describe package('nginx') do
		it { should be_installed }
		its('version') { should cmp >= "1.15.0-0+bionic0" }
	end

end

control '3' do
	impact 'critical'
	title 'Purge apache2'
	desc '' # detailed description
	tag duration: '15' # estimated time to complete task in min
    tag help: '' # optional URL to help

	describe package('apache2') do
		it { should_not be_installed }
	end
	describe package('apache2-bin') do
		it { should_not be_installed }
	end
    describe package('apache2-utils') do
		it { should_not be_installed }
	end
	describe package('apache2-data') do
		it { should_not be_installed }
	end

    describe file('/etc/apache2') do
        it { should_not exist }
    end
    describe file('/var/lib/apache2') do
        it { should_not exist }
    end
end

control '4' do
	impact 'critical'
	title 'Restore /etc/crontab'
	desc '' # detailed description
	tag duration: '15' # estimated time to complete task in min
    tag help: '' # optional URL to help

    describe file('/etc/crontab') do
        it { should exist }
        its('md5sum') { should eq '8f111d100ea459f68d333d63a8ef2205' }
    end
    describe file('/etc/crontab.backup') do
        it { should exist }
        its('md5sum') { should eq '8e87cc59e9912032a41c13358665f3fa' }
    end
end