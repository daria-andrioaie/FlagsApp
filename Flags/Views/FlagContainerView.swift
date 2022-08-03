//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

struct FlagView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
    var body: some View {
        return flagViewModel.getView()
    }
}

struct FlagContainerView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
    var body: some View {
        FlagView(flagViewModel: flagViewModel)
            .cornerRadius(5)
            .frame(width: 250, height: 150)
            .background(Color("LightGray"))
            .padding(30)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
    }
}
