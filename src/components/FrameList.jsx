'use strict';

const React = require('react');
const Frame = require("./Frame.jsx");
const styles = require('../styles/FrameList.css');

const FrameList = class FrameList extends React.Component {
  constructor(props) {
    super();
    if(!props.frames) {
      props.frames = [];
    }
    this.state = props;
  }
  render() {
    let scores = this.state.scores;
    let frames = this.state.frames.map(function(frame, i) {
      return (<Frame key={i} bowls={frame} score={scores[i]} className={styles.frame} />);
    });

    return (<div className={styles.frameRow}>{frames}</div>);
  }
};

module.exports = FrameList;
