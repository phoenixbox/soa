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
end