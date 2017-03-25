# Elections

First, install bundler and some gems:

```
$ gem install bundler
$ bundle install
```

To get started, get your data:

```
$ curl 'https://phl.carto.com/api/v2/sql?filename=board_workers_2017&q=select+*+from+phl.board_workers_2017&format=csv&bounds=&api_key=&skipfields=the_geom_webmercator' > elections.csv
```

Now run the app:

```
$ shotgun app.rb
```

Cool, now open your browser to `localhost:9393`.
