// Generated by LiveScript 1.6.0
(function(){
  var bignumber, ref$, map, pairsToObj, math;
  bignumber = require('bignumber.js');
  ref$ = require('prelude-ls'), map = ref$.map, pairsToObj = ref$.pairsToObj;
  math = function($){
    return function(x, y){
      var err;
      try {
        return new bignumber(x)[$](y).toString();
      } catch (e$) {
        err = e$;
        throw x + " " + $ + " " + y + " = " + err;
      }
    };
  };
  module.exports = pairsToObj(
  map(function(it){
    return [it, math(it)];
  })(
  ['plus', 'minus', 'times', 'div']));
}).call(this);
