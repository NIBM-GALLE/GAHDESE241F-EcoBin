"use client";

import { useEffect, useState } from "react";
import { getCurrentUser, updateUserProfile, User } from "@/firebase/db";
import Sidebar from "@/components/Sidebar";


const Profile = () => {
    const [user, setUser] = useState<User | null>(null);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
  });

  // Fetch user data when the component loads
  useEffect(() => {
    const fetchUserData = async () => {
      const userData = await getCurrentUser();
      if (userData) {
        setUser(userData);
        setFormData({
          name: userData.name || "",
          email: userData.email || "",
          phone: userData.phone || "",
          address: userData.address || "",
        });
      }
    };

    fetchUserData();
  }, []);

  // Handle input change
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Handle profile update
  const handleUpdate = async () => {
    if (user) {
      await updateUserProfile(user.id, formData);
    } else {
      alert("User data is not available.");
    }
    alert("Profile updated successfully!");
  };

  if (!user) return <p className="text-center mt-10">Loading...</p>;

  return (
    <div className="flex">
      <Sidebar />
      <main className="ml-64 p-8 w-full bg-gray-100 min-h-screen">
        <h1 className="text-3xl font-bold mb-4">User Profile</h1>

        <div className="bg-white p-6 rounded-lg shadow-md max-w-lg">
          <h2 className="text-xl font-bold mb-4">Personal Information</h2>

          <div className="space-y-4">
            <div>
              <label className="block text-gray-700">Name:</label>
              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
                className="w-full p-2 border rounded"
              />
            </div>

            <div>
              <label className="block text-gray-700">Email:</label>
              <input
                type="email"
                name="email"
                value={formData.email}
                readOnly
                className="w-full p-2 border rounded bg-gray-100"
              />
            </div>

            <div>
              <label className="block text-gray-700">Phone:</label>
              <input
                type="text"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                className="w-full p-2 border rounded"
              />
            </div>

            <div>
              <label className="block text-gray-700">Address:</label>
              <input
                type="text"
                name="address"
                value={formData.address}
                onChange={handleChange}
                className="w-full p-2 border rounded"
              />
            </div>

            <button
              onClick={handleUpdate}
              className="bg-blue-500 text-white p-2 rounded w-full hover:bg-blue-600"
            >
              Update Profile
            </button>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Profile;
