window.Application ||= {}

class Application.LocationsMap
  constructor: (container_id, lat, lng) ->
    @map = new GMaps({
      div: container_id,
      zoom: 16,
      mapType: 'Satellite'
      lat: lat,
      lng: lng,
    });

  addLocations: (locations) ->
    for location in locations
      @map.addMarker {
        lat: location['latitude'],
        lng: location['longitude'],
        title: location['name']
      }
