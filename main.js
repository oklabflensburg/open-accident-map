// Define an array of GeoJSON file URLs in the desired order
const jsonUrls = [ 
  './static/meta.json'
];

// Define an array of GeoJSON file URLs in the desired order
const geoJsonUrls = [
  './static/flensburg_stadtteile.geojson',
  './static/flensburg_details.geojson'
];

let currentClickedLayer = null;
let metaDataArray = null;

const circleMarkers = [];
const geoJsonLayers = [];

const style1 = {
  fillColor: '#011936',
  color: '#011936',
  weight: 1,
  opacity: .7,
};

const style2 = {
};

const style3 = {
};

// Define different pointToLayer functions with an index parameter
const pointToLayerFunctions = [
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
      color: '#f95016',
      fillOpacity: 1
    });

    const year = feature.properties.ujahr
    const tooltip = getMetaName(metaDataArray.utyp1, feature.properties.utyp1);

    // Add a tooltip to the CircleMarker
    const label = `${tooltip.utyp1}, ${year}`;

    circleMarker.bindTooltip(label);

    // Add an onClick event handler to each CircleMarker
    circleMarker.on('click', function (e) {
      // Center the map on the CircleMarker's location
      map.setView(latlng, 17);

      const detail = {
        ukategorie: getMetaName(metaDataArray.ukategorie, e.target.feature.properties.ukategorie),
        uwochentag: getMetaName(metaDataArray.uwochentag, e.target.feature.properties.uwochentag),
        umonat: getMetaName(metaDataArray.umonat, e.target.feature.properties.umonat),
        ujahr: feature.properties.ujahr,
        ustunde: removeLeadingZero(feature.properties.ustunde),
        uland: getMetaName(metaDataArray.uland, e.target.feature.properties.uland),
        utyp1: getMetaName(metaDataArray.utyp1, e.target.feature.properties.utyp1),
        uart: getMetaName(metaDataArray.uart, e.target.feature.properties.uart),
        ulichtverh: getMetaName(metaDataArray.ulichtverh, e.target.feature.properties.ulichtverh),
        istrad: getMetaName(metaDataArray.istrad, e.target.feature.properties.istrad),
        istpkw: getMetaName(metaDataArray.istpkw, e.target.feature.properties.istpkw),
        istfuss: getMetaName(metaDataArray.istfuss, e.target.feature.properties.istfuss),
        istgkfz: getMetaName(metaDataArray.istgkfz, e.target.feature.properties.istgkfz),
        istkrad: getMetaName(metaDataArray.istkrad, e.target.feature.properties.istkrad),
        istsonstig: getMetaName(metaDataArray.istsonstig, e.target.feature.properties.istsonstig)
      }

      console.log(detail);
      let detailOutput = '';

      for (const key of Object.keys(detail)) {
        const value = detail[key];

        if (value !== undefined) {
          if (key === 'umonat') {
            detailOutput += `<li class="xxx"><strong>Monat</strong> ${value.umonat}</li>`
          }

          if (key === 'uland') {
            detailOutput += `<li class="xxx"><strong>Bundesland</strong> ${value.uland}</li>`
          }

          if (key === 'ujahr') {
            detailOutput += `<li class="xxx"><strong>Jahr</strong> ${value}</li>`
          }

          if (key === 'ustunde') {
            detailOutput += `<li class="xxx"><strong>Ungefähr</strong> ${value} Uhr</li>`
          }

          if (key === 'uwochentag') {
            detailOutput += `<li class="xxx"><strong>Tag</strong> ${value.uwochentag}</li>`
          }

          if (key === 'istrad') {
            detailOutput += `<li class="xxx"><strong>-</strong> ${value.istrad}</li>`
          }

          if (key === 'istpkw') {
            detailOutput += `<li class="xxx"><strong>-</strong> ${value.istpkw}</li>`
          }

          if (key === 'istfuss') {
            detailOutput += `<li class="xxx"><strong>-</strong> ${value.istfuss}</li>`
          }

          if (key === 'istgkfz') {
            detailOutput += `<li class="xxx"><strong>-</strong> ${value.istgkfz}</li>`
          }

          if (key === 'istkrad') {
            detailOutput += `<li class="xxx"><strong>-</strong> ${value.istkrad}</li>`
          }

          if (key === 'istsonstig') {
            detailOutput += `<li class="xxx"><strong>Beteiligung</strong> ${value.istsonstig}</li>`
          }

          if (key === 'ukategorie') {
            detailOutput += `<li class="text-xl"><strong>${value.ukategorie}</strong></li>`
          }

          if (key === 'ulichtverh') {
            detailOutput += `<li class="xxx"><strong>Lichtverhältnisse</strong> ${value.ulichtverh}</li>`
          }

          if (key === 'utyp1') {
            detailOutput += `<li class="xxx"><strong>Unfalltyp</strong> ${value.utyp1}</li>`
          }

          if (key === 'uart') {
            detailOutput += `<li class="xxx"><strong>Unfallart</strong> ${value.uart}</li>`
          }
        }
      }

      const element = document.querySelector('#details');
      element.innerHTML = `<ul class="p-3 space-y-2 bg-gray-700 text-white mb-4 md:mb-8"> ${detailOutput}</ul>`;

      // Trigger click events on CircleMarkers in previous GeoJSON layers
      geoJsonLayers[index - 1].fire('click')
    });

    return circleMarker;
  },
];

// Define different onEachFeature functions with an index parameter
const onEachFeatureFunctions = [
  (feature, layer, index) => {
    // Add a click event handler for each layer
    layer.on('click', function () {
      // Check if there was a previously clicked layer
      if (currentClickedLayer) {
        // Reset the fill color of the previously clicked layer
        currentClickedLayer.setStyle({ fillColor: '#011936' });
      }

      // Set the fill color of the clicked layer
      layer.setStyle({ fillColor: 'yellow' });

      // Update the currently clicked layer
        currentClickedLayer = layer;
    });
  },
  (feature, layer, index) => {
    // Custom logic for the second GeoJSON layer with index = 1
  },
  (feature, layer, index) => {
    // Custom logic for the third GeoJSON layer with index = 2
  },
];

const styles = [style1, style2, style3];

// Initialize map
const map = L.map('map', {
  maxZoom: 19
}).setView([54.7836, 9.4121], 2)

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
  maxZoom: 19,
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(map)

// Create an array of jsonPromises for fetching JSON data
const jsonPromises = jsonUrls.map((url, index) =>
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      return data;
    })
);

// Create an array of geoJsonPromises for fetching GeoJSON data
const geoJsonPromises = geoJsonUrls.map((url, index) =>
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
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
function handleLayerClick(event) {
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

function getMetaName(array, property) {
  return array.find((item) => item.id === removeLeadingZero(property));
}

function removeLeadingZero(inputString) {
  if (inputString.startsWith('0')) {
    return parseInt(inputString.substring(1));
  }

  return parseInt(inputString);
}

function calculateRadius(zoom) {
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