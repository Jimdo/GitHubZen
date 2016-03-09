require 'spec_helper.rb'

describe GitHubZen do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end
end
