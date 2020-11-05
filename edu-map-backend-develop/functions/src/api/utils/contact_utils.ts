export function verifyContactBodyRequest(contact:any){
if (!contact.phone)
    throw new Error("mail contact is required.");
if (!contact.email)
    throw new Error("phone contact is required.");
}