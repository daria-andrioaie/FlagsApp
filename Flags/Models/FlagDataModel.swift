//
//  FlagModel.swift
//  Flags
//
//  Created by Daria Andrioaie on 02.08.2022.
//

import Foundation
import SwiftUI

enum FlagOrientation {
    case vertical
    case horizontal
}

protocol Component {
}

protocol Stripe: Component {
    var color: Color { get }
    var parent: Flag { get set }
}

struct SimpleStripe: Stripe {
    let color: Color
    var parent: Flag
    
    init(color: Color, parent:  Flag) {
        self.color = color
        self.parent = parent
    }
}

struct StripeWithEmblem: Stripe {
    let color: Color
    let emblem: String
    var parent: Flag
    
    init(color: Color, emblem: String, parent: Flag) {
        self.color = color
        self.emblem = emblem
        self.parent = parent
    }
}

class Flag: Component {
    var components: [Component]
    var orientation: FlagOrientation
    var parent: Flag?
    
    init(components: [Component], type: FlagOrientation) {
        self.components = components
        self.orientation = type
    }
    
    init(components: [Component], type: FlagOrientation, parent: Flag) {
        self.components = components
        self.orientation = type
        self.parent = parent
    }
    
    func addComponent(_ component: Component){
        components.append(component)
    }
}

struct FlagDataModel {
    var rootFlag: Flag
//    var currentFlag: Flag?
    var currentFlag: Flag
    
    init(flag: Flag) {
        self.rootFlag = flag
        self.currentFlag = flag
    }

    func addComponentToRoot(_ flagComponent: Component) {
        rootFlag.addComponent(flagComponent)
    }
    
    func isEmpty() -> Bool {
        return rootFlag.components.isEmpty
    }
    
    func setOrientation(_ orientation: FlagOrientation) {
        rootFlag.orientation = orientation
    }
}
