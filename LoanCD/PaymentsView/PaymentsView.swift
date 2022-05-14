//
//  PaymentsView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI

struct PaymentsView: View {
    
    @StateObject var viewModel = PaymentsViewModel()
    
    var body: some View {

        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            Rectangle()
                .frame(height: 32)
                .foregroundColor(.purple)
                .cornerRadius(10)
                .padding()
            
            Text("Expected to finish by ")
            
            List{
                
            }
            .listStyle(.plain)
        }
        .navigationTitle("Loan name")
        .navigationBarItems(trailing: Button {
            
        } label: {
            Image(systemName: "circle.plus.fill")
                .font(.title)
        })
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
