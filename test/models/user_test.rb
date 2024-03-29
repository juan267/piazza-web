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

  test 'password length must be at least 8 chars and ActiveModel maximun' do
    @user = User.new(name: 'John Doe', email: 'a@a.com', password: '1234567')
    assert_not @user.valid?

    @user.password = '12345678'
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED

    @user.password = 'a' * (max_length + 1)
    assert_not @user.valid?
  end

  test 'can create a session with email and correct password' do
    @app_session = User.create_app_session(
      email: 'jerry@example.com',
      password: 'password'
    )

    assert_not_nil @app_session
    assert_not_nil @app_session.token
  end

  test 'cannot create a session with email and invalid password' do
    @app_session = User.create_app_session(
      email: 'jerry@example.com',
      password: 'WRONG'
    )

    assert_nil @app_session
  end

  test 'creating a session with non existent emaisl returns nil' do
    @app_session = User.create_app_session(
      email: 'whoami@example.com',
      password: 'WRONG'
    )

    assert_nil @app_session
  end
end
