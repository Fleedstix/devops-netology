# Домашнее задание к занятию "7.5. Основы golang"

> Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода на своем компьютере, либо использовать песочницу: https://play.golang.org/.

> Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:

```
package main

import "fmt"

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input * 2

    fmt.Println(output)    
}
```
```
package main

import "fmt"

func main() {
	fmt.Print(" enter the number of meters:")
	var input float64
	fmt.Scanf("%f", &input)

	output := input / 0.3048

	fmt.Println(output, "feet")
}
```
> Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```
x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
```
```
package main

import "fmt"

func main() {
	var x = []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	var min int = x[0]
	for _, v := range x {
		if (v < min) {
			min = v
		}
	}

	fmt.Println(min)
}
```
> Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

```
package main

import (
	"fmt"
)

func main() {
	for i := 0; i < 100; i++ {
		if (i % 3 == 0) {
			fmt.Println(i)
		}
	}
}
```

