//The Computer Language Benchmarks Game
// https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

// Contributed by Peter Elek

// Algorithm lifted from C gcc #3 code by Mr Ledrug et al.

const std = @import("std");

pub fn A(i: u32, j: u32) f64 {
    return @intToFloat(f64, (i + j) * (i + j + 1) / 2 + i + 1);
}

pub fn dot(v: []f64, u: []f64, num: u32) f64 {
    var ind: u32 = 0;
    var sum: f64 = 0;

    while (ind < num) : (ind += 1) {
        sum += v[ind] * u[ind];
    }

    return sum;
}

pub fn mult_Av(in: []f64, out: []f64, n: u32) void {
    var i: u32 = 0;

    while (i < n) : (i += 1) {
        var sum: f64 = 0;
        var j: u32 = 0;
        while (j < n) : (j += 1) {
            sum += in[j] / A(i, j);
        }
        out[i] = sum;
    }
}

pub fn mult_Atv(in: []f64, out: []f64, n: u32) void {
    var i: u32 = 0;

    while (i < n) : (i += 1) {
        var sum: f64 = 0;
        var j: u32 = 0;
        while (j < n) : (j += 1) {
            sum += in[j] / A(j, i);
        }
        out[i] = sum;
    }
}

pub fn mult_AtAv(in: []f64, out: []f64, num: u32, tmp: []f64) void {
    mult_Av(in, tmp, num);
    mult_Atv(tmp, out, num);
}

pub fn get_num() !u32 {
    //set allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    //get the main args
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const c = @cImport({
        @cInclude("stdlib.h");
    });

    if (args.len > 1) {
        //cast the input and use atoi from stdlib.h
        return @intCast(u32, c.atoi(args[1]));
    } else {
        return 0;
    }
}

pub fn main() !void {

    //set stdout
    const stdout = std.io.getStdOut().writer();

    var num: u32 = try get_num();

    if (num <= 0) {
        num = 2000;
    }

    //try stdout.print("matrix_size:{d}\n", .{num});

    //set allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    //alloc memory
    var u: []f64 = try allocator.alloc(f64, num);
    var v: []f64 = try allocator.alloc(f64, num);
    var tmp: []f64 = try allocator.alloc(f64, num);

    // frees at the end of the block
    defer allocator.free(u);
    defer allocator.free(v);
    defer allocator.free(tmp);

    var ind: u32 = 0;
    while (ind < num) : (ind += 1) {
        u[ind] = 1;
    }
    ind = 0;
    while (ind < 10) : (ind += 1) {
        mult_AtAv(u, v, num, tmp);
        mult_AtAv(v, u, num, tmp);
    }

    try stdout.print("{d:.9}\n", .{std.math.sqrt(dot(u, v, num) / dot(v, v, num))});
}
