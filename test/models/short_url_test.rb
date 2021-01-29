require "test_helper"

class ShortUrlTest < ActiveSupport::TestCase
  # validations
  test "valid origin url with http scheme" do
    short_url = ShortUrl.new
    short_url.origin_url = "http://www.google.com"
    assert short_url.valid?
  end

  test "valid origin url with https scheme" do
    short_url = ShortUrl.new
    short_url.origin_url = "https://www.google.com"
    assert short_url.valid?
  end

  test "invalid origin url without http/https scheme" do
    short_url = ShortUrl.new
    short_url.origin_url = "www.google.com"
    assert_not short_url.valid?
  end

  test "invalid origin url" do
    short_url = ShortUrl.new
    short_url.origin_url = "google"
    assert_not short_url.valid?
  end

  test "blank origin url" do
    short_url = ShortUrl.new
    assert_not short_url.valid?
  end

  # expired?
  test "short url with expires_at unset" do
    short_url = ShortUrl.new

    assert_nil short_url.expires_at
    assert_not short_url.expired?
  end

  test "short url with expired expires_at" do
    short_url = ShortUrl.new
    short_url.expires_at = 3.days.ago

    assert short_url.expired?
  end

  test "short url with not expired expires_at" do
    short_url = ShortUrl.new
    short_url.expires_at = 3.days.after

    assert_not short_url.expired?
  end

  # visit
  test "visit expired short url should not increase count" do
    short_url = ShortUrl.create(origin_url: "https://www.google.com", expires_at: 3.days.ago)

    assert short_url.expired?
    assert_equal 0, short_url.count
    short_url.visit
    assert_equal 0, short_url.reload.count
  end

  test "visit unexpired short url should increase count" do
    short_url = ShortUrl.create(origin_url: "https://www.google.com")

    assert_not short_url.expired?
    assert_equal 0, short_url.count
    short_url.visit
    assert_equal 1, short_url.reload.count
  end

  # short_id
  test "save short url should create a short id with length 6" do
    short_url = ShortUrl.new(origin_url: "https://www.google.com")

    assert_nil short_url.short_id
    short_url.save!
    assert_match /\A[0-9a-z]{6}\z/, short_url.short_id
  end

  test "save short url should create a admin id with length 20" do
    short_url = ShortUrl.new(origin_url: "https://www.google.com")

    assert_nil short_url.admin_id
    short_url.save!
    assert_match /\A[0-9a-z]{20}\z/, short_url.admin_id
  end
end
