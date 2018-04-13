module ApplicationHelper
  def link_to_delete(text, url, model)
    form_for model, url: url, method: :delete do |f|
      f.submit text
    end
  end
end
