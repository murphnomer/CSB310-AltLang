//
//  CellCabinet.swift
//  Cell
//
//  Created by Mike Murphy on 6/4/23.
//

import Foundation
import SwiftCSV
class CellCabinet {
    var cells: [Cell] = []
    
    var oemList: [String] {
        var oems: Set<String> = Set()
        for cell in cells {
            oems.insert(cell.Manufacturer)
        }
        return oems.sorted()
    }
    
    var averageCellWeight: [String: Float] {
        var totals: [String: (count: Int, weight: Float)] = [:]
        var avg: [String: Float] = [:]
        
        for cell in cells {
            var stats: (count: Int, weight: Float) = (((cell.Weight ?? 0.0) == 0.0) ? 0 : 1, ((cell.Weight ?? 0.0) == 0.0) ? 0.0 : cell.Weight!)
            stats = ((totals[cell.Manufacturer] ?? (0, 0.0)).count + stats.count, (totals[cell.Manufacturer] ?? (0, 0.0)).weight + stats.weight)
            totals[cell.Manufacturer] = stats
            avg[cell.Manufacturer] = totals[cell.Manufacturer]!.weight / Float(totals[cell.Manufacturer]!.count)
        }
        
        return avg
        
    }
    
    var diffReleaseYear: [Cell] {
        var diff: [Cell] = []
        
        for cell in cells {
            let ya = (cell.YearAnnounced ?? 0), yr = (cell.YearReleased ?? 0)
            if  ya != 0 && yr != 0 && ya != yr {
                diff.append(cell)
            }
        }
        
        return diff
    }
    
    var onlyOneFeature: [Cell] {
        var onlyOne: [Cell] = []
        
        for cell in cells {
            if (cell.Features != "") && !cell.Features.contains(",") {
                onlyOne.append(cell)
            }
        }
        return onlyOne
    }
    
    init(cellFileURL: String) {
        do {
            let csv: CSV = try CSV<Named>(url: URL(string:cellFileURL)!)
            for r in csv.rows {
                var cell : Cell = Cell()
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
            /*
             print(cells.randomElement()!)
             print()
             print(cells.randomElement()!)
             print("\n")
             */
            
        } catch {
            print(error)
        }
        
    }
}
