# SwiftUI Experiments
<img width="1096" alt="image" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/290cf1bb-7333-4b0d-a025-6b76f33d4922">
</br><h3>Synopsis</h3>
A very simple app created to get a hold on some of the latest technologies available for iOS development.
</br> Functionality revolves around calling GitHub API to search for repositories.
</br>
</br><h3>MVI</h3>
<img alt="mvi" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/6c2af878-7fca-4d5d-a3c2-79c6063480a6">
</br></br>Having a background as an Android Software Engineer, MVI was a rather drastic shift from my standard MVVM + Clean Architecture approach that I've used 
for many years at this point, which is pretty much an industry standard for Android. Switching to MVI was mainly dictated by the features of SwiftUI 
and later set in stone by Realm. MVI's definition is rather broad 
and open for interpretation, yet in the context of this project, it goes as follows: SwiftUI view calls an Interactor directly; Interactor works similarly to 
what would be a UseCase in Clean Architecture, aside from the fact that it doesn't return any observable objects for the View. Instead, it encapsulates all 
the business logic necessary to properly communicate with the Data (Model) layer; Realm database is treated as a single source of truth, Realm objects are 
observed directly in the View, using @ObservedResults. While it might sound like a lack of separation of concerns to some (which it clearly is), the amount of 
code needed to be written is drastically lower when compared to the MVVM+C counterpart. 
That said, the codebase itself is reasonably scalable and readable as well, so I would consider it a very solid architectural pattern for iOS, as of 2024.
</br>
</br><h3>Screens</h3>
<table>
  <tr>
    <td><img width="502" alt="image" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/50cab935-48cd-41f9-8c40-3e14398f0cf0"></td>
    <td><img width="502" alt="image" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/c5e3accc-c430-493b-8c5b-5bf988a3d2c2"></td>
    <td><img width="502" alt="image" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/f9a68f1e-a23f-49c7-b682-3c42dff368bb"></td>
    <td><img width="502" alt="image" src="https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/c422ceec-a1c4-4dc8-9d7c-8736c3ba1f17"></td>
  </tr>
</table>
</br>
</br>The app itself is very simple and only consists of 2 screens, one Settings sheet and a Navigational Drawer to move around them. On the home screen, 
the fetch is triggered automatically, after 1 second of not typing anything. There is also a demonstrational stab for validation, as to demonstrate 
how SideEffects, returned from Interactors, work. Here, it just tells you that you can't use "~" in your query.
</br>History screen is self-explanatory, whatever search you made gets saved there.
</br>Settings is probably the most interesting one here, as it allows you to set the amount of cached results, while displaying corresponding queries. 
Instead of cleaning the cache every 24h or so, I decided to opt it for the amount of queries. Haven't really seen a similar mechanism in other apps, 
yet I find it to be very convenient. As I am no designer (partially), most of the functionality is implemented the way I would want it to be in some 
application from the AppStore that I have nothing to do with.
</br>The Drawer is also an interesting element here, as it's all custom-made and I struggled quite a bit to make pretty animations work, as well as to make 
the drawer itself feel natural. Overall, I am glad with how it turned out. The starry sky is replaced with a sunny one on Light Theme.
</br>
</br><h3>Live demonstration</h3>
https://github.com/polyhedra99/SwiftUI-Experiments/assets/34110629/8b3a3607-eabf-4273-a863-c2a59f183a7f
</br>
