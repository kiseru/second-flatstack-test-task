class EventsController < ApplicationController
  def index
    if params[:my] == 'true'
      if user_signed_in?
        @events = current_user.events
      else
        redirect_to new_user_session_path
      end
    else
      @events = Event.all
    end
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
end
