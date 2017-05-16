module Users
  class ImageController < ApplicationController
    def show
      @user = current_user
    end

    def update
      @user = current_user
      @user.image = image_params[:image]
      if @user.save
        redirect_to user_index_path
      else
        render :show
      end
    end

    private

    def image_params
      params.require(:user).permit(:image)
    end
  end
end