module Users
  class AvatarController < ApplicationController
    def show
      @user = current_user
    end

    def update
      @user = current_user
      @user.avatar = avatar_params[:avatar]
      if @user.save
        redirect_to user_index_path
      else
        render :show
      end
    end

    private

    def avatar_params
      params.require(:user).permit(:avatar)
    end
  end
end