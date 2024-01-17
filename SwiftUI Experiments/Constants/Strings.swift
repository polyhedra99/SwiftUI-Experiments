//
//  StringConstants.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

struct Strings {
    
    // MARK: - Drawer
    static let DRAWER_HOME = "Home"
    static let DRAWER_HISTORY = "History"
    static let DRAWER_SETTINGS = "Settings"
    
    // MARK: - ReposView
    static let REPOS_TITLE = "GitHub Search API"
    static let REPOS_SEARCH_PLACEHOLDER = "Search.."
    static let REPOS_CONTAINS_TILDA = "Cannot contain \"~\"."
    
    // MARK: - HistoryView
    static let HISTORY_TITLE = "History"
    static let HISTORY_CLEAR = "Clear all"
    static let HISTORY_CLEAR_SUCCESS = "History cleared"
    
    // MARK: - SettingsView
    static let SETTINGS_TITLE = "Settings"
    
    static let SETTINGS_APPEARANCE = "Appearance"
    static let SETTINGS_THEME = "Theme"
    static let SETTINGS_THEME_DARK = "Dark"
    static let SETTINGS_THEME_LIGHT = "Light"
    static let SETTINGS_THEME_NONE = "Same as system"
    
    static let SETTINGS_DATA = "Data"
    static let SETTINGS_PER_PAGE: (Int) -> String  = { count in "Items loaded per query: \(count)"}
    static let SETTINGS_CACHE: (Int) -> String = { amount in "Results persisted: \(amount)"}
    static let SETTINGS_CACHE_QUERIES: (String) -> String = { queries in "Persisted for queries: \(queries)" }
    
    // MARK: - Universal
    static let SEARCH_PLACEHOLDER = "Search"
    static let DONE = "Done"
    
    // MARK: - Errors
    static let DECODING_ERROR = "Failed to decode the object from the service."
    static let CODE_ERROR: (Int) -> String = { code in "Error code: \(code)." }
    static let UNKNOWN_ERROR = "Unknown error."
    
    // MARK: - Keys
    static let APP_STORAGE_THEME = "preferredTheme"
    static let APP_STORAGE_PER_PAGE = "resultsPerPage"
    static let APP_STORAGE_CACHED = "resultsCached"
}
