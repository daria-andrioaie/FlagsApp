//
//  EmblemPicker.swift
//  Flags
//
//  Created by Daria Andrioaie on 04.08.2022.
//

import SwiftUI

struct EmblemPicker: View {
    private static var gridDimension: CGFloat = 64
    private static var symbolCornerRadius: CGFloat = 8
    private static var symbolSize: CGFloat = 24
    
    private static var secondarySystemBackground: Color {
        let color = UIColor { $0.userInterfaceStyle == .dark ?
                .init(red: 0, green: 0, blue: 0, alpha: 1.0)
            : .init(red: 0.95, green: 0.95, blue: 1, alpha: 1.0)
        }
        return Color(color)
    }
    
    private static var systemBackground: Color {
        let color = UIColor { $0.userInterfaceStyle == .dark ?
                .init(red: 0, green: 0, blue: 0, alpha: 1.0)
            : .init(red: 1, green: 1, blue: 1, alpha: 1.0)
        }
        return Color(color)
    }
    
    private static var systemGray: Color {
        let color = UIColor { $0.userInterfaceStyle == .dark ?
                .init(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.0)
            : .init(red: 0.9, green: 0.9, blue: 0.92, alpha: 1.0)
        }
        return Color(color)
    }
    
    static var SFSymbols: [String] = {
        if let symbolsURL = Bundle.main.url(forResource: "sf-symbols", withExtension: "txt") {
            if let symbolsString = try? String(contentsOf: symbolsURL) {
                let symbolsArray = symbolsString.components(separatedBy: "\n")
                return symbolsArray
            }
        }
        return []
    }()
    
    
    @Binding var selectedSymbol: String
    @State private var searchText = ""
    @Environment(\.presentationMode) private var presentationMode
    
    @ViewBuilder
    private var searchableSymbolGrid: some View {
        VStack {
            TextField("Search a symbol..", text: $searchText)
                .padding(8)
                .padding(.horizontal, 8)
                .background(Self.systemGray)
                .cornerRadius(8)
                .padding(.horizontal, 16.0)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            symbolGrid
                .padding()
        }
    }
    
    private var symbolGrid: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                ForEach(Self.SFSymbols.filter {
                    searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText)
                }, id: \.self) { currentSymbol in
                    Button {
                        selectedSymbol = currentSymbol
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        if selectedSymbol == currentSymbol {
                            Image(systemName: currentSymbol)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Color.accentColor)
                                .cornerRadius(Self.symbolCornerRadius)
                                .foregroundColor(.white)
                        }
                        else {
                            Image(systemName: currentSymbol)
                                .font(.system(size: Self.symbolSize))
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Self.systemBackground)
                                .cornerRadius(Self.symbolCornerRadius)
                                .foregroundColor(.primary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Self.secondarySystemBackground
                searchableSymbolGrid
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct EmblemPicker_Previews: PreviewProvider {
    @State static private var symbol: String = "square.and.arrow.up"
    static var previews: some View {
        EmblemPicker(selectedSymbol: Self.$symbol)
    }
}
