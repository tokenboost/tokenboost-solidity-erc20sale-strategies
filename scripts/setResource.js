module.exports = async function (renderer, locale, key, value) {
    return await new Promise(async (resolve,) => {
        let prev = await renderer.resource(locale, key);
        if (prev.toString() !== value.toString()) {
            await renderer.setResource(locale, key, value);
        }
        resolve();
    });
};
