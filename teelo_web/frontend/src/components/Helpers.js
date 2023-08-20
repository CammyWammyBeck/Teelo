function stringToColor(str) {
  let sum = 0;
  for (let i = 0; i < str.length; i++) {
    sum += str.charCodeAt(i);
  }
  let hue = sum % 360;

  let saturation = 60; // You can adjust this to your preferred saturation level

  // If str is a tourney level, make it les saturated
  if (str == "Futures" || str == "Challenger" || str == "ATP" || str == "Maters" || str == "Grand Slam") {
    saturation = 20;
  }

  let lightness = 60; // Full lightness for pastel color

  // If str is a surface, make it darker
  if (str == "Hard" || str == "Clay" || str == "Grass") {
    lightness = 40;
  }

  return `hsl(${hue}, ${saturation}%, ${lightness}%)`;
}

export default stringToColor;
