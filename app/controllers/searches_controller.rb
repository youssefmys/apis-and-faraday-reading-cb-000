class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = Rails.application.secrets.foursquare_client_id
      req.params['client_secret'] = Rails.application.secrets.foursquare_client_secret
      req.params['v'] = '20160201'
      req.params['near'] =  params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)

    if @resp.success? #if @resp.status == 200
      @venues = body_hash["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout error"
      render :search
    end
  end


end
