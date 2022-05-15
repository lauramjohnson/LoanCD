//
//  ProgressBar.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/15/22.
//

import SwiftUI

struct ProgressBarView: View {
    var value: Double
    var remainingAmount: Double
    var paidAmount: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                    Text(remainingAmount.toCurrency)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width * value, height: geometry.size.height)
                        .opacity(1)
                        .foregroundColor(Color.purple)
                    Text(paidAmount.toCurrency)
                        .font(.caption)
                        .padding(.horizontal)
                }

            }
            .cornerRadius(45)
            
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: 0.3, remainingAmount: 5000, paidAmount: 5000)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
