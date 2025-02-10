//
//  HolidaysViewModel.swift
//  InternalSolutions
//
//  Created by Trainee on 2/5/25.
//

import Foundation

class HolidaysViewModel: ObservableObject{
    
    @Inject var service: HolidaysService
    @Published var holidays = [Holiday]()
    
    
    func getHolidays() {
        Task {
            do {
                let fetchedHolidays = try await service.fetchHolidays()
                await onHolidaysFetched(holidays: fetchedHolidays)
            } catch {
                return
            }
        }
    }
    
    @MainActor
    func onHolidaysFetched(holidays: [Holiday]) {
        self.holidays = holidays
    }
}
