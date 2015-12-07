class AddColumnsToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :search_limit, :integer
    add_column :queries, :search_date, :date
  end
end
