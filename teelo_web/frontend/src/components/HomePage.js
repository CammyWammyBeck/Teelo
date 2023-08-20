import React, {useEffect, useState} from "react";
import {DataGrid} from "@mui/x-data-grid";
import {TextField, Button, Grid, AppBar, Toolbar, Typography} from "@mui/material";
import axios from "axios";
import "../styles.css";
import "bootstrap/dist/css/bootstrap.min.css";
import moment from "moment";
import FilterSelect from "./FilterSelect";
import stringToColor from "./Helpers";
import "../App.css";
import {Link} from "react-router-dom";

const ranking_columns = [
  {
    field: "rank",
    headerName: "Rank",
    headerClassName: "ranking-grid-header data-grid-header",
    type: "number",
    cellClassName: "align-left",
  },
  {
    field: "name",
    headerName: "Name",
    headerClassName: "ranking-grid-header data-grid-header",
    minWidth: 120,
    flex: 1.5,
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
    field: "elo",
    headerName: "Elo",
    type: "number",
    minWidth: 80,
    flex: 1,
    headerClassName: "ranking-grid-header data-grid-header",
    cellClassName: "align-left",
  },
];

const columns = [
  {
    field: "match_date",
    headerName: "Match Date",
    headerClassName: "data-grid-header",
    minWidth: 100,
    flex: 1,
    type: "dateTime",
    valueGetter: (params) => new Date(params.value),
    renderCell: (params) => moment(params.value).format("DD/MM/YYYY"),
    sortable: true,
    filterable: false,
  },
  {
    field: "A_name",
    headerName: "Winner",
    minWidth: 100,
    flex: 2,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      return (
        <div className="no-underline-link">
          <Link className="fw-bold" to="/player" state={{playerName: params.value}}>
            {params.value}
          </Link>
        </div>
      );
    },
    sortable: true,
    filterable: false,
  },
  {
    field: "B_name",
    headerName: "Loser",
    minWidth: 100,
    flex: 2,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      return (
        <div className="no-underline-link">
          <Link className="fw-bold" to="/player" state={{playerName: params.value}}>
            {params.value}
          </Link>
        </div>
      );
    },
    sortable: true,
    filterable: false,
  },
  {
    field: "tourney_name",
    headerName: "Tourney Name",
    minWidth: 120,
    width: "100%",
    flex: 1.5,
    headerClassName: "data-grid-header",
    sortable: true,
    filterable: false,
    renderCell: (params) => {
      return (
        <div
          className="p-1 px-2 rounded-2 border-light text-light fs-12 fs-8"
          style={{backgroundColor: stringToColor(params.value)}}
        >
          {params.value}
        </div>
      );
    },
  },
  {
    field: "tourney_level",
    headerName: "Tourney Level",
    minWidth: 100,
    flex: 1,
    headerClassName: "data-grid-header",
    sortable: true,
    filterable: false,
    renderCell: (params) => {
      let cellText;
      if (params.value === "G") {
        cellText = "Grand Slam";
      } else if (params.value === "M") {
        cellText = "Masters";
      } else if (params.value === "A") {
        cellText = "ATP";
      } else if (params.value === "C") {
        cellText = "Challenger";
      } else if (params.value === "F") {
        cellText = "Futures";
      } else {
        cellText = params.value;
      }
      return (
        <span
          className="p-1 px-2 rounded-2 border-light text-light fs-8"
          style={{backgroundColor: stringToColor(cellText)}}
        >
          {cellText}
        </span>
      );
    },
  },
  {
    field: "surface",
    headerName: "Surface",
    minWidth: 100,
    flex: 1,
    headerClassName: "data-grid-header",
    renderCell: (params) => {
      let color;

      switch (params.value) {
        case "Hard":
          color = "#349cb0"; // Darker blue
          break;
        case "Clay":
          color = "#a5581d"; // Darker orange
          break;
        case "Grass":
          color = "#4a8f29"; // Darker green
          break;
        default:
          color = "#000";
      }
      return (
        <span className="p-1 px-2 rounded-2 border-light text-light fs-12 fs-8" style={{backgroundColor: color}}>
          {params.value}
        </span>
      );
    },
    sortable: true,
    filterable: false,
  },
  {
    field: "round",
    headerName: "Round",
    minWidth: 80,
    flex: 0.6,
    headerClassName: "data-grid-header",
    sortable: true,
    filterable: false,
  },
  {
    field: "A_elo",
    headerName: "A Elo",
    type: "number",
    minWidth: 80,
    flex: 0.5,
    headerClassName: "data-grid-header",
    sortable: true,
    filterable: false,
  },
  {
    field: "B_elo",
    headerName: "B Elo",
    type: "number",
    minWidth: 80,
    flex: 0.5,
    headerClassName: "data-grid-header",
    sortable: true,
    filterable: false,
  },
];

function HomePage() {
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

  const [player_rankings, setPlayerRankings] = useState([]);
  useEffect(() => {
    axios
      .get("http://192.168.20.3:5000/get_player_rankings", {params: {num_rankings: 0}})
      .then((response) => {
        setPlayerRankings(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  }, []);

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
        <div className="matches-container mx-md-5 mx-0 mt-5">
          <div className="filters-container">
            <Grid container spacing={2} className="mt-0" justifyContent="center" alignItems="center">
              <Grid item xs={12} sm={6} md={3} className="pt-0" container justifyContent="center" alignItems="center">
                <TextField
                  id="filter-name"
                  label="Player Name"
                  variant="outlined"
                  onBlur={(e) => setPlayerName(e.target.value)}
                  fullWidth
                />
              </Grid>
              <Grid item xs={12} sm={6} md={3} className="pt-0" container justifyContent="center" alignItems="center">
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
              <Grid item xs={12} sm={6} md={3} className="pt-0" container justifyContent="center" alignItems="center">
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
              <Grid item xs={12} sm={6} md={3} className="pt-0" container justifyContent="center" alignItems="center">
                <Button
                  variant="contained"
                  onClick={() => {
                    setPlayerName(document.getElementById("filter-name").value);
                    setTourneyLevel(document.getElementById("filter-level").value);
                    setSurface(document.getElementById("filter-surface").value);
                  }}
                  style={{lineHeight: "normal"}}
                >
                  Update Table
                </Button>
              </Grid>
            </Grid>
          </div>
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
                hideFooter
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
              />
            )}
          </Grid>
        </div>
        <div className="player-rankings-container mx-md-5 mx-0 mt-5">
          <Grid container spacing={2} justifyContent="center" alignItems="center">
            <DataGrid
              rows={player_rankings}
              columns={ranking_columns}
              style={{height: window.innerHeight - 200}}
              getRowId={(row) => row.name}
              pageSize={player_rankings.length > 0 ? player_rankings.length : 1}
              disablePagination
              hideFooter
              initialState={{
                sorting: {
                  sortModel: [
                    {
                      field: "elo",
                      sort: "desc",
                    },
                  ],
                },
              }}
            />
          </Grid>
        </div>
      </div>
    </>
  );
}

export default HomePage;
