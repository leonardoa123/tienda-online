require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "render a list of products" do
    get products_path

    assert_response :success
    assert_select '.product', 2
      
  end
  test "render a detaild product page" do
    get products_path(products(:ps4))

    assert_response :success
    assert_select '.title', 'PS4'
    assert_select '.description', 'Consola en buen estado'
    assert_select '.price', '100'

  end
end
