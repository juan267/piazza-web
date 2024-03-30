require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'requires a name' do
    @user = User.new(name: '', email: 'a@a.com', password: '12345678')
    assert_not @user.valid?

    @user.name = 'John Doe'
    assert @user.valid?
  end

  test 'requires a valid email' do
    @user = User.new(name: 'John Doe', email: '', password: '12345678')
    assert_not @user.valid?

    @user.email = 'invalid_email'
    assert_not @user.valid?

    @user.email = 'a@a.com'
    assert @user.valid?
  end

  test 'requires a unique email' do
    @existing_user = User.create(name: 'John Doe', email: 'a@a.com', password: '12345678')
    assert @existing_user.persisted?

    @user = User.new(name: 'Jane Doe', email: 'a@a.com')
    assert_not @user.valid?
  end

  test 'name and email is stripped of spaces before saving' do
    @user = User.create(name: ' John Doe ', email: ' a@a.com ', password: '12345678')
    assert_equal 'John Doe', @user.name
    assert_equal 'a@a.com', @user.email
  end
end
