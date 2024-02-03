import React, {useEffect, useState, useRef, useCallback} from "react";
import {TextField, Button, Grid, AppBar, Toolbar, Typography} from "@mui/material";
import axios from "axios";
import "../styles.css";
import "bootstrap/dist/css/bootstrap.min.css";
import FilterSelect from "./FilterSelect";
import stringToColor from "./Helpers";
import "../App.css";
import {Link} from "react-router-dom";
import {AgGridReact} from "ag-grid-react";

import "ag-grid-community/styles/ag-grid.css";
import "ag-grid-community/styles/ag-theme-alpine.css";

const ranking_columns = [
    {
        field: "rank",
        headerName: "Rank",
        headerClass: "ranking-grid-header data-grid-header",
        cellDataType: "number",
        cellClass: "align-left",
    },
    {
        field: "name",
        headerName: "Name",
        minWidth: 100,
        flex: 2,
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
            return (
                <div className="teelo-link">
                    <Link to="/player" state={{playerName: params.value}}>
                        {params.value}
                    </Link>
                </div>
            );
        },
        cellStyle: {padding: "0.25rem"},
        autoHeight: true,
    },
    {
        field: "elo",
        headerName: "Elo",
        cellDataType: "number",
        minWidth: 80,
        flex: 1,
        headerClass: "ranking-grid-header data-grid-header",
        cellClass: "align-left",
    },
];

const columns = [
    {
        field: "match_id",
        headerName: "Match ID",
        headerClass: "data-grid-header",
        minWidth: 100,
        flex: 1,
        cellStyle: {padding: "0.25rem"},
        autoHeight: true,
    },
    {
        field: "match_date",
        headerName: "Match Date",
        headerClass: "data-grid-header",
        minWidth: 100,
        cellDataType: "date",
        flex: 1,
        cellStyle: {padding: "0.25rem"},
        autoHeight: true,
    },
    {
        field: "A_name",
        headerName: "Winner",
        minWidth: 100,
        flex: 2,
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
            return (
                <div className="teelo-link">
                    <Link to="/player" state={{playerName: params.value}}>
                        {params.value}
                    </Link>
                </div>
            );
        },
        cellStyle: {padding: "0.25rem"},
        autoHeight: true,
    },
    {
        field: "B_name",
        headerName: "Loser",
        minWidth: 100,
        flex: 2,
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
            return (
                <div className="teelo-link">
                    <Link to="/player" state={{playerName: params.value}}>
                        {params.value}
                    </Link>
                </div>
            );
        },
        cellStyle: {padding: "0.25rem"},
        autoHeight: true,
    },
    {
        field: "tourney_name",
        headerName: "Tourney Name",
        minWidth: 120,
        autoHeight: true,
        flex: 1.5,
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
            return (
                <span
                    className="lh-lg p-1 px-4 rounded-2 border-light text-light fs-8 text-center"
                    style={{backgroundColor: stringToColor(params.value)}}
                >
                    {params.value}
                </span>
            );
        },
    },
    {
        field: "tourney_level",
        headerName: "Tourney Level",
        minWidth: 100,
        autoHeight: true,
        flex: 1,
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
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
                    className="lh-lg p-1 px-4 rounded-2 border-light text-light fs-8 text-center"
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
        headerClass: "data-grid-header",
        cellRenderer: (params) => {
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
                <span
                    className="lh-lg p-1 px-4 rounded-2 border-light text-light fs-8 text-center"
                    style={{backgroundColor: color}}
                >
                    {params.value}
                </span>
            );
        },
    },
    {
        field: "round",
        headerName: "Round",
        minWidth: 80,
        flex: 0.6,
        headerClass: "data-grid-header",
    },
    {
        field: "A_elo",
        headerName: "A Elo",
        cellDataType: "number",
        minWidth: 80,
        flex: 0.5,
        headerClass: "data-grid-header",
    },
    {
        field: "B_elo",
        headerName: "B Elo",
        cellDataType: "number",
        minWidth: 80,
        flex: 0.5,
        headerClass: "data-grid-header",
    },
];

function HomePage() {
    const [playerName, setPlayerName] = useState("");
    const [tourneyLevel, setTourneyLevel] = useState(["G", "M", "A"]);
    const [surface, setSurface] = useState([]);
    const [loading, setLoading] = useState(false);
    const recentMatchesGridDivRef = useRef(null);
    const [gridApi, setGridApi] = useState(null);
    const [dataSource, setDataSource] = useState(null);

    useEffect(() => {
        if (gridApi && dataSource) {
            gridApi.setDatasource(dataSource);
        }
    }, [gridApi, dataSource]);

    useEffect(() => {
        setDataSource({
            rowCount: undefined,
            getRows: (params) => {
                getRowsFunction(params, playerName, tourneyLevel, surface);
            },
        });
    }, [playerName, tourneyLevel, surface]);

    const [player_rankings, setPlayerRankings] = useState([]);
    useEffect(() => {
        axios
            .get("http://192.168.20.4:5000/get_player_rankings", {params: {num_rankings: 0}})
            .then((response) => {
                setPlayerRankings(response.data);
                console.log("Updated player rankings:", response.data); // Debugging line
            })
            .catch((error) => {
                console.log(error);
            });
    }, []);

    const onGridReady = useCallback(
        (params) => {
            setGridApi(params.api);
            setDataSource({
                rowCount: undefined,
                getRows: (params) => {
                    getRowsFunction(params, playerName, tourneyLevel, surface);
                },
            });
        },
        [playerName, tourneyLevel, surface]
    );

    const getRowsFunction = async (params, playerName, tourneyLevel, surface) => {
        console.log("asking for " + params.startRow + " to " + params.endRow);
        try {
            const response = await axios.get("http://192.168.20.4:5000/matches", {
                params: {
                    start: params.startRow,
                    end: params.endRow,
                    player_name: playerName,
                    tourney_level: [tourneyLevel].join(","),
                    surface: [surface].join(","),
                },
            });

            const matches = response.data.map((match) => ({
                ...match,
                match_date: new Date(match.match_date),
                id: match.match_id,
            }));

            let lastRow = -1;
            if (matches.length < 100) {
                lastRow = params.startRow + matches.length;
            }

            params.successCallback(matches, lastRow);
        } catch (error) {
            console.error("Error fetching data", error);
        }
    };

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
                            <Grid
                                item
                                xs={12}
                                sm={6}
                                md={3}
                                className="pt-0"
                                container
                                justifyContent="center"
                                alignItems="center"
                            >
                                <TextField
                                    id="filter-name"
                                    label="Player Name"
                                    variant="outlined"
                                    onBlur={(e) => setPlayerName(e.target.value)}
                                    fullWidth
                                />
                            </Grid>
                            <Grid
                                item
                                xs={12}
                                sm={6}
                                md={3}
                                className="pt-0"
                                container
                                justifyContent="center"
                                alignItems="center"
                            >
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
                            <Grid
                                item
                                xs={12}
                                sm={6}
                                md={3}
                                className="pt-0"
                                container
                                justifyContent="center"
                                alignItems="center"
                            >
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
                            <Grid
                                item
                                xs={12}
                                sm={6}
                                md={3}
                                className="pt-0"
                                container
                                justifyContent="center"
                                alignItems="center"
                            >
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
                    <Grid item xs={12} minwidth="1000px" height="80vh">
                        {loading ? (
                            <div className="text-center mt-4">Loading...</div>
                        ) : (
                            <AgGridReact
                                ref={recentMatchesGridDivRef}
                                columnDefs={columns}
                                rowModelType="infinite"
                                cacheBlockSize={100}
                                cacheOverflowSize={2}
                                maxConcurrentDatasourceRequests={2}
                                infiniteInitialRowCount={100}
                                maxBlocksInCache={10}
                                onGridReady={onGridReady}
                                getRowId={(row) => row.match_id}
                                defaultColDef={{
                                    sortable: true,
                                    filter: true,
                                    resizable: true,
                                    flex: 1,
                                    minWidth: 100,
                                }}
                            />
                        )}
                    </Grid>
                </div>
                <div className="player-rankings-container mx-md-5 mx-0 mt-5">
                    <Grid item xs={12} justifyContent="center" alignItems="center" minwidth="400" height="80vh">
                        <AgGridReact rowData={player_rankings} columnDefs={ranking_columns} />
                    </Grid>
                </div>
            </div>
        </>
    );
}

export default HomePage;
