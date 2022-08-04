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
