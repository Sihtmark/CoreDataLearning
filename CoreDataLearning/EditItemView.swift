//
//  EditItemView.swift
//  CoreDataLearning
//
//  Created by Sergei Poluboiarinov on 05.02.2023.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var item: FetchedResults<Item>.Element
    
    @State private var name = ""
    @State private var price = 0.0
    @State private var pc: Float = 1.1
    
    var body: some View {
        Form {
            Section {
                TextField("\(item.name ?? name)", text: $name)
                    .font(.title)
                    .bold()
                    .onAppear {
                        name = item.name ?? name
                        price = item.price
                        pc = Float(item.pc)
                    }
                VStack {
                    Text("Cost: \(Int(price)) eur")
                    Slider(value: $price, in: 0...100)
                }
                .padding()
                
                VStack {
                    Text("Total: \(Int(pc))pc")
                    Slider(value: $pc, in: 1...15, step: 1.0)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        CoreDataManager().editItem(item: item, name: name, price: price, pc: Int16(pc), context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
