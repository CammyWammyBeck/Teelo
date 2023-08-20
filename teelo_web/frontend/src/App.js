import React from "react";
import "./styles.css";
import "bootstrap/dist/css/bootstrap.min.css";
import {createTheme, ThemeProvider} from "@mui/material/styles";
import "./App.css";
import HomePage from "./components/HomePage";
import PlayerPage from "./components/PlayerPage";
import {BrowserRouter, Routes, Route} from "react-router-dom";

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

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/player" Component={PlayerPage} />
        <Route path="/" exact Component={HomePage} />
      </Routes>
    </BrowserRouter>
  );
}

export default function ThemedApp() {
  return (
    <ThemeProvider theme={theme}>
      <App />
    </ThemeProvider>
  );
}
