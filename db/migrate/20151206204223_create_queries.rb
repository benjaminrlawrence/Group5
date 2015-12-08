class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.datetime    :created_at,   null: false
      t.datetime    :updated_at,  default: DateTime.now, null: false
      t.text    :query_type, default: 'recent'
      t.text    :search_query
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
