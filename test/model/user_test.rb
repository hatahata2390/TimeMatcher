# require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @user2 = User.new(name: "Example User2", email: "user2@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "micropost interface" do
    assert_not @user.like_send_to?(@user2)
    assert_not @user2.like_sent_by?(@user)
    @user.like(@user2)
    debugger
    assert @user.like_send_to?(@user2)
    assert @user2.like_sent_by?(@user)
  end
end