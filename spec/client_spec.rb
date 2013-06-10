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

  it "should update the user" do
    user = User.update("shane", {:bio => "moving to new york"})
    user["name"].should == "shane"
    user["email"].should == "shane@example.com"
    user["bio"].should = "moving to new york"
    User.find_by_name("shane").should == user
  end

  it "should destroy the user" do
    User.destroy("paul").should == true
    User.find_by_name("paul").should be_nil
  end
end