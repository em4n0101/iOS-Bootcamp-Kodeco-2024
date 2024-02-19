import UIKit

/**
 a) Create an array of Int called nums with values 0 through 20. Iterate over the Array and print the even numbers.
 */

let nums = Array(0...20)

for evenNumber in nums where evenNumber % 2 == 0 {
  print(evenNumber)
}


/**
 b) In your Playground, define the following String:
 let sentence = “The qUIck bRown fOx jumpEd over the lAzy doG”
 
 Iterate over sentence counting the vowels (a, e, i, o, u), ignoring the case.
 
 Iterate over the given sentence, counting the vowels while ignoring the case. But this time, keep track of the count of each vowel. Finally, print the vowels and their count in ascending order by count.
 */

let sentence = "The qUIck bRown fOx jumpEd over the lAzy doG"
var vowelCounts: [Character: Int] = ["a": 0, "e": 0, "i": 0, "o": 0, "u": 0]

for letter in sentence.lowercased() {
  if (letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u" ) {
    vowelCounts[letter, default: 0] += 1
  }
}

let sortedVowelCounts = vowelCounts.sorted { $0.value < $1.value }

for (vowel, count) in sortedVowelCounts {
  print("\(vowel): \(count)")
}


/**
 c) Create two arrays of Int with the values of 0 through 4. Use a nested for loop to print a mini multiplication table. The output, which should be multiple lines, should be in the following format:
 0 * 0 = 0
 
 The format follows the number from the first array, space, followed by the character *, space,  followed by the number from the second array, space,  followed by =, space, followed by the result of the number from the first array multiplied by the number from the second array (just like the example above). There are a couple of ways to achieve this, but String Interpolation is the easiest.
 */

let arrayA = Array(0...4)
let arrayB = Array(0...4)

for numA in arrayA {
  for numB in arrayB {
    print("\(numA) * \(numB) = \(numA * numB)")
  }
}


/**
 d) Write a function called average that takes an optional array of Int. If the array is not nil, calculate the average of the array's values and print:
 “The average of the values in the array is <average>.”
 
 Where <average> is the calculated average. If the array is nil, print:
 “The array is nil. Calculating the average is impossible.”
 
 Note: the average is calculated by summing the values in the array and dividing by the number of elements.
 
 Call this function two times. First, pass in the nums array from part A and second by passing an optional array of Int.
 */

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

average(numbers: nums)
average(numbers: nil)


/**
 e) Create a struct called Person with the properties firstName, lastName, and age. Choose appropriate data types for the properties. Include a method on Person called details that prints the values stored in the properties in the following format:
 Name: <firstName> <lastName>, Age: <age>
 
 Create an instance of Person called person. Pass your first name, last name, and age for the properties. Finally, call the method details.
 */

struct Person {
  var firstName: String
  var lastName: String
  var age: Int
  
  func details() {
    print("Name: \(firstName) \(lastName), Age: \(age)")
  }
}

let person = Person(firstName: "Alejandro", lastName: "Barranco", age: 34)
person.details()


/**
 f) Create a class called Student with two properties: person of type Person and grades, an array of Int. The class must have a method called calculateAverageGrade that takes no parameters and returns a Double. Include a method called details that prints the values of the properties stored in Student along with the average grade in the following format:
 Name: <firstName> <lastName>, Age: <age>, GPA: <average grade>.
 
 Create an instance of Student called student passing in your first name, last name, age, and an array of five numbers: 94, 99, 81, 100, 79. Next call the details method to output the details of the student.
 */

class Student {
  var person: Person
  var grades: [Int]
  
  init(person: Person, grades: [Int]) {
    self.person = person
    self.grades = grades
  }
  
  func calculateAverageGrade() -> Double {
    var sum = 0
    for grade in grades {
      sum+=grade
    }
    return Double(sum) / Double(grades.count)
  }
  
  func details() {
    let averageGrade = calculateAverageGrade()
    print("Name: \(person.firstName) \(person.lastName), Age: \(person.age), GPA: \(averageGrade)")
  }
}

let student = Student(person: Person(firstName: "Alejandro", lastName: "Barranco", age: 34), grades: [94, 99, 81, 100, 79])
student.details()


/**
 Part 3 - Above and Beyond.
 */

struct Square {
  var side: Int
  func area() -> Int {
    return side * side
  }
}

class Rectangle {
  var length: Int
  var width: Int
  init(length: Int, width: Int) {
    self.length = length
    self.width = width
  }
  func area() -> Int {
    return length * width
  }
}

var square1 = Square(side: 4)
var square2 = square1
square2.side = 5
print("Area: square1 - \(square1.area()) square2 - \(square2.area())")

var rectangle1 = Rectangle(length: 4, width: 4)
var rectangle2 = rectangle1
rectangle2.length = 5
print("Area: rectangle1 - \(rectangle1.area()) rectangle2 - \(rectangle2.area())")
