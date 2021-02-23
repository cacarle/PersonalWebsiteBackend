import Vapor

func routes(_ app: Application) throws {
    
    app.get { req in
        req.leaf.render(template: "index", context: [
            "title": "Carlos Carle 👨‍💻",
        ])
    }
}
