//
//  WorkingView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import SwiftUI

struct WorkingView: View {
    @EnvironmentObject var shop: ShopStore
    
    var body: some View {
        ScrollView {
            
            ForEach(shop.phien(chon: shop.shop.chon)){ tech in
                TechButtonTurnView(tech: binding(for: tech))
            }
           
        }
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                Toggle("By Turn", isOn: $shop.shop.chon)
                    .foregroundStyle(shop.shop.chon ? .green : .blue)
            })
        }
        
    }//body
    
    private func binding(for tech: Tech) -> Binding<Tech>{
        guard let techIndex = shop.shop.techs.firstIndex(where: {$0.id == tech.id}) else {
            fatalError("Can't get technician!")
        }
        return $shop.shop.techs[techIndex]
    }
}

#Preview {
    WorkingView()
        .environmentObject(ShopStore())
}


