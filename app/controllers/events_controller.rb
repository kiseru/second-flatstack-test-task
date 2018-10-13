class EventsController < ApplicationController
  def index
    if params[:my] == 'true'
      return redirect_to new_user_session_path unless user_signed_in?
      @events = current_user.events
    else
      @events = Event.all
    end
  end

  def new
    return redirect_to new_user_session_path unless user_signed_in?
    @event = Event.new
  end

  def create
    @event = Event.new(params.require(:event).permit(:name, :date))
    @event.user = current_user
    @event.save
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(params.require(:event).permit(:name, :date))
    redirect_to @event
  end

  def edit
    @event = Event.find(params[:id])
  end
end
