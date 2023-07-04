import React from "react";
import {Select, MenuItem} from "@mui/material";

class FilterSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: this.props.value || [],
    };
  }

  handleChange = (event) => {
    this.setState({value: event.target.value});
    if (this.props.onChange) {
      this.props.onChange(event);
    }
  };

  render() {
    const {labelId, id, label, options} = this.props;
    const {value} = this.state;

    return (
      <Select labelId={labelId} id={id} multiple value={value} onChange={this.handleChange} label={label} fullWidth>
        {options.map((option, index) => (
          <MenuItem key={index} value={option.value}>
            {option.label}
          </MenuItem>
        ))}
      </Select>
    );
  }
}

export default FilterSelect;
