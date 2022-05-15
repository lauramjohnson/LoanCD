//
//  PaymentsViewModel.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI

final class PaymentsViewModel: ObservableObject {
    @Published var allPayments:[Payment] = []
    @Published var allPaymentsObjects: [PaymentObject] = []
    @Published var isNavigationLinkActive: Bool = false
    @Published var expectedToFinishOn = ""
    @Published var selectedPayment: Payment?
    
    var loan: Loan
    
    init(loan: Loan) {
        self.loan = loan
    }
    
    func totalPaid() -> Double {
        return allPayments.reduce(0) {
            $0 + $1.amount
        }
    }
    
    func toBePaid() -> Double {
        return loan.totalAmount - totalPaid()
    }
    
    func progressValue() -> Double {
        return totalPaid() / loan.totalAmount
    }
    
    func fetchAllPayments() {
        allPayments = PersistenceController.shared.fetchPayments(for: loan.id ?? "")
    }
    
    func deletePayment(paymentObect: PaymentObject, index: IndexSet) {
        guard let indexRow = index.first else { return }
        let paymentToDelete = paymentObect.sectionObjects[indexRow]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        fetchAllPayments()
        calculateDays()
        separateByYear()
    }
    
    func calculateDays() {
        let totalPaid = totalPaid()
        
        let totalDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: loan.dueDate ?? Date()).day!
        let passedDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: Date()).day!
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        
        let averagePaidPerDay = totalPaid / Double(passedDays)
        
        let daysLeftToFinish = (Double(totalDays - passedDays)) / averagePaidPerDay
        let estimatedFinishDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        
        guard let estimatedFinishDate = estimatedFinishDate else {
            expectedToFinishOn = ""
            return
        }
        
        expectedToFinishOn = "Expected to finish by \(estimatedFinishDate.longDate)"
    }
    
    func separateByYear() {
        allPaymentsObjects = []
        let dict = Dictionary(grouping: allPayments, by: {
            $0.date?.dayNumberOfYear
        })
        
        for (key, value) in dict {
            var total = 0.00
            
            for payment in value {
                total += payment.amount
            }
            
            allPaymentsObjects.append(PaymentObject(sectionName: "\(key!)", sectionObjects: value, sectionTotal: total))
        }
        
        sortPaymentObjects()
    }
    
    func sortPaymentObjects() {
        allPaymentsObjects.sorted(by: {$0.sectionName > $1.sectionName})
    }
}

struct PaymentObject: Equatable {
    var sectionName: String!
    var sectionObjects: [Payment]!
    var sectionTotal: Double!
}
