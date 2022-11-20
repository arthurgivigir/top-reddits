# **Top Reddits**

## **iOS Code Challenge**
The goal is to implement a basic Top Reddits reader, with the features mentioned below. The API to get the all required Reddits data is specified below as well.

### Required Features
- List Top Reddits with thumbnails :white_check_mark:

- Pull to refresh Reddits :white_check_mark:

- Load more Reddits when reaching end of list :white_check_mark:

### Nice to have

- Support for different device resolutions and orientation :x:

- Display Reddit details (only for reddits with images in PNG and JPG format) :white_check_mark:

- Save Reddit image into photo library :white_check_mark:

Reddit API:
https://www.reddit.com/top.json

---

### Important Informations:
- XCode 14.1
- iOS 16.1.1
- MacOS Ventura 13.0
- Architecture: MVVM

---

### What I've done?
- I've implemented all the **required features** and two **nice to have**. 
- I've implemented some few testes to show how can I test a Mocked API and the transfomation between a model and an entity. The best scenario is implement all functionalities, but I was afraid to not delivery at time this challenge.
    - This test helped me to implement the service and to map the most needed elements from json.
- The images have been loaded and saved inside a local cache. I dind't implement a loading at the images, but I could complete the basic scenario.
- The details page can show a image and a link, if the user clicks on it, Safari will be opened loading the content.
- The details page can save the image if the user clicks on save button. This coverages only the success scenario.
