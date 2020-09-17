class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  # GET "/places/search", to: places#search
  def search
    keyword = params[:query]
    location = params[:location]

    if keyword.nil? || keyword.empty?
      @places = ""
    else
      url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
      resp = Faraday.get(url, {query: keyword, location: location, key: ENV['GOOGLE_API_KEY']}, {'Accept' => 'application/json'})
      @places = JSON.parse(resp.body)['results']
      render json: @places
    end
  end

  # GET "/places/:id" , to: places#show
  def show
    @place = Place.find(params[:id])
  end
end
