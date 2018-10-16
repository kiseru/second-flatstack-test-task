class EventInstance
  attr_reader :event, :date, :recurrence

  # @param [Event] event
  # @param [DateTime] datetime
  def initialize(event, datetime)
    @event = event
    @date = datetime
    begin
      @recurrence = IceCube::Schedule.from_yaml(event.schedule_rule).to_s
    rescue TypeError
      @recurrence = 'Никогда'
    end
  end
end
