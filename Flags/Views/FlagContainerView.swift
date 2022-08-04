//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct FlagView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
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
    func getView(flagViewModel: FlagViewModel) -> some View {
        getComponentView(component: flagViewModel.flagDataModel.rootFlag)
    }
    
    var body: some View {
        getView(flagViewModel: flagViewModel)
    }
}

struct FlagContainerView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
    var body: some View {
        FlagView(flagViewModel: flagViewModel)
            .cornerRadius(5)
            .frame(width: 250, height: 150)
            .background(Color("LightGray"))
            .padding(30)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagContainerView(flagViewModel: FlagViewModel.mocked())
    }
}
