
## 🧩 Library Used

### 🖼 **SDWebImage**
**Purpose:**  
Used for asynchronous image downloading and caching in the article list. It ensures smooth scrolling and fast image loading by caching images locally.

**Installation (SPM):**  
In Xcode → File → Add Packages → Add this URL: 

https://github.com/SDWebImage/SDWebImage.git

**Usage Example in Code:**
```swift
import SDWebImage

articleImageView.sd_setImage(
    with: URL(string: article.urlToImage ?? ""),
    placeholderImage: UIImage(named: "")
)

## 🧩 Optional Library

### 🖼 **Kingfisher**
**Purpose:**  
Used as an alternative image downloading and caching library. It offers smooth asynchronous image loading, caching, and transition animations with full Swift support.

**Installation (SPM):**  
In Xcode → File → Add Packages → Add this URL: 

https://github.com/onevcat/Kingfisher.git

**Usage Example in Code:**
```swift
import Kingfisher

articleImageView.kf.setImage(
    with: URL(string: article.urlToImage ?? ""),
    placeholder: UIImage(named: "")
)


### 🌐 ** Alamofire**
**Purpose:**  
A Swift-based HTTP networking library that simplifies API requests, JSON decoding, and error handling.
It’s useful for handling more complex or large-scale network operations compared to native URLSession

**Installation (SPM):**  
In Xcode → File → Add Packages → Add this URL: 

https://github.com/Alamofire/Alamofire.git

**Usage Example in Code:**
```swift
import Alamofire

AF.request("https://newsapi.org/v2/top-headlines", parameters: ["country": "us"])
    .responseDecodable(of: NewsResponseModel.self) { response in
        switch response.result {
        case .success(let news):
            print(news)
        case .failure(let error):
            print(error)
        }
    }
