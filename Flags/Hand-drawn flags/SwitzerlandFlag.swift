//
//  SwitzerlandFlag.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct FullRedVerticalStripe: View {
    var body: some View {
        Color("SwissRed")
    }
}

struct RedWhiteRedVerticalStripe: View {
    var numberOfWhiteUnits: Int
    var numberOfRedUnits: Int
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numberOfRedUnits, id: \.self) { _ in
                Color("SwissRed")
            }
            ForEach(0..<numberOfWhiteUnits, id: \.self) { _ in
                Color.white
            }
            ForEach(0..<numberOfRedUnits, id: \.self) { _ in
                Color("SwissRed")
            }
        }
    }
}

struct SwitzerlandFlag: View {
    var paddingValue = 20.0
    var aspectRatio: Double = 1
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { _ in
                FullRedVerticalStripe()
            }
            ForEach(0..<7) { _ in
                RedWhiteRedVerticalStripe(numberOfWhiteUnits: 6, numberOfRedUnits: 13)
            }
            ForEach(0..<6) { _ in
                RedWhiteRedVerticalStripe(numberOfWhiteUnits: 20, numberOfRedUnits: 6)
            }
            ForEach(0..<7) { _ in
                RedWhiteRedVerticalStripe(numberOfWhiteUnits: 6, numberOfRedUnits: 13)
            }
            ForEach(0..<6) { _ in
                FullRedVerticalStripe()
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .padding(paddingValue)
    }
}

struct SwitzerlandFlag_Previews: PreviewProvider {
    static var previews: some View {
        SwitzerlandFlag()
    }
}
