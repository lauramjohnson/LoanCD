//
//  LoanListItem.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI

struct LoanListItemView: View {
    let name: String
    let amount: Double
    let date: Date
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(amount.toCurrency)
                    .font(.title2)
                    .fontWeight(.light)

            }
            
            Spacer()
            
            Text(date.longDate)
                .font(.subheadline)
                .fontWeight(.light)
        }
    }
}

struct LoanListItem_Previews: PreviewProvider {

    static var previews: some View {
        LoanListItemView(name: "Test Name", amount: 25000, date: Date())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
