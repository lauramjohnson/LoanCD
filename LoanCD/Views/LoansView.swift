//
//  ContentView.swift
//  LoanCD
//
//  Created by Laura Johnson on 5/14/22.
//

import SwiftUI
import CoreData

struct LoansView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Loan>
    
    @State var showAddModal: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(loans) { loan in
                    LoanListItemView(name: loan.name ?? "Unknown", amount: loan.totalAmount, date: loan.dueDate ?? Date())
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle("All Loans")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddModal = true
                    }) {
                        Label("Add Item", systemImage: "plus.circle.fill")
                            .font(.title)
                    }
                }
            }
            Text("Select an item")
        }
        .accentColor(Color(.label))
        .sheet(isPresented: $showAddModal, content: {
            AddLoanView(viewModel: AddLoanViewModel())
        })
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
