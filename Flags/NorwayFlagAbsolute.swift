//
//  NorwayFlagAbsolute.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct RedVerticalStripeAbsolute: View {
    var body: some View {
        VStack(spacing: 0) {
            Color("WineRed")
                .frame(height: 60)
            WhiteBlueWhiteHorizontalStripeAbsolute()
            Color("WineRed")
                .frame(height: 60)
        }
    }
}

struct WhiteBlueVerticalStripeAbsolute: View {
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

struct WhiteBlueWhiteHorizontalStripeAbsolute: View {
    var body: some View {
        Color.white
            .frame(height: 10)
        Color("NavyBlue")
            .frame(height: 20)
        Color.white
            .frame(height: 10)
    }
}

struct NorwayFlagAbsolute: View {
    var body: some View {
        HStack(spacing: 0) {
            RedVerticalStripeAbsolute()
                .frame(width: 60)
            WhiteBlueVerticalStripeAbsolute()
            RedVerticalStripeAbsolute()
                .frame(width: 120)
        }
        .frame(width: 220, height: 160)
    }
}

struct NorwayFlagAbsolute_Previews: PreviewProvider {
    static var previews: some View {
        NorwayFlagAbsolute()
    }
}
