<template>
  <div>
    <div id="info" class="bg-red-600 text-white p-4 z-50">Nothing selected</div>
    <div id="map" style="height: 100vh; background-color: azure" ref="map"></div>
  </div>
</template>
<script>
import {APISettings} from '@/api/config.js'

import {ref} from 'vue'
import Map from 'ol/Map'
import {fromLonLat, transformExtent} from 'ol/proj'
import {createEmpty} from 'ol/extent'
import {GeoJSON} from 'ol/format'
import TileLayer from "ol/layer/Tile"
import {View} from "ol"
import {Style, Icon, Circle, Stroke} from "ol/style"
import VectorSource from 'ol/source/Vector'
import VectorLayer from "ol/layer/Vector";
import {OSM} from "ol/source";


export default {
  data() {
    return {
      center: ref(fromLonLat([9.438259373563051, 54.783414127446065])),
      projection: ref('EPSG:3857'),
      vectorLayer: ref(null),
      fetchError: ref(null),
      geoData: ref([]),
      map: ref(null),
      zoom: ref(14)
    }
  },
  mounted() {
    const route = useRoute()
    const municipality = route.params.municipality
    // this.loadData(municipality)

    const image = new Circle({
      radius: 5,
      fill: 'white',
      stroke: new Stroke({color: 'red', width: 1}),
    })

    const styles = {
      'Point': new Style({
        image: image,
      })
    }

    const iconStyle = new Style({
      image: new Icon({
        anchor: [0.5, 46],
        anchorXUnits: 'fraction',
        anchorYUnits: 'pixels',
        src: '/marker-icon-red.png',
      })
    })

    const styleFunction = function (feature) {
      return styles[feature.getGeometry().getType()]
    }

    const tileLayer = new TileLayer({
      source: new OSM()
    })

    const map = new Map({
      target: "map",
      layers: [
        tileLayer
      ],
      view: new View({
        center: this.center,
        projection: this.projection,
        zoom: this.zoom
      })
    })

    const vectorSource = new VectorSource({
      url: APISettings.baseURL + municipality,
      format: new GeoJSON({
        dataProjection: 'EPSG:4326',
        featureProjection: 'EPSG:3857'
      })
    })

    const vectorLayer = new VectorLayer({
      source: vectorSource,
      style: iconStyle
    })

    vectorSource.once('change', function (e) {
      let self = this

      if (vectorSource.getState() === 'ready') {
        if (vectorLayer.getSource().getFeatures().length > 0) {
          map.getView().fit(vectorSource.getExtent(), {
            size: map.getSize(),
            padding: [100, 50, 50, 50],
            maxZoom: 16
          })
        }
      }
    })

    let highlight

    const displayFeatureInfo = function (pixel) {
      const feature = map.forEachFeatureAtPixel(pixel, function (feature) {
        return feature;
      });

      const info = document.getElementById('info')

      if (feature) {
        info.innerHTML = feature.get('uart') || '&nbsp;'
      } else {
        info.innerHTML = '&nbsp;'
      }

      if (feature !== highlight) {
        if (highlight) {
          featureOverlay.getSource().removeFeature(highlight)
        }

        if (feature) {
          featureOverlay.getSource().addFeature(feature)
        }

        highlight = feature
      }
    }

    map.on('pointermove', function (event) {
      if (event.dragging) {
        return
      }

      const pixel = map.getEventPixel(event.originalEvent)

      displayFeatureInfo(pixel)
    })

    map.on('click', function (event) {
      displayFeatureInfo(event.pixel)
    })

    this.map = map
    this.map.addLayer(vectorLayer)
  }
}
</script>

