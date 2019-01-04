import Foundation

struct ImageModel {
    let name: String
    let image: String
}

func fetchData() -> [ImageModel] {
    let img1 = ImageModel(name: "Puerto del Carmen", image: "img1")
    let img2 = ImageModel(name: "Roque Nublo", image: "img2")
    let img3 = ImageModel(name: "La Santa", image: "img3")
    let img4 = ImageModel(name: "Playa de Las Teresitas", image: "img4")
    let img5 = ImageModel(name: "Playa de La Tejita", image: "img5")
    return [img1, img2, img3, img4, img5]
}
