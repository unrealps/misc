package main

import (
	"fmt"
)

func main() {
	fmt.Println("Unsigned Integer Variables in Go")
	var a uint8 = 255
	var b uint16 = 65535
	var c uint32 = 4294967295
	var d uint64 = 18446744073709551615

	fmt.Printf("Value of a (uint8): %d\n", a)
	fmt.Printf("Value of b (uint16): %d\n", b)
	fmt.Printf("Value of c (uint32): %d\n", c)
	fmt.Printf("Value of d (uint64): %d\n", d)

	fmt.Println("Signed Integer Variables in Go")
	var e int8 = -128                  // -128 to 127
	var f int16 = -32768               // -32768 to 32767
	var g int32 = -2147483648          // -2147483648 to 2147483647
	var h int64 = -9223372036854775808 // -9223372036854775808 to 9223372036854775807

	fmt.Printf("Value of e (int8): %d\n", e)
	fmt.Printf("Value of f (int16): %d\n", f)
	fmt.Printf("Value of g (int32): %d\n", g)
	fmt.Printf("Value of h (int64): %d\n", h)

	// rune = int32
	var r rune = 'A'
	fmt.Printf("Value of r (rune): %d\n", r)

	// byte = uint8
	var by byte = 255
	fmt.Printf("Value of by (byte): %d\n", by)

	// uint and int
	var ui uint = 4294967295 // platform dependent size
	var si int = -2147483648 // platform dependent size

	fmt.Printf("Value of ui (uint): %d\n", ui)
	fmt.Printf("Value of si (int): %d\n", si)

	fmt.Println("Floating-Point Variables in Go")
	var f32 float32 = 3.4028235e+38
	var f64 float64 = 1.7976931348623157e+308

	fmt.Printf("Value of f32 (float32): %f\n", f32)
	fmt.Printf("Value of f64 (float64): %f\n", f64)

	fmt.Println("Complex Number Variables in Go")
	var c64 complex64 = complex(1.5, 2.5)
	var c128 complex128 = complex(3.5, 4.5)

	fmt.Printf("Value of c64 (complex64): %v\n", c64)
	fmt.Printf("Value of c128 (complex128): %v\n", c128)

	fmt.Println("String Variable in Go")
	var str string = "Hello, Go!"
	var strMultiLine string = `This is a
multi-line
string.`
	fmt.Printf("Value of str (string): %s\n", str)
	fmt.Printf("Value of strMultiLine (string): %s\n", strMultiLine)

	fmt.Println("Character Variable in Go")
	var char rune = 'G'
	fmt.Printf("Value of char (rune): %c\n", char)

	fmt.Println("Ascii Value of Character")
	fmt.Printf("Ascii value of char: %d\n", char)

	fmt.Println("Ascii Value of a String")
	for i := 0; i < len(str); i++ {
		fmt.Printf("Ascii value of %c: %d\n", str[i], str[i])
	}

	fmt.Println("Boolean Variable in Go")
	var boolVar bool = true

	fmt.Printf("Value of boolVar (bool): %t\n", boolVar)

	fmt.Println("Defining two strings at same time")
	var firstName, lastName string = "John", "Doe"
	fmt.Printf("First Name: %s, Last Name: %s\n", firstName, lastName)
}
