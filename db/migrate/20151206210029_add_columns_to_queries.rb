class AddColumnsToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :searched_limit, :integer
    add_column :queries, :searched_date, :date
  end
end
