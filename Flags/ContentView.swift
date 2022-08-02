//
//  ContentView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var mainFlagViewModel = FlagViewModel(components: [SimpleStripeComponent(color: .red), SimpleStripeComponent(color: .blue), FlagViewModel(components: [SimpleStripeComponent(color: .orange), SimpleStripeComponent(color: .green)], type: .vertical)], type: .horizontal)

    @StateObject var mainFlagViewModel = FlagViewModel(components: [], type: .vertical)
    
    var body: some View {
        return NavigationView {
            VStack {
                FlagContainerView(mainFlagViewModel: mainFlagViewModel)
                ControlsView(mainFlagViewModel: mainFlagViewModel)
            }
            .toolbar {
                Button("Save Flag", action: saveFlag)
                    .frame(width: 115, height: 40, alignment: .center)
                    .font(.body.weight(.bold))
                    .foregroundColor(Color("MermaidBlue"))
                    .background(Color("LightGray"))
                    .cornerRadius(5)
            }
        }
    }
    
    func saveFlag() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
