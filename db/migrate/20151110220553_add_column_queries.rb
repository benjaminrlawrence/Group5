class AddColumnQueries < ActiveRecord::Migration
  def change
    add_column :queries, :type, :string
    add_column :queries, :search_query, :string
    add_column :queries, :user_id, :integer
  end
end
