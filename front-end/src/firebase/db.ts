import { getDatabase, ref, onValue } from "firebase/database";
import { app } from "./firebaseConfig"; // Firebase initialization
import { db } from "./firebaseConfig";
import { collection, doc, getDocs, updateDoc, deleteDoc, getDoc } from "firebase/firestore";
import { auth } from "./firebaseConfig";
import { User } from "../types/User";


export const fetchBinsData = (setBins: (data: any) => void) => {
  const db = getDatabase(app);
  const binsRef = ref(db, "wasteBins");

  onValue(binsRef, (snapshot) => {
    if (snapshot.exists()) {
      setBins(snapshot.val());
    } else {
      setBins(null);
    }
  });
};

// 📌 Fetch the current user's data
export const getCurrentUser = async (): Promise<User | null> => {
  const user = auth.currentUser;
  if (!user) return null;

  const userDoc = await getDoc(doc(db, "users", user.uid));

  if (!userDoc.exists()) return null;

  // Ensure all expected fields exist
  const data = userDoc.data();
  return {
    id: user.uid,
    name: data.name || "",
    email: data.email || "",
    phone: data.phone || "",
    address: data.address || "",
    role: data.role || "user",
  };
};

// 📌 Update user profile data
export const updateUserProfile = async (userId: string, updatedData: any) => {
  const userRef = doc(db, "users", userId);
  await updateDoc(userRef, updatedData);
};

// 📌 Fetch all users
export const getAllUsers = async () => {
  const usersRef = collection(db, "users");
  const snapshot = await getDocs(usersRef);
  return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
};

// 📌 Update user role
export const updateUserRole = async (userId: string, newRole: string) => {
  const userRef = doc(db, "users", userId);
  await updateDoc(userRef, { role: newRole });
};

// 📌 Delete user
export const deleteUser = async (userId: string) => {
  const userRef = doc(db, "users", userId);
  await deleteDoc(userRef);
};





export type { User };

