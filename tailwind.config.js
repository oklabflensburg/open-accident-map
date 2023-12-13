/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js}"],
  theme: {
    container: {
      center: true,
      padding: "16px",
     
    },
    screens: {
      xs: '480px',
      sm: '640px',
      md: '768px',
      lg: '984px',
      xl: '1240px',
      '2xl': '1240',
    },
    extend: {
      colors: {
        black: "#212b36",
        gray: {
          DEFAULT: "#777777",
          "light": "#dedede",
          "dark": "#3d3d3d"
        },
        dark: "#090E34",
        primary: {
          "dark": "#0F284A",
          DEFAULT: "#00367D",
          "light": "#5B96E3",
          "lighter": "#CCE2FF"
        },
        "secondary": "#0045f6",
        "warning": "#FBBF24"
      },
      font:{
        bold: "letter-spacing: 1px",
        thin: "font-stretch: 110%"
      },
      spacing: {
        '1/1': '100%'
      },
      boxShadow: {
        input: "0px 7px 20px rgba(0, 0, 0, 0.03)",
        pricing: "0px 39px 23px -27px rgba(0, 0, 0, 0.04)",
        "switch-1": "0px 0px 5px rgba(0, 0, 0, 0.15)",
        testimonial: "0px 60px 120px -20px #EBEFFD"
      },
  plugins: [],
    }
  }
}

/** npx tailwindcss -i ./src/tailwind.css -o ./src/main.css --watch */