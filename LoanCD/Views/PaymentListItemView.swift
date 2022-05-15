//
//  PaymentListItemView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/15/22.
//

import SwiftUI

struct PaymentListItemView: View {
    let amount: Double
    let date: Date
    
    var body: some View {
        
        
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(amount.toCurrency)
                    .font(.title3)
                Text(date.longDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct PaymentListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PaymentListItemView(amount: 253.65, date: Date())
                .previewLayout(.sizeThatFits)
                .padding()
            PaymentListItemView(amount: 253.65, date: Date())
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
