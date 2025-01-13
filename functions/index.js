/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendNotification = functions.firestore
  .document('notifications/{notificationId}')
  .onCreate(async (snap, context) => {
    try {
      const notification = snap.data();
      
      if (!notification.token) {
        console.error('Token bulunamadı');
        return null;
      }

      const message = {
        token: notification.token,
        notification: {
          title: notification.title,
          body: notification.body,
        },
        android: {
          priority: 'high',
          notification: {
            channelId: 'high_importance_channel',
            priority: 'high',
            defaultSound: true,
            defaultVibrateTimings: true,
          },
        },
        data: {
          senderId: notification.senderId || '',
        }
      };

      const response = await admin.messaging().send(message);
      console.log('Bildirim başarıyla gönderildi:', response);
      return { success: true, messageId: response };
    } catch (error) {
      console.error('Bildirim gönderme hatası:', error);
      return { success: false, error: error.message };
    }
  });
