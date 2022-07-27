//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

enum FlagType {
    case vertical
    case horizontal
}

protocol FlagComponent {
    associatedtype FlagView: View
    func draw() -> FlagView
}

struct SimpleStripe: FlagComponent, View {
    let color: String
    var body: some View {
        draw()
    }
    
    func draw() -> some View {
        Color(color)
    }
}

struct Flag: FlagComponent, View {
    let type: FlagType
    var components: [FlagComponent]

    var body: some View {
        draw()
    }
    
    func draw() -> some View {
        switch type {
        case .vertical:
            VStack {
                ForEach(components, id: \.self) { component in
                    component.draw()
                }
            }
        case .horizontal:
            HStack {
                ForEach(components, id: \.self) { component in
                    component.draw()
                }
            }
        }
        
    }
}

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
