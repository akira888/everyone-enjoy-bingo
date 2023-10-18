class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # enum の値を日本語化する
  # @see https://zenn.dev/farstep/articles/b1cebeaefd324b
  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end

  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, self.send("#{attr_name}"))
    end
end
