module.exports = async function (context, req) {
    context.log(`Obtendo token no Azure EntraID`);

    const tenantID = "xxxxx";

    const formData = new URLSearchParams();
    formData.append("grant_type", "Client_Credentials");
    formData.append("client_id", "xxxxx");
    formData.append("client_secret", "xxxxx");
    formData.append("scope", "https://aks-aad-server.azure.com/.default");
    
    const azureEntraRequest = await fetch(`https://login.microsoftonline.com/${tenantID}/oauth2/v2.0/token`, {
    method: "POST",
    headers: {
        "Content-Type": "application/x-www-form-urlencoded",
    },
    body: formData.toString(),
    json: true
    });

    const azureToken = await azureEntraRequest.json();

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: azureToken
    };
}