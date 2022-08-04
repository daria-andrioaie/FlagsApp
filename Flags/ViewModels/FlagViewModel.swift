//
//  FlagViewModel.swift
//  Flags
//
//  Created by Daria Andrioaie on 27.07.2022.
//

import Foundation
import SwiftUI


class FlagViewModel: ObservableObject {
    @Published var flagDataModel: FlagDataModel
    @Published var currentColor: Color = .white
    @Published var currentSymbol: String = ""
    
    init(flagModel: FlagDataModel) {
        self.flagDataModel = flagModel
    }
    
    @ViewBuilder
    func getComponentView(component: Component) -> some View {
        if let stripeComponent = component as? SimpleStripe {
            AnyView(stripeComponent.color)
        }
        else if let stripeWithEmblemComponent = component as? StripeWithEmblem {
            AnyView(ZStack {
                AnyView(stripeWithEmblemComponent.color)
                AnyView(Image(systemName: stripeWithEmblemComponent.emblem))
            })
        }
        else if let flag = component as? Flag {
            switch flag.orientation {
            case .vertical:
                AnyView(HStack(spacing: 0) {
                    ForEach(0..<flag.components.count, id: \.self) { index in
                        self.getComponentView(component: flag.components[index])
                    }
                })
            case .horizontal:
                AnyView(VStack(spacing: 0) {
                    ForEach(0..<flag.components.count, id: \.self) { index in
                        self.getComponentView(component: flag.components[index])
                    }
                })
            }
        }
    }
    
    @ViewBuilder
    func getView() -> some View {
        getComponentView(component: flagDataModel.rootFlag)
    }
    
    func addStripe() {
        let newStripe: Component
        if currentSymbol != "" {
            newStripe = StripeWithEmblem(color: currentColor, emblem: currentSymbol)
            currentSymbol = ""
        }
        else {
            newStripe = SimpleStripe(color: currentColor)
        }
        
        guard let currentFlag = flagDataModel.currentFlag else {
            flagDataModel.addComponentToRoot(newStripe)
            objectWillChange.send()
            return
        }
        currentFlag.addComponent(newStripe)
        objectWillChange.send()
    }
    
    func addVerticalSubsection() {
        if flagDataModel.isEmpty() {
            flagDataModel.setOrientation(.vertical)
            return
        }
        
        guard let currentFlag = flagDataModel.currentFlag else {
            flagDataModel.currentFlag = Flag(components: [], type: .vertical, parent: flagDataModel.rootFlag)
            flagDataModel.addComponentToRoot(flagDataModel.currentFlag!)
            return
        }

        let newFlag = Flag(components: [], type: .vertical, parent: currentFlag)
        currentFlag.addComponent(newFlag)
        flagDataModel.currentFlag = newFlag
    }
    
    func addHorizontalSubsection() {
        if flagDataModel.isEmpty() {
            flagDataModel.setOrientation(.vertical)
            return
        }
        
        guard let currentFlag = flagDataModel.currentFlag else {
            flagDataModel.currentFlag = Flag(components: [], type: .horizontal, parent: flagDataModel.rootFlag)
            flagDataModel.addComponentToRoot(flagDataModel.currentFlag!)
            return
        }

        let newFlag = Flag(components: [], type: .horizontal, parent: currentFlag)
        currentFlag.addComponent(newFlag)
        flagDataModel.currentFlag = newFlag
    }
    
    func commitSection() {
        guard let currentFlag = flagDataModel.currentFlag else {
            return
        }
        guard let upperParent = currentFlag.parent else {
            return
        }
        flagDataModel.currentFlag = upperParent
    }
    
    static func mocked() -> FlagViewModel {
        return FlagViewModel(flagModel: FlagDataModel(flag: Flag(components: [SimpleStripe(color: .blue), StripeWithEmblem(color: .yellow, emblem: "scribble"), SimpleStripe(color: .blue)], type: .horizontal)))
    }
}
