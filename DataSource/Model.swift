import Foundation

struct Model {
    let name: String
    let image: String
    
    static func fetchData() -> [Model] {
        let img1 = Model(name: "Puerto del Carmen", image: "img1")
        let img2 = Model(name: "Roque Nublo", image: "img2")
        let img3 = Model(name: "La Santa", image: "img3")
        let img4 = Model(name: "Playa de Las Teresitas", image: "img4")
        let img5 = Model(name: "Playa de La Tejita", image: "img5")
        return [img1, img2, img3, img4, img5]
    }
}
