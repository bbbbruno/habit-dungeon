# frozen_string_literal: true

json.array! @levels do |level|
  json.extract! level, :id, :number, :title, :days
  json.destroy false
end
