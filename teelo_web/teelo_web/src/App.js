import React, {useEffect, useState} from "react";
import {DataGrid} from "@mui/x-data-grid";
import axios from "axios";

const columns = [
  {field: "match_id", headerName: "Match ID", width: 130},
  {field: "player_A", headerName: "Player A", width: 130},
  {field: "player_B", headerName: "Player B", width: 130},
  {field: "tourney_name", headerName: "Tourney Name", width: 130},
  {field: "tourney_level", headerName: "Tourney Level", width: 130},
  {field: "surface", headerName: "Surface", width: 130},
  {field: "round", headerName: "Round", width: 130},
  {field: "A_elo", headerName: "A Elo", type: "number", width: 130},
  {field: "B_elo", headerName: "B Elo", type: "number", width: 130},
];

function App() {
  const [rows, setRows] = useState([]);

  useEffect(() => {
    const params = {
      player_name: "PlayerName", // replace with actual player name
      tourney_level: "Level", // replace with actual tourney level
      surface: "Surface", // replace with actual surface
    };

    axios.get("http://127.0.0.1:5000/matches", {params}).then((response) => {
      const matches = response.data;
      setRows(matches);
    });
  }, []);

  return (
    <div style={{height: 400, width: "100%"}}>
      <DataGrid rows={rows} columns={columns} pageSize={5} getRowId={(row) => row.match_id} checkboxSelection />
    </div>
  );
}

export default App;
