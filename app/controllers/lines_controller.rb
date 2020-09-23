class LinesController < ApplicationController
  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @line = Line.new
    @line.start_date = DateTime.now
    @line.end_date = @line.start_date
    @line.active = true
    @line.place = @place
    @line.user = current_user
    @line.save!
    redirect_to place_line_path(@place, @line)
  end

  def update
    @place = Place.find(params[:place_id])
    @line = Line.find(params[:id])
    @line.end_date = DateTime.now
    @line.active = false
    @line.save!
    PlaceChannel.broadcast_to(
        @place,
        render_to_string(partial: "lines/info", locals: { place: @place })
      )
    flash[:notice] = "Thank you for your participation!"
    redirect_to place_path(@place)
  end

  def show
    @place = Place.find(params[:place_id])
    @line = Line.find(params[:id])
  end
end
