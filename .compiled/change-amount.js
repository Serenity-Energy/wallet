// Generated by LiveScript 1.5.0
(function(){
  var ref$, times, minus, plus, div, changeAmount;
  ref$ = require('./math.ls'), times = ref$.times, minus = ref$.minus, plus = ref$.plus, div = ref$.div;
  changeAmount = function(store, amountSend){
    var send, wallet, resultAmountSend, sendUsd;
    send = store.current.send;
    wallet = send.network.wallet;
    send.amountSend = amountSend != null ? amountSend : "";
    resultAmountSend = amountSend != null ? amountSend : 0;
    send.value = times(resultAmountSend, Math.pow(10, send.network.decimals));
    sendUsd = times(resultAmountSend, wallet.usdRate);
    send.amountObtain = minus(resultAmountSend, send.network.txFee);
    send.amountObtainUsd = times(send.amountObtain, wallet.usdRate);
    send.amountSendUsd = sendUsd;
    send.amountSendFee = send.network.txFee;
    send.amountSendFeeUsd = times(send.network.txFee, wallet.usdRate);
    return send.error = parseFloat(minus(wallet.balance, resultAmountSend)) < 0 ? "Not Enough Funds" : "";
  };
  module.exports = changeAmount;
}).call(this);