class DropUserCourses < ActiveRecord::Migration[7.1]
  def up
    drop_table :user_courses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
