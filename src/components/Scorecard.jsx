const React = require('react');

const Scorecard = React.createClass({
  displayName: 'Scorecard',

  eachPlayer: function(player, $index) {
    return (
        <li key={$index}>
          <p>{player.player}</p>
          <p>Frames placeholder</p>
        </li>
    )
  },

  render: function() {
    console.info(this.props);
    return (
      <ul>{ this.props.players.map(this.eachPlayer) } </ul>
    )
  }
});

module.exports = Scorecard;
