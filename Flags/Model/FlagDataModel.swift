//
//  Flag.swift
//  Flags
//
//  Created by Daria Andrioaie on 27.07.2022.
//

import Foundation
import SwiftUI

//protocol FlagComponent {
//    associatedtype FlagView: View
//    func draw() -> FlagView
//}
//
//struct SimpleStripe: FlagComponent {
//    typealias FlagView = Color
//    let color: String
//
//    func draw() -> Color {
//        Color(color)
//    }
//}
//
//struct Flag: FlagComponent {
//    var flagComponents: [FlagComponent] = []
//    func draw() -> some View {
//        ForEach(flagComponents, id: \.self) { component in
//            component.draw()
//        }
//    }
//}

protocol FlagComponent {
}

class SimpleStripe: FlagComponent {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
}

enum FlagType {
    case vertical
    case horizontal
}

class FlagModel: FlagComponent {
    var components: [FlagComponent] = []
    let type: FlagType = .horizontal
    
    func add(flagComponent: FlagComponent) {
        components.append(flagComponent)
    }
    
    
}

