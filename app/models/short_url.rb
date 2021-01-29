class ShortUrl < ApplicationRecord
    validates :origin_url, presence: true, url: true

    before_create :generate_short_id, :generate_admin_id

    def visit
        increment!(:count) unless expired?
    end

    def expired?
        self.expires_at && DateTime.current > self.expires_at
    end

    private
    def generate_short_id
        self.short_id = SecureRandom.hex (3)
    end

    def generate_admin_id
        self.admin_id = SecureRandom.hex (10)
    end
end
