import { TOKEN_SECRET } from "../exceptions/messages";
import { UserModel } from "../models/user_model";

const jwt = require('jsonwebtoken');

export function createToken(userModel:UserModel) {
    return 'Bearer '+jwt.sign(
        {
            id:userModel.idUser,
            username:userModel.username,
            role:userModel.role
        },
        TOKEN_SECRET,
        {
            expiresIn:864000,
        }
    );
}

