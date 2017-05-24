# frozen_string_literal: true

module Admin
  class StaticPageController < BaseController
    def index
      @pages = StaticPage.all
    end

    def new
      @page = StaticPage.new
    end

    def create
      @page = StaticPage.new(static_page_params)
      if @page.save
        redirect_to controller: '/static_page',
                    action: :show,
                    path: @page.path
      else
        render :new
      end
    end

    def edit
      @page = StaticPage.find(params[:id])
    end

    def update
      @page = find(params[:id])
      if @page.update(static_page_params)
        redirect_to controller: '/static_page',
                    action: :show,
                    path: @page.path
      else
        render :new
      end
    end

    def destroy
      @page = StaticPage.find(params[:id])
      @page.destroy!
      redirect_to admin_static_page_index_path
    end

    private

    def static_page_params
      params.require(:static_page).permit(:path, :title, :body, :syntax).tap do |params|
        params[:path] = params[:path].strip.sub(%r{^/}, '') if params[:path].present?
        params[:syntax] = params[:syntax].to_i if params[:syntax].present?
      end
    end
  end
end
