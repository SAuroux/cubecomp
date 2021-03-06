require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  setup do
    @theme = themes(:default)
  end

  test 'validates presence of name' do
    @theme.name = nil
    assert_not_valid(@theme, :name)

    @theme.name = ''
    assert_not_valid(@theme, :name)
  end

  test 'validates uniqueness of name' do
    new_theme = @theme.dup
    assert_not_valid(new_theme, :name)

    new_theme.name = 'foobar'
    assert_valid(new_theme)
  end

  test 'destroys theme files' do
    count = @theme.files.count
    assert_difference 'ThemeFile.count', -1 * count do
      @theme.destroy
    end
  end
end
