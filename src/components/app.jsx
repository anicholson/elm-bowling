const React = require('react'),
    Scorecard = require('./Scorecard.jsx'),
    styles = require('../styles/app.css');

class App extends React.Component{
  constructor(args) {
    var store = args.store;
    super();

    store.listen(App.cardChanged(this));

    this.state = {
      players: []
    };
  }

  static cardChanged(self) {
    return function(e) {
      self.state.players = e;

      self.setState(self.state.players);
    }
  }

  render() {
    return (
        <div id="app" className={styles.main}>
          <h1>Elm's House of Bowling</h1>
          <Scorecard players={this.state.players} />
        </div>
    );
  }
}

module.exports = App;
