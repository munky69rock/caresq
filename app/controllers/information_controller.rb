# frozen_string_literal: true

class InformationController < ApplicationController
  def index
    @information = Information.page(params[:page])
  end

  def show
    @information = Information.find(params[:id])
  end
end
