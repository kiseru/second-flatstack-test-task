class AddScheduleRuleToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :schedule_rule, :string
  end
end
