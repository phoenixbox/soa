ENV['SINATRA_ENV'] = 'test'

require File.dirname(__FILE__) + '/../service'
require 'rspec'
require 'rack/test'

# set :environment, :test
#Test::Unit::TestCase.send :include, Rack::Test::Methods

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

describe "service" do
  before(:each) do
    User.delete_all
  end

  describe "GET on /api/v1/users/:id" do
    before(:each) do
      User.create(
        :name => "paul",
        :email => "paul@pauldix.net",
        :password => "strongpass",
        :bio => "rubyist")
    end

    it "should return a user by name" do
      get '/api/v1/users/paul'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes["name"].should == "paul"
    end
    it "should return a user with an email" do
      get '/api/v1/users/paul'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes["email"].should == "paul@pauldix.net"
    end
    it "should not return a user's password" do
      get '/api/v1/users/paul'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes.should_not have_key("password")
    end
    it "should return a user with a bio" do
      get '/api/v1/users/paul'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes["bio"].should == "rubyist"
    end

    it "should return a 404 for a user that doesn't exist" do
      get '/api/v1/users/foo'
      last_response.status.should == 404
    end
  end

  describe "POST on /api/v1/users" do
    it "should create a user" do
      post '/api/v1/users', {
      :name => "trotter",
      :email => "trotter@example.com",
      :password => "trotter",
      :bio => "southern belle"}.to_json
      last_response.should be_ok
      get '/api/v1/users/trotter'
      attributes = JSON.parse(last_response.body)
      attributes["name"].should == "trotter"
      attributes["email"].should == "trotter@example.com"
      attributes["bio"].should == "southern belle"
    end
  end

  describe 'PUT on /api/v1/users/:id' do
    it "should be able to update a user" do
      User.create(
        :name => "shane",
        :email => "shane@example.com",
        :password => "shane",
        :bio => "gschool student")
      put '/api/v1/users/shane', {
        :bio => "gschool graduate"}.to_json
      last_response.should be_ok
      get '/api/v1/users/bryan'
      attributes = JSON.parse(last_response.body)
      attributes["bio"].should == "gschool graduate"
    end
  end
end











































