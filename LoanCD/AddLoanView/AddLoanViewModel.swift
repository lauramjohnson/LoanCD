//
//  AddLoanViewModel.swift
//  LoanCD


import SwiftUI

final class AddLoanViewModel: ObservableObject {
    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    func isValidForm() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
    
    func saveLoan() {
        let newLoan = Loan(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = name
        newLoan.totalAmount = Double(amount) ?? 0.0
        newLoan.startDate = startDate
        newLoan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
}
