interface CommentEntity {
    idSchool:string;
    content: string,
    createdAt: string,
    owner: string,
    rating: number,
    totalReplies:number,
}

interface ReplyCommentEntity {
    idComment:string,
    content: string,
    createdAt: string,
    owner: string,
}
