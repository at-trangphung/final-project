class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /[a-z\s.-]/i #The following regex allows letters, white space, dot and dash
      record.errors[attribute] << (options[:message] || I18n.t("invalid.name"))
    end
  end
end

