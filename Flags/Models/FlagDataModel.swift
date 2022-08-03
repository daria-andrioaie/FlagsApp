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

struct SimpleStripeComponent: Component {
    let color: Color
    
    init(color: Color) {
        self.color = color
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
    var currentFlag: Flag?
    
    init(flag: Flag) {
        self.rootFlag = flag
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
