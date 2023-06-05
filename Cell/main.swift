//
//  main.swift
//  Cell
//
//  Created by Mike Murphy on 5/27/23.
//

import Foundation
import SwiftCSV

let cellFileURL: String = "https://raw.githubusercontent.com/murphnomer/CSB310-AltLang/main/cells.csv"
var cabinet: CellCabinet

// initialize the Array of Cell objects from the .csv file hosted on GitHub
// NOTE: Swift doesn't have a built-in CSV parser, so I had to use a third-party library for this functionality,
// available at: https://swiftpackageindex.com/swiftcsv/SwiftCSV
cabinet = CellCabinet(cellFileURL: cellFileURL)

// get the list of average weights by oem and sort it in descending order by the average
let sortedByWeight = cabinet.averageCellWeight.sorted{ $0.1 > $1.1 }

print("The OEM with the largest average phone weight is:")
// print out the first one in the list, which will be the one with the highest average
print("\(sortedByWeight[0].key) with average weight of \(sortedByWeight[0].value) g")
print()

// run the method to generate a list of machines that were released in a different year than they were announced
for cell in cabinet.diffReleaseYear {
    // and print out each one
    print("\(cell.Manufacturer) \(cell.Model) was announced in \(cell.YearAnnounced!) and released in \(cell.YearReleased!).")
}
print()

// generate and print the count of machines that only have one feature
print("\(cabinet.onlyOneFeature.count) cells with only one feature.")
print()

// generate the count of phones announced by year over 2000, then sort it by count descending
let sortedYearsByCount = cabinet.phonesByYear.sorted(by: { $0.1 > $1.1 })
// and print out the one with the highest count, which will be the first in the list
print("The year after 2000 with the most launched phones was \(sortedYearsByCount[0].key) with \(sortedYearsByCount[0].value) phones launched that year")
print()

// print out the largest phone in the list
print("The biggest overall phone is:")
print(cabinet.biggestPhone)
print()

// and print out the smallest one
print("The smallest overall phone is:")
print(cabinet.smallestPhone)

print("\n\n\n\n")

// Required tests
print("\(cabinet.rowsReadFromFile) rows were read from the input file, so it is not empty.")
print()

print("The body_weight variable is now type \(type(of: cabinet.cells.first?.Weight))")
print()
if let testCell: Cell = cabinet.findACell(oem: "Motorola", model: "V560") {
    print("The Motorola V560, which has several missing values, has the following platform: \(testCell.OSPlatform)")
    print("Since the procedure for processing missing data is the same, all other missing values should also be nil.")
}
if let testCell: Cell = cabinet.findACell(oem: "Motorola", model: "Moto Z4 Force") {
    print("The Motorola Moto Z4 Force, which has several - values, has the following weight: \(testCell.Weight)")
    print("Since the procedure for processing - data is the same, all other - values should also be nil.")
}


print("\n\n\n\n")

