const React = require('react');

const Scorecard = React.createClass({
  displayName: 'Scorecard',

  eachPlayer: function(player, $index) {
    return (
        <div key={$index}>
          <p className="player__name">{player.player}</p>
          <p className="player__frames">{JSON.stringify(player.frames, null, 2)}</p>
          <p className="player__score">{player.score}</p>
        </div>
    )
  },

  render: function() {
    return (
      <div className="player">{ this.props.players.map(this.eachPlayer) } </div>
    )
  }
});

module.exports = Scorecard;
