import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Timestamp } from '@google-cloud/firestore';

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

admin.initializeApp();
const db = admin.firestore();

const DB_NAME = "prescriptions";

// To delete
// firestore:delete --all-collections --project reminder-53ebc
exports.createUser = functions.firestore
    .document('prescriptions/{userId}')
    .onCreate(async (snap, context) => {
        console.log("onCreate" + context.params.userId);

        const today = new Date();
        const date = today.getFullYear() + '-' + today.getMonth() + '-' + today.getDate();
        const creationDate = {
            "creationDate": date,
        };
        await snap.ref.set(creationDate, { merge: true });
    });


export const initDb = functions.https.onRequest(async (request, response) => {

    await db.collection(DB_NAME).doc().set({});
    response.end();

});


export const templateDb = functions.https.onRequest(async (request, response) => {
    const now = JSON.stringify(Timestamp.now());

    const prescriptions = {
        uid: {
            pills: {
                pillName: {
                    total: 0,
                    current: 0,
                    qtyToTake: 0,
                    remindAt: "e",
                    remindWhen: 0,
                    taken: false,
                },
            }
            ,
            events: {
                [now]: {
                    takenAll: false,
                    pills: {
                        pillName: {
                            totalDay: 0,
                            currentDay: 0,
                            qtyToTakeDay: 0,
                            remindAtDay: Date(),
                            remindWhenDay: 0,
                            takenDay: false,
                        },
                    },
                },
            },
        },

    };
    await db.collection(DB_NAME).doc().set(prescriptions);
    response.end();

});


