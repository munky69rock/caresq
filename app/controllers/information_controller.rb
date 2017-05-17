# frozen_string_literal: true

class InformationController < ApplicationController
  def index
    @information = Information.published.page(params[:page])
  end

  def show
    @information = Information.published.find(params[:id])
  end
end
