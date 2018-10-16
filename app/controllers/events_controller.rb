class EventsController < ApplicationController
  before_action :require_login, only: %i[edit update destroy]

  def index
    if params[:my] == 'true'
      return redirect_to new_user_session_path unless user_signed_in?

      @events = current_user.events
    else
      @events = Event.all
    end

    if params[:d].nil? && params[:m].nil? && params[:y].nil?
      @current_date = Date.today.to_time
      events = @events.map { |event| [event, event.schedule.occurrences_between(Time.now, (Date.today + 6.day).to_time)] }.to_h
                      .select { |_, v| v.any? }
      @events = []
      events.each do |k, v|
        v.each do |i|
          @events.push(EventInstance.new(k, i))
        end
      end
    end
  end

  def new
    return redirect_to new_user_session_path unless user_signed_in?

    @event = Event.new
  end

  def create
    return redirect_to new_user_session_path unless user_signed_in?

    @event = Event.new(event_params)
    recurrence = params[:recurrence]
    @event.add_recurrence_and_save(current_user, recurrence)
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    recurrence = params[:recurrence]
    @event.add_recurrence_and_save(current_user, recurrence)
    redirect_to @event
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date)
  end

  def require_login
    return redirect_to new_user_session unless user_signed_in?

    redirect_to events_path unless current_user == Event.find(params[:id]).user
  end
end
