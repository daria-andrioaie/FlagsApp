//
//  ContentView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var flagViewModel = FlagViewModel.mocked()
    @StateObject var flagViewModel = FlagViewModel(flagModel: FlagDataModel(flag: Flag(components: [], type: .horizontal)))
    @State private var savedFlag = false
    
    
    var body: some View {
        return NavigationView {
            GeometryReader { geometryProxy in
                VStack {
                    FlagContainerView(flagViewModel: flagViewModel)
                        .id(UUID())
                        .frame(height: geometryProxy.size.height * 1 / 4)
                    ControlsView(flagViewModel: flagViewModel)
                        .frame(height: geometryProxy.size.height * 3 / 4)
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
        .alert("Saved successfuly!", isPresented: $savedFlag) {
            Button("Ok", role: .cancel) { }
        }
    }
    
    func saveFlag() {
        flagViewModel.getView().saveAsImage(width: 250, height: 150) { image in
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
//        let image = flagViewModel.getView().snapshot(width: 250, height: 150)
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//
        savedFlag = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
