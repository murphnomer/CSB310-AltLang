//
//  main.swift
//  Cell
//
//  Created by Mike Murphy on 5/27/23.
//

import Foundation
import SwiftCSV

struct OEMStats {
    var Count: Int = 0
    var TotalWeight: Float = 0.0
}

func getUniqueOEMs(cellList: [Cell]) -> [String] {
    var oems: Set<String> = Set()
    for cell in cellList {
        oems.insert(cell.Manufacturer)
    }
    return oems.sorted()
}

let cellFileURL: String = "https://raw.githubusercontent.com/murphnomer/CSB310-AltLang/main/cells.csv"
var cabinet: CellCabinet

cabinet = CellCabinet(cellFileURL: cellFileURL)

let sortedByWeight = cabinet.averageCellWeight.sorted{ $0.1 > $1.1 }

print("Count: \(sortedByWeight.count) Winner: \(sortedByWeight)")

for cell in cabinet.diffReleaseYear {
    print("\(cell.Manufacturer) \(cell.Model) was announced in \(cell.YearAnnounced!) and released in \(cell.YearReleased!).")
}
print("\(cabinet.onlyOneFeature.count) cells with only one feature.")

