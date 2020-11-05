export function verifyAddressRequestBody(address:any) {
    if (!address.city)
        throw new Error("Address City is required.");
    if (!address.country)
        throw new Error("Address Country is required.");
}