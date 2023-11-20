//
//  ContentView.swift
//  TipCalculatorSwiftUI
//
//  Created by Mac on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
        
    var totalAmount: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let totalAmount = checkAmount + tipValue
        
        return totalAmount
    }
    
    var totalPerPerson: Double {

        let tipPerPerson = totalAmount / Double(numberOfPeople + 2)

        return tipPerPerson
    }
    var body: some View {
        //Finished all
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentages", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
