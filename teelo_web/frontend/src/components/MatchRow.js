import React from "react";
import {GridRow} from "@mui/x-data-grid";
import md5 from "js-md5";

// Function to convert string to color
function stringToColor(str) {
  let hash = md5(str);
  let hue = (hash.charCodeAt(0) + hash.charCodeAt(1) + hash.charCodeAt(2) + hash.charCodeAt(3)) % 360;
  let saturation = 50; // You can adjust this value to get your preferred pastel look.
  let lightness = 85; // Full lightness for pastel color
  return `hsl(${hue}, ${saturation}%, ${lightness}%)`;
}

class MatchRow extends React.Component {
  constructor(props) {
    super(props);
    let color = stringToColor(props.row.tourney_name);
    this.state = {
      color: color,
    };
  }

  render() {
    const {color} = this.state;
    const {props} = this;
    return (
      <div style={{backgroundColor: color}}>
        <GridRow {...props} />
      </div>
    );
  }
}

export default MatchRow;
