# frozen_string_literal: true

require 'redcarpet'

class MarkdownTemplateHandler
  def erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def call(template, source)
    compiled_source = erb.call(template, source)
    options = {
      hard_wrap: true,
      space_after_headers: true,
    }
    extensions = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
    }
    "Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(#{options}), #{extensions}).render(begin;#{compiled_source};end).html_safe"
  end
end

ActionView::Template.register_template_handler(:md, MarkdownTemplateHandler.new)
