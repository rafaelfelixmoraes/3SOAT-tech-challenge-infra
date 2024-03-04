const { app } = require('@azure/functions');

app.http('checkin-request', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const tenantID = "d285340b-541c-4d60-b0a9-dac78335cef9";

        const formData = new URLSearchParams();
        formData.append("grant_type", "Client_Credentials");
        formData.append("client_id", "bb30276c-d0f8-4ab3-a99d-6efd4cede1f5");
        formData.append("client_secret", "FgT8Q~PIajZOO7sVA3i3I2UJOUheDNTi5X_F5cEE");
        
        const azureEntraRequest = await fetch(`https://login.microsoftonline.com/${tenantID}/oauth2/token`, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: formData.toString(),
        json: true
        });

        const azureToken = await azureEntraRequest.json();

            return { jsonBody: azureToken };
        }
});
