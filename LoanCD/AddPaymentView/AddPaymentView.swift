//
//  AddPaymentView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/15/22.
//

import SwiftUI

struct AddPaymentView: View {
    @ObservedObject var viewModel: AddPaymentViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }
            
            Section {
                Button {
                    viewModel.savePayment()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .disabled(!viewModel.isFormValid())
        }
        .onAppear() {
            viewModel.setupEditingView()
        }
        .navigationTitle(viewModel.payment != nil ? "Edit Payment" : "Add Payment")
    }
}

//struct AddPaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPaymentView()
//    }
//}
