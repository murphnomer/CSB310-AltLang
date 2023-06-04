//
//  main.swift
//  Cell
//
//  Created by Mike Murphy on 5/27/23.
//

import Foundation
import SwiftCSV

let cellFileURL : String = "https://raw.githubusercontent.com/murphnomer/CSB310-AltLang/main/cells.csv"
var cells : [Cell] = []

do {
    let csv: CSV = try CSV<Named>(url: URL(string:cellFileURL)!)
    print("CSV has \(csv.rows.count) rows")
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
    print("Got \(cells.count) cell objects")

} catch {
    print(error)
}

