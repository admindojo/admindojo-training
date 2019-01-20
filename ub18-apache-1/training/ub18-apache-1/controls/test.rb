# encoding: utf-8
control '1' do
	impact 'critical'
	title 'Web server'
	desc ''
	tag duration: '10'
	describe package('apache2') do
		it { should be_installed }
	end
	describe service('apache2') do
		it { should be_installed }
		it { should be_enabled }
		it { should be_running }
	end
end
control '2' do
	impact 'critical'
	title 'HTTP'
	desc ''
	tag duration: '5'
	describe port(80) do
		it { should be_listening }
	end
	describe http('http://localhost', ssl_verify: false) do
		its('status') { should eq 200 }
		its('body') { should match /Hello World!/ }
		its('headers.Content-Type') { should cmp 'text/html' }
	end
end
control '3' do
	impact 'critical'
	title 'HTTPS'
	desc ''
	tag duration: '5'
	describe port(443) do
		it { should be_listening }
	end
	describe http('https://localhost', ssl_verify: false) do
		its('status') { should eq 200 }
		its('body') { should match /Hello World!/ }
		its('headers.Content-Type') { should cmp 'text/html' }
	end
end
