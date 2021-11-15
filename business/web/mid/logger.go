package mid

import (
	"context"
	"github.com/vince15dk/myservice3/foundation/web"
	"go.uber.org/zap"
	"net/http"
	"time"
)

// Logger ...
func Logger(log *zap.SugaredLogger) web.Middleware {
	m := func(handler web.Handler) web.Handler {
		h := func(ctx context.Context, w http.ResponseWriter, r *http.Request) error {

			traceID := "0000000000000000"
			statuscode := http.StatusOK
			now := time.Now()

			log.Infow("request started", "traceid", traceID, "method", r.Method, "path", r.URL.Path,
				"remoteaddr", r.RemoteAddr)

			// Call the next handler.
			err := handler(ctx, w, r)

			log.Infow("request completed", "traceid", traceID, "method", r.Method, "path", r.URL.Path,
				"remoteaddr", r.RemoteAddr, "statuscode", statuscode, "since", time.Since(now))

			return err
		}

		return h
	}
	return m
}
