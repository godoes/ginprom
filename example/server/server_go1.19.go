//go:build !go1.20

package main

import (
	"math/rand"
	"time"
)

func init() {
	// rand.Seed 从 go1.20 开始被弃用
	rand.Seed(time.Now().Unix())
}
