//
//  AcknowledgeExchange.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct AcknowledgeExchange: View {
    @ObservedObject var data: DataSource
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Great! now you have \(data.targetCurrentAmount) in your account.").font(.headline).multilineTextAlignment(.center)
            Text("Your Conversion rate was \(data.rate.rounded(toPlaces: 4))").font(.body).multilineTextAlignment(.center)
        }.padding()
    }
}

struct AcknowledgeExchange_Previews: PreviewProvider {
    static var previews: some View {
        AcknowledgeExchange(data: .init())
    }
}
