"use strict";

exports.toBytes = function(n) {
    return Array.from(new Uint8Array(new Float32Array([n]).buffer));
};
