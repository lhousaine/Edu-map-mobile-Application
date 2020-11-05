import { Repository } from "./repository";
import { REPLIESCOMMENT_API_COLLECTION_NAME } from "../../core/exceptions/messages";
import { DocumentSnapshot, QuerySnapshot, DocumentReference } from "@google-cloud/firestore";
import { db } from "../..";

const repliesCommentCollection=REPLIESCOMMENT_API_COLLECTION_NAME;

export class ReplyCommentRepository extends Repository<ReplyCommentEntity>{

    async getById(idReply: string): Promise<DocumentSnapshot> {
        return await db.collection(repliesCommentCollection).doc(idReply).get();
    } 

    async getAll(): Promise<QuerySnapshot> {
        return await db.collection(repliesCommentCollection).get();
    }

    async getRepliesComment(idComment:string):Promise<QuerySnapshot>{
        return db.collection(repliesCommentCollection).where('idComment','==',idComment).get();
    }

    async post(reply: ReplyCommentEntity): Promise<DocumentReference> {
        return await db.collection(repliesCommentCollection).add(reply);
    }

    async update(idReply: string, reply:any): Promise<string> {
        const docRef=db.collection(repliesCommentCollection).doc(idReply);
        await docRef.update(reply);
        return docRef.id;
    }

    async remove(idReply: string): Promise<string> {
        const RefReplyComment=await db.collection(repliesCommentCollection).doc(idReply);
        if(!RefReplyComment)
           throw new Error('Reply does not exist');
        await RefReplyComment.delete();
        return RefReplyComment.id;
    }

}