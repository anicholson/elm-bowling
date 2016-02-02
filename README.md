# elm-bowling
An Elm + React JS experiment.

## System Requirements

* Elm platform v0.16 [install instructions][1]
* Node JS

## Installation in Dev

1. `npm install`
2. `elm package install`

## Usage

1. `webpack -d -w`
2. Run some kind of static file server out of `dist/`, for convenience, I often resort to `php -S 0.0.0.0:7000`
3. Open http://localhost:7000/bowling.html

## Tests

1. `./specs.sh`

This will call `elm make` to compile everything, output it in a format that will run on node instead of the browser, and run the test suites on node.

[1]: http://elm-lang.org/install