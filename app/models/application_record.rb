class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ci_find(attribute, value)
    target_field = self.table_name + '.' + attribute
    quoted_value = ActiveRecord::Base.connection.quote(value.downcase)
    where("LOWER(#{target_field}) = #{quoted_value}")
    .first
  end

  def self.find_by(hash)
    order(:id).find_by(hash)
  end
end
