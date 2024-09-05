//
//  String+Additions.swift

import Foundation

extension String {
    func toDate(format: Date.Format) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}
