//
//  ContentView.swift
//  CoreDataLearning
//
//  Created by Sergei Poluboiarinov on 05.02.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)])
    var items: FetchedResults<Item>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Total: \(totalPrice()) eur")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: EditItemView(item: item)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name!)
                                        .font(.title2)
                                        .bold()
                                    Text("\(item.pc) pc")
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                HStack(alignment: .bottom) {
                                    Text("Price for \(Int(item.pc)) pc: \(Int(item.price) * Int(item.pc)) eur")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                        
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Shop")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AdditemView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func totalPrice() -> Int {
        var sum = 0.0
        for i in items {
            sum += i.price * Double(i.pc)
        }
        return Int(sum)
    }
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map{items[$0]}.forEach(managedObjectContext.delete)
            CoreDataManager().save(context: managedObjectContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
