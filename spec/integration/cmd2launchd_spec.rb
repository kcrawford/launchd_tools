require 'tempfile'
describe 'running cmd2launchd' do
  it "converts right back to original commmand using launchd2cmd" do
    t = Tempfile.new(__FILE__)
    temp_file_path = t.path
    t.close
    output = `bundle exec bin/cmd2launchd ls -la /tmp > #{temp_file_path} && bin/launchd2cmd #{temp_file_path}`
    expect(output.chomp).to eql("ls -la /tmp")
    File.unlink(temp_file_path)
  end
end
