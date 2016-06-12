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
`ruby comcast-cli.rb -d`

Login to admin panel using custom crendtials:
`ruby comcast-cli.rb -u <username> -p <password>`

### Credits
Kent 'picat' Gruber
