import React, {useEffect, useState} from "react";
import {DataGrid} from "@mui/x-data-grid";
import {TextField, Button, Grid, AppBar, Toolbar, Typography} from "@mui/material";
import axios from "axios";
import "../styles.css";
import "bootstrap/dist/css/bootstrap.min.css";
import moment from "moment";
import FilterSelect from "./FilterSelect";
import MatchRow from "./MatchRow";
import "../App.css";
import {Link} from "react-router-dom";

const columns = [
  {
    field: "match_date",
    headerName: "Match Date",
    headerClassName: "data-grid-header",
    minWidth: 80,
    flex: 1,
    type: "dateTime",
    valueGetter: (params) => new Date(params.value),
    renderCell: (params) => moment(params.value).format("DD/MM/YYYY"),
  },
  {
    field: "A_name",
    headerName: "Winner",
    minWidth: 120,
    flex: 1.5,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      return (
        <div className="no-underline-link">
          <Link to="/player" state={{playerName: params.value}}>
            {params.value}
          </Link>
        </div>
      );
    },
  },
  {
    field: "B_name",
    headerName: "Loser",
    minWidth: 120,
    flex: 1.5,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      return (
        <div className="no-underline-link">
          <Link to="/player" state={{playerName: params.value}}>
            {params.value}
          </Link>
        </div>
      );
    },
  },
  {field: "tourney_name", headerName: "Tourney Name", minWidth: 100, flex: 1.5, headerClassName: "data-grid-header"},
  {field: "tourney_level", headerName: "Tourney Level", minWidth: 80, flex: 1, headerClassName: "data-grid-header"},
  {
    field: "surface",
    headerName: "Surface",
    minWidth: 80,
    flex: 1,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      let color;

      switch (params.value) {
        case "Hard":
          color = "#45afd6";
          break;
        case "Clay":
          color = "#c96f2a";
          break;
        case "Grass":
          color = "#5fb357";
          break;
        default:
          color = "#000";
      }
      return <span style={{color: color}}>{params.value}</span>;
    },
  },
  {field: "round", headerName: "Round", minWidth: 80, flex: 1, headerClassName: "data-grid-header"},
  {field: "A_elo", headerName: "A Elo", type: "number", minWidth: 80, flex: 1, headerClassName: "data-grid-header"},
  {field: "B_elo", headerName: "B Elo", type: "number", minWidth: 80, flex: 1, headerClassName: "data-grid-header"},
];

function MatchTable() {
  const [rows, setRows] = useState([]);
  const [playerName, setPlayerName] = useState("");
  const [tourneyLevel, setTourneyLevel] = useState(["G", "M", "A"]);
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
        params: {player_name: playerName, tourney_level: [tourneyLevel].join(","), surface: [surface].join(",")},
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
      <div className="main-container mx-md-5 mx-0">
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
              value={tourneyLevel}
              onChange={(e) => setTourneyLevel([e.target.value])}
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
              value={surface}
              onChange={(e) => setSurface([e.target.value])}
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
                pageSize={rows.length > 0 ? rows.length : 1}
                disablePagination
                hideFooterPagination
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
                  row: MatchRow,
                }}
              />
            )}
          </Grid>
        </Grid>
      </div>
    </>
  );
}

export default MatchTable;
