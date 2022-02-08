//
//  main.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 08.02.2022.
//

import Foundation

var isRepeat = true

repeat {
    print("---Меню---")
    print("1. Первое домашнее задание. 1. Решить квадратное уровнение")
    print("2. Первое домашнее задание. 2. Прямоугольный треугольник")
    print("3. Первое домашнее задание. 3. Рассчитать сумму вклада")

    print("4. Второе домашнее задание. 1. Проверка на четное число")
    print("5. Второе домашнее задание. 2. Проверка на кратность числу 3")
    print("6. Второе домашнее задание. 3. Выводит массив из 100 чисел")
    print("7. Второе домашнее задание. 4. Массив от 1 до 100 без четных чисел и чисел кратных 3")
    print("8. Второе домашнее задание. 5. Массив чисел Фибоначчи из 50 элементов")
    print("9. Второе домашнее задание. 6. Массив из 100 элементов различными простыми числами")

    print("0. Выйти из программы")
    print()
    let menuNumber = readDoubleParameter()
    print()
    switch menuNumber {
    case 1:
        quadraticEquation()
    case 2:
        triangle()
    case 3:
        depositAmount()
    case 4:
        let number = readIntParameter(parameterName: "целое число")
        if isEven(number) {
            print("Вы ввели четное число!")
        } else {
            print("Вы ввели не четное число!")
        }
    case 5:
        let number = readIntParameter(parameterName: "целое число")
        if isDevidedWithoutRemainderByThree(number) {
            print("Введенное число кратно 3")
        } else {
            print("Введенное число не кратно 3")
        }
    case 6:
        let numbers = getAnArrayOfNumbersFromOneToHundred()
        print("Массив целых числел размером \(numbers.count):")
        print(numbers)
    case 7:
        var numbers  = getAnArrayOfNumbersFromOneToHundred()
        numbers = numbers.filter { number in
            return !isEven(number) && isDevidedWithoutRemainderByThree(number)
        }
        print("Массив без четных чисел и чисел не кратных 3. Длина массива \(numbers.count)")
        print(numbers)
    case 8:
        var fibonacci: [Int] = [1, 1]
        // Диапазон начинается с 3 так, как массив уже состоит из 2 элементов		
        for _ in 3...50 {
            fibonacci.append(newFibonacciNumber(fibonacci))
        }
        print("Массив чисел Фибоначчи из \(fibonacci.count) элементов")
        print(fibonacci)
    case 9:
        let arrayLength = readIntParameter(parameterName: "кол-во простых чисел", isPositive: true)
        let primes = generatePrimes(count: arrayLength)
        print("Массив из \(primes.count) различных простых чисел")
        print(primes)
    case 0:
        isRepeat = false
    default:
        print("Введет неверный номер пункта меню. Попробуйте еще раз!")
    }
    print()
} while isRepeat
