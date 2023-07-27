import React, {useState, useEffect} from "react";
import {useLocation} from "react-router-dom";
import {AppBar, Toolbar, Typography} from "@mui/material";
import axios from "axios";
import LineChart from "./LineChart";

function PlayerPage(props) {
  let {state} = useLocation();
  let playerName = state.playerName;

  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    axios
      .get("http://192.168.20.3:5000/get_player_elo", {
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

  return (
    <>
      <AppBar position="static" elevation={0}>
        <Toolbar>
          <Typography variant="h6" component="div" sx={{flexGrow: 1, textAlign: "center"}}>
            {playerName}
          </Typography>
        </Toolbar>
      </AppBar>
      <div className="main-container mx-md-5 mx-0">
        {loading ? <div className="text-center mt-4">Loading...</div> : <LineChart data={data} />}
      </div>
    </>
  );
}

export default PlayerPage;
