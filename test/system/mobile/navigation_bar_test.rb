require 'application_system_test_case'

module Mobile
  class NavigationBarTest < MobileSystemTestCase
    test 'can acces sign up page via burger menu' do
      visit root_path
      find(".navbar-burger").click
      click_on I18n.t("application.navbar.sign_up")
      assert_current_path sign_up_path
    end

    test 'can access login page vie burger menu' do
      visit root_path

      find('.navbar-burger').click
      within '.navbar-menu' do
        click_on I18n.t('application.navbar.login')
      end

      assert_current_path login_path
    end
  end
end
