import UIKit
import CoreData

class FavoritesVC: UIViewController {

    var collectionView: UICollectionView!
    
    var usernameArray: [String] = []
    var streamURLArray: [String] = []
    var imageURLArray: [String] = []
    var idArray: [String] = []
    
    
    var username: String!
    var streamURL: String!
    var imageURL: String!
    var id: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        getUserData()
    }
    

    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.reuseID)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avalibleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWigth = avalibleWidth / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.itemSize = CGSize(width: itemWigth, height: itemWigth + 40)
        
        return layout
    }

    
    func getUserData(){
        let appDelegate = AppDelegate()
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Streamers")

        do{
            let result = try managedContext.fetch(fetchRequest)
            
            if !usernameArray.isEmpty{
                usernameArray.removeAll()
                streamURLArray.removeAll()
                imageURLArray.removeAll()
                idArray.removeAll()
            }
            
            for data in result as! [NSManagedObject]{
                username = (data.value(forKey: "username") as? String)!
                usernameArray.append(username)
                
                streamURL = (data.value(forKey: "streamURL") as? String)!
                streamURLArray.append(streamURL)
                
                imageURL = (data.value(forKey: "imageURL") as? String)!
                imageURLArray.append(imageURL)
                
                id = (data.value(forKey: "id") as? String)!
                idArray.append(id)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }catch{
            print("failed")
        }
    }
  

}


extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usernameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        
        
        let url = URL(string: imageURLArray[indexPath.row])!
        if let data = try? Data(contentsOf: url){
            cell.userImage.image = UIImage(data: data)
        }
        
        cell.usernameLabel.text = usernameArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showVC = ShowVC(id: idArray[indexPath.row],
                            name: usernameArray[indexPath.row],
                            streamURL: streamURLArray[indexPath.row],
                            title: usernameArray[indexPath.row])
        
        
        showVC.title = usernameArray[indexPath.row]
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    
}
