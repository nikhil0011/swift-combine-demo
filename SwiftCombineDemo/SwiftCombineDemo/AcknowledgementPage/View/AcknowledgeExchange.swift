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
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Image(uiImage: UIImage(named: UIImage.App.exchnageCompleted)!)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                Text("Great! now you have \(data.targetCurrentAmount) in your account.").font(.headline).multilineTextAlignment(.center)
                Text("Your Conversion rate was \(data.rate.rounded(toPlaces: 4))").font(.body).multilineTextAlignment(.center)
            }.padding().navigationBarBackButtonHidden()
                .toolbar {
                    Button("Done") {
                    }
                }
        }.navigationBarHidden(true)
    }
}

struct AcknowledgeExchange_Previews: PreviewProvider {
    static var previews: some View {
        AcknowledgeExchange(data: .init())
    }
}
extension UIImage {
    struct App {
        static let exchnageCompleted = "checked"
    }
}
