
define(["dermis"], function(dermis) {
  dermis.route('/');
  dermis.route('/boards');
  dermis.route('/board/:id');
  dermis.route('/board/:id/:page');
  dermis.route('/thread/:id');
  dermis.route('/thread/:id/:post');
  return dermis.init();
});
