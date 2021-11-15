package testgrp

import (
	"context"
	"github.com/vince15dk/myservice3/foundation/web"
	"go.uber.org/zap"
	"net/http"
)

// Handlers manage the set of check endpoints.
type Handlers struct {
	Log *zap.SugaredLogger
}

// Test handler is for development.
func (h Handlers) Test(ctx context.Context, w http.ResponseWriter, r *http.Request) error {
	status := struct {
		Status string
	}{
		Status: "OK",
	}

	return web.Respond(ctx, w, status, http.StatusOK)
}
