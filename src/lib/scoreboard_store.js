'use strict';

class ScoreboardStore {
  constructor(port) {
    this.listeners = [];

    port.subscribe((newScorecard) => {
      this.trigger(newScorecard);
    });
  }

  listen(listener) {
    this.listeners.push(listener);
  }

  trigger(newValue) {
    this.listeners.map(function(cb) {
      cb(newValue);
    })
  }
}

module.exports = ScoreboardStore;
