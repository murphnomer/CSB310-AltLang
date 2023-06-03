//
//  Cell.swift
//  Cell
//
//  Created by Mike Murphy on 6/2/23.
//

import Foundation

class Cell {
    struct Dimension2 {
        var Width : Float = 0.0
        var Height : Float = 0.0
    }
    
    struct Dimension3 {
        var Width : Float = 0.0
        var Height : Float = 0.0
        var Thickness : Float = 0.0
    }
    
    struct Display {
        var Tech : String = ""
        var Size : Int = 0
        var Resolution : Dimension2
    }
    
    var Manufacturer : String = ""
    var Model : String = ""
    var DateAnnounced : Int = 0
    var DateReleased : String = ""
    var LaunchStatus : String = ""
    var Dimensions : Dimension3
    var Weight : Float = 0.0
    var SIMType : String = ""
    var DisplayType : String = ""
    var DisplaySize : Dimension2
    var DisplayResolution : String = ""
    var Features : String = ""
    var OSPlatform : String = ""
 
    init() {
        
    }
}
