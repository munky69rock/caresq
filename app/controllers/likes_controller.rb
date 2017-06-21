class LikesController < ApplicationController
  include LoginRequirable
  include RegistrationConfirmable
  require_login
  confirm_registration

  def create
    if Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
      return render json: { status: 'ng', message: 'already likes' }
    end
    Like.transaction do
      @post = Post.lock.find(params[:post_id])
      @like = Like.create!(user_id: current_user.id, post_id: params[:post_id])
      @post.like_count += 1
      @post.save!
    end
    render json: { status: 'ok', like: @like }
  end

  def destroy
    @like = Like.find_by!(user_id: current_user.id, post_id: params[:id])
    Like.transaction do
      @post = Post.lock.find(params[:id])
      @like.destroy
      @post.like_count -= 1
      @post.save!
    end
    render json: { status: 'ok', like: @like }
  end
end