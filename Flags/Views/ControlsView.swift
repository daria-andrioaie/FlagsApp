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
    @ObservedObject var flagViewModel: FlagViewModel
    @State private var symbolPickerPresented = false

    var body: some View {
        ZStack {
            Color("LightGray")
            VStack(spacing: 20) {
                HStack(spacing: 40) {
                    VStack {
                        Text("Pick color")
                        ColorPicker("Pick color", selection: $flagViewModel.currentColor)
                            .labelsHidden()
                            .scaleEffect(CGSize(width: 0.7, height: 0.7))
                            .frame(height: 5)
                    }
                    VStack {
                        Text("Pick emblem")
                        Button {
                            symbolPickerPresented = true
                        } label: {
                            Image(systemName: "star.circle")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $symbolPickerPresented) {
                            EmblemPicker(selectedSymbol: $flagViewModel.currentSymbol)
                        }
                    }
                }
                .FlagsFrameStyle()
                
                
                Button("Add Stripe", action: flagViewModel.addStripe)
                    .FlagsButtonStyle(backgroundColor: "MermaidBlue")
                    
                VStack {
                    Text("Add subsection")
                        .textCase(.uppercase)
                        .font(.subheadline.weight(.bold))
                        .foregroundColor(Color("MermaidBlue"))
                    HStack(spacing: 70) {
                        Button {
                            flagViewModel.addVerticalSubsection()
                        } label: {
                            Image("vertical")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                        Button {
                            flagViewModel.addHorizontalSubsection()
                        } label: {
                            Image("horizontal")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                .FlagsFrameStyle()
                
                Button("Commit section", action: flagViewModel.commitSection)
                    .FlagsButtonStyle(backgroundColor: "PoisonGreen")
            }
            .frame(maxWidth: .infinity)
            .padding(40)
        }
        
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(flagViewModel: FlagViewModel(flagModel: FlagDataModel(flag: Flag(components: [], type: .horizontal))))
    }
}
