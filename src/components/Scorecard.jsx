'use strict';

const React = require('react');
const styles = require('../styles/Scorecard.css');

const FrameList = require('./FrameList.jsx');

class Scorecard extends React.Component {
  eachPlayer(player, $index) {
    return (
        <div className={styles.row} key={$index}>
          <p className={styles.name}>{player.player}</p>
          <div className={styles.frames}>
            <FrameList frames={player.frames} scores={player.runningScores}/>
          </div>
          <p className="player__score">{player.score}</p>
        </div>
    )
  }

  headerRow() {
    let frames = [1,2,3,4,5,6,7,8,9,10].map(function(f) {
      return (<div key={f} className={styles.frame} >{f}</div>)
    });

    return(
        <div className={styles.headerRow}>
          <div className={styles.name}>Name</div>
          <div className={styles.frames}>{frames}</div>
          <div>Score</div>
          </div>
    )
  }

  render() {
    console.log("State:", this.state);
    return (
        <div>
          {this.headerRow()}
          <div className={styles.border}>{ this.props.players.map(this.eachPlayer) } </div>
        </div>
    )
  }
}

module.exports = Scorecard;
