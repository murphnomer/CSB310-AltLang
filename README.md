# Swift Language Project  
## by Mike Murphy  

For my alternative language project, I chose Swift, which is now the primary language that Apple uses internally and encourages developers who want to develop for its various platforms to use.  I chose this language because I use and greatly enjoy Apple products, and have had a number of ideas for apps I would like to create for iPhones, iPads, and other Apple devices.  However, my lack of knowledge of Swift has meant that I have not yet started to make these apps, so I decided this project was a great opportunity to get my feet wet.  

Swift is an OOP-native language, and very strongly supports objects across the board.  It is loosely based on Apple's previous preferred language, Objective-C which was itself an attempt to add OOP support to C.  Swift is under active development by Apple, with new versions being released annually to coincide with releases of Apple's flagship operating system platforms, such as iOS, iPadOS, MacOS, and so on.  The current version of Swift is 5.8.  

## Interesting concepts
Below are some interesting deviations I encountered in Swift from other languages I am accustomed to using, such as Java and Python.  

### Optional types
When declaring a property in a class, including a ? after the type name marks that property as Optional (i.e. Int?), and that type is considered to be separate from the non-optional variant of the same type.  Optional properties that have not been specified for a particular instance of a Class retain the value **nil** (the Swift equivalent of null in Java or None in Python)  Before accessing an optional property, you must "unwrap" that property either explicitly (by including a ! character after the name of the property) or implicitly by including access of the property inside of an if let block.  Any attempts to use a nil property will result in a runtime error.

Optional types make working with data that might or might not be specified really easy (such as the column with invalid data in this project).

### Regex literals
Regular expressions in Swift are very easy to use thanks to the Regex Literal, specified by enclosing the desired regex in / characters.

### Calculated Properties
In Swift, you can specify Calculated Properties alongside normal property variables by simply providing a code block after the name of the variable that calculates and returns the desired property value.

## Libraries
Swift only provides three native data structures: Arrays, Sets, and Dictionaries.  Other data structures can be fashioned from these either using inheritance or by using included methods to simulate the desired data structure behavior (using an Array as a Queue, for instance).

In addition, I had to use a third party CSV parsing library, as no native library for this funcitonality was available.

## Questions about the data

### What company (oem) has the highest average weight of the phone body?
HP with a weight of 453.6g

### Were there any phones announced in one year and released in another?
Yes:
Motorola One Hyper was announced in 2019 and released in 2020.
Motorola Razr 2019 was announced in 2019 and released in 2020.
Xiaomi Redmi K30 5G was announced in 2019 and released in 2020.
Xiaomi Mi Mix Alpha was announced in 2019 and released in 2020.

### How many phones have only one feature sensor?
432  
This is a large number because the assignment specified that the value "V1" was acceptable, and nearly half of the phone in the dataset had this singular value for this column.

### What year in the 2000s had the most phones launched?
2019 with 303 launches.

