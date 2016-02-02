'use strict';

const React    = require('react'),
      ReactDOM = require('react-dom'),
      Elm      = require('./elm/BowlingGame.elm');

const App = require('./components/app.jsx'),
    ScoreboardStore = require('./lib/scoreboard_store.js');

const entryPoint = document.getElementById('entry');

const elmApp = Elm.worker(Elm.BowlingGame, { trigger: 'LOL' });

const startGame = () => {
  elmApp.ports.trigger.send('');
};

const ready = (fn) => {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
};

let store = new ScoreboardStore(elmApp.ports.scorecard);

store.listen(function(value) {
  console.info("The store is working", value);
});

ready(() => {
  const root = React.createElement(App, {store : store});
  ReactDOM.render(root, entryPoint);

  startGame();
});



