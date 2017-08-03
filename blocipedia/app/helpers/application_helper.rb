module ApplicationHelper
  def header(text)
    content_for(:header) { text.to_s }
  end

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end
end
