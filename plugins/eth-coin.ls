require! {
    \../../config.json : { eth-net },
    \../../blockchain/config.json
}
current = config[eth-net]
export mainnet =
    decimals: 18
    tx-fee: \0.0014
    message-prefix: 'Ethereum'
    mask: \0x0000000000000000000000000000000000000000
    api:
        provider: \eth
        web3Provider : \https://mainnet.infura.io/UoCkF4efTrbEGU8Qpcs0
        url : \https://etherscan.io
        apiUrl : \https://api.etherscan.io/api
export ethnamed =
    decimals: 18
    tx-fee: \0.0014
    message-prefix: 'Ethereum'
    mask: \0x0000000000000000000000000000000000000000
    api:
        provider: \eth
        web3Provider : \http://ethnamed.io:9000
        url : \http://ethnamed.io:8000
        apiUrl : \http://ethnamed.io:8000/api
export ropsten =
    decimals: 18
    tx-fee: \0.0014
    message-prefix: 'Ethereum'
    mask: \0x0000000000000000000000000000000000000000
    api:
        provider: \eth
        web3Provider : current.web3Provider
        url : current.etherscanBaseUrl
        apiUrl : current.apiUrl
export testnet = ropsten
export type = \coin    
export enabled = yes
export token = \eth
export image = \./res/eth-ethnamed.png
export usd-info = "url(https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DASH,XEM&tsyms=USD).ETH.USD"