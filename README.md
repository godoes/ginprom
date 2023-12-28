<h1 style="text-align:center">📡 ginprom</h1>
<p style="text-align:center">
    <em>Prometheus metrics exporter for Gin. Inspired by <a href="https://github.com/Depado/ginprom">Depado/ginprom.</a></em>
</p>

### 🔰 Installation

> [!Note]
> Required go 1.19

```shell
go get github.com/godoes/ginprom
```

### 📝 Usage

It's easy to get started with ginprom, only a few lines of code needed.

```text
package main

import (
    "github.com/gin-gonic/gin"
    "github.com/godoes/ginprom"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
    r := gin.Default()
    // use prometheus metrics exporter middleware.
    //
    // ginprom.PromMiddleware() expects a ginprom.PromOpts{} pointer.
    // It is used for filtering labels by regex. `nil` will pass every requests.
    //
    // ginprom prometheus-labels: 
    //   `status`, `endpoint`, `method`
    //
    // for example:
    // 1). I don't want to record the 404 status request. That's easy for it.
    // ginprom.PromMiddleware(&ginprom.PromOpts{ExcludeRegexStatus: "404"})
    //
    // 2). And I wish to ignore endpoints started with `/prefix`.
    // ginprom.PromMiddleware(&ginprom.PromOpts{ExcludeRegexEndpoint: "^/prefix"})
    r.Use(ginprom.PromMiddleware(nil))

    // register the `/metrics` route.
    r.GET("/metrics", ginprom.PromHandler(promhttp.Handler()))

    // your working routes
    r.GET("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{"message": "home"})
     })
}
```

### Static check

```shell
go run github.com/golangci/golangci-lint/cmd/golangci-lint@latest run
```

```shell
go run honnef.co/go/tools/cmd/staticcheck@latest -f stylish ./...
```

### 🎉 Metrics

Details about exposed Prometheus metrics.

| Name                                  | Type      | Exposed Information                 |
|---------------------------------------|-----------|-------------------------------------|
| service_uptime                        | Counter   | HTTP service uptime.                |
| service_http_request_count_total      | Counter   | Total number of HTTP requests made. |
| service_http_request_duration_seconds | Histogram | HTTP request latencies in seconds.  |
| service_http_request_size_bytes       | Summary   | HTTP request sizes in bytes.        |
| service_http_response_size_bytes      | Summary   | HTTP response sizes in bytes.       |

### 📊 Grafana

Although Prometheus offers a simple dashboard, Grafana is clearly a better choice. [Grafana's configuration](./ginprom-service.json).

![GrafanaDashboard](https://user-images.githubusercontent.com/19553554/65812184-19a5a000-e1f6-11e9-8881-e0c260196bc9.png)

### 📃 LICENSE

MIT [©chenjiandongx](https://github.com/chenjiandongx)
