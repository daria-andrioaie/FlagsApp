//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct ComponentView: View {
    let component: Component
    var body: some View {
        if component is SimpleStripeComponent {
            let stripeComponent = component as! SimpleStripeComponent
            return AnyView(stripeComponent.color)
        }
        else if component is FlagViewModel {
//        else {
            let flag = component as! FlagViewModel
            switch flag.type {
            case .vertical:
                return AnyView(HStack(spacing: 0) {
                    ForEach(0..<flag.components.count, id: \.self) { index in
                        ComponentView(component: flag.components[index])
                    }
                })
            case .horizontal:
                return AnyView(VStack(spacing: 0) {
                    ForEach(0..<flag.components.count, id: \.self) { index in
                        ComponentView(component: flag.components[index])
                    }
                })
            }
        }
        else {
            return AnyView(Color.red)
        }
    }
}

struct FlagView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
    var body: some View {
        print("In the flag view: \(flagViewModel.components)")
        return ComponentView(component: flagViewModel)
    }
}

struct FlagContainerView: View {
    @ObservedObject var mainFlagViewModel: FlagViewModel
    
    var body: some View {
        FlagView(flagViewModel: mainFlagViewModel)
            .cornerRadius(5)
            .frame(width: 250, height: 150)
            .background(Color("LightGray"))
            .padding(30)
    }
    
    func saveFlag() {
        
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagContainerView(mainFlagViewModel: FlagViewModel(components: [SimpleStripeComponent(color: .red), SimpleStripeComponent(color: .blue), FlagViewModel(components: [SimpleStripeComponent(color: .yellow), SimpleStripeComponent(color: .green), FlagViewModel(components: [SimpleStripeComponent(color: .orange), SimpleStripeComponent(color: .pink)], type: .horizontal)], type: .vertical)], type: .horizontal))
    }
}
