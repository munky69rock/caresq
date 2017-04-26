# frozen_string_literal: true

class CommentForm
  def initialize(params)
    @comment = Comment.new params
    @post = @comment.post
  end

  def save!
    ActiveRecord::Base.transaction do
      @post.lock!
      @comment.save!
      @post.update_attributes! comment_count: @post.comment_count + 1
    end
  end

  def save
    true.tap { save! }
  rescue => e
    Rails.logger.warn "Failed to create comment: #{e}"
    false
  end
end
