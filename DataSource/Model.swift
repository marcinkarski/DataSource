import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

struct Model {
    var about: String?
    var top = [Top]()
    var category = [Category]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                self.about = body["about"] as? String
                if let top = body["top"] as? [[String: Any]] {
                    self.top = top.map { Top(json: $0) }
                }
                
                if let category = body["category"] as? [[String: Any]] {
                    self.category = category.map { Category(json: $0) }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

struct Top {
    var name: String?
    var image: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.image = json["image"] as? String
    }
}

struct Category {
    var key: String?
    var value: String?
    
    init(json: [String: Any]) {
        self.key = json["key"] as? String
        self.value = json["value"] as? String
    }
}
