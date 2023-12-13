// Define an array of GeoJSON file URLs in the desired order
export const jsonUrls = [ 
    './static/meta.json'
  ];
  
  // Define an array of GeoJSON file URLs in the desired order
  export const geoJsonUrls = [
    './static/flensburg_stadtteile.geojson',
    './static/flensburg_details.geojson'
  ];
  
  let currentClickedLayer = null;
  let currentClickedMarker = null;
  let metaDataArray = null;
  
  export const circleMarkers = [];
  export const geoJsonLayers = [];
  
  export const style1 = {
    fillColor: '#fff',
    fillOpacity: .6,
    color: '#989898',
    weight: 2,
  };
  
  export const style2 = {
  };
  
  export const style3 = {
  };
  
  // Define different pointToLayer functions with an index parameter
  export const pointToLayerFunctions = [
    (feature, latlng, index) => {
      latlng.on('click', function (e) {
        console.debug('0')
      })
    },
    (feature, latlng, index) => {
      // Calculate the radius based on the current zoom level
      const zoom = map.getZoom();
      const radius = calculateRadius(zoom);
  
      // Custom pointToLayer logic for the third GeoJSON layer
      const circleMarker = L.circleMarker(latlng, { 
        weight: 0,
        radius: radius,
        color: '#00367D',
        fillOpacity: 1
      });
  
      const year = feature.properties.ujahr
      const utyp1 = getMetaValue(metaDataArray.utyp1, feature.properties.utyp1);
  
      // Add a tooltip to the CircleMarker
      const label = `${utyp1.name}, ${year}`;
  
      circleMarker.bindTooltip(label);
  
      // Add an onClick event handler to each CircleMarker
      circleMarker.on('click', function (e) {
        const currentZoom = map.getZoom();
  
        // Set minimum zoom level
        let zoomView = 18;
  
        if (zoomView < currentZoom) {
          zoomView = currentZoom;
        }
  
        // Center the map on the CircleMarker's location
        map.setView(latlng, zoomView);
  
        const detail = {
          ukategorie: getMetaValue(metaDataArray.ukategorie, e.target.feature.properties.ukategorie),
          uwochentag: getMetaValue(metaDataArray.uwochentag, e.target.feature.properties.uwochentag),
          umonat: getMetaValue(metaDataArray.umonat, e.target.feature.properties.umonat),
          ujahr: feature.properties.ujahr,
          ustunde: removeLeadingZero(feature.properties.ustunde),
          uland: getMetaValue(metaDataArray.uland, e.target.feature.properties.uland),
          utyp1: getMetaValue(metaDataArray.utyp1, e.target.feature.properties.utyp1),
          uart: getMetaValue(metaDataArray.uart, e.target.feature.properties.uart),
          ulichtverh: getMetaValue(metaDataArray.ulichtverh, e.target.feature.properties.ulichtverh),
          istrad: getMetaValue(metaDataArray.istrad, e.target.feature.properties.istrad),
          istpkw: getMetaValue(metaDataArray.istpkw, e.target.feature.properties.istpkw),
          istfuss: getMetaValue(metaDataArray.istfuss, e.target.feature.properties.istfuss),
          istgkfz: getMetaValue(metaDataArray.istgkfz, e.target.feature.properties.istgkfz),
          istkrad: getMetaValue(metaDataArray.istkrad, e.target.feature.properties.istkrad),
          istsonstig: getMetaValue(metaDataArray.istsonstig, e.target.feature.properties.istsonstig)
        }
  
        let details = '';
        let detailOutput = '';
        const incident = [];

        for (const key of Object.keys(detail)) {
          const value = detail[key];
         
          if (value !== undefined) {
            if (key === 'ukategorie' && value) {
              incident["ukategorie"] = value.name;
              details += `<li class="text-xl font-black text-primary pb-2">${value.name}</li>`
            }
            if (key === 'umonat') {
              incident["month"] = value.name;
              //details += `<li><strong>Monat</strong> ${value.name}</li>`
            }
  
            if (key === 'uland') {
              incident["land"] = value;
             // detailOutput += `<li><strong>Bundesland</strong> ${value.name}</li>`
            }
  
            if (key === 'ujahr') {
              incident["year"] = value;
              //details += `<li><strong>Jahr</strong> ${value}</li>`
            }
  
            if (key === 'ustunde') {
              incident["time"] = value;
              //details += `<li><strong>Ungefähr</strong> ${value} Uhr</li>`
            }
  
            if (key === 'uwochentag') {
              incident["day"] = value.name;
              //details += `<li><strong>Tag</strong> ${value.name}</li>`
            }
  
            if (key === 'istrad') {
              incident["istrad"] = value.name;
              details += `<li class="pb-2"><i class="icon icon-bike"></i> ${value.name}</li>`
            }
  
            if (key === 'istpkw') {
              incident["istpkw"] = value.name;
              details += ` <li class="pb-2"><i class="icon icon-car"></i> ${value.name}</li>`
            }
  
            if (key === 'istfuss') {
              incident["istfuss"] = value.name;
              details += ` <li class="pb-2"><i class="icon icon-walk"></i> ${value.name}</li>`
            }
  
            if (key === 'istgkfz') {
              incident["istgkfz"] = value.name;
              details += ` <li class="pb-2"><i class="icon icon-lkw"></i> ${value.name}</li>`
            }
  
            if (key === 'istkrad') {
              incident["istkrad"] = value.name;
              details += ` <li class="pb-2"><i class="icon icon-motorcycle"></i> ${value.name}</li>`
            }
  
            if (key === 'istsonstig') {
              incident["istsonstig"] = value.name;
              details += ` <li class="pb-2"><i class="icon icon-vehicle"></i> ${value.name}</li>`
            }  
  
            if (key === 'ulichtverh') {
              incident["ulichtverh"] = value.name;
              details += ` <li class="pb-2"><strong>Lichtverhältnisse</strong> <i class="icon icon-sun"></i> ${value.name}</li>`
            }
  
            if (key === 'utyp1') {
              incident["utyp1"] = value.name;
              details += ` <li class="pb-2"><strong>Unfalltyp: </strong> ${value.name}</li>`
            }
  
            if (key === 'uart') {
              incident["uart"] = value.name;
              details += ` <li class="pb-2"><strong>Unfallart: </strong> ${value.name}</li>`
            }
          }
        }
        detailOutput = `
          <li><span class="text-gray text-sm font-light">${incident.month}.${incident.year} ${incident.day}s ca.${incident.time}:00 Uhr</span></li>
          ${details}
        `
        circleMarker.bindPopup(`<ul class="data"> ${detailOutput}</ul>`).openPopup();
      
        // Trigger click events on CircleMarkers in previous GeoJSON layers
        geoJsonLayers[index - 1].fire('click')
      });
  
      return circleMarker;
    },
  ];
  
  // Define different onEachFeature functions with an index parameter
  export const onEachFeatureFunctions = [
    (feature, layer, index) => {
      // Add a click event handler for each layer
      layer.on('click', function () {
        // Check if there was a previously clicked layer
        if (currentClickedLayer) {
          // Reset the fill color of the previously clicked layer
          currentClickedLayer.setStyle({ fillColor: '#fff' });
        }
  
        // Set the fill color of the clicked layer
        layer.setStyle({ fillColor: '#d1e4fd' });
  
        // Update the currently clicked layer
        currentClickedLayer = layer;
      });
    },
    (feature, layer, index) => {
      // Add a click event handler for each layer
      layer.on('click', function () {
        // Check if there was a previously clicked marker
        if (currentClickedMarker) {
          // Reset the color of the previously clicked marker
          currentClickedMarker.setStyle({ fillColor: '#5B96E3' });
        }
  
        // Set the fill color of the clicked marker
        layer.setStyle({ fillColor: '#F00' }); 
  
        // Update the currently clicked layer
        currentClickedMarker = layer;
      });
    },
    (feature, layer, index) => {
      // Custom logic for the third GeoJSON layer with index = 2
    },
  ];
  
  export const styles = [style1, style2, style3];
  
  // Initialize map
  export const map = L.map('map', {
    maxZoom: 19
  }).setView([54.7836, 9.4121], 2)
  
  L.tileLayer.wms('https://sgx.geodatenzentrum.de/wms_basemapde?SERVICE=WMS&Request=GetCapabilities', {
    layers: 'de_basemapde_web_raster_grau',
    maxZoom: 19, 
    attribution: '<a href="https://www.bkg.bund.de">GeoBasis-DE BKG</a> | <a href="https://creativecommons.org/licenses/by/4.0">CC BY 4.0</a>'
  }).addTo(map);
  
  /* L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  }).addTo(map); */
  
  // Create an array of jsonPromises for fetching JSON data
  export const jsonPromises = jsonUrls.map((url, index) =>
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        return data;
      })
  );
  
  // Create an array of geoJsonPromises for fetching GeoJSON data
  export const geoJsonPromises = geoJsonUrls.map((url, index) =>
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        localStorage.setItem('data',JSON.stringify(data))
        let geojsonLayer
        
        if (index === geoJsonUrls.length - 1) {
          geojsonLayer = L.geoJSON(data, {
            pointToLayer: (feature, latlng) => {
              // Call the corresponding pointToLayer function with the index parameter
              return pointToLayerFunctions[index](feature, latlng, index);
            },
            onEachFeature: (feature, layer) => {
              // Call the corresponding onEachFeature function with the index parameter
              onEachFeatureFunctions[index](feature, layer, index);
            },
          });
        } else {
          // For other layers, use the default onEachFeature function
          geojsonLayer = L.geoJSON(data, {
            style: styles[index],
            onEachFeature: (feature, layer) => {
              // Call the corresponding onEachFeature function with the index parameter
              onEachFeatureFunctions[index](feature, layer, index);
            },
          });
        }
  
        // Store the GeoJSON layer in the geoJsonLayers array
        geoJsonLayers.push(geojsonLayer);
  
        return geojsonLayer;
      })
  );
  
  // Define a click event handler
  export function handleLayerClick(event) {
    // Perform your custom action here, using event properties
    console.log('Click event:', event);
  
    // Example: Change the style of the clicked layer
    event.target.setStyle({ fillColor: 'red' });
  }
  
  // Use Promise.all to wait for all geoJsonPromises to resolve
  Promise.all(jsonPromises)
   .then((data) => {
      let tmpData = data
  
      while (Array.isArray(tmpData) && tmpData.length === 1) {
        tmpData = tmpData[0];
      }
  
      metaDataArray = tmpData;
    })
    .catch((error) => {
      console.error('Error fetching GeoJSON data:', error);
    });
  
  // Use Promise.all to wait for all geoJsonPromises to resolve
  Promise.all(geoJsonPromises)
   .then((layers) => {
      layers[0].addTo(map)
      layers[1].addTo(map)
  
      // Calculate the bounds based on all GeoJSON layers
      const bounds = L.featureGroup(layers).getBounds();
  
      const center = bounds.getCenter();
      const newLatitude = center.lat + 0.01;
      const newCenter = L.latLng(newLatitude, center.lng);
  
      map.setView(newCenter, 13);
  
      // Event listener to update circle marker radius when zoom changes
      map.on('zoomend', function () {
        const zoom = map.getZoom();
  
        layers[1].eachLayer(function (layer) {
          const radius = calculateRadius(zoom);
  
          layer.setStyle({ radius: radius }); 
        }); 
      });
  
      // Create a LayerGroup and add your layers to it
      const layerGroup = L.layerGroup(...layers);
  
      // Add a click event listener to the LayerGroup
      layerGroup.on('click', handleLayerClick);
    })
    .catch((error) => {
      console.error('Error fetching GeoJSON data:', error);
    });
  
  export function getMetaValue(array, property) {
    return array.find((item) => item.id === removeLeadingZero(property));
  }
  
  export function removeLeadingZero(inputString) {
    if (inputString !== null && inputString.startsWith('0')) {
      return parseInt(inputString.substring(1));
    }
  
    return parseInt(inputString);
  }
  
  export function calculateRadius(zoom) {
    let value
  
    if (zoom >= 16) {
      value = 6
    }
    else if (zoom >= 13 && zoom < 16) {
      value = 4
    }
    else if (zoom < 13) {
      value = 2
    }
  
    return value
  }

  