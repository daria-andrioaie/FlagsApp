//
//  FlagView.swift
//  Flags
//
//  Created by Daria Andrioaie on 26.07.2022.
//

import SwiftUI

//enum FlagType {
//    case vertical
//    case horizontal
//}
//
//protocol FlagComponent {
//    //associatedtype FlagView: View
//    //func draw() -> FlagView
//
//    func draw()
//}
//
//struct SimpleStripe: FlagComponent, View {
//    let color: String
//    var body: some View {
//
//    }
//
//    func draw() {
//        print(color)
//    }
//
////    func draw() -> some View {
////        Color(color)
////    }
//}
//
//struct Flag: FlagComponent, View {
//    let type: FlagType
//    var components: [FlagComponent]
//
//    var body: some View {
//        Button("Draw flag") {
//            draw()
//        }
//    }
//
////    func draw() -> some View {
////        switch type {
////        case .vertical:
////            VStack {
////                ForEach(components, id: \.self) { component in
////                    component.draw()
////                }
////            }
////        case .horizontal:
////            HStack {
////                ForEach(components, id: \.self) { component in
////                    component.draw()
////                }
////            }
////        }
////    }
//
//    func draw() {
//        for component in components {
//            component.draw()
//        }
//    }
//}


protocol FlagComponent: View {
}

struct SimpleStripe: FlagComponent {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        color
    }
}

enum FlagType {
    case vertical
    case horizontal
}

struct FlagModel: FlagComponent {
    
//    var components: [AnyView] = [AnyView(Text("Hi1")), AnyView(Text("Bye1")), AnyView(FlagModel(components: [AnyView(Text("Hi2")), AnyView(Text("Bye2"))], type: .vertical))]
    var components: [AnyView] = [AnyView(SimpleStripe(color: .red)), AnyView(SimpleStripe(color: .blue)), AnyView(FlagModel(components: [AnyView(SimpleStripe(color: .yellow)), AnyView(SimpleStripe(color: .green))], type: .vertical))]
    var type: FlagType = .horizontal
    
    mutating func add(flagComponent: AnyView) {
        components.append(flagComponent)
    }
    
    var body: some View {
        switch type {
        case .vertical:
            VStack(spacing: 0) {
                ForEach(0..<components.count, id: \.self) { index in
                    components[index]
                }
//                ForEach(components, id: \.self) { component in
//                    component
//                }
            }
        case .horizontal:
            HStack(spacing: 0) {
//                ForEach(components, id: \.self) { component in
//                    component
//                }
                ForEach(0..<components.count, id: \.self) { index in
                    components[index]
                }
            }
        }
            
    }
}


struct FlagContainerView: View {
    @ObservedObject var flagViewModel: FlagViewModel
    
    var body: some View {
//        RoundedRectangle(cornerRadius: 3)
//            .fill(Color("LightGray"))
//            .frame(width: 250, height: 150)
//            .padding(30)
        FlagModel()
            .frame(width: 250, height: 150)
            .padding(30)
    }
    
    func saveFlag() {
        
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagContainerView(flagViewModel: FlagViewModel())
    }
}
