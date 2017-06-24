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
    if save_post_with_tag(@post)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @post.attributes = post_params
    if save_post_with_tag(@post)
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
      params[:values] = params[:values].reject!(&:blank?).map(&:strip) if params[:values].present?
    end
  end

  def save_post_with_tag(post)
    ActiveRecord::Base.transaction do
      if tags_params[:values].present?
        original_tags = post.tags
        persisted_tags = Tag.where(value: tags_params[:values])
        additional_tags = get_additional_tags(original_tags, persisted_tags)
        unchanged_tags = get_unchanged_tags(original_tags, persisted_tags)
        removal_tags = get_removal_tags(original_tags, tags_params[:values])
        new_tags = get_new_tags(persisted_tags, tags_params[:values])

        if new_tags.present?
          Tag.import(new_tags) if new_tags.present?
          additional_tags = additional_tags.concat(new_tags)
        end

        if additional_tags.count > 0
          Tag.lock.where(id: additional_tags.map(&:id)).update_all('count = count + 1')
        end

        if removal_tags.count > 0
          Tag.lock.where(id: removal_tags.map(&:id)).update_all('count = count - 1')
        end
        post.tags = unchanged_tags.concat(additional_tags)
      end
      post.user_id = current_user.id
      post.save!
    end
    true
  rescue => e
    p e
    false
  end

  def get_unchanged_tags(original, persisted)
    persisted.select { |p| original.any? { |o| o.value == p.value } }
  end

  def get_additional_tags(original, persisted)
    persisted.select { |p| original.none? { |o| o.value == p.value } }
  end

  def get_removal_tags(original, values)
    original.select { |o| values.none? { |v| v == o.value } }
  end

  def get_new_tags(persisted, values)
    values.select { |v| persisted.none? { |p| p.value == v } }.map do |value|
      Tag.new(value: value, count: 0)
    end
  end

  def assert_posted_by_current_user
    @post = Post.find(params[:id])
    return if @post.by? current_user
    raise ActionController::BadRequest,
          "Attempt to modify other user's post: user:#{current_user.id},post:#{@post.id}"
  end
end
