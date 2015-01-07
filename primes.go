// A concurrent prime sieve

package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

func primes(n int) []int {
	if n == 2 {
		return []int{2}
	} else if n < 2 {
		return []int{}
	}
	s := []int{}
	for i := 3; i < n+1; i = i + 2 {
		s = append(s, i)
	}
	mroot := math.Sqrt(float64(n))
	half := (n+1)/2 - 1
	i, m := 0, 3.0
	for m <= mroot {
		if s[i] != 0 {
			j := int((m*m - 3) / 2)
			s[j] = 0
			for j < half {
				s[j] = 0
				j += int(m)
			}
		}
		i = i + 1
		m = 2.0*float64(i) + 3.0
	}
	return func(s []int) []int {
		x_in_s := []int{2}
		for _, x := range s {
			if x != 0 {
				x_in_s = append(x_in_s, x)
			}
		}
		return x_in_s
	}(s)
}

func main() {
	max, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Println("no integer passed")
		os.Exit(1)
	}
	primes_all := primes(max)
	fmt.Println(len(primes_all))
}
