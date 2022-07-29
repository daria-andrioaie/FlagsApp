//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct SimpleStripe: View {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        color
    }
}

struct FlagView: View {
    @ObservedObject var flagModel: FlagViewModel
    
    var body: some View {
        switch flagModel.type {
        case .vertical:
            VStack(spacing: 0) {
                ForEach(0..<flagModel.components.count, id: \.self) { index in
                    flagModel.components[index]
                }
            }
        case .horizontal:
            HStack(spacing: 0) {
                ForEach(0..<flagModel.components.count, id: \.self) { index in
                    flagModel.components[index]
                }
            }
        }
            
    }
}


struct FlagContainerView: View {
    @ObservedObject var mainFlagViewModel: FlagViewModel
    
    var body: some View {
        FlagView(flagModel: mainFlagViewModel)
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
        FlagContainerView(mainFlagViewModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagView(flagModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical)))], type: .horizontal))
    }
}
