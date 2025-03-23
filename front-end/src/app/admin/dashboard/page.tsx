"use client";
import { useEffect, useState } from "react";
import Sidebar from "../../../components/Sidebar";
import { fetchBinsData } from "../../../firebase/db";
import GoogleMapComponent from "@/components/GoogleMap";

const AdminDashboard = () => {
  const [bins, setBins] = useState<any>(null);

  useEffect(() => {
    fetchBinsData(setBins);
  }, []);

  if (!bins) return <p className="text-center mt-10">Loading...</p>;

  return (
    <div className="flex">
      <Sidebar />
      <main className="ml-64 p-8 w-full bg-gray-100 min-h-screen">
        <h1 className="text-3xl font-bold mb-4">Admin Dashboard</h1>
        <p className="text-gray-600">Manage waste bins, users, and alerts.</p>

        <div className="bg-white p-6 rounded-lg shadow mt-8">
          <h2 className="text-xl font-bold mb-4">Bin Locations</h2>
          <GoogleMapComponent />
        </div>

        {/* 📌 Bin Data Table */}
        <div className="bg-white p-6 rounded-lg shadow mt-6">
          <h2 className="text-xl font-bold mb-4">All Waste Bins</h2>
          <table className="w-full border-collapse">
            <thead>
              <tr className="bg-gray-200 text-gray-700">
                <th className="p-3 text-left">ID</th>
                <th className="p-3 text-left">Location</th>
                <th className="p-3 text-left">Fill Level</th>
                <th className="p-3 text-left">Status</th>
              </tr>
            </thead>
            <tbody>
              {Object.values(bins).map((bin: any, index) => {
                const levelPercentage = bin.wasteLevel;
                return (
                  <tr key={index} className="border-b">
                    <td className="p-3">{bin.id}</td>
                    <td className="p-3">{bin.location}</td>
                    <td className="p-3">{levelPercentage.toFixed(1)}%</td>
                    <td className={`p-3 font-semibold ${levelPercentage >= 75 ? "text-red-500" : levelPercentage >= 40 ? "text-yellow-500" : "text-green-500"}`}>
                      {levelPercentage >= 75 ? "Full" : levelPercentage >= 40 ? "Half-Full" : "Low"}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </main>
    </div>
  );
};

export default AdminDashboard;
