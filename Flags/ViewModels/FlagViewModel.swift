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
            AnyView(stripeComponent.color.addOpacityToStripe(stripe: stripeComponent, currentFlag: flagDataModel.currentFlag))
        }
        else if let stripeWithEmblemComponent = component as? StripeWithEmblem {
            AnyView(ZStack {
                AnyView(stripeWithEmblemComponent.color.addOpacityToStripe(stripe: stripeWithEmblemComponent, currentFlag: flagDataModel.currentFlag))
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
            newStripe = StripeWithEmblem(color: currentColor, emblem: currentSymbol, parent: flagDataModel.currentFlag)
            currentSymbol = ""
        }
        else {
            newStripe = SimpleStripe(color: currentColor, parent: flagDataModel.currentFlag)
        }
        
        flagDataModel.currentFlag.addComponent(newStripe)
        objectWillChange.send()
    }
    
    func addVerticalSubsection() {
        if flagDataModel.isEmpty() {
            flagDataModel.setOrientation(.vertical)
            return
        }
        
        let newFlag = Flag(components: [], type: .vertical, parent: flagDataModel.currentFlag)
        flagDataModel.currentFlag.addComponent(newFlag)
        flagDataModel.currentFlag = newFlag
    }
    
    func addHorizontalSubsection() {
        if flagDataModel.isEmpty() {
            flagDataModel.setOrientation(.vertical)
            return
        }
        
        let newFlag = Flag(components: [], type: .horizontal, parent: flagDataModel.currentFlag)
        flagDataModel.currentFlag.addComponent(newFlag)
        flagDataModel.currentFlag = newFlag
    }
    
    func commitSection() {
        guard let upperParent = flagDataModel.currentFlag.parent else {
            return
        }
        flagDataModel.currentFlag = upperParent
    }
    
    static func mocked() -> FlagViewModel {
        let flag = Flag(components: [], type: .horizontal)
        flag.components.append(SimpleStripe(color: .blue, parent: flag))
        flag.components.append(StripeWithEmblem(color: .yellow, emblem: "scribble", parent: flag))
        flag.components.append(SimpleStripe(color: .red, parent: flag))
        
        return FlagViewModel(flagModel: FlagDataModel(flag: flag))
    }
}
