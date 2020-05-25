# Filters

## Run the tests
```
docker-compose run --rm --service-ports filters mix deps.get
docker-compose run --rm --service-ports filters mix test
```

## Run in interactive mode
```
docker-compose run --rm --service-ports filters mix ecto.init && iex -S mix
```