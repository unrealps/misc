package main

import "fmt"

func main() {
	var input1, input2 int
	fmt.Print("Enter first integer: ")
	fmt.Scanln(&input1)
	fmt.Print("Enter second integer: ")
	fmt.Scanln(&input2)

	sum := input1 + input2
	difference := input1 - input2
	product := input1 * input2
	quotient := float64(input1) / float64(input2)
	remainder := input1 % input2

	add := input1
	add += input2 // Equivalent to add = add + input2

	subtract := input1
	subtract -= input2 // Equivalent to subtract = subtract - input2

	multiply := input1
	multiply *= input2 // Equivalent to multiply = multiply * input2

	divide := float64(input1)
	divide /= float64(input2) // Equivalent to divide = divide / input2

	modulus := input1
	modulus %= input2 // Equivalent to modulus = modulus % input2

	// Display results
	fmt.Printf("Sum: %d + %d = %d\n", input1, input2, sum)
	fmt.Printf("Difference: %d - %d = %d\n", input1, input2, difference)
	fmt.Printf("Product: %d * %d = %d\n", input1, input2, product)
	fmt.Printf("Quotient: %d / %d = %.2f\n", input1, input2, quotient)
	fmt.Printf("Remainder: %d %% %d = %d\n", input1, input2, remainder)

	fmt.Printf("Add using += : %d += %d results in %d\n", input1, input2, add)
	fmt.Printf("Subtract using -= : %d -= %d results in %d\n", input1, input2, subtract)
	fmt.Printf("Multiply using *= : %d *= %d results in %d\n", input1, input2, multiply)
	fmt.Printf("Divide using /= : %d /= %d results in %.2f\n", input1, input2, divide)
	fmt.Printf("Modulus using %%= : %d %%= %d results in %d\n", input1, input2, modulus)
}
