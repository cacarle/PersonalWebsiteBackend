import Vapor
import Leaf

public func configure(_ app: Application) throws {
    
    // Disabling renderer caching for Leaf allows you to change the templates (HTML and CSS files in this case) without having to restart the server
    if !app.environment.isRelease { LeafRenderer.Option.caching = .bypass }
    
    // Without directory indexing you can't make a request to '/ which is what you want so you can access 'website.com'
    LeafFileMiddleware.directoryIndexing = .ignore
    
    // So leaf knows where to look for the templates
    let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
    
    LeafEngine.rootDirectory = detected
    // Tells Leaf details about how to handle files, such as letting us deal with normal HTML files rather than .leaf files that make it easier for syntax coloring
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
