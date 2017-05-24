module Admin
  class DumpsController < BaseController
    def show
      @static_pages = StaticPage.all
      @information = Information.all
      send_data({ static_pages: @static_pages, information: @information }.to_json,
                type: :json,
                filename: 'dump.json',
                disposition: 'attachment')
    end
  end
end