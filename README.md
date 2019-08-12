# redis-benchmark-buildpack

The `redis-benchmark-buildpack` is a Cloud Foundry buildpack for running Redis benchmarks. It compiles `redis-benchmark`and a custom Ruby app into a droplet which can then be used to execute a benchmark run from within the CF elastic runtime.

## Usage

* Edit a file named `redis_benchmark_spec.yml` and specify following options

```
benchmark:
  clients: 75
  requests: 150000
  size: 3
```

* Create a Redis service instance named `redis`
* Create a benchmark app

```
cf push <APP-NAME>
```

* Invoke the app

## Limitations

* Redis service instance is assumed to be named `redis`
* Only the ` -n ` and ` -c ` options of http://redis.io/topics/benchmarks are supported
