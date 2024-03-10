//
//  AddServiceView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct AddServiceView: View {
    @EnvironmentObject var shop: ShopStore
    @State private var name: String = ""
    @State private var price: Int = 0
//    @Binding var isPresenting: Bool
    
    var body: some View {
        HStack {
            VStack {
                TextField("SerVice" , text: $name)
                    .textInputAutocapitalization(.words)
                TextField("Price" , value: $price, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            Button(action: {
                addService()
            }, label: {
                Label("", systemImage: "plus.circle")
            }).disabled(name.isEmpty)
        }
        
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading){
//                Button("Dismiss"){
//                    isPresenting = false
//                }
//            }
//            ToolbarItem(placement: .confirmationAction){
//                Button("Done"){
//                    addService()
//                    isPresenting = false
//                }.disabled(name.isEmpty)
//            }
//        }
    }//body
    
    private func addService(){
        let newSer = Service(name: name, price: price)
        shop.shop.services.append(newSer)
        name = ""
        price = 0
    }
}

#Preview {
    NavigationStack {
        AddServiceView()
            .environmentObject(ShopStore())
    }
}
