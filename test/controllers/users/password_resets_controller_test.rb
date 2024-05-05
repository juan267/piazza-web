require "test_helper"

class Users::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)

    ActionMailer::Base.deliveries.clear
  end

  test "creating a password reset send an email and show instructions" do
    post users_password_resets_path, params: { email: @user.email }

    assert_response :ok
    assert_select 'p', I18n.t('users.password_resets.create.message')
    assert_emails 1
  end
end
