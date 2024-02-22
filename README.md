<h1 align="center"> Chefaa Technical Assessment </h1>

## Note that:

- Follow the instructions bellow to clone this app succcessfully.
- Check requirements to see which work is done and which is not.
- Check commit messages & pull requests.
- Check Issues tickets at this [jira project](https://marvel-app.atlassian.net/jira/software/projects/SCRUM/boards/1/backlog?atlOrigin=eyJpIjoiNzA2N2QzYWI1ZWY5NGQ1MmE4ZTA3NDY2YTRjZmQyZjQiLCJwIjoiaiJ9).
- Don't forget to send me your feedback I really want this feedback.

## Getting Started

*To get this project up and running on your local machine for development and testing purposes make sure all prerequisties are met.*
- Clone this project on your machine by running
 ```
git clone https://github.com/ma7ros/ToDo-List.git
```
Or you can simply click [Download](https://github.com/ma7ros/ToDo-List/archive/refs/heads/master.zip) to manually download.
- Xcode Version 15.2
- iOS Deployment Target 17.2
- After cloned the code build the project by press <kbd>cmd</kbd> + <kbd>B</kbd>
    - if build failed check package dependency and add:
       - [RxSwift](https://github.com/ReactiveX/RxSwift) Up to Next Major Version 6.6.0
       - [Kingfisher](https://github.com/onevcat/Kingfisher) Up to Next Major Version 7.11.0
       - After that build again should be succeeded.
    - if build succeeded now choose your device ![Screenshot 2024-02-22 at 4 26 55 PM](https://github.com/AhmedMa7rous/MarvelApp/assets/33738409/a3a7c5a4-5f50-43bd-b16b-c442ec56b75b)

- Then hit run button OR press <kbd>cmd</kbd> + <kbd>R</kbd>

## Requirements CheckList

- [x] Splash animation.
- [x] Pagination works fine on the Character List screen.
- [x] Using available data from the Character List when navigating to the details screen.
- [x] Search for characters by name.
- [x] Fetch images for the (comics/series/stories/events sections) from the resource URL.
- [ ] Images of (comics/series/stories/events sections) should be clickable to be viewed as a full-screen gallery view.
- [ ] image detail gallery should appear and scroll to the selected image.
- [ ] Users can swipe right or left in the Image detail gallery.

## Solution Steps
### Linting
I used code linting in this task, this what I made:
- Naming: used [camel Case style](https://en.wikipedia.org/wiki/Camel_case).
    - Functions Naming: should start with verb that explain it's role. 
    - Functions Body: should be 7 or 9 lines or depending on the case if it exceed should split the code to 2 functions.
- Architecture: MVVM.
- Software Development Methodologies: Agile Methodologies (SRUM Methodology)
- Version Control: Github.
    - Each commit message in this task repo contains two parts.
        - The first is Jira Task story ID.
        - The second is name of the task.

### Agile Methodology
They said that "Success comes from good planning" and after reading and understanding it, I decided to plan well for solve the task here's my solution steps in detail:
1. I used Jira Software for this task you can check the [jira project](https://marvel-app.atlassian.net/jira/software/projects/SCRUM/boards/1/backlog?atlOrigin=eyJpIjoiNzA2N2QzYWI1ZWY5NGQ1MmE4ZTA3NDY2YTRjZmQyZjQiLCJwIjoiaiJ9) in this task I Choosed SRUM Methodology.
2. Divide the project to stories tasks.
3. create project Backlog Stories.

### APIs:

- You can check this [Postman Collection](https://www.postman.com/gomini-app/workspace/public-workspace/collection/18620351-9c0d68f0-35fb-449d-97eb-75c47a2a3330?action=share&creator=18620351).



<h3 align="center"> Thanks </h3>
