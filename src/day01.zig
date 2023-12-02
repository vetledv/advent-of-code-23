const std = @import("std");

const split = std.mem.split;
const dprint = std.debug.print;
const is_digit = std.ascii.isDigit;

const file = @embedFile("data/day01.txt");
const digit_strings = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn main() !void {
    var splits = split(u8, file, "\n");
    var part1_sum: u32 = 0;
    var part2_sum: u32 = 0;
    while (splits.next()) |line| {
        part1_sum += solver(line, false);
        part2_sum += solver(line, true);
    }
    dprint("day 01\n", .{});
    dprint("\t1: {d}\n", .{part1_sum});
    dprint("\t2: {d}\n", .{part2_sum});
}

fn solver(line: []const u8, is_part_two: bool) u8 {
    var first: ?u8 = null;
    var last: ?u8 = null;
    for (line, 0..) |c, i| {
        var digit: ?u8 = null;
        if (is_digit(c)) {
            digit = c - '0';
        } else if (is_part_two) {
            for (digit_strings, 1..) |dstr, pos| {
                if (std.mem.startsWith(u8, line[i..], dstr)) {
                    digit = @intCast(pos);
                }
            }
        }
        if (digit) |d| {
            if (first == null) {
                first = d * 10;
            }
            last = d;
        }
    }
    return first.? + last.?;
}
