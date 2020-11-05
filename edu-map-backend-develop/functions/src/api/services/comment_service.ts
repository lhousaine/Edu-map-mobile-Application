import { Service } from "./service";
import { CommentRepository } from "../repositories/comment_repository";
import { COMMENT_NOT_FOUND } from "../../core/exceptions/messages";
import { documentSnapshotToCommentEntity, querySnapshotToArrayComments } from "../utils/comment_utils";
import { DocumentReference } from "@google-cloud/firestore";
import { CommentModel } from "../../core/models/comment_model";

const commentRepository=new CommentRepository();

export class CommentService extends Service<CommentEntity,CommentModel>{
    
    async getById(idComment: string): Promise<CommentModel> {
        const resultComment = await commentRepository.getById(idComment);
        if (!resultComment.exists) {
            throw new Error('Comment - ' + COMMENT_NOT_FOUND)
        }
        const comment = documentSnapshotToCommentEntity(resultComment);
        return new CommentModel(idComment,comment);
    }
    
    async getSchoolComments(id_school:string):Promise<CommentModel[]>{
        return querySnapshotToArrayComments(await commentRepository.getSchoolComments(id_school))
    }

    async getAll(): Promise<CommentModel[]> {
        return querySnapshotToArrayComments(await commentRepository.getAll());
    }
    
    async  isUserAlreadyRated(owner:string,idSchool:string):Promise<boolean> {
        const userQuerySnapshot=await commentRepository.getUserComments(owner,idSchool);
        if(userQuerySnapshot.empty)
            return false;
        else 
            return true;
    }

    async post(comment: CommentEntity): Promise<string> {
        if(await this.isUserAlreadyRated(comment.owner,comment.idSchool))
            throw new Error("you can't rate/comment more than one time");
        comment.totalReplies=0;
        const docRef:DocumentReference=await commentRepository.post(comment);
        return docRef.id;
    }

    async update(idComment: string, comment: CommentEntity): Promise<string> {
        return await commentRepository.update(idComment,comment);
    }
    
    async remove(idComment: string): Promise<string> {
        return await commentRepository.remove(idComment);
    }

}
