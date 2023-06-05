//
//  CellCabinet.swift
//  Cell
//
//  Created by Mike Murphy on 6/3/23.
//

import Foundation
import SwiftCSV

// Class to track overall collection of Cell objects and do collection-wide statistics and metrics
class CellCabinet {
    
    // Array data structure to store Cell objects
    var cells: [Cell] = []
    
    // Calculated property to get list of unique oems in the dataset
    var oemList: [String] {
        // Set data structure to generate unique list
        var oems: Set<String> = Set()
        // add each cell to the Set
        for cell in cells {
            oems.insert(cell.Manufacturer)
        }
        // return a sorted Array built from the Set
        return oems.sorted()
    }
    
    // Calculated property to return a Dictionary data structure with the average weight of phones from each oem
    var averageCellWeight: [String: Float] {
        // Dictionary with the count and total weight of all cells from any given oem
        var totals: [String: (count: Int, weight: Float)] = [:]
        // Dictionary with running averages
        var avg: [String: Float] = [:]
        
        for cell in cells {
            // this convoluted calculation creates a (1, weight) tuple if the weight optional property exists for this
            // cell object, and a (0,0) one otherwise.  this allows us to ignore those cell objects that don't have
            // valid data in the weight column
            var stats: (count: Int, weight: Float) = (((cell.Weight ?? 0.0) == 0.0) ? 0 : 1, ((cell.Weight ?? 0.0) == 0.0) ? 0.0 : cell.Weight!)
            // add the temp tuple created in the previous line to the running total for this oem
            stats = ((totals[cell.Manufacturer] ?? (0, 0.0)).count + stats.count, (totals[cell.Manufacturer] ?? (0, 0.0)).weight + stats.weight)
            // and store the updated running totals
            totals[cell.Manufacturer] = stats
            // and the running average, or 0 if count is 0 to avoid diving by 0
            avg[cell.Manufacturer] = totals[cell.Manufacturer]!.count == 0 ? 0 : totals[cell.Manufacturer]!.weight / Float(totals[cell.Manufacturer]!.count)
        }
        
        // return the running average Dictionary
        return avg
        
    }
    
    // Calculated property to identify Cell objects that were announced in a different year than they were released,
    // if both years were present in the source data
    var diffReleaseYear: [Cell] {
        // temp Array for storage of matching Cell objects
        var diff: [Cell] = []
        
        for cell in cells {
            // populate the year variables if the data exists, make it 0 otherwise
            let ya = (cell.YearAnnounced ?? 0), yr = (cell.YearReleased ?? 0)
            // check if the year exists and is different
            if  ya != 0 && yr != 0 && ya != yr {
                diff.append(cell)
            }
        }
        
        // return the temp array of matching objects
        return diff
    }
    
    // Calculated property to identify Cell objects that only have one listed sensor/feature
    var onlyOneFeature: [Cell] {
        // temp storage variable for objects that match the rule
        var onlyOne: [Cell] = []
        
        for cell in cells {
            // if the features list is not blank and it doesn't contain a comma, then there's only one feature
            if (cell.Features != "") && !cell.Features.contains(",") {
                onlyOne.append(cell)
            }
        }
        
        // return the temp variable
        return onlyOne
    }
    
    // Calculated property to produce a count of phones announced in each calendar year over 2000
    var phonesByYear: [Int: Int] {
        // temp Dictionary to store the list
        var yearCount: [Int: Int] = [:]
        
        for cell in cells {
            // if the year is 2000 or later
            if ((cell.YearAnnounced ?? 0) >= 2000) {
                // if we haven't seen this year yet, initialize it to 1
                if yearCount[cell.YearAnnounced!] ?? 0 == 0 {
                    yearCount[cell.YearAnnounced!] = 1
                // otherwise add 1 to the current count
                } else {
                    yearCount[cell.YearAnnounced!]! += 1
                }
            }
        }
        
        // return the temp variable
        return yearCount
    }
    
    // Calculated property to identify the largest overall phone as measured by volume
    var biggestPhone: Cell {
        // temp variable with a tuple containing the largest phone seen so far and its total volume
        var bigGuy: (size: Float, cell: Cell) = (0, Cell())
        var size: Float = 0.0
        
        for cell in cells {
            // if this Cell object had body size specified
            if (cell.Dimensions ?? Cell.Dimension3()).description != "Unknown" {
                // calculate the volume of this one
                size = cell.Dimensions!.Height * cell.Dimensions!.Width * cell.Dimensions!.Thickness
                // if it's the biggest yet, store it
                if size > bigGuy.size {
                    bigGuy = (size, cell)
                }
            }
        }
        
        // return the temp variable
        return bigGuy.cell
    }
    
    // constructor to build a list of Cell objects from the provided .csv file
    // NOTE: None of the methods I could find a listing for worked for accessing the file via the local "Bundle",
    // so I had to reference the file directly from the GitHub repo.
    // NOTE 2: Swift doesn't have a built-in CSV parser, so I had to use a third-party library for this functionality,
    // available at: https://swiftpackageindex.com/swiftcsv/SwiftCSV
    init(cellFileURL: String) {
        do {
            // initialize the CSV parser with the provided URL
            let csv: CSV = try CSV<Named>(url: URL(string:cellFileURL)!)
            // parse all of the rows and call the Cell class' parsing functions
            for r in csv.rows {
                let cell : Cell = Cell()
                cell.parseManufacturer(value: r["oem"] ?? "")
                cell.parseModel(value: r["model"] ?? "")
                cell.parseYearAnnounced(value: r["launch_announced"] ?? "")
                cell.parseYearReleased(value: r["launch_status"] ?? "")
                cell.parseLaunchStatus(value: r["launch_status"] ?? "")
                cell.parseDimensions(value: r["body_dimensions"] ?? "")
                cell.parseWeight(value: r["body_weight"] ?? "")
                cell.parseSIMType(value: r["body_sim"] ?? "")
                cell.parseDisplayType(value: r["display_type"] ?? "")
                cell.parseDisplaySize(value: r["display_size"] ?? "")
                cell.parseDisplayResolution(value: r["display_resolution"] ?? "")
                cell.parseFeatures(value: r["features_sensors"] ?? "")
                cell.parseOSPlatform(value: r["platform_os"] ?? "")
                cells.append(cell)
            }
        } catch {
            print(error)
        }
        
    }
}
