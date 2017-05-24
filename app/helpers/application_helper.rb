# frozen_string_literal: true

require 'markdowner'

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

  def render_markdown(markdown)
    Markdowner.render(markdown)
  end

  def static_page_link_to(title, path, options = {})
    if path.is_a?(Array)
      link_to title, "/#{path.join('/')}", options
    else
      link_to title, "/#{path}", options
    end
  end

  def flex_spacing
    'offset-0 offset-sm-0 offset-md-1 offset-lg-2 offset-xl-2 ' \
      'col-12 col-sm-12 col-md-10 col-lg-8 col-xl-8'
  end
end
