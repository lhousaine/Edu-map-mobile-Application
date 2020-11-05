import { QuerySnapshot, DocumentSnapshot } from "@google-cloud/firestore";
import { ReplyCommentModel} from "../../core/models/comment_model";

export function buildResponseReplyComment(replycomment:ReplyCommentModel):ReplyCommentModel{
    return {
        idReply: replycomment.idReply,
        idComment:replycomment.idComment,
        content:replycomment.content,
        createdAt:replycomment.createdAt,
        owner:replycomment.owner
    }
}

export function documentSnapshotToReplyCommentEntity(resultReplyComment:DocumentSnapshot){
    return {
        idComment:resultReplyComment.data()!.idComment,
        content: resultReplyComment.data()!.content,
        createdAt: resultReplyComment.data()!.createdAt,
        owner: resultReplyComment.data()!.owner,
    };
 }

 export function querySnapshotToArrayReplyComments(q:QuerySnapshot):ReplyCommentModel[]{
    const repliesComment: ReplyCommentModel[] = [];
    q.forEach(
      (resultReplyComment) => {
       const replyCommentModel: ReplyCommentModel = new ReplyCommentModel(resultReplyComment.id,
                                                    documentSnapshotToReplyCommentEntity(resultReplyComment));
        repliesComment.push(
           buildResponseReplyComment(replyCommentModel)
        );
      }
    );
    return repliesComment;
}

export function verifyCommentReplayRequestBody(request: any) {
    if (!request.body.content)
        throw new Error("comment content is required.");
    if (!request.body.createdAt)
        throw new Error("reply creation date is required.");
    if (!request.body.owner)
        throw new Error("comment owner is required.");
}