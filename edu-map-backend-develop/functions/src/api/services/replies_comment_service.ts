import { Service } from "./service";
import { ReplyCommentRepository } from "../repositories/replies_comment_repository";
import { REPLIESCOMMENT_NOT_FOUND } from "../../core/exceptions/messages";
import { documentSnapshotToReplyCommentEntity, querySnapshotToArrayReplyComments } from "../utils/replies_comment_utils";
import { DocumentReference } from "@google-cloud/firestore";
import { ReplyCommentModel } from "../../core/models/comment_model";

const replyCommentRepository=new ReplyCommentRepository();

export class ReplyCommentService extends Service<ReplyCommentEntity,ReplyCommentModel>{

    async getById(idReply: string): Promise<ReplyCommentModel> {
        const resultReplyComment = await replyCommentRepository.getById(idReply);
        if (!resultReplyComment.exists) {
            throw new Error('ReplyComment - ' + REPLIESCOMMENT_NOT_FOUND)
        }
        const replyComment = documentSnapshotToReplyCommentEntity(resultReplyComment);
        return new ReplyCommentModel(idReply,replyComment);
    }

    async getRepliesComment(idComment:string):Promise<ReplyCommentModel[]>{
        return querySnapshotToArrayReplyComments(await replyCommentRepository.getRepliesComment(idComment));
    }

    async getAll(): Promise<ReplyCommentModel[]> {
        return querySnapshotToArrayReplyComments(await replyCommentRepository.getAll());
    }

    async post(reply: ReplyCommentEntity): Promise<string> {
        const docRef:DocumentReference=await replyCommentRepository.post(reply);
        return docRef.id;
    }

    async update(idReply: string, reply:any): Promise<string> {
        return await replyCommentRepository.update(idReply,reply);
    }
    
    async remove(idReply: string): Promise<string> {
        return await replyCommentRepository.remove(idReply);
    }

}