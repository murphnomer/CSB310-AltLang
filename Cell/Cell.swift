//
//  Cell.swift
//  Cell
//
//  Created by Mike Murphy on 5/27/23.
//

import Foundation

// Class to track individual Cell objects representing rows in the provided .csv file
// CustomStringConvertible protocol allows objects to have automatic String conversion for printing and such
class Cell: CustomStringConvertible {
    
    // struct for screen dimensions
    struct Dimension2: CustomStringConvertible {
        var Width: Int = 0
        var Height: Int = 0
        
        // Swift version of toString, convert object to String type for printing
        var description: String {
            if Width == 0 && Height == 0 {
                return "Unknown"
            } else {
                return "\(Width) x \(Height) px"
            }
        }
    }
    
    // struct for phone body dimensions
    struct Dimension3: CustomStringConvertible {
        var Width: Float = 0.0
        var Height: Float = 0.0
        var Thickness: Float = 0.0
        
        // Swift version of toString, convert object to String type for printing
        var description: String {
            if (Width == 0.0 && Height == 0.0 && Thickness == 0.0) {
                return "Unknown"
            } else {
                return "\(Height) x \(Width) x \(Thickness)mm"
            }
        }
    }
    
    // struct for tracking the characteristics of the phone's display screen
    struct Display: CustomStringConvertible {
        var Tech: String = ""
        var Size: Float?
        var Resolution: Dimension2 = Dimension2()
        
        // Swift version of toString, convert object to String type for printing
        var description: String {
            if Tech == "" {
                return ": Unknown"
            } else {
                return " Type: \(Tech)\nSize: \((Size ?? 0.0) == 0 ? "Unknown" : String(Size!))cm² \(Resolution)"
            }
        }
    }

    // oem
    var Manufacturer: String = ""
    // model
    var Model: String = ""
    // optional: year the phone was announced
    var YearAnnounced: Int?
    // optional: year the phone was released
    var YearReleased: Int?
    // optional: launch status of the phone
    var LaunchStatus: String?
    // optional: dimensions of the phone body
    var Dimensions: Dimension3?
    // optional: weight of the phone
    var Weight: Float?
    // optional: type of SIM card supported by the phone
    var SIMType: String?
    // property to track properties of the display
    var Display: Display = Display()
    // list of features and sensors supported by the phone
    var Features: String = ""
    // operating system platform targeted by the phone at release
    var OSPlatform: String?
    
    // determine oem property from input value based on the rules specified in the assignment
    func parseManufacturer(value: String) {
        // just put whatever was in the file into this property
        self.Manufacturer = value
    }
    
    // determine model property from input value based on the rules specified in the assignment
    func parseModel(value: String){
        // just put whatever was in the file into this property
        self.Model = value
    }

    // if a announcement year was provided , record it here
    func parseYearAnnounced(value: String){
        // regex to determine if a valid year was included
        if let match = value.firstMatch(of: /^(\d{4})/ ) {
            // the first regex group captures the year, cast it to Int type
            YearAnnounced = Int(match.1)
        }

    }

    // if a release year was provided as part of the launch_status column, record it here
    func parseYearReleased(value: String){
        // regex to determine if a valid year was included
        if let match = value.firstMatch(of: /(\d{4})/ ) {
            // the first regex group captures the year, cast it to Int type
            YearReleased = Int(match.1)
        }
    }

    // if the launch_status column meets the criteria specified in the assignment, record it, otherwise leave it nil
    func parseLaunchStatus(value: String){
        // regex to determine if one the allowable values was provided
        if let match = value.firstMatch(of: /(\d{4}|Discontinued|Cancell?ed)/ ) {
            // first regex group contains the allowed value
            LaunchStatus = String(match.1)
        }
    }
    
    // if body dimensions were provided, parse out the metric ones
    func parseDimensions(value: String){
        // regex to grab the metric version of the screen dimensions
        if let match = value.firstMatch(of: /([\d.]+) x ([\d.]+) x ([\d.]+) mm/ ) {
            // create a new struct to store the body dimensions
            Dimensions = Dimension3()
            // store the height, width, and thickness from the appropriate capture groups of the regex
            Dimensions!.Height = Float(match.1)!
            Dimensions!.Width = Float(match.2)!
            Dimensions!.Thickness = Float(match.3)!
        }
    }

    // if the phone's weight was provided, store the metric version
    func parseWeight(value: String){
        // regex to grab the regex
        if let match = value.firstMatch(of: /([\d.]+) g/ ) {
            self.Weight = Float(match.1)!
        }
    }
    
    // if the value provided for the SIM type meets the criteria, store it
    func parseSIMType(value: String){
        if value != "Yes" && value != "No" {
            self.SIMType = value
        }
    }

    // store the value provided for display_type in the Display struct
    func parseDisplayType(value: String){
        // just put whatever was in the file into this value in the object
        self.Display.Tech = value
    }
    
    // if a valid value for screen size was provided, store it in the Display struct
    func parseDisplaySize(value: String){
        // regex to grab the metric version of screen size
        if let match = value.firstMatch(of: /([\d.]+) cm/ ) {
            // first group of the regex contains the size in metric units
            self.Display.Size = Float(match.1)!
        }
    }

    // if a valid display resolution was provided, store it in the Display struct
    func parseDisplayResolution(value: String){
        // regex to grab the two dimensions of the screen resolution
        if let match = value.firstMatch(of: /([\d]+) x ([\d]+) pixels/ ) {
            // grab the two groups and store them in the appropriate section of the struct
            self.Display.Resolution.Width = Int(match.1)!
            self.Display.Resolution.Height = Int(match.2)!
        }
    }

    // grab whatever was provided for features and store it
    func parseFeatures(value: String){
        self.Features = value
    }
    
    // if platform info was provided, parse out the part specified in the assignment
    func parseOSPlatform(value: String){
        // regex to grab everything before the first comma (or everything if no comma)
        if let match = value.firstMatch(of: /([^,]+),?/ ) {
            self.OSPlatform = String(match.1)
        }
    }

    // Swift version of toString, convert object to String type for printing
    var description: String {
        var desc = ""
        desc += "\(Manufacturer) \(Model)\n"
        desc += "Announced: \((YearAnnounced ?? 0 == 0) ? "Unknown" : String(YearAnnounced!)), "
        desc += "Status: \((YearReleased ?? 0 == 0) ? (LaunchStatus ?? "Unknown") : "Released " + String(YearReleased!))\n"
        desc += "Body: \(Dimensions ?? Dimension3()), \((Weight ?? 0.0) == 0 ? "Unknown" : String(Weight!))g\n"
        desc += "SIM Type: \(SIMType ?? "Unknown")\n"
        desc += "Display\(self.Display)\n"
        desc += "Features/Sensors: \(Features)\n"
        desc += "Platform: \(OSPlatform ?? "Unknown"))"
        return desc
    }


}
