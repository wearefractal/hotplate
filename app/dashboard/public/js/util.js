define(function() {
  return {
    readableSize: function(size) {
      var i, units;
      units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      i = 0;
      while (size >= 1024) {
        size /= 1024;
        ++i;
      }
      return "" + (Math.floor(size.toFixed(1))) + " " + units[i];
    },
    prettySeconds: function(secs) {
      var days, hours, minutes, out, seconds;
      days = Math.floor(secs / 86400);
      hours = Math.floor((secs % 86400) / 3600);
      minutes = Math.floor(((secs % 86400) % 3600) / 60);
      seconds = ((secs % 86400) % 3600) % 60;
      out = "";
      if (days > 0) {
        out += "" + days + " days ";
      }
      if (hours > 0) {
        out += "" + hours + " hours ";
      }
      if (minutes > 0) {
        out += "" + minutes + " minutes";
      }
      if (seconds > 0 && days <= 0) {
        out += " " + seconds + " seconds";
      }
      return out;
    }
  };
});