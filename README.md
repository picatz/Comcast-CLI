# COMCAST-CLI

Basically a browser bot with a command line application to automate comcast router admin panel tasks using default credenetials or custom crednetials. Allows a neat little option to set a new password once you're in.

TODO: 
* Logger option.
* Automate other tasks, perhaps firewall related.

## Installation
You're going to need to install the following ruby gems for rainbow powers and browser automation:                                                                     
`gem install watir-webdriver lolcat`

## Usage
Login to admin panel using default credentials:
`ruby comcast.rb -d`

Login to admin panel using custom crendtials:
`ruby comcast.rb -u <username> -p <password>`

## Help Menu
`
COMCAST-CLI
Version 1.0

Usage: comcast.rb [OPTIONS]

Basically a browser bot to automate comcast router things.
EX: comcast.rb -d
EX: comcast.rb -u admin -p password -l

Options: 
    -d, --default                    Use default username/password.
    -u, --username <USERNAME>        Define username.
    -p, --password <PASSWORD>        Define password.
    -n, --newpass <NEW_PASSWORD>     Define new password to set.
    -l, --lol                        Rainbow support, because we need it.
    -v, --version                    Show verison number.
    -h, --help                       Help menu.
`

### Credits
Kent 'picat' Gruber
