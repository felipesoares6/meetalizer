module ApplicationHelper
  def link_to_delete(text, url, model)
    form_request(text, url, model, :delete)
  end

  def link_to_create(text, url, model)
    form_request(text, url, model, :post)
  end

  def link_to_update(text, url, model)
    form_request(text, url, model, :patch)
  end

  private
  def form_request(text, url, model, method)
    form_for model, url: url, method: method do |f|
      f.submit text
    end
  end
end
