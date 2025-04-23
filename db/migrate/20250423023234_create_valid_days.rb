class CreateValidDays < ActiveRecord::Migration[8.0]
  def change
    create_table :valid_days do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end

    # Create a join table to establish the many-to-many relationship between assemblies and parts.
    # `id: false` indicates that the table does not need a primary key of its own
    create_table :parking_passes_valid_days, id: false do |t|
      # creates foreign keys linking the join table to the `assemblies` and `parts` tables
      t.belongs_to :parking_pass
      t.belongs_to :valid_day
    end
end
