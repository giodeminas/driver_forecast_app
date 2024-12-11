const Caret = ({ size = 16, color = "black" , direction}) => {
    return (
      <svg
        width={size}
        height={size}
        viewBox="0 0 16 16"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        className={direction}
      >
        <path
          d="M3.204 5h9.592L8 10.481 3.204 5z"
          fill={color}
        />
      </svg>
    );
  };

export default Caret;