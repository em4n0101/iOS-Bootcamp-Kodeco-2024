import UIKit

/**
 a) In the assignment for Week 3, part D asked you to write a function that would compute the average of an array of Int. Using that function and the array created in part A, create two overloaded functions of the function average.
 */

let numsA = Array(0...20)

func average(numbers: [Int]?) {
  var sum = 0
  if let numbers = numbers {
    for number in numbers {
      sum+=number
    }
    print("The average of the values in the array is \(sum / numbers.count).")
  } else {
    print("The array is nil. Calculating the average is impossible.")
  }
}

func average(numbers: [Double]?) -> Double? {
  var sum = 0.0
  if let numbers = numbers {
    for number in numbers {
      sum+=Double(number)
    }
    return sum / Double(numbers.count)
  } else {
    return nil
  }
}

func average(numbers: [Int]?, numberOfElements: Int) {
  var sum = 0.0
  if let numbers = numbers {
    for number in numbers {
      sum+=Double(number)
    }
    print("The average of the values in the array is \(sum / Double(numberOfElements)).")
  } else {
    print("The array is nil. Calculating the average is impossible.")
  }
}

average(numbers: numsA)
average(numbers: numsA, numberOfElements: numsA.count)


/**
 b) Create an enum called Animal that has at least five animals. Next, make a function called theSoundMadeBy that has a parameter of type Animal. This function should output the sound that the animal makes. For example, if the Animal passed is a cow, the function should output, “A cow goes moooo.”
 Hint: Do not use if statements to complete this section.
 Call the function twice, sending a different Animal each time.
 */

enum Animal {
    case cow
    case dog
    case cat
    case lion
    case duck
    case pig
}

func theSoundMadeBy(animal: Animal) {
    switch animal {
    case .cow:
        print("A cow goes moooo.")
    case .dog:
        print("A dog goes woof.")
    case .cat:
        print("A cat goes meow.")
    case .lion:
        print("A sheep goes roar.")
    case .duck:
        print("A horse goes quack.")
    case .pig:
        print("A horse goes oink.")
    }
}

theSoundMadeBy(animal: .cow)
theSoundMadeBy(animal: .duck)


/**
 c) This question will have you creating multiple functions that will require you to use closures and collections. First, you will do some setup.
 
 Create an array of Int called nums with the values of 0 to 100.
 Create an array of Int? called numsWithNil with the following values:
 79, nil, 80, nil, 90, nil, 100, 72

 Create an array of Int called numsBy2 with values starting at 2 through 100, by 2.
 Create an array of Int called numsBy4 with values starting at 2 through 100, by 4.
 */
var nums = Array(0...100)
var numsWithNil = [79, nil, 80, nil, 90, nil, 100, 72]

let numsBy2 = Array(stride(from: 2, through: 100, by: 2))
let numsBy4 = Array(stride(from: 2, through: 100, by: 4))

/**
 - Create a function called evenNumbersArray that takes a parameter of [Int] (array of Int) and returns [Int]. The array of Int returned should contain all the even numbers in the array passed. Call the function passing the nums array and print the output.
 */
func evenNumbersArray(numbers: [Int]) -> [Int] {
  numbers.filter { $0 % 2 == 0 }
}

print("Even numbers in the array")
evenNumbersArray(numbers: nums).forEach { print($0)}

/**
 - Create a function called sumOfArray that takes a parameter of [Int?] and returns an Int. The function should return the sum of the array values passed that are not nil. Call the function passing the numsWithNil array, and print out the results.
 */
func sumOfArray(numbers: [Int?]) -> Int {
  numbers.compactMap { $0 }.reduce(0, +)
}

print("The sum of the array values passed that are not nil: \(sumOfArray(numbers: numsWithNil))")

/**
 - Create a function called commonElementsSet that takes two parameters of [Int] and returns a Set<Int> (set of Int). The function will return a Set<Int> of the values in both arrays.
 */
func commonElementsSet(array1: [Int], array2: [Int]) -> Set<Int> {
    let commonElements = array2.filter { array1.contains($0) }
    return Set(commonElements)
}

/**
 - Call the function commonElementsSet passing the arrays numsBy2, numsBy4, and print out the results.
 */
print("Common elements set: \(commonElementsSet(array1: numsBy2, array2: numsBy4))")


/**
 d) Create a struct called Square that has a stored property called sideLength and a computed property called area. Create an instance of Square and print the area.
 */
struct Square {
    var sideLength: Double
    var area: Double {
        return sideLength * sideLength
    }
}

let square = Square(sideLength: 5)
print("Area of the square: \(square.area)")
