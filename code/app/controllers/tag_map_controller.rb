require "tagger"

class TagMapController < ApplicationController
  include Tagger


  def index

  end

  def inspect

    #setup Faraday connection to GET source code
    conn = Faraday.new(:url => urlify(inspect_params[:url])) do |c|
      c.request  :url_encoded            
      c.response :logger                  # log requests to STDOUT
      #c.response :json                  # form response as JSON (otherwise it will be a string)
      c.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.get ''
    @source = response.body

  end

  private

  def inspect_params
    params.require(:tag_map).permit(:url)
  end

end
