import React, {useEffect, useState} from "react";
import {DataGrid, GridRow, GridHeader} from "@mui/x-data-grid";
import {TextField, Button, Grid, AppBar, Toolbar, Typography} from "@mui/material";
import axios from "axios";
import "./styles.css";
import "bootstrap/dist/css/bootstrap.min.css";
import moment from "moment";
import FilterSelect from "./components/FilterSelect";
import {createTheme, ThemeProvider, useTheme} from "@mui/material/styles";

import md5 from "js-md5";

// Function to convert string to color
function stringToColor(str) {
  let hash = md5(str);
  let color = "#";

  for (let i = 0; i < 3; i++) {
    let value = Math.min(Math.round((hash.charCodeAt(i) / 255) * 55) + 200, 255);
    color += ("00" + value.toString(16)).substr(-2);
  }

  return color;
}

function MyRow(props) {
  let color = stringToColor(props.row.tourney_name);

  return (
    <div style={{backgroundColor: color}}>
      <GridRow {...props} />
    </div>
  );
}

function MyHeader(props) {
  const theme = useTheme();
  return (
    <div style={{backgroundColor: theme.palette.primary.main, color: theme.palette.primary.contrastText}}>
      <GridHeader {...props} />
    </div>
  );
}

const theme = createTheme({
  palette: {
    mode: "light",
    primary: {
      main: "#E4572E",
      contrastText: "#F8F9F1",
    },
    secondary: {
      main: "#7293A0",
      contrastText: "#F8F9F1",
    },
    background: {
      default: "#F8F9F1",
      paper: "#F8F9F1",
    },
    text: {
      primary: "#393E41",
      secondary: "#4C5357",
      disabled: "#4C5357",
      hint: "#4C5357",
    },
    divider: "#393E41",
  },
});

const columns = [
  {
    field: "match_date",
    headerName: "Match Date",
    width: 130,
    type: "dateTime",
    valueGetter: (params) => new Date(params.value),
    renderCell: (params) => moment(params.value).format("DD/MM/YYYY"),
  },
  {field: "A_name", headerName: "Winner", width: 130},
  {field: "B_name", headerName: "Loser", width: 130},
  {field: "tourney_name", headerName: "Tourney Name", width: 130},
  {field: "tourney_level", headerName: "Tourney Level", width: 130},
  {field: "surface", headerName: "Surface", width: 130},
  {field: "round", headerName: "Round", width: 130},
  {field: "A_elo", headerName: "A Elo", type: "number", width: 130},
  {field: "B_elo", headerName: "B Elo", type: "number", width: 130},
];

function App() {
  const [rows, setRows] = useState([]);
  const [playerName, setPlayerName] = useState("");
  const [tourneyLevel, setTourneyLevel] = useState([]);
  const [surface, setSurface] = useState([]);
  const [loading, setLoading] = useState(false);
  const [cancelToken, setCancelToken] = useState(null);

  useEffect(() => {
    if (cancelToken) {
      // Cancel the previous request
      cancelToken.cancel("Request canceled");
    }

    setLoading(true);
    const source = axios.CancelToken.source();
    setCancelToken(source);

    axios
      .get("http://192.168.20.3:5000/matches", {
        params: {player_name: playerName, tourney_level: tourneyLevel.join(","), surface: surface.join(",")},
        cancelToken: source.token,
      })
      .then((response) => {
        const matches = response.data;
        setRows(matches);
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

    return () => {
      if (cancelToken) {
        cancelToken.cancel("Request canceled");
      }
    };
  }, [playerName, tourneyLevel, surface]);

  return (
    <>
      <AppBar position="static" elevation={0}>
        <Toolbar>
          {/* <IconButton size="large" edge="start" color="inherit" aria-label="menu" sx={{mr: 2}}>
            <MenuIcon />
          </IconButton> */}
          <Typography variant="h6" component="div" sx={{flexGrow: 1, textAlign: "center"}}>
            Teelo
          </Typography>
        </Toolbar>
      </AppBar>
      <Grid container spacing={2} className="mt-4" justifyContent="center" alignItems="center">
        <Grid item xs={12} sm={6} md={3} container justifyContent="center" alignItems="center">
          <TextField
            id="filter-name"
            label="Player Name"
            variant="outlined"
            onBlur={(e) => setPlayerName(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3} container justifyContent="center" alignItems="center">
          <FilterSelect
            labelId="tourney-level-label"
            id="filter-level"
            value={[tourneyLevel]}
            onChange={(e) => setTourneyLevel(e.target.value)}
            label="Surface"
            options={[
              {value: "G", label: "Grand Slam"},
              {value: "M", label: "Masters"},
              {value: "A", label: "ATP (250/500)"},
              {value: "C", label: "Challenger"},
              {value: "F", label: "Futures"},
            ]}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3} container justifyContent="center" alignItems="center">
          <FilterSelect
            labelId="surface-label"
            id="filter-surface"
            value={[surface]}
            onChange={(e) => setSurface(e.target.value)}
            label="Tourney Surface"
            options={[
              {value: "Clay", label: "Clay"},
              {value: "Grass", label: "Grass"},
              {value: "Hard", label: "Hard"},
            ]}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3} container justifyContent="center" alignItems="center">
          <Button
            variant="contained"
            onClick={() => {
              setPlayerName(document.getElementById("filter-name").value);
              setTourneyLevel(document.getElementById("filter-level").value);
              setSurface(document.getElementById("filter-surface").value);
            }}
          >
            Update Table
          </Button>
        </Grid>
        <Grid item xs={12}>
          {loading ? (
            <div className="text-center mt-4">Loading...</div>
          ) : (
            <DataGrid
              rows={rows}
              columns={columns}
              style={{height: window.innerHeight - 200}}
              getRowId={(row) => row.match_id}
              initialState={{
                sorting: {
                  sortModel: [
                    {
                      field: "match_date",
                      sort: "desc",
                    },
                  ],
                },
              }}
              slots={{
                row: MyRow,
              }}
            />
          )}
        </Grid>
      </Grid>
    </>
  );
}

export default function ThemedApp() {
  return (
    <ThemeProvider theme={theme}>
      <App />
    </ThemeProvider>
  );
}
