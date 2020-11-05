import { DocumentSnapshot, QuerySnapshot } from "@google-cloud/firestore";
import { CommentModel } from "../../core/models/comment_model";

export function buildResponseComment(comment:CommentModel):CommentModel{
    return {
        idComment: comment.idComment,
        idSchool:comment.idSchool,
        content:comment.content,
        createdAt:comment.createdAt,
        owner:comment.owner,
        rating:comment.rating,
        totalReplies:comment.totalReplies,
    }
}

export function documentSnapshotToCommentEntity(resultComment:DocumentSnapshot){
    return {
        idSchool:resultComment.data()!.idSchool,
        content: resultComment.data()!.content,
        createdAt: resultComment.data()!.createdAt,
        owner: resultComment.data()!.owner,
        rating: resultComment.data()!.rating,
        totalReplies:resultComment.data()!.totalReplies,
    };
 }

 export function querySnapshotToArrayComments(q:QuerySnapshot):CommentModel[]{
    const comments: any[] = [];
    q.forEach(
      (resultComment) => {
       const commentModel: CommentModel = new CommentModel(resultComment.id,documentSnapshotToCommentEntity(resultComment));
        comments.push(
           buildResponseComment(commentModel)
        );
      }
    );
    return comments;
}

export function verifyCommentRequestBody(request: any) {
        if (!request.body.content)
            throw new Error("comment content is required.");
        if (!request.body.createdAt)
            throw new Error("comment creation date is required.");
        if (!request.body.owner)
            throw new Error("comment owner is required.");
        if (!request.body.rating)
            throw new Error("comment rating is required.");
}
