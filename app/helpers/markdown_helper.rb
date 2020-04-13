# frozen_string_literal: true

module MarkdownHelper
  def markdown(text)
    return '' if text.blank?

    options = {
      hard_wrap:       true,
      space_after_headers: true,
    }

    extensions = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
    }

    input = ERB.new(text).result(binding)
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(input).html_safe
  end
end
