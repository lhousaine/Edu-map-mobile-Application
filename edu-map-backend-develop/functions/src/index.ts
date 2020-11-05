import * as functions from 'firebase-functions';
import * as bodyParser from "body-parser";
import * as express from 'express';
import * as cors from 'cors';
import admin from './admin';
import { SCHOOL_API_COLLECTION_NAME, REPLIESCOMMENT_API_COLLECTION_NAME, COMMENT_API_COLLECTION_NAME } from './core/exceptions/messages';
import { documentSnapshotToCommentEntity } from './api/utils/comment_utils';


const schoolsCollection = SCHOOL_API_COLLECTION_NAME;
const commentsCollection = COMMENT_API_COLLECTION_NAME;
const replies_commentCollection = REPLIESCOMMENT_API_COLLECTION_NAME;

export const db = admin.firestore();

const app = express();
const main = express();

main.use('/api/v0', app);
main.use(bodyParser.json());
app.use(cors({ origin: true }));

const userRouter = require('./api/web/users');
const schoolRouter = require('./api/web/schools');

// ROUTES
app.use('/users', userRouter);
app.use('/schools', schoolRouter);

export const mainApi = functions.https.onRequest(main);

export const onSchoolRatingUpdate=functions.firestore
.document('/schools/{id}')
.onUpdate(async (change,context)=>{
    if(!change.after)
          return null;
    else{
        const before=change.before.data();
        const after = change.after.data();
        if(before.globalRating.level1===after.globalRating.level1
            && before.globalRating.level2===after.globalRating.level2
            && before.globalRating.level3===after.globalRating.level3 
            && before.globalRating.level4===after.globalRating.level4 
            && before.globalRating.level5===after.globalRating.level5 ){
              return null;
       }else{
        const docRef=db.collection(schoolsCollection).doc(context.params.id);
        const newrating=calculeRating(after.globalRating);
        await docRef.update({rating:newrating});
        return docRef.id;
    }
    }
});

function calculeRating(globalRating:GlobalRatingEntity){
    const levelRating=globalRating.level1*1+globalRating.level2*2+ globalRating.level3*3+globalRating.level4*4+globalRating.level5*5;
    const NbreRating=globalRating.level1+globalRating.level2+globalRating.level3+globalRating.level4+globalRating.level5;
    let newrating=levelRating/NbreRating;
    if(newrating>Math.floor(newrating)+0.7)
        newrating=Math.ceil(newrating);
    else if(newrating<Math.floor(newrating)+0.3)
        newrating=Math.floor(newrating);
    else
        newrating=Math.floor(newrating)+0.5;
    return newrating;
}

export const onSchoolRemoved=functions.firestore
.document('/schools/{id}')
.onDelete(async (change,context)=>{ 
    const docRef = db.collection(commentsCollection).where('idSchool','==',context.params.id);
        docRef.get().then(function(querySnapshot) {
            querySnapshot.forEach(function(doc) {
            doc.ref.delete();
           });
        });
});


export const onCommentAdded = functions.firestore
    .document('comments/{id}')
    .onCreate(async (snap, context) => {
        const comment = snap.data();
        const docRef=db.collection(schoolsCollection).doc(comment.idSchool);
        const school= await docRef.get();
        let grating=school.data().globalRating;
        const globalRating=add_delete_comment(grating,comment.rating,'add');
        await docRef.update({globalRating:globalRating});
    });

    
export const onCommentRemoved=functions.firestore
.document('/comments/{id}')
.onDelete(async (snap,context)=>{
    const comment = snap.data();
    const schoolRef=db.collection(schoolsCollection).doc(comment.idSchool);
    if(schoolRef){
        const school= await schoolRef.get();
        let gRating=school.data().globalRating;
        const globalRating=add_delete_comment(gRating,comment.rating,'delete');
        await schoolRef.update({globalRating:globalRating});
    }
    const docRef = db.collection(replies_commentCollection).where('idComment','==',context.params.id);
        docRef.get().then(function(querySnapshot) {
            querySnapshot.forEach(function(doc) {
            doc.ref.delete();
           });
        });
});

function add_delete_comment(grating,rating,oper:string){
    const isadd=(oper==='add'?true:false);
    switch(rating){
      case 1:
        grating.level1+=isadd?1:-1;
        break;
      case 2:
          grating.level2+=isadd?1:-1;
          break;
      case 3:
          grating.level3+=isadd?1:-1;
          break;
      case 4:
          grating.level4+=isadd?1:-1;
          break;
      case 5:
          grating.level5+=isadd?1:-1;
          break;
      default :
          return null;
  }
  return grating;
}

export const onReplyAdded = functions.firestore
    .document('replies/{id}')
    .onCreate(async (snap, context) => {
        replyTrigger(snap,'add');
    });

export const onReplyRemoved = functions.firestore
    .document('replies/{id}')
    .onDelete(async (snap, context) => {
        replyTrigger(snap,'delete');
});

async function replyTrigger(snap,operation:string){
        const reply=snap.data();
        const commentRef = db.collection(COMMENT_API_COLLECTION_NAME).doc(reply.idComment);
        const comment =documentSnapshotToCommentEntity(await commentRef.get());
        try{
        let newTotalReplies=0
        if(operation==='add')
            newTotalReplies = comment.totalReplies + 1;
        else if(operation==='delete')
            newTotalReplies = comment.totalReplies - 1;
        await commentRef.update({totalReplies:newTotalReplies});
        }catch(error){
            throw new Error('the comment was not exist');
        }
    }


