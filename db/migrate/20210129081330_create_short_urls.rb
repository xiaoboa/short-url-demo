class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls do |t|
      t.string :short_id
      t.string :origin_url
      t.string :admin_id
      t.integer :count, default: 0
      t.datetime :expires_at

      t.timestamps
    end
  end
end
