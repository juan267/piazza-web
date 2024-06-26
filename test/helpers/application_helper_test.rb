require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @turbo_native_app = false
  end
  test 'formats page specific title' do
    content_for(:title) { 'Page title' }

    assert_equal "Page title | #{I18n.t('piazza')}", title
  end

  test 'returns app name when page title is missing' do
    assert_equal I18n.t('piazza'), title
  end

  private 
    def turbo_native_app?
      @turbo_native_app
    end
end
