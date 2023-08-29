const OneSignal = window.OneSignal || [];
var player_id = '';
async function  getPredictions(input) {
var res = await calls(input);
console.log("this is from js file",res);
return JSON.stringify(res);
  }


function  getPlayerId() {
        return player_id;
  }

  window.onload = function(e){
//        console.log("window.onload", e, Date.now() ,window.tdiff);
//      onesingnalInit('a1994d85-6f98-47b1-ad8a-274f984d2475');
//       OneSignal.push(function () {
//              OneSignal.isPushNotificationsEnabled(function(isEnabled) {
//              console.log('push notification enable for web',isEnabled);
//                if (isEnabled) getUserId();
//              });
//              OneSignal.on('subscriptionChange', function (isSubscribed) {
//              console.log('subscriptionChange',isSubscribed);
//                if (isSubscribed) getUserId();
//
//              });
//            });
  }

  function onesingnalInit(appId) {
    var initConfig = {
          appId: appId,//"6e0261ea-252e-4935-86d0-b9479e0b8cc3",
          persistNotification: true,
          autoRegister: true, /* Set to true to automatically prompt visitors */
          httpPermissionRequest: {
              enable: true,
          },
          notificationClickHandlerMatch: 'origin',
          notificationClickHandlerAction: 'focus',
          notifyButton: {
              enable: false
          },
        };
        OneSignal.push(function () {
          OneSignal.init(initConfig);

        });
         OneSignal.push(function() {
                      OneSignal.push(["addListenerForNotificationOpened", function(value) {
                                    console.log('addListenerForNotificationOpened ',value);

                      }]);
                        OneSignal.on('notificationDisplay', function(data) {
                             console.log('notificationDisplay ',data);
                      });
                    });
  }

//   var eUserID = document.getElementById('osUserID');
      function getUserId() {
        OneSignal.getUserId(function(osUserID) {
        console.log('player id',osUserID);
          if (osUserID) {
          player_id = osUserID;
//            eUserID.value = osUserID;
            }
        });
      }












//    function getVideoCover(file, seekTo = 0.0) {
//        console.log("getting video cover for file: ", file);
//        return new Promise((resolve, reject) => {
//            // load the file to a video player
//            const videoPlayer = document.createElement('video');
//            videoPlayer.setAttribute('src', file);
//            videoPlayer.load();
//            videoPlayer.addEventListener('error', (ex) => {
//                reject("error when loading video file", ex);
//            });
//            // load metadata of the video to get video duration and dimensions
//            videoPlayer.addEventListener('loadedmetadata', () => {
//                // seek to user defined timestamp (in seconds) if possible
//                if (videoPlayer.duration < seekTo) {
//                    reject("video is too short.");
//                    return;
//                }
//                // delay seeking or else 'seeked' event won't fire on Safari
//                setTimeout(() => {
//                  videoPlayer.currentTime = seekTo;
//                }, 200);
//                // extract video thumbnail once seeking is complete
//                videoPlayer.addEventListener('seeked', () => {
//                    console.log('video is now paused at %ss.', seekTo);
//                    // define a canvas to have the same dimension as the video
//                    const canvas = document.createElement("canvas");
//                    canvas.width = videoPlayer.videoWidth;
//                    canvas.height = videoPlayer.videoHeight;
//                    // draw the video frame to canvas
//                    const ctx = canvas.getContext("2d");
//                    ctx.drawImage(videoPlayer, 0, 0, canvas.width, canvas.height);
////                    console.log('imag escreen shot ----',canvas.toDataURL("image/png", 1.0));
//                    console.log(canvas,ctx);
//                    var base64string = canvas.toDataURL("image/png", 1.0);
//                    var binary = atob(base64string.split(',')[1]);
//                     var array = [];
//                        for (var i = 0; i < binary.length; i++) {
//                            array.push(binary.charCodeAt(i));
//                        }
////                        console.log("this is array",array);
//                    // return the canvas image as a blob
//                    resolve(array);
//
//                });
//            });
//        });
//    }