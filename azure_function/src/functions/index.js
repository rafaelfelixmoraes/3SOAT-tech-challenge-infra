module.exports = async function (context, req) {
    context.log(`Consultando dados do endereço para o CEP: ${req.query.cep}`);
    
    const requestTest = await fetch(`https://viacep.com.br/ws/${req.query.cep}/json`);

    const responseTest = await requestTest.json();

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: responseTest
    };
}