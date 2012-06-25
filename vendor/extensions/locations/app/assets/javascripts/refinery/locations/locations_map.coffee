window.Application ||= {}

class Application.LocationsMap
  constructor: (container_id, center) ->
    @map = new GMaps {
      div: container_id,
      zoom: 16,
      mapType: 'Satellite'
      lat: center[0],
      lng: center[1]
    }

  updateLocation: (location, e) =>
    $('#location_preview .location_name').text(location['name'])
    $('#location_preview .description_preview').text(location['description_preview'])

  addLocations: (locations) ->
    @locations = locations
    for location in @locations
      @map.addMarker {
        lat: location['latitude'],
        lng: location['longitude'],
        title: location['name'],
        infoWindow: {content: location['name']}
        click: (e)=>
          this.updateLocation(location, e)
      }
