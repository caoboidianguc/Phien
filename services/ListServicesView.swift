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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var columns: [GridItem] {
        let count = horizontalSizeClass == .regular ? 5 : 3
        return Array(repeating: GridItem(.flexible(), spacing: 2), count: count)
    }

    @State private var danhMuc: [Service] = []
    @State private var removeLastItem = false
    @State private var lastTappedCatalogID: UUID?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                selectionSummary
                Divider()
                serviceGrid
            }
            .padding()
        }
        .frame(idealWidth: 500, idealHeight: 700)
        .navigationTitle("Add Service for \(tech.name)")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddServicesButton {
                    tech.servDone += danhMuc
                    dismiss()
                }
                .disabled(danhMuc.isEmpty)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Remove Last Turn", action: {
                    removeLastItem = true
                })
                .disabled(tech.servDone.filter { $0.today }.isEmpty)
            }
        }
        .alert("Last one was removed", isPresented: $removeLastItem, actions: {
            Button("Done") {
                tech.servDone.removeLast()
            }
        })
    }

    private var selectionSummary: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                danhMuc = []
                lastTappedCatalogID = nil
            }
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(danhMuc.isEmpty ? "Tap services below to add" : "Selected — tap to clear all")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if !danhMuc.isEmpty {
                    Text(danhMuc.map(\.name).joined(separator: " · "))
                        .font(.body.weight(.medium))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.primary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
        }
        .buttonStyle(.plain)
    }

    private var serviceGrid: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(services) { service in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        let picked = service.pickedForTurn()
                        lastTappedCatalogID = service.id
                        danhMuc.append(picked)
                    }
                } label: {
                    ServicePickerTile(
                        name: service.name,
                        price: service.price,
                        isHighlighted: lastTappedCatalogID == service.id
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.bottom, 3)
    }
}

private struct ServicePickerTile: View {
    let name: String
    let price: Int
    let isHighlighted: Bool

    private static let normalFill = Color(red: 0.90, green: 0.94, blue: 1.0)
    private static let highlightFill = Color(red: 0.88, green: 0.97, blue: 0.90)

    var body: some View {
        VStack(spacing: 4) {
            Text(name)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Text("$\(price)")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .center)
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isHighlighted ? Self.highlightFill : Self.normalFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(
                    isHighlighted ? Color.green.opacity(0.5) : Color.blue.opacity(0.2),
                    lineWidth: isHighlighted ? 2 : 1
                )
        )
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
                .frame(width: 75, height: 35)
                .overlay {
                    Text("Done")
                        .font(.system(size: 25))
                        .foregroundStyle(.background)
                }
        })
    }
}