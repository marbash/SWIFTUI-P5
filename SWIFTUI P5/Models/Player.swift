//
//  Player.swift
//  SWIFTUI P5
//
//  Created by MOHD ALARBASH on 5/11/20.
//  Copyright © 2020 MOHD ALARBASH. All rights reserved.
//

import Foundation

enum Player {
    case x
    case o
    case none
    
    mutating func toggle(){
        switch self{
        case .x: self = .o
        case .o: self = .x
        case .none: self = .none
        }
    }
    func text() -> String
    {
        switch self {
        case .x:
            return "X"
        case .o:
            return "O"
        case .none:
            return ""
        }
    }
}
