//
//  NorwayView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct RedVerticalStripe: View {
    var body: some View {
        VStack(spacing: 0) {
            Color("WineRed")
                .frame(height: 60)
            WhiteBlueWhiteHorizontalStripe()
            Color("WineRed")
                .frame(height: 60)
        }
    }
}

struct WhiteBlueVerticalStripe: View {
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0) {
                Color.white
                    .frame(width: 10)
                Color("NavyBlue")
                    .frame(width: 20)
                Color.white
                    .frame(width: 10)
            }
            Color("NavyBlue")
                .frame(height: 20)
            HStack(spacing: 0) {
                Color.white
                    .frame(width: 10)
                Color("NavyBlue")
                    .frame(width: 20)
                Color.white
                    .frame(width: 10)
            }
        }
            
    }
}

struct WhiteBlueWhiteHorizontalStripe: View {
    var body: some View {
        Color.white
            .frame(height: 10)
        Color("NavyBlue")
            .frame(height: 20)
        Color.white
            .frame(height: 10)
    }
}

struct NorwayView: View {
    var body: some View {
        HStack(spacing: 0) {
            RedVerticalStripe()
                .frame(width: 60)
            WhiteBlueVerticalStripe()
            RedVerticalStripe()
                .frame(width: 120)
        }
        .frame(width: 220, height: 160)
    }
}

struct NorwayView_Previews: PreviewProvider {
    static var previews: some View {
        NorwayView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
