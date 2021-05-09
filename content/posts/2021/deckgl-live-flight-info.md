---
title: "It's A Bird! It's A Plane! Displaying Live Flight Information Using deck.gl"
date: 2021-03-20
slug: "deckgl-displaying-live-flight-info"
tags: ["deck.gl", "geospatial data", "flight information", "opensky"]
draft: false
---
As part of another project I wished to render data points on a map in real-time, or as near to real-time as possible. Being new to [deck.gl](http://deck.gl) this seemed an opportune time to reduce the scope and focusing on rendering. 

For this project, I've chosen flight data because I'm a fan of anything aerospace. The OpenSky Network API provides [a free API for live flight information](https://opensky-network.org/apidoc/) (for research and non-commercial purposes). I wanted to use Earth observation data for this project, but that data is not real-time thanks to orbital periods. 

Information about the data provided by The OpenSky Network API can be found on their documentation. We will receive descriptive and positional information derived from [ADS-B](https://www.faa.gov/nextgen/programs/adsb/) and [Mode-S transponder](https://trig-avionics.com/knowledge-bank/transponders/mode-s/) messages. Using this information we can render the flight on a map.

# The Cast
- [deck.gl](http://deck.gl) - used to render data on the map
- [Mapbox GL JS](https://www.mapbox.com/mapbox-gljs) - used to render the map itself. Provided by the deck.gl examples
- [The OpenSky Network API](https://opensky-network.org/) - provides the flight information
- [Webpack](https://webpack.js.org/) - to bundles everything nicely and provides a better developer experience
- npm - for package management
- [webpack-dev-server package](https://github.com/webpack/webpack-dev-server) - to run a local server and verify the results by eye. Provided by the deck.gl examples
- Javascript - for writing the code. Typescript takes extra setup which is unnecessary for our purposes

In the beginning, there was nothing, no code, no frameworks, just a blank directory staring back at us. To fix this we clone the [deck.gl repository](https://github.com/visgl/deck.gl/). We will be working from the Mapbox directory (`/examples/get-started/pure-js/mapbox/`).

Next, it's time to fetch our dependencies using `npm install`. 

Once complete you should be able to run `npm start` and see this:

{{< figure src="img/posts/2021/deckgl-mapbox-example-running.png" caption="The Mapbox getting started example" alt="The deck.gl Mapbox example up and running">}}

Your `app.js` file should look something like this:

{{< gist thomaspaulin 39a188355403bdd9d38d66fdf2061b9f >}}

[According to the deck.gl documentation](https://deck.gl/docs/developer-guide/performance) "Layer updates happen when the layer is first created, or when some layer props change." Thus, we must have our live data cause a prop change when it is received. The obvious first step here is a callback that creates the layers arrays using the new data. It then sets the props of the Deck using those layers. Be wary of the [performance implications](https://deck.gl/docs/developer-guide/performance) that changing data can bring. We won't be addressing those in this article.

{{< gist thomaspaulin 3d6961d8090d592eb28d20fae7cbb63d >}}

Now we have a way to set the props from a callback we can fetch flight information from the OpenSky Network API. As a demonstration project, we only care about the latest information for all flights. Thus, we will get network's entire state vector set, without authenticating. This means our request is: `GET https://opensky-network.org/api/states/all`.

The response we receive is not in the format [deck.gl](http://deck.gl) expects, and so we'll need to transform it. Fortunately, the OpenSky Network API response is easy to handle meaning a simple mapping function is sufficient. 

{{< gist thomaspaulin d7f5ad040deca4a4d034a59ad21f12c9 >}}

Once we've added this mapping into the response chain we also call the same `render(...)` function we created earlier. After running, we should see the flights rendered on the map.

{{< figure src="img/posts/2021/deckgl-opensky-flight-info-plotted.png" caption="Flight information from the OpenSky Network API rendered" alt="Flights plotted on the map using information from the OpenSky Network API" >}}

# Notes
- The `webpack.config.js` file says the local development overrides should be removed from the file. I haven't had an issue with this so for now they can stay. If you wish to remove them, changing the final line to `module.exports = env => CONFIG;` should suffice.
- The [deck.gl](http://deck.gl) example works out of the box, but in case you don't see the map, you should set the Mapbox token. See the comment in the first code snippet for how to do this.
- We don't do any checks that the data is the latest, nor do we add any 'thread safety'. It's possible callbacks arrive out of order and our data 'goes back in time'.
- Visit the [layer lifecycle](https://deck.gl/docs/developer-guide/custom-layers/layer-lifecycle) page to learn more about how the lifecycles work.
