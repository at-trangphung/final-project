# frozen_string_literal: true

module ViewHelper
  %w[create update].each do |method|
    define_method "act_#{method}?" do
      params[:action] == method
    end
  end

  def msg_form_errors(object, field)
    return if object.errors.blank?
    content_tag :div, class: "note valid" do
      object.errors.messages[field.to_sym].each do |message|
        concat content_tag :span, "#{field.to_s.humanize} #{message}", class: "form-errors"
      end
    end
  end

  def flash_notify(width = "col-md-10")
    return if flash.blank?
    klass = flash.keys.include?("notice") ? "alert-success" : "alert-danger"
    status = flash.keys.include?("notice") ? "Success!" : "Failed!"
    content_tag :div, class: width do
      content_tag :div, class: "alert #{klass}" do
        content_tag :strong, "#{status} #{flash[flash.keys.first]}"
      end
    end
  end

  def redirect_after_update_or_create(object)
    if object.try(:errors).try(:any?)
      act_create? ? render(:new) : render(:edit)
    else
      redirect_to products_path, notice: message_notify(object)
    end
  end

  def message_notify(object)
    if act_create?
      "Add new #{object.model_name.name.downcase} successfully"
    else
      "Update #{object.model_name.name.downcase} successfully"
    end
  end

  def link_assets(*links)
    links -= ["", nil]
    type = File.extname(links.first).delete(".")
    html = ""
    case type
    when "css", "scss"
      links.each { |link| html += stylesheet_link_tag asset_path(link) }
    when "js"
      links.each { |link| html += javascript_include_tag asset_path(link) }
    end
    html.html_safe
  end
end
