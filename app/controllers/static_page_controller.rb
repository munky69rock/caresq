# frozen_string_literal: true

class StaticPageController < ApplicationController
  def show
    if params[:format].present? && StaticPage.asset_format?(params[:format])
      raise ActionController::RoutingError, "no resource matches: #{request.fullpath}"
    end
    @page = StaticPage.find_by!(path: params[:path])
  end
end
