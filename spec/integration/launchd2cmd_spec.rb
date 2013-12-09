describe 'running launchd2cmd' do
  context 'launch agent' do
    it 'outputs the command' do
      output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchAgents/com.apple.storeagent.plist`
      expect(output.chomp).to eql("/System/Library/PrivateFrameworks/CommerceKit.framework/Versions/A/Resources/storeagent")
    end
  end
  context 'bad file path' do
    it "outputs error" do
      output = `bundle exec bin/launchd2cmd not/a/real/path`
      expect(output).to include("No launchd job found at not/a/real/path")
    end
  end
  context 'launch daemon' do
    context 'with environment variables' do
      it 'includes argument and environment variables in output' do
        output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchDaemons/org.apache.httpd.plist`
        expect(output.chomp).to eql("XPC_SERVICES_UNAVAILABLE=1 /usr/sbin/httpd -D FOREGROUND")
      end
    end
  end
  context "binary plist" do
    it "handles it without error" do
      output = `bundle exec bin/launchd2cmd spec/fixtures/LaunchDaemons/com.apple.opendirectoryd.plist`
      expect(output.chomp).to eql("__CFPREFERENCES_AVOID_DAEMON=1 __CF_USER_TEXT_ENCODING=0x0:0:0 /usr/libexec/opendirectoryd")
    end
  end
end
