# frozen_string_literal: true

module Admin
  class TagsController < BaseController
    def index
      @tags = Tag.all.order(id: :desc).page params[:page]
    end

    def show
      @tag = Tag.find(params[:id])
    end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        redirect_to admin_tags_path
      else
        render :new
      end
    end

    def edit
      @tag = Tag.find(params[:id])
    end

    def update
      @tag = Tag.find(params[:id])
      if @tag.update(tag_params)
        redirect_to admin_tags_path
      else
        render :edit
      end
    end

    def destroy
      @tag = Tag.find(params[:id])
      @tag.destroy!
      redirect_to admin_tags_path
    end

    private

    def tag_params
      params.require(:tag).permit(:value)
    end
  end
end
