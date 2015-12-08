class AddColumnsToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :search_limit, :integer, default: 0
    add_column :queries, :search_date, :date, default: nil
  end
end
