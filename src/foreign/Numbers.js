"use strict";

exports.toBytes = function(n) {
    return Array.from(new Uint8Array(new Float64Array([n]).buffer));
};
