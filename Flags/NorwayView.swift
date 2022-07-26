//
//  NorwayView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct RedWhiteBlueVerticalStripe: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6) { _ in
                Color("WineRed")
            }
            Color.white
            ForEach(0..<2) { _ in
                Color("NavyBlue")
            }
            Color.white
            ForEach(0..<6) { _ in
                Color("WineRed")
            }
        }
    }
}

struct WhiteBlueWhiteVerticalStripe: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<7) { _ in
                Color.white
            }
            ForEach(0..<2) { _ in
                Color("NavyBlue")
            }
            ForEach(0..<7) { _ in
                Color.white
            }
        }
    }
}

struct BlueVerticalStripe: View {
    var body: some View {
        Color("NavyBlue")
    }
}

struct NorwayView: View {
    var paddingValue = 20.0
    var aspectRatio: Double = 11/8
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { _ in
                RedWhiteBlueVerticalStripe()
            }
            WhiteBlueWhiteVerticalStripe()
            ForEach(0..<2) { _ in
                BlueVerticalStripe()
            }
            WhiteBlueWhiteVerticalStripe()
            ForEach(0..<12) { _ in
                RedWhiteBlueVerticalStripe()
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .padding(paddingValue)
    }
}

struct NorwayView_Previews: PreviewProvider {
    static var previews: some View {
        NorwayView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
