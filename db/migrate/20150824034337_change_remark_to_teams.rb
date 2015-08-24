class ChangeRemarkToTeams < ActiveRecord::Migration
  def up
    change_column :teams, :remark, :text
  end

  def down
    change_column :teams, :remark, :string
  end
end
