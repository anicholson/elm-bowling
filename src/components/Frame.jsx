'use strict';

const React = require('react');
const styles = require('../styles/Frame.css');

module.exports = class Frame extends React.Component {
  constructor(props) {
    super();
    console.log(props);
    this.state = props;
  }

  render() {
    let styleForScore = (bowl) => {
      switch(bowl) {
        case 'X':
          return styles.strike;
        case '/':
          return styles.spare;
        default:
          return styles.bowl
      }
    };
    let bowls = this.state.bowls.map(function (bowl, i) {
      return (
          <div key={i} className={styleForScore(bowl)}>{bowl}</div>
      )
    });
    return (
        <div className={styles.container}>
          <div className={styles.individualBowlContainer}>
            {bowls}
          </div>
          <div className={styles.frameScore}><p>{this.state.score}</p></div>
        </div>
    )
  }
};
