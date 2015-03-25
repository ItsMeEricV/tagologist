require "tagger"

class TagMapController < ApplicationController
  include Tagger
  SCHEMES = %w(http https)

  def inspect

    #verify that URL is valid
    if(!inspect_params[:url].empty?)
      #format URL
      url = urlify(inspect_params[:url])

      #setup Faraday connection to GET source code
      conn = Faraday.new(:url => url) do |c|
        c.use FaradayMiddleware::FollowRedirects, limit: 5
        c.request  :url_encoded            
        c.response :logger                  # log requests to STDOUT
        #c.response :json                  # form response as JSON (otherwise it will be a string)
        c.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      begin
        response = conn.get ''
      rescue => e
        render json: e.message, status: :unprocessable_entity and return
      end

      #set the source code to @source so it is available in our view
      @source = response.body
      @source_url = url

      #inspect the tags in the source and build up a summary table based on occurence of each tag
      @summary = inspect_tags(@source)
      #sort the table with highest occurrences first
      @summary = @summary.sort_by { |k,v| v }.reverse.to_h

      #convert all tags to &lt; and &gt; then tell Rails that it's html_safe we it will render the apps tags
      @source = decorate_tags(@source).html_safe
    else #url is blank
      head :unprocessable_entity
    end
  end

  private

  def inspect_params
    params.require(:tag_map).permit(:url)
  end

end
