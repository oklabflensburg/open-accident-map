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
let currentClickedMarker = null;
let metaDataArray = null;

const circleMarkers = [];
const geoJsonLayers = [];

const style1 = {
  fillColor: '#fff',
  fillOpacity: .6,
  color: '#989898',
  weight: 2,
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

      let detailOutput = '';

      for (const key of Object.keys(detail)) {
        const value = detail[key];

        if (value !== undefined) {
          if (key === 'umonat') {
            detailOutput += `<li><strong>Monat</strong> ${value.name}</li>`
          }

          if (key === 'uland') {
            detailOutput += `<li><strong>Bundesland</strong> ${value.name}</li>`
          }

          if (key === 'ujahr') {
            detailOutput += `<li><strong>Jahr</strong> ${value}</li>`
          }

          if (key === 'ustunde') {
            detailOutput += `<li><strong>Ungefähr</strong> ${value} Uhr</li>`
          }

          if (key === 'uwochentag') {
            detailOutput += `<li><strong>Tag</strong> ${value.name}</li>`
          }

          if (key === 'istrad') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'istpkw') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'istfuss') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'istgkfz') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'istkrad') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'istsonstig') {
            detailOutput += `<li><strong>-</strong> ${value.name}</li>`
          }

          if (key === 'ukategorie') {
            detailOutput += `<li class="text-xl"><strong>${value.name}</strong></li>`
          }

          if (key === 'ulichtverh') {
            detailOutput += `<li><strong>Lichtverhältnisse</strong> ${value.name}</li>`
          }

          if (key === 'utyp1') {
            detailOutput += `<li><strong>Unfalltyp</strong> ${value.name}</li>`
          }

          if (key === 'uart') {
            detailOutput += `<li><strong>Unfallart</strong> ${value.name}</li>`
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
        currentClickedMarker.setStyle({ fillColor: '#f95016' });
      }

      // Set the fill color of the clicked marker
      layer.setStyle({ fillColor: '#00f' }); 

      // Update the currently clicked layer
      currentClickedMarker = layer;
    });
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

function getMetaValue(array, property) {
  return array.find((item) => item.id === removeLeadingZero(property));
}

function removeLeadingZero(inputString) {
  if (inputString !== null && inputString.startsWith('0')) {
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