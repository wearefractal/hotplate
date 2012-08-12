
define(["vendor/vein"], function(Vein) {
  if (Vein == null) {
    return console.log("Vein not loaded");
  }
  return new Vein;
});
