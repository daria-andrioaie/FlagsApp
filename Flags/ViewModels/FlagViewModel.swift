//
//  FlagViewModel.swift
//  Flags
//
//  Created by Daria Andrioaie on 27.07.2022.
//

import Foundation
import SwiftUI

enum FlagType {
    case vertical
    case horizontal
}

protocol Component {
    
}

class SimpleStripeComponent: Component {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
}

class FlagViewModel: Component, ObservableObject {
//    var components: [AnyView] = [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagView(flagModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical)))]
//    var type: FlagType = .horizontal
    @Published var components: [Component]
    var type: FlagType
    var parent: FlagViewModel?
    
    init(components: [Component], type: FlagType) {
        self.components = components
        self.type = type
    }
    
    init(components: [Component], type: FlagType, parent: FlagViewModel) {
        self.components = components
        self.type = type
        self.parent = parent
    }
    
    func add(flagComponent: Component) {
        components.append(flagComponent)
    }
    
    func deepCopy() -> FlagViewModel {
        let copy = FlagViewModel(components: [], type: type)
        for component in components {
            if component is SimpleStripeComponent {
                copy.components.append(component)
            }
            else {
                let flagComponent = component as! FlagViewModel
                copy.components.append(flagComponent.deepCopy())
            }
        }
        return copy
    }
}
