//
//  PreConfirmationView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct PreConfirmationView: View {
    @State var timerCounter = 30
    @ObservedObject var data: DataSource
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                Text("\(data.baseCurrencyAmount)").font(.largeTitle)
                Text("Precedes")
                Text("\(data.targetCurrentAmount)").font(.largeTitle)
            }
            NavigationLink(destination: AcknowledgeExchange(data: data)) {
                if timerCounter > 0 {
                    Text("Convert")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }
            TimerView(seconds: $timerCounter)
        }
    }
}

class DataSource: ObservableObject {
    @Published var baseCurrencyAmount: String = ""
    @Published var targetCurrentAmount: String = ""
    @Published var rate: Double = 0.0
}
struct PreConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        PreConfirmationView(data: .init())
    }
}
struct TimerView: View {
    @Binding var seconds: Int
    
    var body: some View {
        VStack {
            Text("\(seconds) seconds left")
                .font(.headline)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.seconds > 0 {
                    self.seconds -= 1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}
