# encoding: utf-8

# Add all tests in here
# Add a seperate test for each small task/stop

# control '1' do
# 	impact 'critical'
# 	title 'Install Apache' # task description
# 	desc '' # detailed descriotion
# 	tag duration: '10' # estimated time to complete task in min
#   tag help: '' # optional URL to help
#
# 	describe package('apache2') do
# 		it { should be_installed }
# 	end
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
# end
