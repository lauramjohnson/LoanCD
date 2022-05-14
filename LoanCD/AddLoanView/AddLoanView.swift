//
//  AddLoanView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI

struct AddLoanView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: AddLoanViewModel
        
    var body: some View {
        VStack {
            HStack {
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 32)
                }
                
                Spacer()
                
                Button{
                    viewModel.saveLoan()
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 80, height: 32)
                }
                .disabled(viewModel.isValidForm())
            }
            .padding()
            
            Form {
                TextField("Name", text: $viewModel.name)
                    .autocapitalization(.sentences)
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: .date)
            }
        }
    }
}

struct AddLoanView_Previews: PreviewProvider {
    static var viewModel: AddLoanViewModel {
        let viewModel = AddLoanViewModel()
        viewModel.name = "Test loan"
        viewModel.amount = "25000"
        viewModel.startDate = Date()
        viewModel.dueDate = Date()
        
        return viewModel
    }
    
    static var viewModelEmpty: AddLoanViewModel {
        let viewModel = AddLoanViewModel()
        
        return viewModel
    }
    
    static var previews: some View {
        Group {
            AddLoanView(viewModel: viewModelEmpty)

            AddLoanView(viewModel: viewModel)
        }
    }
}
