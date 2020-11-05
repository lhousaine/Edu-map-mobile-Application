import {COMMENT_API_COLLECTION_NAME} from "../../core/exceptions/messages";
import { db } from "../..";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import { DocumentReference, QuerySnapshot} from "@google-cloud/firestore";
import {Repository} from "./repository";

const commentsCollection = COMMENT_API_COLLECTION_NAME;

export class CommentRepository extends Repository<CommentEntity>{
    
    async getById(idComment: string): Promise<DocumentSnapshot> {
        return await db.collection(commentsCollection).doc(idComment).get();
    }

    async getUserComments(owner:string,idSchool:string):Promise<QuerySnapshot>{
        return await db.collection(commentsCollection)
        .where('owner','==',owner)
        .where('idSchool','==',idSchool)
        .get();
    }

    async getSchoolComments(idSchool:string):Promise<QuerySnapshot>{
        return await db.collection(commentsCollection)
        .where('idSchool','==',idSchool)
        .get();
    }

    async getCommentReplies(request:Request,response:Response){

    }

    async getAll(): Promise<QuerySnapshot> {
        return await db.collection(commentsCollection).get();
    }

    async post(comment: CommentEntity): Promise<DocumentReference> {
        return await db.collection(commentsCollection).add(comment);
    }

    async update(idComment: string,comment: CommentEntity): Promise<string> {
        const docRef=db.collection(commentsCollection).doc(idComment);
        await db.collection(commentsCollection).doc().update(comment);
        return docRef.id;
    }

    async remove(idComment: string): Promise<string> {
        const docRef=db.collection(commentsCollection).doc(idComment);
        await db.collection(commentsCollection).doc(idComment).delete();
        return docRef.id;
    }

}