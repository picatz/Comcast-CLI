#!/usr/bin/env ruby
# Kent 'picat' Gruber
# Comcast/Xfinity Router Automation

require 'watir-webdriver'
require 'optparse'

def banner
	puts "COMCAST-CLI\n"
end

def version
	puts "Version 1.0"
end

def cls
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

class ComcastBot

	def start
		@router = Watir::Browser.new
		@router.goto 'http://10.0.0.1/'
	end
 
	def refresh
		@router.refresh
	end	
 
	def status
		@router.status
	end	

	def close
		@router.close
	end

	def login(username, password)
		@router.text_field(:id => 'loginUsername').set username
		@router.text_field(:id => 'loginPassword').set password
		@router.button(:value => 'Log In').click
	end

	def login_check
		if @router.text.include? 'Please try again.'
			puts "Login Failed."
		else
		 	puts "Login (probably) Worked!"
		end
	end

	def change_password(password, new_password)
		@router.goto 'http://10.0.0.1/password_change.asp'
		@router.text_field(:id => 'currPassword').set password
		@router.text_field(:id => 'newPassword').set new_password
		@router.text_field(:id => 'reenternewPassword').set new_password
		@router.button(:value => 'Save').click
	end
end

options = {}
optparse = OptionParser.new do |opts|
	opts.banner = "Usage: #{$0} [OPTIONS]"
	opts.separator ""
	opts.separator "Basically a browser bot to automate comcast router things."
	opts.separator "EX: #{$0} -d"
	opts.separator "EX: #{$0} -u admin -p password -l"
	opts.separator ""
	opts.separator "Options: "
	opts.on('-d', '--default', "Use default username/password.") do
		options[:method] = 0
		options[:username] = "admin"
		options[:password] = "password"
  	end
	opts.on('-u', '--username <USERNAME>', "Define username.", String) do | username |
		options[:method] = 1
		options[:username] = username
	end

	opts.on('-p', '--password <PASSWORD>', "Define password.", String) do | password |
		options[:password] = password
  	end
  	opts.on('-n', '--newpass <NEW_PASSWORD>', "Define new password to set.", String) do | new_password |
  		options[:method] = 2
  		if new_password.length > 8 
			options[:new_password] = new_password
		else
			puts "[ WARNING ] New password must be greater than 8 characters!"
			exit
		end
  	end
  	opts.on('-l', '--lol', "Rainbow support, because we need it.") do
    	require 'lolize/auto'
  	end
  	opts.on('-v', '--version', "Show verison number.") do 
    	banner
    	version
    	exit
  	end
  	opts.on('-h', '--help', "Help menu.") do
   		cls
   		banner
   		version
    	puts
    	puts opts
    	puts
    	exit
  	end
end

begin 
	optparse.parse!
	if options[:method].to_i == 0 || options[:method].to_i == 1
		mandatory = [:username,:password]
	elsif options[:method].to_i == 2
		mandatory = [:username,:password,:new_password]
	end
	missing = mandatory.select{ |param| options[param].nil? }
	if not missing.empty?
		banner
	    puts
	    puts "Missing options: #{missing.join(', ')}"
	    puts optparse
	    puts
	    exit
	end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
	cls
	banner
	puts
	puts $!.to_s
	puts
	puts optparse
	puts
	exit
end

banner
admin = ComcastBot.new
admin.start

begin
	case options[:method].to_i
	when 0
		admin.login(options[:username], options[:password])
	when 1
		admin.login(options[:username], options[:password])
	when 2
		admin.login(options[:username], options[:password])
		admin.change_password(options[:password], options[:new_password])
	end

	admin.login_check
ensure
	#admin.close
end
