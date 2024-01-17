//
//  SettingsView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

import SwiftUI
import RealmSwift

// TODO: Sheet theme is not updated correctly for "Same as system" (only sheet)
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(Strings.APP_STORAGE_THEME) var theme = ThemeSelection.defaultTheme
    @AppStorage(Strings.APP_STORAGE_PER_PAGE) var perPage = UniversalConstants.DEFAULT_PER_PAGE
    @AppStorage(Strings.APP_STORAGE_CACHED) var cachedAmount = UniversalConstants.DEFAULT_CACHED
    
    // Didn't work with projection for some obscure reason
    @ObservedSectionedResults(
        RepoDetails.self,
        sectionKeyPath: \.query
    ) var queriesForCachedResuls
    
    var body: some View {
        NavigationView {
            Form {
                Section(Strings.SETTINGS_APPEARANCE) {
                    ThemeView()
                }
                
                Section(Strings.SETTINGS_DATA) {
                    PerPageView()
                    CachedItemsView()
                }
            }
            .navigationTitle(Strings.SETTINGS_TITLE)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                Button { dismiss() } label: { Text(Strings.DONE) }
            }
            // Theme was not updated for sheet for some reason
            .desideOnColorScheme(themeSelection: theme)
        }
    }
    
    // MARK: - Internals
    @ViewBuilder
    private func ThemeView() -> some View {
        Picker(Strings.SETTINGS_THEME, selection: $theme) {
            Text(Strings.SETTINGS_THEME_DARK).tag(ThemeSelection.dark)
            Text(Strings.SETTINGS_THEME_LIGHT).tag(ThemeSelection.light)
            Text(Strings.SETTINGS_THEME_NONE).tag(ThemeSelection.system)
        }
    }
    
    @ViewBuilder
    private func SliderLabel(_ text: String) -> some View {
        Text(text).font(.headline)
    }
    
    @ViewBuilder
    private func PerPageView() -> some View {
        let perPageMin = 5.0
        let perPageMax = 25.0
        let perPageRange = perPageMin...perPageMax
        let perPageStep = 5.0
        VStack(alignment: .leading) {
            SliderLabel(Strings.SETTINGS_PER_PAGE(perPage))
            
            Slider(
                value: .convert(from: $perPage),
                in: perPageRange,
                step: perPageStep
            ) {
                EmptyView()
            } minimumValueLabel: {
                Text(String(Int(perPageMin)))
            } maximumValueLabel: {
                Text(String(Int(perPageMax)))
            }
        }
    }
    
    @ViewBuilder
    private func CachedItemsView() -> some View {
        let cachedMin = 2.0
        let cachedMax = 10.0
        let cachedRange = cachedMin...cachedMax
        let cachedStep = 2.0
        VStack(alignment: .leading) {
            Text(Strings.SETTINGS_CACHE(cachedAmount)).font(.headline)
            Slider(
                value: .convert(from: $cachedAmount),
                in: cachedRange,
                step: cachedStep
            ) {
                EmptyView()
            } minimumValueLabel: {
                Text(String(Int(cachedMin)))
            } maximumValueLabel: {
                Text(String(Int(cachedMax)))
            }
            
            let queries = generateQueriesString(queriesForCachedResuls)
            Text(Strings.SETTINGS_CACHE_QUERIES(queries)).font(.caption)
        }
    }
}

private func generateQueriesString(_ queriesForCachedResuls: SectionedResults<String, RepoDetails>) -> String {
    return String(String("\(Array(queriesForCachedResuls.allKeys))"
        .dropFirst()).dropLast())
}

private extension Binding {
    static func convert<TInt, TFloat>(from intBinding: Binding<TInt>) -> Binding<TFloat>
        where TInt:   BinaryInteger,
              TFloat: BinaryFloatingPoint{

            Binding<TFloat> (
                get: { TFloat(intBinding.wrappedValue) },
                set: { intBinding.wrappedValue = TInt($0) }
            )
        }

        static func convert<TFloat, TInt>(from floatBinding: Binding<TFloat>) -> Binding<TInt>
        where TFloat: BinaryFloatingPoint,
              TInt:   BinaryInteger {

            Binding<TInt> (
                get: { TInt(floatBinding.wrappedValue) },
                set: { floatBinding.wrappedValue = TFloat($0) }
            )
        }
}
