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
    Markdowner.render(markdown).html_safe # rubocop:disable Rails/OutputSafety
  end

  def static_page_link_to(title, path, options = {})
    if path.is_a?(Array)
      link_to title, "/#{path.join('/')}", options
    else
      link_to title, "/#{path}", options
    end
  end
end
