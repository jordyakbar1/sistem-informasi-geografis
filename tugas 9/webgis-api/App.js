import React, { useEffect, useState } from "react";
import { MapContainer, TileLayer, GeoJSON } from "react-leaflet";
import axios from "axios";
import "leaflet/dist/leaflet.css";

function App() {
  const [data, setData] = useState(null);

  // =========================
  // FETCH DATA DARI API FASTAPI
  // =========================
  useEffect(() => {
    axios.get("http://127.0.0.1:8000/geojson")
      .then((res) => {
        setData(res.data);
      })
      .catch((err) => {
        console.error(err);
      });
  }, []);

  // =========================
  // STYLE BERDASARKAN JENIS
  // =========================
  const styleByJenis = (feature) => {
    const jenis = feature.properties.jenis;

    if (jenis === "brt") {
      return { color: "red" };
    } else if (jenis === "bus") {
      return { color: "blue" };
    } else {
      return { color: "green" };
    }
  };

  // =========================
  // POPUP + INTERAKSI
  // =========================
  const onEachFeature = (feature, layer) => {
    const props = feature.properties;

    // popup
    layer.bindPopup(`
      <b>${props.nama}</b><br/>
      Jenis: ${props.jenis}
    `);

    // hover highlight
    layer.on({
      mouseover: (e) => {
        e.target.setStyle({
          weight: 5,
          color: "yellow"
        });
      },
      mouseout: (e) => {
        e.target.setStyle(styleByJenis(feature));
      }
    });
  };

  return (
    <MapContainer
      center={[-5.37, 105.22]} // 📍 wilayah kamu
      zoom={15}
      style={{ height: "100vh", width: "100%" }}
    >
      <TileLayer
        attribution='&copy; OpenStreetMap'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />

      {data && (
        <GeoJSON
          data={data}
          style={styleByJenis}
          onEachFeature={onEachFeature}
        />
      )}
    </MapContainer>
  );
}

export default App;
