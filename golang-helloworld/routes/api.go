package routes

import (
	"golang-helloworld/controllers"

	"github.com/labstack/echo/v4"
)

// Build returns the application routes
func Build(e *echo.Echo) {
	e.GET("/", controllers.PrintHelloWorld)
}
