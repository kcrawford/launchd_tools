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

## Usage from Ruby

### Parsing a launchd plist

```ruby
>> require 'launchd_tools/path'
=> false
>> sshd_plist_path =
LaunchdTools::Path.new("/System/Library/LaunchDaemons/ssh.plist")
=> #<LaunchdTools::Path:0x007f9a7b1a5f50
@path="/System/Library/LaunchDaemons/ssh.plist">
>> sshd_job = sshd_plist_path.parse
=> #<LaunchdTools::LaunchdJob:0x007f9a7aa6cc70
@attributes={"EnvironmentVariables"=>[],
"ProgramArguments"=>["/usr/sbin/sshd", "-i"]}>
>> sshd_job.program_arguments
=> ["/usr/sbin/sshd", "-i"]
```

### Creating a launchd plist

```ruby
>> require 'launchd_tools/launchd_plist'
=> true
>> plist = LaunchdTools::LaunchdPlist.new
=> #<LaunchdTools::LaunchdPlist:0x007fde1c434c78 @doc=<UNDEFINED> ...
</>, @program_args_array_element=<array/>>
>> plist.add_program_args(["/usr/local/bin/daemon", "-f", "-o",
"/var/log/daemon.log"])
=> ["/usr/local/bin/daemon", "-f", "-o", "/var/log/daemon.log"]
>> puts plist.to_s
<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version='1.0'>
  <dict>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/daemon</string>
      <string>-f</string>
      <string>-o</string>
      <string>/var/log/daemon.log</string>
    </array>
  </dict>
</plist>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


