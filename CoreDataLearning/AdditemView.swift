//
//  AdditemView.swift
//  CoreDataLearning
//
//  Created by Sergei Poluboiarinov on 05.02.2023.
//

import SwiftUI

struct AdditemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var price = 0.0
    @State private var pc: Float = 1.1
    
    var body: some View {
        Form {
            Section {
                TextField("new item", text: $name)
                    .font(.title)
                    .bold()
                
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
                        CoreDataManager().addItem(name: name, price: price, pc: Int16(pc), context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AdditemView_Previews: PreviewProvider {
    static var previews: some View {
        AdditemView()
    }
}
