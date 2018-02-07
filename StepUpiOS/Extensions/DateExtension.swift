//
//  DateExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 21/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension Formatter {
    public static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    public static let RFC339: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    static let logger: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
}

extension String {
    public var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
    
    public var dateFromRFC339: Date? {
        return Formatter.RFC339.date(from: self)
    }
}

extension Date {
    var daySuffix: String
    {
        get {
            var suffix = ""
            if let dayOfMonth = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self).day {
                switch dayOfMonth
                {
                case 1, 21, 31:
                    suffix = "st"
                case 2, 22:
                    suffix = "nd"
                case 3, 23:
                    suffix = "rd"
                default:
                    suffix = "th";
                }
            } else {
                Logger.error(message: "Unable to retrieve day from Date", additionalData: ["Date": self])
            }
            return suffix
        }
    }
    
    public func removeYears(_ yearsToRemove: Int) -> Date? {
        let unitFlags: Set<Calendar.Component> = [.hour, .day, .month, .year]
        var components = Calendar.current.dateComponents(unitFlags, from: self)
        if let year = components.year {
            components.year = year - yearsToRemove
        }
        
        return Calendar.current.date(from: components)
    }
}
