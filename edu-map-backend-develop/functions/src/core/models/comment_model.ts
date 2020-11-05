export class CommentModel {
    idComment: string;
    idSchool:string;
    content:string;
    createdAt: string;
    owner: string;
    rating: number;
    totalReplies:number;
    constructor(idComment: string, comment: CommentEntity){
        this.idComment =idComment;
        this.idSchool=comment.idSchool;
        this.content=comment.content;
        this.createdAt=comment.createdAt;
        this.owner = comment.owner;
        this.rating = comment.rating;
        this.totalReplies=comment.totalReplies;
    }
}

export class ReplyCommentModel {
    idReply: string;
    idComment:string;
    content: string;
    createdAt:string;
    owner: string;

    constructor(idReply: string, commentReplay: ReplyCommentEntity) {
        this.idReply = idReply;
        this.idComment=commentReplay.idComment;
        this.content = commentReplay.content;
        this.createdAt = commentReplay.createdAt;
        this.owner = commentReplay.owner;
    }
    
}