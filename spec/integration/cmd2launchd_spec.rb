require 'tempfile'
describe 'running cmd2launchd' do
  it "converts right back to original commmand using launchd2cmd" do
    t = Tempfile.new(File.basename(__FILE__))
    temp_file_path = t.path
    t.close
    output = `bundle exec bin/cmd2launchd ls -la /tmp > #{temp_file_path} && bundle exec bin/launchd2cmd #{temp_file_path}`
    expect(output.chomp).to include("ls -la /tmp")
    File.unlink(temp_file_path)
  end

  context "no arguments" do
    it "outputs usage info" do
      output = `bundle exec bin/cmd2launchd`
      expect(output.chomp).to include("Usage: ")
    end
  end

  context "help option" do
    it "outputs usage info" do
      output = `bundle exec bin/cmd2launchd -h`
      expect(output.chomp).to include("Usage: ")
    end
  end
end
