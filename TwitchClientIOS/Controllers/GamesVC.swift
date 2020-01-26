import UIKit

class GamesVC: UIViewController {

    
    var collectionView: UICollectionView!
    var idArray = [String]()
    var gamesArray = [String]()
    var boxArtUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        getGames()
    }
    
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.register(GamesCell.self, forCellWithReuseIdentifier: GamesCell.reuseID)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avalibleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWigth = avalibleWidth / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.itemSize = CGSize(width: itemWigth, height: itemWigth + 40)
        
        return layout
    }
    
    func getGames(){
        NetworkManager.shared.getGames { (games) in
            for item in 0 ..< games.data.count{
                self.gamesArray.append((games.data[item].name))
                self.idArray.append(games.data[item].id)
                self.boxArtUrlArray.append(games.data[item].boxArtUrl)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func correctUrl(url: String) -> String{
        let oldUrl = url.replacingOccurrences(of: "{width}", with: "200")
        let newUrl = oldUrl.replacingOccurrences(of: "{height}", with: "200")
        
        return newUrl
    }
}


extension GamesVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCell.reuseID, for: indexPath) as! GamesCell
        
        cell.gameLabel.text = gamesArray[indexPath.row]
        
        let url = URL(string: correctUrl(url: boxArtUrlArray[indexPath.row]))!

        if let data = try? Data(contentsOf: url){
            cell.gameImage.image = UIImage(data: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let streamersVC = StreamsVC(id: idArray[indexPath.item], name: gamesArray[indexPath.item])
        streamersVC.title = gamesArray[indexPath.row]
        navigationController?.pushViewController(streamersVC, animated: true)
        
    }
    
}
