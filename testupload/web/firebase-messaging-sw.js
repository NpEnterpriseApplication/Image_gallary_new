importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
     apiKey: "AIzaSyAUQFb9A4SQHVFnzqbGlWol1VZBB22tS7Y",
      authDomain: "image-galary-cd036.firebaseapp.com",
      projectId: "image-galary-cd036",
      storageBucket: "image-galary-cd036.appspot.com",
      messagingSenderId: "467540600447",
      appId: "1:467540600447:web:f756de990873fd019c014a",
      measurementId: "G-Z2R01D9CJ7"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});