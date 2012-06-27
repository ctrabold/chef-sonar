require 'minitest/spec'

describe_recipe 'sonar::default' do

  # It's often convenient to load these includes in a separate
  # helper along with
  # your own helper methods, but here we just include them directly:
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "installs" do
    it "installs the files to the correct folder" do
      directory(node['sonar']['dir']).must_exist
    end

#    TODO ct 2012-06-27 How to check sonar process?
#    it "starts the server" do
#      service "sonar".must_be_running
#    end
  end

  describe "run_state" do
    it "succeed" do
      run_status.success?.must_equal true
    end
  end
end
