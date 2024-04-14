//
//  ListServicesView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct ListServicesView: View {
    @Binding var tech: Tech
    @Binding var services: [Service]
    @Environment(\.dismiss) private var dismiss
    let cot = [GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center)]
    @State private var danhMuc: [Service] = []
    @State private var removeLastItem = false
    
    var body: some View {
        ScrollView {
            pickDV()
            Divider().frame(width: 420)
            LazyVGrid(columns: cot, alignment: .center, spacing: 42, content: {
                ForEach($services){$dv in
                    NutChonDV(dv: $dv, danhMuc: $danhMuc)
                }
            })
        }
        .frame(idealWidth: 500, idealHeight: 700)
        .navigationTitle("Add Service for \(tech.name)")
        .toolbar {
            ToolbarItem(placement: .primaryAction){
                Button("Done"){
                    tech.servDone += danhMuc
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading){
                Button("Remove Last Turn", action: {
                    removeLastItem = true
                }).disabled(tech.servDone.filter{$0.today}.isEmpty)
            }
        }
        .alert("Last one was removed", isPresented: $removeLastItem, actions: {
            Button("Done"){
                tech.servDone.removeLast()
            }
        })
    }//body
    
    var chon: LocalizedStringKey {
            danhMuc.isEmpty ? "Please Pick" : "UnPick-> "
        }
    
    private func pickDV() -> some View{
        Button(action: {
            withAnimation {
                danhMuc = []
            }
        }, label: {
            Text(chon)
            layTenService()
        })
    }
    private func layTenService() -> some View {
        var ten: [String] = []
        for dv in danhMuc {
            ten.append(dv.name)
        }
        return Text(ten.joined(separator: " ; "))
    }
}

#Preview {
    ListServicesView(tech: .constant(Tech.techMau[0]), services: .constant(allServices))
}
