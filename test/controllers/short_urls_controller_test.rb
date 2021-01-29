require "test_helper"

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get root_path

    assert_response :success
    assert_select "h1", "New Short Url"
  end

  test "should create short_url" do
    post short_urls_path, params: { short_url: { origin_url: "https://www.google.com" }    }

    assert_response :success
    assert_select "li p strong", "Short url:"
    assert_select "li p:nth-child(1) a:match('href', ?)", /http:\/\/www.example.com\/s\/[0-9a-z]{6}/
    assert_select "li p:nth-child(2)", "Origin url: https://www.google.com"
    assert_select "li p[3] strong", "Admin url:"
    assert_select "li p:nth-child(3) a:match('href', ?)", /http:\/\/www.example.com\/a\/[0-9a-z]{20}/
  end

  test "should redirect to origin url when get show" do
    short_url = ShortUrl.create(origin_url: "https://www.google.com")
    get short_url_path(short_url.short_id)

    assert_redirected_to short_url.origin_url
  end

  test "should get 404 when short url not exist" do
    get short_url_path('abcdef')

    assert_response :missing
  end
end
