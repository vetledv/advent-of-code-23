const std = @import("std");

const file = @embedFile("data/day01.txt");
const split = std.mem.split;
const dprint = std.debug.print;

pub fn main() !void {
    var splits = split(u8, file, "\n");
    var part1_sum: u32 = 0;
    while (splits.next()) |line| {
        part1_sum += part1(line);
    }
    dprint("day 01\n", .{});
    dprint("part 1: {d}\n", .{part1_sum});
}

fn part1(line: []const u8) u8 {
    var first: ?u8 = null;
    var last: ?u8 = null;
    for (line) |c| {
        if (std.ascii.isDigit(c)) {
            const digit = c - '0';
            if (first == null) {
                first = digit * 10;
            }
            last = digit;
        }
    }
    return first.? + last.?;
}
