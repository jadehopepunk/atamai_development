# encoding: utf-8

module PropertiesHelper
  def gst_ex_price(value)
    in_dollars(value.to_s) + " + GST" if value
  end

  def in_dollars(value)
    number_to_currency(value, :precision => 0, :unit => '$') if value
  end

  def in_sqm(value_in_sqm)
    "#{value_in_sqm} m²" if value_in_sqm
  end

  def in_acres(value_in_sqm)
    if value_in_sqm
      result = (value_in_sqm / 4046.8564224).to_s
      "(approx #{number_with_precision(result)} acres)"
    end
  end

  def availability_class(value)
    if value
      'availability_' + value.gsub(' ', '_').downcase
    end
  end
end