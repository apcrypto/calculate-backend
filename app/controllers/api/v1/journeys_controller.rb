class Api::V1::JourneysController < ApplicationController

  def index
    @journeys = Journey.all
    render json: @journeys
  end

  def create
    if get_current_user
      @journey = Journey.new(arrival_loc: params[:arrival_loc], date_of_service: params[:date_of_service], price: params[:price], refund: params[:refund], delay: params[:delay], user_id: params[:user_id], user: get_current_user)
      @journey.save
      byebug
      render json: @journey
    end
  end

  def update
    @journey.update(journey_params)
    @journey.save
    render json: @journey
  end

  def destroy
    @journey.destroy
    render json: @journeys
  end

  def journey_info
    first_url = 'https://hsp-prod.rockshore.net/api/v1/serviceMetrics'
    first_body = JSON.generate(journey_params.to_h)
    first_headers = {authorization: "Basic YW5keXB1cmJyaWNrQGdtYWlsLmNvbTpSZWdnYWUxOTc4Kg==", content_type: :json, accept: :json}

    first_response = RestClient.post(first_url, first_body, first_headers)
    first_parsed_json = JSON.parse(first_response.body)
    rids = first_parsed_json['Services'][0]["serviceAttributesMetrics"]["rids"][0]

    second_url = 'https://hsp-prod.rockshore.net/api/v1/serviceDetails'
    second_body = JSON.generate({rid: rids})
    second_headers = {authorization: "Basic YW5keXB1cmJyaWNrQGdtYWlsLmNvbTpSZWdnYWUxOTc4Kg==", content_type: :json, accept: :json}

    second_response = RestClient.post(second_url, second_body, second_headers)
    result = JSON.parse(second_response.body)

    render json: result
  end

  private

  def journey_params
    params.require(:journey).permit(:from_loc, :to_loc, :from_time, :to_time, :from_date, :price, :delay, :user_id, :to_date, :days)
  end

end
