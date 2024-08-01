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
    @State var danhMuc: [Service] = []
    @State private var removeLastItem = false
    @State private var chonnut = ""
    
    var body: some View {
        ScrollView {
            pickDV()
            Divider().frame(width: 420)
            LazyVGrid(columns: cot, alignment: .center, spacing: 42, content: {
                ForEach($services){$dv in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)){
                            dv.startTime = Date.now
                            chonnut = dv.name
                            danhMuc.append(dv)
                        }
                    }, label: {
                        VStack {
                            Text(dv.name)
                            Text("\(dv.price)")
                        }
                        .opacity(chonnut == dv.name ? 0.1 : 1)
                        .scaleEffect(chonnut == dv.name ? 0.1 : 1.1)
                        .rotationEffect(.degrees(chonnut == dv.name ? 180 : 0))
                    })
                }
            })
        }
        .frame(idealWidth: 500, idealHeight: 700)
        .navigationTitle("Add Service for \(tech.name)")
        .toolbar {
            ToolbarItem(placement: .primaryAction){
                AddServicesButton(){
                    tech.servDone += danhMuc
                    dismiss()
                }.disabled(danhMuc.isEmpty)
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
    }
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
        .environmentObject(ShopStore())
}


struct AddServicesButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(width:75, height: 35)
                .overlay{
                    Text("Done")
                        .font(.system(size: 25))
                        .foregroundStyle(.background)
                }
        })
    }
}
