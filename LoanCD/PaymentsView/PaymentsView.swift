//
//  PaymentsView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI

struct PaymentsView: View {
    
    @ObservedObject var viewModel: PaymentsViewModel
    
    var body: some View {

        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ProgressBarView(value: viewModel.progressValue(), remainingAmount: viewModel.toBePaid(), paidAmount: viewModel.totalPaid())
                .frame(height: 20)
                .padding(.horizontal, 8)
            
            Text(viewModel.expectedToFinishOn)
            
            List{
                ForEach(viewModel.allPaymentsObjects, id: \.sectionName) { paymentObject in
                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal.toCurrency)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    ) {
                        ForEach(paymentObject.sectionObjects) { payment in
                            PaymentListItemView(amount: payment.amount, date: payment.date ?? Date())
                                .onTapGesture{
                                    viewModel.isNavigationLinkActive = true
                                    viewModel.selectedPayment = payment
                                }
                        }
                        .onDelete { index in
                            viewModel.deletePayment(paymentObect: paymentObject, index: index)
                        }
                    }
                }

            }
            .listStyle(.plain)
        }
        .navigationTitle(viewModel.loan.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.isNavigationLinkActive = true
                }) {
                    Label("Add Payment", systemImage: "plus.circle.fill")
                        .font(.title)
                }
            }
        }
        .background(
            NavigationLink(destination: AddPaymentView(viewModel: AddPaymentViewModel(loanId: viewModel.loan.id ?? "", paymentToEdit: viewModel.selectedPayment)), isActive: $viewModel.isNavigationLinkActive) {
                EmptyView()
            }
                .hidden()
        )
        .onAppear() {
            viewModel.selectedPayment = nil
            viewModel.fetchAllPayments()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

//struct PaymentsView_Previews: PreviewProvider {
//    static var loanDummy: Loan {
//        var loan = Loan()
//        loan.id = "1"
//        loan.name = "hi there loan"
//        loan.totalAmount = 62555
//        loan.startDate = Date()
//        loan.dueDate = Date()
//
//        return loan
//    }
//
//    static var previews: some View {
//        PaymentsView(viewModel: PaymentsViewModel(loan: loanDummy))
//    }
//}
