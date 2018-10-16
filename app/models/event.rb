class Event < ApplicationRecord
  include IceCube
  serialize :recurrence, IceCube::Schedule
  attr_accessor :recurrence

  belongs_to :user

  # @return [IceCube::Schedule]
  def schedule
    return recurrence unless recurrence.nil?

    if schedule_rule.nil?
      self.recurrence = IceCube::Schedule.new(start = date)
    else
      self.recurrence = IceCube::Schedule.from_yaml(schedule_rule)
    end

    # if recurrence.nil? && !schedule_rule.nil?
    #   self.recurrence = IceCube::Schedule.from_yaml(self.schedule_rule)
    # elsif recurrence.nil?
    #   self.recurrence = IceCube::Schedule.new(start = date)
    # elsif !self.schedule_rule.nil?
    #   self.recurrence = IceCube::Schedule.from_yaml(self.schedule_rule)
    # end
    #
    # recurrence
  end

  def add_daily_recurrence_rule
    schedule.add_recurrence_rule IceCube::Rule.daily
  end

  def add_weekly_recurrence_rule
    schedule.add_recurrence_rule IceCube::Rule.weekly
  end

  def add_monthly_recurrence_rule
    schedule.add_recurrence_rule IceCube::Rule.monthly
  end

  def add_yearly_recurrence_rule
    schedule.add_recurrence_rule IceCube::Rule.yearly
  end

  # @param [User] current_user
  # @param [String] recurrence
  def add_recurrence_and_save(current_user, recurrence)
    self.user = current_user

    case recurrence
    when "1"
      add_daily_recurrence_rule
    when "2"
      add_weekly_recurrence_rule
    when "3"
      add_monthly_recurrence_rule
    when "4"
      add_yearly_recurrence_rule
    else
      return
    end

    self.schedule_rule = schedule.to_yaml
    self.save
  end
end
