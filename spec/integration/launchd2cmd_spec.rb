describe 'running launchd2cmd' do
  context 'launch agent' do
    it 'outputs the command' do
      output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchAgents/com.apple.storeagent.plist`
      expect(output.chomp).to include("/System/Library/PrivateFrameworks/CommerceKit.framework/Versions/A/Resources/storeagent")
    end
    it "outputs a comment line with path to the plist" do
      output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchAgents/com.apple.storeagent.plist`
      expect(output.chomp).to include("# #{File.expand_path("spec/fixtures/LaunchAgents/com.apple.storeagent.plist")}")
    end
  end
  context "no arguments" do
    it "outputs usage info" do
      output = `bundle exec bin/launchd2cmd`
      expect(output.chomp).to include("Usage: ")
    end
  end
  context "help option" do
    it "outputs usage info" do
      output = `bundle exec bin/launchd2cmd -h`
      expect(output.chomp).to include("Usage: ")
    end
  end

  context "inaccessible file" do
    it "outputs relevant error message" do
      inaccessible_path = 'spec/fixtures/LaunchDaemons/inaccessible.plist'
      File.chmod(0000, inaccessible_path)
      output = `bundle exec bin/launchd2cmd #{inaccessible_path}`
      File.chmod(0644, inaccessible_path)
      require 'etc'
      username = Etc.getpwuid(Process.euid).name
      expect(output).to include("Error: user #{username} does not have access to read launchd job")
    end
  end

  context "unparsable file" do
    it "outputs relevant error message" do
      output = `bundle exec bin/launchd2cmd #{__FILE__}`
      expect(output).to include("Error: unable to parse launchd job")
    end
  end

  context 'bad file paths' do
    it "outputs relevant error message" do
      output = `bundle exec bin/launchd2cmd not/a/real/path and/another/bad/path`
      expect(output).to include("No launchd job found at 'not/a/real/path'")
      expect(output).to include("No launchd job found at 'and/another/bad/path'")
    end
  end
  context 'launch daemon' do
    context 'with environment variables' do
      it 'includes argument and environment variables in output' do
        output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchDaemons/org.apache.httpd.plist`
        expect(output.chomp).to include("XPC_SERVICES_UNAVAILABLE=1 /usr/sbin/httpd -D FOREGROUND")
      end
    end
  end
  context "binary plist" do
    it "handles it without error" do
      output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchDaemons/com.apple.opendirectoryd.plist`
      expect(output.chomp).to include("__CFPREFERENCES_AVOID_DAEMON=1 __CF_USER_TEXT_ENCODING=0x0:0:0 /usr/libexec/opendirectoryd")
    end
  end
end
