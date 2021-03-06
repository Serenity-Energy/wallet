// Generated by LiveScript 1.6.0
(function(){
  var ref$, observable, toJS, each, map, pairsToObj, getTransactions, run, task, transactions, same, extend, addTransaction, buildLoader, loadAllTransactions, out$ = typeof exports != 'undefined' && exports || this;
  ref$ = require('mobx'), observable = ref$.observable, toJS = ref$.toJS;
  ref$ = require('prelude-ls'), each = ref$.each, map = ref$.map, pairsToObj = ref$.pairsToObj;
  getTransactions = require('./api.ls').getTransactions;
  ref$ = require('./workflow.ls'), run = ref$.run, task = ref$.task;
  out$.transactions = transactions = observable([]);
  same = function(x, y){
    return (x != null ? typeof x.toUpperCase == 'function' ? x.toUpperCase() : void 8 : void 8) === (y != null ? typeof y.toUpperCase == 'function' ? y.toUpperCase() : void 8 : void 8);
  };
  extend = curry$(function(arg$, tx){
    var address, coin;
    address = arg$.address, coin = arg$.coin;
    tx.type = (function(){
      switch (false) {
      case !same(tx.to, address):
        return 'IN';
      default:
        return 'OUT';
      }
    }());
    return tx.token = coin.token;
  });
  addTransaction = function(tx){
    return transactions.push(tx);
  };
  buildLoader = function(wallet){
    return task(function(cb){
      var address, network, coin;
      address = wallet.address, network = wallet.network, coin = wallet.coin;
      return getTransactions({
        address: address,
        network: network,
        token: coin.token
      }, function(err, data){
        if (err != null) {
          return cb();
        }
        each(addTransaction)(
        each(extend({
          address: address,
          coin: coin
        }))(
        data));
        return cb();
      });
    });
  };
  out$.loadAllTransactions = loadAllTransactions = function(store, cb){
    var wallets, loaders, tasks;
    transactions.length = 0;
    wallets = store.current.account.wallets;
    loaders = map(buildLoader)(
    wallets);
    tasks = pairsToObj(
    map(function(it){
      return [loaders.indexOf(it).toString(), it];
    })(
    loaders));
    return run([tasks]).then(cb);
  };
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
