import React from "react";
import {Line} from "react-chartjs-2";
import "chartjs-adapter-moment";
import Chart from "chart.js/auto";

import {Chart as Chartt, LinearScale, PointElement, Tooltip, Legend, TimeScale} from "chart.js";

Chartt.register(LinearScale, PointElement, Tooltip, Legend, TimeScale);

const LineChart = ({data}) => {
  const chartData = {
    labels: data.map((obj) => {
      return new Date(obj.date);
    }),
    datasets: [
      {
        label: "Elo",
        data: data.map((obj) => obj.elo),
        fill: false,
        backgroundColor: "rgb(75, 192, 192)",
        borderColor: "rgba(75, 192, 192, 0.8)",
        pointRadius: 1.5,
        borderJoinStyle: "round",
      },
    ],
  };

  const config = {
    scales: {
      x: {
        type: "time",
        time: {
          unit: data.length <= 12 ? "quarter" : "year",
          displayFormats: {
            quarter: "MMM YYYY",
            year: "YYYY",
          },
        },
        title: {
          display: true,
          text: "Date",
        },
      },
      y: {
        title: {
          display: true,
          text: "Elo",
        },
      },
    },
  };

  return <Line data={chartData} options={config} />;
};

export default LineChart;
