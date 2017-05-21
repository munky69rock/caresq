class Markdowner
  class HTMLRender < Redcarpet::Render::HTML
    def table(header, body)
      <<-HTML.strip_heredoc
      <table class="table">
        <thead>#{header}</thead>
        <tbody>#{body}</tbody>
      </table>
      HTML
    end
  end

  class << self
    def render(text)
      renderer.render(text).html_safe
    end

    def renderer
      @renderer ||= Redcarpet::Markdown.new(
        HTMLRender,
        tables: true,
        fenced_code_blocks: true,
        strikethrough: true,
      )
    end
  end
end