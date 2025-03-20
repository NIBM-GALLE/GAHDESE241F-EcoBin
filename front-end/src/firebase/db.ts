import { getDatabase, ref, onValue } from "firebase/database";
import { app } from "./firebaseConfig"; // Firebase initialization

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
