//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct FlagView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color("LightGray"))
            .frame(width: 250, height: 150)
            .padding(30)
    }
    
    func saveFlag() {
        
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView()
    }
}
