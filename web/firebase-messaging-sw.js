importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");
const firebaseConfig = {
        apiKey: "AIzaSyD0oWpmKczpKrHlwJUDcCnp1Ut8wIziTVo",
        authDomain: "testweb-66f9a.firebaseapp.com",
        projectId: "testweb-66f9a",
        storageBucket: "testweb-66f9a.appspot.com",
        messagingSenderId: "593934203257",
        appId: "1:593934203257:web:eb1b85f0ed0485a284d7a8",
        measurementId: "G-R7EED08BC0"
    };
firebase.initializeApp(firebaseConfig);
// Necessary to receive background messages:
const messaging = firebase.messaging();
// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage...manish", m);
});
