class CreateAppSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :app_sessions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :token_digest

      t.timestamps
    end
  end
end
