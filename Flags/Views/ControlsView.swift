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
            print("Added a stripe in the main flag")
            print("\(mainFlagViewModel.components)")
            return
        }
        currentFlagViewModel.add(flagComponent: AnyView(SimpleStripe(color: currentColor)))
        print("Added a stripe in the flag \(currentFlagViewModel)")
        print("\(currentFlagViewModel.components)")
    }
    
    func addVerticalSubsection() {
        guard var currentFlagViewModel = currentFlagViewModel else {
            currentFlagViewModel = FlagViewModel(components: [], type: .vertical)
            mainFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: currentFlagViewModel!)))
            print("Added a vertical section in the main flag")
            return
        }

        var newFlagViewModel = FlagViewModel(components: [], type: .vertical)
        currentFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: newFlagViewModel)))
        currentFlagViewModel = newFlagViewModel
        print("Added a vertical section in the inner-most flag")
    }
    
    func addHorizontalSubsection() {
        guard var currentFlagViewModel = currentFlagViewModel else {
            currentFlagViewModel = FlagViewModel(components: [], type: .horizontal)
            mainFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: currentFlagViewModel!)))
            print("Added a horizontal section in the main flag")
            return
        }

        var newFlagViewModel = FlagViewModel(components: [], type: .horizontal)
        currentFlagViewModel.add(flagComponent: AnyView(FlagView(flagModel: newFlagViewModel)))
        currentFlagViewModel = newFlagViewModel
        print("Added a horizontal section in the inner-most flag")
    }
    
    func commitSection() {
        currentFlagViewModel = nil
    }
    
    func pickEmblem() {
        
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(mainFlagViewModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagView(flagModel: FlagViewModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical)))], type: .horizontal))
    }
}
