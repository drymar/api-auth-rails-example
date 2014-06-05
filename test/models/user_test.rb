require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "creating user with passwords" do
  
  	user = User.new(email: 'test@test.com', password: 'test', password_confirmation: '')
    
    # User.save should return false because the confirmation doesn't match
    assert_not user.save, "Saved user without matching password_confirmation" 
    
    user.password_confirmation = 'test'
    
    # now that the confirmation matches, we should be able to save the user
    user.save 
    assert user.id.integer?, "User failed to save after matching password_confirmation"
    
  end
  
  test "recalling user with password" do
    
    User.new(email: 'test@test.com', password: 'test', password_confirmation: 'test').save
    
    # this should fail because the password is wrong
    assert_not User.find_by(email: 'test@test.com').try(:authenticate, 'bad password'), "Recalled user with bad password"
  
    # this should succeed because the password is correct
    assert_instance_of User, User.find_by(email: 'test@test.com').try(:authenticate, 'test'), "Failed to recalled user with good password"
  
  end
  
end
