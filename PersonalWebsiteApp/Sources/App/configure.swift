import Vapor
import Leaf

public func configure(_ app: Application) throws {
    
    if !app.environment.isRelease {
        LeafRenderer.Option.caching = .bypass
    }
    
    LeafFileMiddleware.directoryIndexing = .ignore
    
    let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
        LeafEngine.rootDirectory = detected

        LeafEngine.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
                                                        limits: .default,
                                                        sandboxDirectory: detected,
                                                        viewDirectory: detected,
                                                        defaultExtension: "html"))
    
    if let lfm = LeafFileMiddleware(publicDirectory: app.directory.publicDirectory) {
        app.middleware.use(lfm)
    }
    
    app.views.use(.leaf)
    try routes(app)
}
