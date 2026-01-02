package main

import "fmt"

func main() {
	const pi = 3.1415
	var radius float64 = 5.0
	area := pi * radius * radius

	fmt.Printf("The area of a circle with radius %.2f is %.2f\n", radius, area)
}
