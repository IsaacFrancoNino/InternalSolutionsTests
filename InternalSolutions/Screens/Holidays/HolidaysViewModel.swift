//
//  HolidaysViewModel.swift
//  InternalSolutions
//
//  Created by Trainee on 2/5/25.
//

import Foundation

class HolidaysViewModel: ObservableObject{
    
    @Inject var service: HolidaysService
    @Published var holidaysByLetter:  [String : [Holiday] ] = [:]
    
    
    func getHolidays() {
        Task {
            do {
                let fetchedHolidays = try await service.fetchHolidays()
                //sort holidays alphabetically
                let sortedHolidays = fetchedHolidays.sorted { $0.date < $1.date }
                // Grouping holidays by first letter
                let grouped = Dictionary(grouping: sortedHolidays) {
                    String($0.name.prefix(1))
                }
                await onHolidaysFetched(holidays: grouped)
            } catch {
                print("Error fetching holidays: \(error.localizedDescription)")
                return
            }
        }
    }
    
    @MainActor
    func onHolidaysFetched(holidays: [String: [Holiday]]) {
        self.holidaysByLetter = holidays
    }
}
