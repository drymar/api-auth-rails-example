class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
