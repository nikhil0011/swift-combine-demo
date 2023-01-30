//
//  PreConfirmationView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct PreConfirmationView: View {
    @ObservedObject var data: DataSource
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                Text("\(data.baseCurrencyAmount.1) \(data.baseCurrencyAmount.0)").fontWeight(.heavy)
                Text("Precedes")
                Text("\(data.targetCurrentAmount.1) \(data.targetCurrentAmount.0)").fontWeight(.heavy)
            }
            
            NavigationLink(destination: EmptyView()) {
                Button(action: {
                }) {
                    Text("Convert")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }
        }
    }
}

class DataSource: ObservableObject {
    @Published var baseCurrencyAmount: (String, Int) = ("", 0)
    @Published var targetCurrentAmount: (String, Int) = ("", 0)
}
struct PreConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        PreConfirmationView(data: .init())
    }
}
