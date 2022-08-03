//
//  ContentView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var flagViewModel = FlagViewModel(flagModel: FlagDataModel(flag: Flag(components: [], type: .horizontal)))
    
    var body: some View {
        return NavigationView {
            VStack {
                FlagContainerView(flagViewModel: flagViewModel)
                    .id(UUID())
                ControlsView(flagViewModel: flagViewModel)
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
