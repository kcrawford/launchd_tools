# Launchd Tools

Convert from command to launchd plist or from launchd plist to command

## Installation

    $ gem install launchd_tools

## Command Usage

Output the command and arguments from a launchd plist:

    $ launchd2cmd /path/to/launchd.plist [another/launchd.plist]

Create a launchd plist from a command and arguments:

    $ cmd2launchd /path/to/daemon [arg] [-option]

## Examples

####launchd2cmd with multiple directories:

    $ launchd2cmd /System/Library/LaunchAgents /System/Library/LaunchDaemons
    ...
    # /System/Library/LaunchDaemons/tftp.plist
    /usr/libexec/tftpd -i /private/tftpboot

####launchd2cmd wildcards/globbing:

    $ launchd2cmd /Library/Launch*/com.googlecode.munki.*
    ...
    # /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-manualcheck.plist
    /usr/local/munki/supervisor --timeout 43200 -- /usr/local/munki/managedsoftwareupdate --manualcheck

####cmd2launchd creating a launchd plist skeleton:

    $ cmd2launchd /usr/local/bin/daemond -d --mode foreground
    <?xml version='1.0' encoding='UTF-8'?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version='1.0'>
      <dict>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/local/bin/daemond</string>
          <string>-d</string>
          <string>--mode</string>
          <string>foreground</string>
        </array>
      </dict>
    </plist>



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


