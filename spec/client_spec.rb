describe "client" do
  before(:each) do
    User.base_uri = "http://localhost:3000"
  end

  it "should get a user from the service" do 
    user = User.find_by_name("shane")
    user["name"].should == "shane"
    user["email"].should == "shane@example.com"
    user["bio"].should == "gschool graduate from Ireland"
  end

  it "should return nil if the user is not found" do
    user = User.find_by_name("simon").should be_nil
  end

  it "should create a user" do
    user = User.create({
      :name => "anna",
      :email => "anna@example.com",
      :password => "anna"
      })
    # testing the return of a hash
    user["name"].should == "anna"
    user["email"].should == "anna@example.com"
    User.find_by_name("anna").should == user
  end
end