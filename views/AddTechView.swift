//
//  AddTechView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI
struct AddTechView: View {
    @State private var name = ""
    @State private var sdt = ""
    @State private var email = ""
    @EnvironmentObject var shop: ShopStore
    @Binding var isPresenting: Bool
    @FocusState private var focusName: Bool
    
    var body: some View {
        NavigationStack {
            TextField("Name:", text: $name)
                .textInputAutocapitalization(.words)
                .focused($focusName)
            TextField("Phone Optional:", text: $sdt)
                .keyboardType(.numberPad)
            TextField("Email Optional:", text: $email)
                .keyboardType(.emailAddress)
        }.padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button("Dismiss"){
                        isPresenting = false
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Done"){
                        addTech()
                        isPresenting = false
                    }.disabled(name.isEmpty)
                }
            }
            .onAppear{focusName = true}
    }
    
    private func addTech(){
        let newTech = Tech(name: name, phone: sdt, email: email)
        shop.shop.techs.append(newTech)
    }
}

#Preview {
    AddTechView(isPresenting: .constant(true))
        .environmentObject(ShopStore())
}
