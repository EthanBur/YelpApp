//
//  PokeDex.swift
//  PokedexApp
//
//  Created by mcs on 2/2/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
                
            }
        }).resume()
    }
}

extension PokeDex {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func loadEvolutionJson(urlString: String) -> PokeEvolution? {
            let urlThing = URL(string: urlString)
            do{
                let data = try Data(contentsOf: urlThing!)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PokeEvolution.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
            return nil
        }
    
    func loadJson() -> pokeDescription? {
        var pokemonDescription: pokeDescription = pokeDescription(flavor_text_entries: [Descriptions(flavor_text: "")], evolution_chain: EvoUrl(url: ""))
        let num = State.product.id
//        let num = 1
        let urlString = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(num)/")
        do{
            let data = try Data(contentsOf: urlString!)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(pokeDescription.self, from: data)
            for i in 0...jsonData.flavor_text_entries.count-1{
                pokemonDescription.flavor_text_entries = [jsonData.flavor_text_entries[i]]
                pokemonDescription.evolution_chain.url = jsonData.evolution_chain.url
            }
        } catch {
            print("error:\(error)")
        }
        return pokemonDescription
    }
}



class PokeDex: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        var primaryType = State.product.types[0].type.name
        if State.product.types.count == 2{
        primaryType = State.product.types[1].type.name
       }
    switch primaryType {
        case "normal":
            view.backgroundColor = hexStringToUIColor(hex: "#A8A77A")
            case "dark":
                view.backgroundColor = hexStringToUIColor(hex: "#705746")
            case "dragon":
                view.backgroundColor = hexStringToUIColor(hex: "#6F35FC")
            case "bug":
                view.backgroundColor = hexStringToUIColor(hex: "#A6B91A")
            case "ice":
                view.backgroundColor = hexStringToUIColor(hex: "#96D9D6")
            case "electric":
                view.backgroundColor = hexStringToUIColor(hex: "#F7D02C")
            case "ghost":
                view.backgroundColor = hexStringToUIColor(hex: "#735797")
            case "flying":
                view.backgroundColor = hexStringToUIColor(hex: "#A98FF3")
            case "psychic":
                view.backgroundColor = hexStringToUIColor(hex: "#F95587")
            case "fighting":
                view.backgroundColor = hexStringToUIColor(hex: "#C22E28")
            case "grass":
                view.backgroundColor = hexStringToUIColor(hex: "#7AC74C")
            case "fire":
                view.backgroundColor = hexStringToUIColor(hex: "#EE8130")
            case "water":
                view.backgroundColor = hexStringToUIColor(hex: "#6390F0")
            case "ground":
                view.backgroundColor = hexStringToUIColor(hex: "#E2BF65")
            case "rock":
                view.backgroundColor = hexStringToUIColor(hex: "#B6A136")
            case "poison":
                view.backgroundColor = hexStringToUIColor(hex: "#A33EA1")
            case "steel":
                view.backgroundColor = hexStringToUIColor(hex: "#B7B7CE")
            case "fairy":
                view.backgroundColor = hexStringToUIColor(hex: "#D685AD")

        default:
            view.backgroundColor = .white
        }
        
        if State.product.id < 10{
            idTextField.text = "00\(State.product.id.description)"
        }else if State.product.id < 100{
            idTextField.text = "0\(State.product.id.description)"
        }else{
            idTextField.text = State.product.id.description
        }
        nameTextLabel.text = State.product.name.capitalized
        let param: String = State.product.sprites.front_default
        iconImage.downloadImage(link: param, contentMode: UIView.ContentMode.center)
        guard let pokemonDescription = loadJson()
            else { return }
        guard let pokemonEvolution: PokeEvolution = loadEvolutionJson(urlString: pokemonDescription.evolution_chain.url)
        else { return }
        var temp: String = pokemonDescription.flavor_text_entries[0].flavor_text
        temp = temp.replacingOccurrences(of: "\n", with: " ")
        descriptionLabel.text = temp
        descriptionLabel.sizeToFit()
               
        let firstEvo = pokemonEvolution.chain.species
        let secondEvo = pokemonEvolution.chain.evolves_to[0]?.species
        let thirdEvo = pokemonEvolution.chain.evolves_to[0]?.evolves_to[0]?.species

        evolutionLabel.text = ("\(firstEvo.name)\n \(secondEvo?.name ?? "") \n \(thirdEvo?.name ?? "")")
        iconImage.frame = CGRect(x: 0, y: 2.5, width: 70, height: 70)
        descriptionLabel.isHidden = false
        evolutionLabel.isHidden = true
        view.addSubview(idTextField)
        view.addSubview(iconImage)
        view.addSubview(nameTextLabel)
        view.addSubview(segmentView)
        view.addSubview(evolutionLabel)
        view.addSubview(descriptionLabel)
        setupConstraints()
    }
    
    var idTextField: UILabel = {
        var textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var iconImage: UIImageView = {
        var textField = UIImageView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var nameTextLabel: UILabel = {
        var textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var evolutionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var segmentView: UISegmentedControl = {
        let items = ["Details" , "Evolution"]
        var segmentC = UISegmentedControl(items: items)
        segmentC.translatesAutoresizingMaskIntoConstraints = false
        segmentC.backgroundColor = .white
        segmentC.selectedSegmentIndex = 0
        segmentC.addTarget(self, action: #selector(PokeDex.indexChanged(_:)), for: .valueChanged)
        return segmentC
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            
            nameTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            
            segmentView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            segmentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            
            evolutionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            evolutionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                descriptionLabel.isHidden = false
                evolutionLabel.isHidden = true
            case 1:
                evolutionLabel.isHidden = false
                descriptionLabel.isHidden = true
            default:
                descriptionLabel.isHidden = false
                evolutionLabel.isHidden = true
            }
    }
}

struct pokeDescription: Decodable {
    var flavor_text_entries: [Descriptions]
    var evolution_chain: EvoUrl
}

struct EvoUrl: Decodable {
    var url: String
}

struct Descriptions: Decodable {
    var flavor_text: String
}

struct PokeEvolution: Decodable {
    var chain: FirstEvolution
}

struct FirstEvolution: Decodable {
    var evolves_to: [SecondEvolution?]
    var species: Pokemon
}

struct SecondEvolution: Decodable {
    var evolves_to: [ThirdEvolution?]
    var species: Pokemon
}

struct ThirdEvolution: Decodable {
    var species: Pokemon
}
