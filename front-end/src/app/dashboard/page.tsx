"use client";

import { useEffect, useState } from "react";
import Sidebar from "../../components/Sidebar";
import { fetchBinsData } from "../../firebase/db";
import { Doughnut, Bar } from "react-chartjs-2";
import { Chart, ArcElement, Tooltip, Legend, CategoryScale, LinearScale, BarElement } from "chart.js";
import GoogleMapComponent from "@/components/GoogleMap";

Chart.register(ArcElement, Tooltip, Legend, CategoryScale, LinearScale, BarElement);

const UserDashboard = () => {
  const [bins, setBins] = useState<any>(null);

  useEffect(() => {
    fetchBinsData(setBins);
  }, []);

  if (!bins) return <p className="text-center mt-10">Loading bins data...</p>;

  // Convert wasteLevel from decimal to percentage
  const binLevels = Object.values(bins).map((bin: any) => bin.wasteLevel);
  const binLocations = Object.values(bins).map((bin: any) => bin.location);
  const fullBins = binLevels.filter((level) => level >= 75).length;

  return (
    <div className="flex">
      <Sidebar />
      <main className="ml-64 p-8 w-full bg-gray-100 min-h-screen">
        <h1 className="text-3xl font-bold mb-4">User Dashboard</h1>
        <p className="text-gray-600">Track your waste bins and access services.</p>

        {/* 📌 Bin Statistics */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-6">
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-bold">Total Bins</h2>
            <p className="text-2xl font-semibold">{Object.keys(bins).length}</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-bold">Full Bins</h2>
            <p className="text-2xl font-semibold">{fullBins}</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-bold">Average Fill Level</h2>
            <p className="text-2xl font-semibold">{(binLevels.reduce((a, b) => a + b, 0) / binLevels.length).toFixed(1)}%</p>
          </div>
        </div>

        <div className="bg-white p-6 rounded-lg shadow mt-8">
           <h2 className="text-xl font-bold mb-4">Bin Locations</h2>
            <GoogleMapComponent />
        </div>

        {/* 📌 Charts */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4" >
          {/* Doughnut Chart: Bin Status */}
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-bold mb-4">Bin Fill Levels</h2>
            <Doughnut
              data={{
                labels: ["Full (75-100%)", "Half-Full (40-74%)", "Low (0-39%)"],
                datasets: [
                  {
                    label: "Bins",
                    data: [
                      binLevels.filter((level) => level >= 75).length,
                      binLevels.filter((level) => level >= 40 && level < 75).length,
                      binLevels.filter((level) => level < 40).length,
                    ],
                    backgroundColor: ["#ff4d4d", "#ffcc00", "#66cc66"],
                  },
                ],
              }}
            />
          </div>

          {/* Bar Chart: Bin Levels by Location */}
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-bold mb-4">Waste Levels by Location</h2>
            <Bar
              data={{
                labels: binLocations,
                datasets: [
                  {
                    label: "Fill Level (%)",
                    data: binLevels,
                    backgroundColor: "#007bff",
                  },
                ],
              }}
              options={{ responsive: true }}
            />
          </div>
        </div>
      </main>
    </div>
  );
};

export default UserDashboard;
