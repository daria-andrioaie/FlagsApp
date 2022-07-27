//
//  FinlandView.swift
//  Flags
//
//  Created by Daria Andrioaie on 25.07.2022.
//

import SwiftUI

struct FinlandView: View {
    var body: some View {
        ZStack {
            Color.gray
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Color.white
                    Color("NavyBlue")
                        .frame(height: 55)
                    Color.white
                }
                .frame(width: 80)
                Color("NavyBlue")
                    .frame(width: 55)
                VStack(spacing: 0) {
                    Color.white
                    Color("NavyBlue")
                        .frame(height: 55)
                    Color.white
                }
            }
            .frame(width: 300, height: 180, alignment: .center)
        }
    }
}

struct FinlandView_Previews: PreviewProvider {
    static var previews: some View {
        FinlandView()
    }
}
