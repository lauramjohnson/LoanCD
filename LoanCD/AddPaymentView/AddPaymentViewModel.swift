//
//  AddPaymentViewModel.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/15/22.
//

import SwiftUI

final class AddPaymentViewModel: ObservableObject {
    @Published var amount = ""
    @Published var date = Date()
    @Published var payment: Payment?
    
    var loanId: String
    
    init(loanId: String, paymentToEdit payment: Payment?) {
        self.loanId = loanId
        self.payment = payment
        
    }
    
    func isFormValid() -> Bool {
        return !amount.isEmpty
    }
    
    func savePayment() {
        if payment != nil {
            updatePayment()
        } else {
            saveNewPayment()
        }
    }
    
    func saveNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanId = loanId
        
        PersistenceController.shared.save()
    }
    
    func updatePayment() {
        payment!.amount = Double(amount) ?? 0.0
        payment!.date = date
        
        PersistenceController.shared.save()

    }
    
    func setupEditingView() {
        if payment != nil {
            amount = "\(payment!.amount)"
            date = payment!.date ?? Date()
        }
    }
}
