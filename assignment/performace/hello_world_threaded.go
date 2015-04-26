package main

import "fmt"

func main() {
	done := make(chan bool)
	for i := 0; i < 100; i++ {
		go func() {
			for j := 0; j < 10000; j++ {
				fmt.Println("Hello World")
			}
			done <- true
		}()
	}

	for k := 0; k < 100; k++ {
		<- done
	}
}

//2.19s