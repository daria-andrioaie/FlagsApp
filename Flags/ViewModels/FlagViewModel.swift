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

class FlagViewModel: ObservableObject {
//    var components: [AnyView] = [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagView(flagModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical)))]
//    var type: FlagType = .horizontal
    @Published var components: [AnyView]
    var type: FlagType
    
    init(components: [AnyView], type: FlagType) {
        self.components = components
        self.type = type
    }
    
    func add(flagComponent: AnyView) {
        components.append(flagComponent)
    }
}
