# frozen_string_literal: true

module ApplicationHelper
  def delete_link_to(name = nil, options = nil, html_options = {}, &block)
    html_options[:method] = :delete
    html_options[:data] = {
      confirm: '削除してもよいですか？'
    }
    link_to(name, options, html_options, &block)
  end

  def title(text, size = 2)
    content_for :title, text
    simple_format text, {}, wrapper_tag: "h#{size}"
  end

  def truncate_l(text, options = {}, &block)
    options[:length] ||= 250
    truncate(text, options, &block)
  end

  def user_image_url(user)
    user.image_url || user.default_image_url
  end
end
