# encoding: utf-8
control '1' do
	impact 'critical'
	title 'Install Apache'
	desc ''
	tag duration: '10'
    tag help: ''
	describe package('apache2') do
		it { should be_installed }
	end
end

control '2' do
	impact 'critical'
	title 'Setup Apache service'
	desc ''
	tag duration: '5'
    tag help: ''
	describe service('apache2') do
		it { should be_installed }
		it { should be_enabled }
		it { should be_running }
	end
end

control '3' do
	impact 'critical'
	title 'Serve HTTP'
	desc ''
	tag duration: '5'
    tag help: ''
	describe port(80) do
		it { should be_listening }
	end
	describe http('http://localhost', ssl_verify: false) do
		its('status') { should eq 200 }
		its('body') { should match /Hello World!/ }
		its('headers.Content-Type') { should cmp 'text/html' }
	end
end
control '4' do
	impact 'critical'
	title 'Serve HTTPS'
	desc ''
	tag duration: '5'
    tag help: ''
	describe port(443) do
		it { should be_listening }
	end
	describe http('https://localhost', ssl_verify: false) do
		its('status') { should eq 200 }
		its('body') { should match /Hello World!/ }
		its('headers.Content-Type') { should cmp 'text/html' }
	end
end
