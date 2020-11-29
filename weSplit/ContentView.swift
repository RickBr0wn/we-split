//
//  ContentView.swift
//  weSplit
//
//  Created by Rick Brown on 29/11/2020.
//  A Basic one page app to learn about the @State property wrapper
//  and its two-way binding.
//

import SwiftUI

struct ContentView: View {
  @State private var checkoutAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 1
  
  let tipPercentages = [2.5, 5, 7.5, 10, 12.5, 0]
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkoutAmount) ?? 0
    
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkoutAmount)
            .keyboardType(.decimalPad)
          
          Picker("Number Of People", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            } // ForEach
          } // Picker
        } // Section
        
        Section(header: Text("How much tip would you like to leave?")) {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0], specifier: "%.1f")%")
            } // ForEach
          } // Picker
          .pickerStyle(SegmentedPickerStyle())
        } // Section
        
        Section(header: Text("Amount owed, per person")) {
          Text("£\(totalPerPerson, specifier: "%.2f")")
        } // Section
      } // Form
      .navigationBarTitle("weSplit")
    } // NavigationView
  } // Body
  
} // ContentView

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
