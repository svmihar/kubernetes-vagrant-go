package controllers

import (
	"log"

	"github.com/labstack/echo/v4"
)

// PrintHelloWorld prints hello world
func PrintHelloWorld(c echo.Context) error {
	log.Println("Hello World!")
	return c.String(200, "Hello World!")
}
