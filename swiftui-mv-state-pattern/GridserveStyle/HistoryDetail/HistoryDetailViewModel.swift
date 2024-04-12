//
//  HistoryDetailViewModel.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 08/04/24.
//

import Combine
import CombineExt
import Foundation

enum HistoryDetailState: Equatable {
    static func == (lhs: HistoryDetailState, rhs: HistoryDetailState) -> Bool {
        switch (lhs, rhs) {
        case (.inprogresshistoryloaded(let lhsData), .inprogresshistoryloaded(let rhsData)):
            return lhsData == rhsData
        case (.failedhistoryloaded(let lhsData), .failedhistoryloaded(let rhsData)):
            return lhsData == rhsData
        case (.successhistoryloaded(let lhsData), .successhistoryloaded(let rhsData)):
            return lhsData == rhsData
        case (.errorGeneral, .errorGeneral):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    
    case inprogresshistoryloaded(data: HistoryDetailData?)
    case failedhistoryloaded(data: HistoryDetailData?)
    case successhistoryloaded(data: HistoryDetailData?)
    case errorGeneral
    case loading
}

enum HistoryAlertState: Equatable {
    static func == (lhs: HistoryAlertState, rhs: HistoryAlertState) -> Bool {
        return true
    }
    
    case none
    case generalErrorAlert
    case networkError(error: NetworkError)
}

@MainActor
class HistoryDetailViewModel: ObservableObject {
    @Published var state: HistoryDetailState = .loading
    @Published var alertState: HistoryAlertState = .none
    
    @Published var status: String = ""
    @Published var locationName: String = ""
    @Published var transactionDate: String = ""
    @Published var chargedAmount: Double = 0
    @Published var generatedKwh: Double = 0
    @Published var image: String = ""
    @Published var adminFee: Double = 0
    @Published var discount: Double = 0
    @Published var orderID: String = ""

    @Published var loadingAppear: Bool = false
    @Published var alertAppear = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $state
            .sink { [weak self] _state in
                self?.loadingAppear = false
                switch _state {
                case .inprogresshistoryloaded(let data), .failedhistoryloaded(let data), .successhistoryloaded(let data):
                    self?.updateViewModelProperties(data)
                case .errorGeneral:
                    self?.alertState = .generalErrorAlert
                case .loading:
                    self?.loadingAppear = true
                }
            }
            .store(in: &cancellables)
        
        $alertState
            .sink { [weak self] _state in
                switch _state {
                case .generalErrorAlert:
                    self?.alertAppear = true
                    print("general error")
                case .networkError(let error):
                    self?.alertAppear = true
                    print("network error \(error.localizedDescription)")
                default:
                    self?.alertAppear = false
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func onAppear() {
        Task {
            let model = await fetchHistory()
            setState(.successhistoryloaded(data: model))
        }
    }
    
    func didSelectSuccessButton() {
        Task {
            let model = await fetchHistory(.success)
            setState(.successhistoryloaded(data: model))
        }
    }
    
    func didSelectInProgressButton() {
        Task {
            let model = await fetchHistory(.inprogress)
            setState(.inprogresshistoryloaded(data: model))
        }
    }
    
    func didSelectFailedButton() {
        Task {
            let model = await fetchHistory(.failed)
            setState(.failedhistoryloaded(data: model))
        }
    }
    
    private func setState(_ state: HistoryDetailState) {
        self.state = state
    }
    
    private func fetchHistory(_ type: DummyJSON.ResponseType = .success) async -> HistoryDetailData? {
        setState(.loading)
        do {
            try await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
            let response: HistoryDetailModel = try await DummyJSON.shared.get(type)
            return response.data
        } catch {
            print(error.localizedDescription)
            setState(.errorGeneral)
            return nil
        }
    }
    
    private func updateViewModelProperties(_ model: HistoryDetailData?) {
        guard let model = model else { return }
        self.status = model.status
        self.locationName = model.locationName
        self.transactionDate = model.transactionDate
        self.chargedAmount = model.chargedAmount
        self.generatedKwh = model.generatedKwh
        self.image = model.image
        self.adminFee = model.adminFee
        self.discount = model.discount
        self.orderID = model.orderID
    }
}
