//
//  ControlsView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    var backgroundColor: String
    
    func body(content: Content) -> some View {
        content
            .font(.title.weight(.medium))
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(Color(backgroundColor))
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}

extension View {
    func FlagsButtonStyle(backgroundColor: String) -> some View {
        modifier(ButtonModifier(backgroundColor: backgroundColor))
    }
}

struct FlagsFrameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
    }
}

extension View {
    func FlagsFrameStyle() -> some View {
        modifier(FlagsFrameModifier())
    }
}

struct ControlsView: View {
    @ObservedObject var mainFlagViewModel: FlagViewModel
    @State var currentFlagViewModel: FlagViewModel?
    @State private var currentColor: Color = .white
    
    var body: some View {
        ZStack {
            Color("LightGray")
            VStack(spacing: 20) {
                HStack(spacing: 40) {
                    VStack {
                        Text("Pick color")
                        ColorPicker("Pick color", selection: $currentColor)
                            .labelsHidden()
                            .scaleEffect(CGSize(width: 0.7, height: 0.7))
                            .frame(height: 5)
                    }
                    VStack {
                        Text("Pick emblem")
                        Button {
                            pickEmblem()
                        } label: {
                            Image(systemName: "star.circle")
                                .foregroundColor(.black)
                        }
                    }
                    
                    
                }
                .FlagsFrameStyle()
                
                
                Button("Add Stripe", action: addStripe)
                    .FlagsButtonStyle(backgroundColor: "MermaidBlue")
                    
                VStack {
                    Text("Add subsection")
                        .textCase(.uppercase)
                        .font(.subheadline.weight(.bold))
                        .foregroundColor(Color("MermaidBlue"))
                    HStack(spacing: 70) {
                        Button {
                            addVerticalSubsection()
                        } label: {
                            Image("vertical")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                        Button {
                            addHorizontalSubsection()
                        } label: {
                            Image("horizontal")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                .FlagsFrameStyle()
                
                Button("Commit section", action: commitSection)
                    .FlagsButtonStyle(backgroundColor: "PoisonGreen")
            }
            .frame(maxWidth: .infinity)
            .padding(40)
        }
        
    }
    
    func addStripe() {
        guard let currentFlagViewModel = currentFlagViewModel else {
            mainFlagViewModel.add(flagComponent: AnyView(SimpleStripe(color: currentColor)))
            return
        }
        currentFlagViewModel.add(flagComponent: AnyView(SimpleStripe(color: currentColor)))
    }
    
    func addVerticalSubsection() {
        if mainFlagViewModel.components.isEmpty {
            mainFlagViewModel.type = .vertical
            return
        }
        
        guard let currentFlagViewModel = currentFlagViewModel else {
            currentFlagViewModel = FlagViewModel(components: [], type: .vertical, parent: mainFlagViewModel)
            mainFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: currentFlagViewModel!)))
            return
        }

        let newFlagViewModel = FlagViewModel(components: [], type: .vertical, parent: currentFlagViewModel)
        currentFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: newFlagViewModel)))
        self.currentFlagViewModel = newFlagViewModel
    }
    
    func addHorizontalSubsection() {
        if mainFlagViewModel.components.isEmpty {
            mainFlagViewModel.type = .horizontal
            return
        }
        
        guard let currentFlagViewModel = currentFlagViewModel else {
            currentFlagViewModel = FlagViewModel(components: [], type: .horizontal, parent: mainFlagViewModel)
            mainFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: currentFlagViewModel!)))
            return
        }

        let newFlagViewModel = FlagViewModel(components: [], type: .horizontal, parent: currentFlagViewModel)
        currentFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: newFlagViewModel)))
        self.currentFlagViewModel = newFlagViewModel
    }
    
    func commitSection() {
        //currentFlagViewModel = nil
        guard let currentFlagViewModel = currentFlagViewModel else {
            return
        }
        self.currentFlagViewModel = currentFlagViewModel.parent
    }
    
    func pickEmblem() {
        
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(mainFlagViewModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagView(flagModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical)))], type: .horizontal))
    }
}
