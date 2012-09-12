xml.instruct!
xml.properties do
  @properties.each do |property|
    xml.property(:status => 'updated') do
      xml.reference_code property.id
      xml.location do
        xml.street property.address_street
        xml.city property.city
        xml.region property.state
        xml.country property.country_code
        xml.tag! 'postal-code', property.post_code
        xml.longitude property.longitude
        xml.latitude property.latitude
      end
      xml.features do
        xml.neighbourhood_is_farm true        
      end
      xml.price do
        xml.min property.total_price
        xml.currency 'NZD'      
      end
      xml.property_type 'Land'
      xml.link refinery.properties_property_url(property)
      xml.long_description strip_tags(property.description)
      xml.land_area_sqm property.land_area_sqm
      xml.images do
        property.images.each do |image|
          xml.image do
            xml.url image.url(:host => "http://#{request.host}")
          end
        end        
      end
    end
  end
end