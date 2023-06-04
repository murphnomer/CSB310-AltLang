//
//  Cell.swift
//  Cell
//
//  Created by Mike Murphy on 6/2/23.
//

import Foundation

class Cell {
    struct Dimension2 {
        var Width : Int = 0
        var Height : Int = 0
    }
    
    struct Dimension3 {
        var Width : Float = 0.0
        var Height : Float = 0.0
        var Thickness : Float = 0.0
    }
    
    struct Display {
        var Tech : String = ""
        var Size : Float?
        var Resolution : Dimension2 = Dimension2()
    }

    var Manufacturer : String = ""
    var Model : String = ""
    var YearAnnounced : Int?
    var YearReleased : Int?
    var LaunchStatus : String?
    var Dimensions : Dimension3?
    var Weight : Float?
    var SIMType : String?
    var Display : Display = Display()
    var Features : String = ""
    var OSPlatform : String?
    
    func parseManufacturer(value : String) -> String {
        self.Manufacturer = value
        return self.Manufacturer
    }
    
    func parseModel(value : String) -> String {
        self.Model = value
        return self.Model
    }
    
    func parseYearAnnounced(value : String) -> Int? {
        if let match = value.firstMatch(of: /^(\d{4})/ ) {
            YearAnnounced = Int(match.1)
        }
        return self.YearAnnounced

    }

    func parseYearReleased(value : String) -> Int? {
        if let match = value.firstMatch(of: /(\d{4})/ ) {
            YearReleased = Int(match.1)
        }
        return self.YearReleased
    }

    func parseLaunchStatus(value : String) -> String? {
        if let match = value.firstMatch(of: /(\d{4}|Discontinued|Cancell?ed)/ ) {
            LaunchStatus = String(match.1)
        }
        return self.LaunchStatus
    }
    
    func parseDimensions(value : String) -> Dimension3? {
        if let match = value.firstMatch(of: /([\d.]+) x ([\d.]+) x ([\d.]+) mm/ ) {
            Dimensions = Dimension3()
            Dimensions!.Height = Float(match.1)!
            Dimensions!.Width = Float(match.2)!
            Dimensions!.Thickness = Float(match.3)!
        }
        return self.Dimensions
    }
    
    func parseWeight(value : String) -> Float? {
        if let match = value.firstMatch(of: /([\d.]+) g/ ) {
            self.Weight = Float(match.1)!
        }
        return self.Weight
    }
    
    func parseSIMType(value : String) -> String? {
        if value != "Yes" && value != "No" {
            self.SIMType = value
        }
        return self.SIMType
    }
    
    func parseDisplayType(value : String) -> String {
        self.Display.Tech = value
        return self.Display.Tech
    }
    
    func parseDisplaySize(value : String) -> Float? {
        if let match = value.firstMatch(of: /([\d.]+) cm/ ) {
            self.Display.Size = Float(match.1)!
        }
        return self.Display.Size
    }
    
    func parseDisplayResolution(value : String) -> String {
        if let match = value.firstMatch(of: /([\d]+) x ([\d]+) pixels/ ) {
            self.Display.Resolution.Width = Int(match.1)!
            self.Display.Resolution.Height = Int(match.2)!
        }
        var reso = "\(self.Display.Resolution.Height) x \(self.Display.Resolution.Width)"
        return reso
    }
    
    func parseFeatures(value : String) -> String {
        self.Features = value
        return self.Features
    }
    
    func parseOSPlatform(value : String) -> String? {
        if let match = value.firstMatch(of: /([^,]+),?/ ) {
            self.OSPlatform = String(match.1)
        }
        return self.OSPlatform
    }
    



}
