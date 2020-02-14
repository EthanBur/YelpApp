//
//  ViewController.swift
//  PokedexApp
//
//  Created by mcs on 1/31/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

struct State {
    static var product: PokemonInfo!
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
//        if !(searchController.searchBar.text! == "") {
//            var ditto = PokemonInfo(id: 132, name: "Ditto", sprites: Sprite(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png"), types: Type[type(name: "normal")])
//            var filteredPokemonList: [PokemonInfo] = []
//            filteredPokemonList.append(pokemonTwoList.first(where: {$0.name == searchController.searchBar.text})!)
//            pokemonList = filteredPokemonList
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemonList.count-1 {
            var newThingy: PokemonContainer
            for i in increment...increment+1 {
                urlString = URL(string: pokemon[i]!.next ?? "" )
                newThingy = loadJson()!
                pokemon.append(newThingy)
                pokemon[i+1] = newThingy
                increment += 1
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "cell") as? PokemonTableViewCell else { return UITableViewCell() }
        cell.partyIcon.downloadImageFrom(link: "\(pokemonList[indexPath.row].sprites.front_default)", contentMode: UIView.ContentMode.left)
        cell.nameLabel.text = "\(pokemonList[indexPath.row].name)"
        cell.nameLabel.text = cell.nameLabel.text?.capitalized
        cell.nameLabel.font = UIFont(name: "Arial", size: 30)
        if pokemonList[indexPath.row].id < 10{
            cell.gameIndexLabel.text = "00\(pokemonList[indexPath.row].id.description)"
        }else if pokemonList[indexPath.row].id < 100{
            cell.gameIndexLabel.text = "0\(pokemonList[indexPath.row].id.description)"
        }else{
        cell.gameIndexLabel.text = "\(pokemonList[indexPath.row].id.description)"
        }
        cell.typeIcon.text = ""
        cell.typeTwoIcon.text = ""
        cell.typeTwoIcon.textColor = .white
        cell.typeIcon.textColor = .white
        cell.typeIcon.layer.borderWidth = 0.5
        cell.typeTwoIcon.layer.borderWidth = 0.5
        cell.typeIcon.text = "\(pokemonList[indexPath.row].types[0].type.name)"
        
        if pokemonList[indexPath.row].types.count == 2 {
            cell.typeIcon.text = "\(pokemonList[indexPath.row].types[1].type.name)"
            cell.typeTwoIcon.text = "\(pokemonList[indexPath.row].types[0].type.name)"
            
            switch cell.typeTwoIcon.text {
            case "normal":
                cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#A8A77A")
                case "dark":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#705746")
                case "dragon":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#6F35FC")
                case "bug":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#A6B91A")
                case "ice":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#96D9D6")
                case "electric":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#F7D02C")
                case "ghost":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#735797")
                case "flying":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#A98FF3")
                case "psychic":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#F95587")
                case "fighting":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#C22E28")
                case "grass":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#7AC74C")
                case "fire":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#EE8130")
                case "water":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#6390F0")
                case "ground":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#E2BF65")
                case "rock":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#B6A136")
                case "poison":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#A33EA1")
                case "steel":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#B7B7CE")
                case "fairy":
                    cell.typeTwoIcon.backgroundColor = hexStringToUIColor(hex: "#D685AD")
                
            default:
                cell.typeTwoIcon.backgroundColor = .white
            }
        }
        cell.typeIcon.font = UIFont(name: "Arial", size: 25)
        cell.typeTwoIcon.font = UIFont(name: "Arial", size: 25)
        cell.selectionStyle = .none
        
        switch cell.typeIcon.text {
        case "normal":
            cell.backgroundColor = hexStringToUIColor(hex: "#A8A77A")
            case "dark":
                cell.backgroundColor = hexStringToUIColor(hex: "#705746")
            case "dragon":
                cell.backgroundColor = hexStringToUIColor(hex: "#6F35FC")
            case "bug":
                cell.backgroundColor = hexStringToUIColor(hex: "#A6B91A")
            case "ice":
                cell.backgroundColor = hexStringToUIColor(hex: "#96D9D6")
            case "electric":
                cell.backgroundColor = hexStringToUIColor(hex: "#F7D02C")
            case "ghost":
                cell.backgroundColor = hexStringToUIColor(hex: "#735797")
            case "flying":
                cell.backgroundColor = hexStringToUIColor(hex: "#A98FF3")
            case "psychic":
                cell.backgroundColor = hexStringToUIColor(hex: "#F95587")
            case "fighting":
                cell.backgroundColor = hexStringToUIColor(hex: "#C22E28")
            case "grass":
                cell.backgroundColor = hexStringToUIColor(hex: "#7AC74C")
            case "fire":
                cell.backgroundColor = hexStringToUIColor(hex: "#EE8130")
            case "water":
                cell.backgroundColor = hexStringToUIColor(hex: "#6390F0")
            case "ground":
                cell.backgroundColor = hexStringToUIColor(hex: "#E2BF65")
            case "rock":
                cell.backgroundColor = hexStringToUIColor(hex: "#B6A136")
            case "poison":
                cell.backgroundColor = hexStringToUIColor(hex: "#A33EA1")
            case "steel":
                cell.backgroundColor = hexStringToUIColor(hex: "#B7B7CE")
            case "fairy":
                cell.backgroundColor = hexStringToUIColor(hex: "#D685AD")
            
        default:
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        State.product = self.pokemonList[indexPath.row]
        navigationController?.pushViewController(PokeDex(), animated: true)
    }
    
    func loadFilteredJson() -> PokemonContainer? {
    var jsonPoke: PokemonContainer?
        do {
            let data = try Data(contentsOf: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=801")!)
            let decoder = JSONDecoder()

            let jsonData = try decoder.decode(PokemonContainer?.self, from: data)
            jsonPoke = jsonData
        } catch {
            print("error:\(error)")
        }
        do {
            for i in 0...jsonPoke!.results.count-1 {
                let urlStr = URL(string: jsonPoke!.results[i].url )
                let data = try Data(contentsOf: urlStr!)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PokemonInfo.self, from: data)
                pokemonTwoList.append(PokemonInfo(id: jsonData.id, name: jsonData.name, sprites: jsonData.sprites, types: jsonData.types))
            }
    } catch {
        print("error:\(error)")
    }
    return jsonPoke
    }
    
    func loadJson() -> PokemonContainer? {
        var jsonPoke: PokemonContainer?
            do {
                let data = try Data(contentsOf: urlString!)
                let decoder = JSONDecoder()
                
                let jsonData = try decoder.decode(PokemonContainer.self, from: data)
                jsonPoke = jsonData
            } catch {
                print("error:\(error)")
            }
            do {
                for i in 0...(jsonPoke?.results.count ?? 1)-1 {
                    let urlStr = URL(string: jsonPoke?.results[i].url ?? "")
                    let data = try Data(contentsOf: urlStr!)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(PokemonInfo.self, from: data)
                    pokemonList.append(PokemonInfo(id: jsonData.id, name: jsonData.name, sprites: jsonData.sprites, types: jsonData.types))
                }
        } catch {
            print("error:\(error)")
        }
        return jsonPoke
        }
    
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
}

var increment = 0

class ViewController: UIViewController {
    
    var urlString = URL(string: "https://pokeapi.co/api/v1/pokemon/")
    var pokemonList = [PokemonInfo]()
    var pokemonTwoList = [PokemonInfo]()
    var pokemon = [PokemonContainer?]()
    
    var pokemonTableView: UITableView = {
           var tableView = UITableView()
        tableView.accessibilityIdentifier = "pokeTable"
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let newThingy: PokemonContainer = loadJson()!

        pokemon.append(newThingy)
        setupTableView()
        setupSearchController()
//        let oldThingy = loadFilteredJson()?.results
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cell")
        pokemonTableView.backgroundColor = .red
        self.navigationItem.title = "PokéDex"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 35.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationItem.setHidesBackButton(true, animated: true);
        setupConstraints()
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        pokemonTableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self as UISearchBarDelegate
    }

    func setupTableView() {
        pokemonTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(pokemonTableView)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo:
                view.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

struct PokemonContainer: Decodable {
    var results: [Pokemon]
    var next: String?
}

struct Pokemon: Decodable {
    var name: String
    var url: String
}

struct PokemonInfo: Decodable {
    var id: Int
    var name: String
    var sprites: Sprite
//    var animatedIcon: String
    var types: [Type]
//    var stats: [Stat]
}

struct Sprite: Decodable {
    var front_default: String
}

//struct PokeDexEntry: Decodable{
//    var flavor_text: String
//}

//
//struct Stat: Decodable {
//    var base_stat: String
//    var name: String
//}
//
struct Type: Decodable {
    var type: type
}
struct type: Decodable {
    var name: String
}

