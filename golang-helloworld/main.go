package main

import (
	"golang-helloworld/routes"
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %s", err)
	}

	e := echo.New()

	routes.Build(e)
	e.Logger.Fatal(e.Start(":" + os.Getenv("APP_PORT")))
}
