require "test_helper"

class Admin::ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    short_url = ShortUrl.create(origin_url: "https://www.google.com")
    get admin_short_url_path(short_url.admin_id)

    assert_response :success
    assert_select "body p:nth-child(1) strong", "Short url:"
    assert_select "body p:nth-child(1) a:match('href', ?)", /http:\/\/www.example.com\/s\/[0-9a-z]{6}/
    assert_select "body p:nth-child(2)", "Origin url: https://www.google.com"
    assert_select "body p:nth-child(3) strong", "Admin url:"
    assert_select "body p:nth-child(3) a:match('href', ?)", /http:\/\/www.example.com\/a\/[0-9a-z]{20}/
    assert_select "body p:nth-child(4)", "Count: 0"
  end

  test "should update expires_at" do
    short_url = ShortUrl.create(origin_url: "https://www.google.com")
    expires_at = 3.days.after

    assert_nil short_url.expires_at
    patch admin_short_url_path(short_url.admin_id), params: { short_url: { expires_at: expires_at }}
    assert_equal expires_at.to_i, short_url.reload.expires_at.to_i
  end
end
