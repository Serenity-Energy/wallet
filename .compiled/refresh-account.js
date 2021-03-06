// Generated by LiveScript 1.6.0
(function(){
  var newAccount, refreshWallet;
  newAccount = require('./new-account.ls');
  refreshWallet = require('./refresh-wallet.ls');
  module.exports = curry$(function(web3, store, cb){
    return newAccount(store, store.current.seed, function(err, account){
      if (err != null) {
        return cb(err);
      }
      store.current.account = account;
      return refreshWallet(web3, store, cb);
    });
  });
  function curry$(f, bound){
    var context,
    _curry = function(args) {
      return f.length > 1 ? function(){
        var params = args ? args.concat() : [];
        context = bound ? context || this : this;
        return params.push.apply(params, arguments) <
            f.length && arguments.length ?
          _curry.call(context, params) : f.apply(context, params);
      } : f;
    };
    return _curry();
  }
}).call(this);
