//
//  TechButtonTurnView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct TechButtonTurnView: View {
    @Binding var tech: Tech
    @State private var showListservicesView = false
    @EnvironmentObject var shop: ShopStore
    var nutNghi: some Gesture {
        LongPressGesture()
            .onEnded { value in
                withAnimation {
                    tech.isWork = false
                }
            }
    }
    var dvHnay: [Service]{
        tech.servDone.filter{$0.today}
    }
    
    
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(tech.today ? tech.maungauNhien : .gray).opacity(0.8)
                .gesture(nutNghi)
                .frame(width: 115, height: 100)
            .overlay{
                VStack(alignment: .listRowSeparatorLeading) {
                    HStack(alignment: .top){
                        themDv
                        Spacer()
                        Text("\(dvHnay.count)")
                            .monospacedDigit()
                            .font(.system(size: 30))
                    }
                    .padding([.leading,.trailing], 4)
                    
                    Text("\(tech.date.formatted(.dateTime.hour().minute()))")
                    Text(tech.name).font(.system(size: 20))
                }.foregroundStyle(.background)
            }
            dichVu
        }
            .sheet(isPresented: $showListservicesView) {
                NavigationStack {
                    ListServicesView(tech: $tech, services: $shop.shop.services)
                }
            }
        
    }
   
    
    var dichVu: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(dvHnay){ser in
                    ServiceBlockView(serv: ser)
                }
            }.frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .greatestFiniteMagnitude)
        }
//        .frame(height: 100)
        .transition(.move(edge: .bottom))
    }
    
    var themDv: some View {
        Button(action: {
            showListservicesView = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .shadow(color: .black, radius: 10)
                    .frame(width: 60, height: 50)
                    .opacity(0.3)
                Text(String(tech.name.first!))
                    .font(.system(size: 42))
            }
            
        })
        .frame(width: 42, height: 42, alignment: .center)
    }
}

#Preview {
    TechButtonTurnView(tech: .constant(Tech.techMau[0]))
        .environmentObject(ShopStore())
}

