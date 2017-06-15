# frozen_string_literal: true

class PostsController < ApplicationController
  include LoginRequirable
  include RegistrationConfirmable

  require_login except: %i[index show]
  confirm_registration except: %i[index show new]

  before_action :assert_posted_by_current_user, only: %i[edit update destroy]

  def index
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(updated_at: :desc).page params[:page]
    @comment = Comment.new post: @post, user: current_user
  end

  def new
    @post = Post.new
  end

  def create
    return render :new unless current_user.confirmed?

    @post = Post.new post_params
    @post.tags = tags_params[:values].map(&Tag.method(:find)) if tags_params[:values].present?
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.soft_destroy!
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

  def tags_params
    params.require(:tags).permit(values: []).tap do |params|
      params[:values].reject!(&:blank?) if params[:values].present?
    end
  end

  def assert_posted_by_current_user
    @post = Post.find(params[:id])
    return if @post.by? current_user
    raise ActionController::BadRequest,
          "Attempt to modify other user's post: user:#{current_user.id},post:#{@post.id}"
  end
end
