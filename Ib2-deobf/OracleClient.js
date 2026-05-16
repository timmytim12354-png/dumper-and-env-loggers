const OracleClient = {
    decompile: async (bytecode) => { // bytecode must be encoded via base64
        if(!this.key) throw new Error("Missing key.");

        const options = {};
        
        const body = {
            script: bytecode,
            decompilerOptions: options
        };
        
        try {
            const url = `https://oracle.mshq.dev/decompile?key=${this.key}&version=2`
            const Body = JSON.stringify(body)
            let response;
            if (!this.url) response = await fetch(url, {
                method: "POST",
                body: Body,
                headers: {
                    'Content-Type': 'application/json'
                }
            }); else {
                response = await fetch(this.url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({udcheck: "hello123", url: url, method: "POST", content: Body})
                })
            }

            return response
        } catch (error) {
            if (error.response) {
                throw new Error(`Failed to decompile: ${error.response.status}`);
            }
            throw new Error('Failed to decompile');
        }
    },
    setKey: (key) => this.key = key,
    setApiUrl: (url) => this.url = url
}

module.exports = OracleClient;