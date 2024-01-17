//
//  DependencyInjector.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Foundation
import Swinject
import RealmSwift

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}

class Resolver {
    static let shared = Resolver()
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
    
    func setDependencyContainer(_ container: Container) {
        self.container = container
    }
}

private func buildContainer() -> Container {
    let container = Container()
    
    container.register(Realm.self) { _ in
        try! Realm(queue: DispatchQueue.main)
    }.inObjectScope(.container)
    
    // MARK: - Repos related injections
    container.register(RepoLocalSource.self) { resolver in
        RepoLocalSourceImpl(realm: resolver.resolve(Realm.self)!)
    }.inObjectScope(.container)
    container.register(RepoRemoteSource.self) { _ in
        RepoRemoteSourceImpl()
    }.inObjectScope(.container)
    container.register(Repository.self) { resolver in
        RepositoryImpl(
            repoRemoteSource: resolver.resolve(RepoRemoteSource.self)!,
            repoLocalSource: resolver.resolve(RepoLocalSource.self)!
        )
    }.inObjectScope(.container)
    
    // MARK: - Interactor related injections
    container.register(RepoUpdateInteractor.self) { resolver in
        RepoUpdateInteractorImpl(
            repository: resolver.resolve(Repository.self)!
        )
    }.inObjectScope(.container)
    container.register(HistoryClearInteractor.self) { resolver in
        HistoryClearInteractorImpl(
            repository: resolver.resolve(Repository.self)!
        )
    }
    
    return container
}
