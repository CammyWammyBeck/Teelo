import React, {useState, useEffect} from "react";
import {useLocation} from "react-router-dom";
import {AppBar, Toolbar, Typography} from "@mui/material";
import {DataGrid} from "@mui/x-data-grid";
import axios from "axios";
import LineChart from "./LineChart";

function PlayerPage(props) {
  let {state} = useLocation();
  let playerName = state.playerName;

  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    axios
      .get("http://192.168.20.4:5000/get_player_elo", {
        params: {player_name: playerName},
      })
      .then((response) => {
        const values = response.data;
        setData(values);
        setLoading(false);
      })
      .catch((error) => {
        if (axios.isCancel(error)) {
          console.log("Request canceled", error.message);
        } else {
          console.log(error);
        }
        setLoading(false);
      });
  }, []);

  const [playerData, setPlayerData] = useState([]);

  useEffect(() => {
    axios
      .get("http://192.168.20.4:5000/get_player_info", {
        params: {player_name: playerName},
      })
      .then((response) => {
        const values = response.data;
        setPlayerData(values);
      })
      .catch((error) => {
        if (axios.isCancel(error)) {
          console.log("Request canceled", error.message);
        } else {
          console.log(error);
        }
      });
  }, []);

  return (
    <>
      <AppBar position="static" elevation={0}>
        <Toolbar>
          <Typography variant="h6" component="div" sx={{flexGrow: 1, textAlign: "center"}}>
            {playerName}
          </Typography>
        </Toolbar>
      </AppBar>
      <div className="main-player-container mx-md-5 mx-0 d-flex flex-row justify-content-center">
        <div className="mt-4 d-flex flex-grow-1">
          <DataGrid
            rows={playerData}
            columns={[
              {field: "value_name", headerName: "Statistic", width: 200},
              {field: "value", headerName: "Value", width: 200},
            ]}
            getRowId={(row) => row.value_name}
            pageSize={5}
            rowsPerPageOptions={[5]}
            disableSelectionOnClick
            disablePagination
            hideFooter
            disable
          />
        </div>
        <div className="m-4 d-flex flex-grow-1 w-50">
          {loading ? <div className="text-center mt-4">Loading...</div> : <LineChart data={data} />}
        </div>
      </div>
    </>
  );
}

export default PlayerPage;
