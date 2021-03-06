require! {
    \react
    \./tools.ls : { cut, money }
    \prelude-ls : { each }
    \./web3.ls
    \react-copy-to-clipboard : { CopyToClipboard }
    \./copied-inform.ls
    \./copy.ls
    \./round5.ls
}
#
.wallet
    $cards-height: 324px
    $pad: 20px
    $radius: 15px 
    position: relative
    cursor: pointer
    $card-height: 80px
    height: $card-height
    background: #fff
    $mt: 20px
    box-sizing: border-box
    border-radius: $radius
    margin-top: -$mt
    overflow: hidden
    transition: height .5s
    box-shadow: 0 -10px 24px 0 rgba(0,0,0,0.05)
    &:first-child
        margin-top: 0
        box-shadow: none
    &.over
        background: #CCC
    &.active
        background: #fff
        height: 135px
        >.wallet-middle
            display: inline-block
    >.wallet-top
        $card-top-height: 50px
        width: 100%
        color: #677897
        font-size: 14px
        text-align: center
        >*
            display: inline-block
            box-sizing: border-box
            vertical-align: top
            padding-top: 10px
            height: $card-top-height
        >.top-left
            width: 35%
            text-align: right
            >*
                display: inline-block
            >.img
                line-height: $card-top-height
                >img
                    vertical-align: top
                    max-width: 50px
                    $s: 35px
                    border-radius: $s
                    width: $s
                    height: $s
            >.info
                text-align: left
                margin-left: $pad / 2
                >.name
                >.price
                    font-weight: bold
                    width: 82px
                    overflow: hidden
                    text-overflow: ellipsis
        >.top-middle
            width: 30%
            text-align: center
            >.balance
                &:last-child
                    font-weight: bold
                    font-size: 13px
        >.top-right
            width: 35%
            padding-left: 35px
            text-align: left
            >button
                outline: none
                margin-top: 5px
                cursor: pointer
                border: 0
                border-radius: 20px
                width: 75px
                height: 30px
                color: #6CA7ED
                text-transform: uppercase
                font-weight: bold
                background: #FFFFFF
                box-shadow: 0 2px 9px 0 rgba(184,184,184,0.50)
                transition: all .5s
                &:hover
                    background: #7aa7f3
                    color: white
    >.wallet-middle
        $card-top-height: 50px
        width: 100%
        color: #677897
        font-size: 14px
        margin-top: 10px
        text-align: center
        position: relative
        >img
            position: absolute
            right: 20px
            margin: 12px
        >a
            width: 90%
            position: relative
            border-radius: 20px
            border: 0
            background: #E6F0FF
            box-sizing: border-box
            vertical-align: top
            text-align: left
            padding-left: 20px
            padding-right: 25px
            height: $card-top-height - 14px
            color: #677897
            font-size: 14px
            line-height: $card-top-height - 14px
            display: inline-block
            text-overflow: ellipsis
            overflow: hidden
module.exports = (store, wallets, wallet)-->
    index = wallets.index-of wallet
    type = 
        | index is 0 => \top
        | index + 1 is wallets.length => \bottom
        | _ => \middle
    return null if not store? or not wallet?
    lweb3 = web3(store)
    address-label = 
        | wallet.coin.token is \xem => \account
        | _ => \address
    send = (wallet, event)-->
        return alert "Not yet loaded" if not wallet?
        { send-transaction } = lweb3[wallet.coin.token]
        to = ""
        value = 0
        err <- send-transaction { to, value }
        console.log err if err?
    usd-rate = wallet?usd-rate ? 0
    expand = ->
        store.current.wallet-index = index
    active = if index is store.current.wallet-index then \active else ''
    balance = round5(wallet.balance) + ' ' + wallet.coin.token.to-upper-case!
    .wallet.pug(on-click=expand class="#{active}" key="#{wallet.coin.token}")
        .wallet-top.pug
            .top-left.pug
                .img.pug
                    img.pug(src="#{wallet.coin.image}")
                .info.pug
                    .name.pug PRICE
                    .price.pug $#{ money(usd-rate)}
            .top-middle.pug
                .balance.pug Balance
                .balance.pug #{ balance }
            .top-right.pug
                button.pug(on-click=send(wallet)) Open
        .wallet-middle.pug
            a.pug(target="_blank" href="#{wallet.network.api.url}/#{address-label}/#{wallet.address}") #{wallet.address}
            CopyToClipboard.pug(text="#{wallet.address}" on-copy=copied-inform(store))
                copy store