//
//  Picker.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI


struct CustomPicker: View {
    @State private var year = 2020
    @State private var isShowingPicker = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isShowingPicker.toggle()
            }) {
                Text("Year: \(self.year)")
                    .padding()
            }
            
            NumberPicker(selection: self.$year, isShowing: self.$isShowingPicker)
                .animation(.linear)
                .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
        }
    }
}

struct NumberPicker: View {
    @Binding var selection: Int
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.isShowing = false
            }) {
                HStack {
                    Spacer()
                    Text("Close")
                        .padding(.horizontal, 16)
                }
            }
            
            Picker(selection: $selection, label: Text("")) {
                ForEach((1900..<2100), id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
            .frame(width: 200)
            .labelsHidden()
            .pickerStyle(.wheel)
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker()
    }
}
