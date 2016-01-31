#!/bin/bash

elm-make src/elm/Tests.elm --output tmp/raw-test.js
. elm-stuff/packages/laszlopandy/elm-console/1.1.0/elm-io.sh "tmp/raw-test.js" "tmp/test.js"

node tmp/test.js
