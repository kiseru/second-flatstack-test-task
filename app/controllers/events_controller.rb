class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params.require(:event).permit(:name, :date))
    @event.user = current_user
    @event.save
    redirect_to events_path
  end

  def my_events
    @events = current_user.events
  end
end
