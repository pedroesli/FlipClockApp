//
//  StoreManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/09/23.
//

import StoreKit

@MainActor
class StoreManager: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var showThankYouTipView = false
    @Published var productInProcess: Product?
    
    private let productIDs = [
        "com.consumable.tip01",
        "com.consumable.tip02",
        "com.consumable.tip03",
        "com.consumable.tip04",
        "com.consumable.tip05"
    ]
    
    private var updates: Task<Void, Never>?
    
    init() {
        updates = newTransactionListenerTask()
    }
    
    deinit {
        updates?.cancel()
    }
    
    func getProducts() {
        Task {
            do {
                products = try await Product.products(for: productIDs).sorted(by: { $0.price < $1.price })
            } catch {
                print("Get products error: \(error)")
            }
        }
    }
    
    func purchase(_ product: Product) {
        productInProcess = product
        Task {
            do {
                let result = try await product.purchase()
                
                switch result {
                case let .success(.verified(transaction)):
                    await transaction.finish()
                    showThankYouTipView = true
                case let .success(.unverified(_, error)):
                    print(error)
                case .userCancelled: break
                case .pending: break
                @unknown default:
                    print("Unknown purchase error")
                }
                productInProcess = nil
            } catch {
                productInProcess = nil
                print("Purchase error: \(error)")
            }
        }
    }
    
    private func newTransactionListenerTask() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                for await unfinished in Transaction.unfinished {
                    guard case .verified(let transaction) = unfinished else {
                        // Ignore unverified transactions.
                        return
                    }
                    await transaction.finish()
                    showThankYouTipView = true
                }
            }
        }
    }
}
