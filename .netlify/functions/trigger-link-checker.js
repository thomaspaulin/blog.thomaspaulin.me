exports.handler = async function(event, context) {
    console.log("I'm server logic");
    return {
        statusCode: 200
    };
}
