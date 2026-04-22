import React, { useEffect, useState } from "react";
import { MapContainer, TileLayer, GeoJSON, Marker, Popup, useMapEvents } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

import markerIcon from "leaflet/dist/images/marker-icon.png";
import markerShadow from "leaflet/dist/images/marker-shadow.png";

delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconUrl: markerIcon,
  shadowUrl: markerShadow
});

function App() {
  const [geoData, setGeoData] = useState(null);
  const [token, setToken] = useState(localStorage.getItem("token") || "");

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const [selectedPos, setSelectedPos] = useState(null);
  const [form, setForm] = useState({
    nama: "",
    jenis: "bus",
    lat: "",
    lon: ""
  });

  // ================= LOAD DATA =================
  const loadData = () => {
    fetch("http://127.0.0.1:8000/geojson")
      .then(res => res.json())
      .then(data => setGeoData(data));
  };

  useEffect(() => {
    loadData();
  }, []);

  // ================= LOGIN =================
  const handleLogin = async () => {
    const formData = new URLSearchParams();
    formData.append("username", username);
    formData.append("password", password);

    const res = await fetch("http://127.0.0.1:8000/token", {
      method: "POST",
      body: formData
    });

    const data = await res.json();

    if (data.access_token) {
      setToken(data.access_token);
      localStorage.setItem("token", data.access_token);
      alert("Login berhasil");
    } else {
      alert("Login gagal");
    }
  };

  // ================= ADD =================
  const handleAdd = async () => {
    if (!token) return alert("Login dulu!");

    await fetch("http://127.0.0.1:8000/halte", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(form)
    });

    setSelectedPos(null);
    loadData();
  };

  // ================= DELETE =================
  window.deleteMarker = async (id) => {
    await fetch(`http://127.0.0.1:8000/halte/${id}`, {
      method: "DELETE"
    });

    loadData();
  };

  // ================= CLICK MAP =================
  function MapClickHandler() {
    useMapEvents({
      click(e) {
        const { lat, lng } = e.latlng;
        setSelectedPos([lat, lng]);
        setForm({ ...form, lat, lon: lng });
      }
    });
    return null;
  }

  return (
    <div style={{ height: "100vh" }}>
      <MapContainer center={[-5.4, 105.26]} zoom={12} style={{ height: "100%" }}>
        
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        <MapClickHandler />

        {geoData && (
          <GeoJSON
            data={geoData}
            coordsToLatLng={(coords) => [coords[1], coords[0]]}

            pointToLayer={(feature, latlng) => {
              let color = "blue";
              if (feature.properties.jenis === "brt") color = "red";
              if (feature.properties.jenis === "bus") color = "green";
              if (feature.properties.jenis === "angkot") color = "orange";

              return L.circleMarker(latlng, {
                radius: 6,
                fillColor: color,
                color: "#000",
                weight: 1,
                fillOpacity: 0.8
              });
            }}

            onEachFeature={(feature, layer) => {
              layer.bindPopup(`
                <b>${feature.properties.nama}</b><br/>
                ${feature.properties.jenis}<br/>
                <button onclick="window.deleteMarker(${feature.properties.id})">Hapus</button>
              `);
            }}
          />
        )}

        {selectedPos && (
          <Marker position={selectedPos}>
            <Popup>
              <input placeholder="Nama"
                onChange={(e) => setForm({...form, nama: e.target.value})} /><br/>

              <select onChange={(e) => setForm({...form, jenis: e.target.value})}>
                <option value="bus">Bus</option>
                <option value="brt">BRT</option>
                <option value="angkot">Angkot</option>
              </select><br/><br/>

              <button onClick={handleAdd}>Simpan</button>
            </Popup>
          </Marker>
        )}

      </MapContainer>

      {/* LOGIN FORM (POJOK KANAN ATAS) */}
      <div style={{
        position: "absolute",
        top: 10,
        right: 10,
        background: "white",
        padding: "12px",
        borderRadius: "10px",
        zIndex: 1000,
        boxShadow: "0 0 10px rgba(0,0,0,0.3)"
      }}>
        <b>Login</b><br/>

        <input
          placeholder="Username"
          onChange={e => setUsername(e.target.value)}
          style={{ marginBottom: "5px", width: "120px" }}
        /><br/>

        <input
          type="password"
          placeholder="Password"
          onChange={e => setPassword(e.target.value)}
          style={{ marginBottom: "5px", width: "120px" }}
        /><br/>

        <button onClick={handleLogin}>Login</button>

        <div style={{ fontSize: "12px", marginTop: "5px" }}>
          {token ? "✔ Login aktif" : "❌ Belum login"}
        </div>
      </div>

    </div>
  );
}

export default App;
