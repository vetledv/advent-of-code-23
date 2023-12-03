const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

const dprint = std.debug.print;

const file = @embedFile("data/day02.txt");

const Game = struct {
    r: u32,
    g: u32,
    b: u32,

    const Self = @This();

    fn is_possible(self: Self) bool {
        return self.r <= 12 and self.g <= 13 and self.b <= 14;
    }
    fn parse(line: []const u8) !Self {
        var game = Self{ .r = 0, .g = 0, .b = 0 };
        var rgb = mem.splitSequence(u8, line, ", ");
        while (rgb.next()) |cc| {
            var cn = mem.splitSequence(u8, cc, " ");
            const num = fmt.parseInt(u16, cn.next().?, 10) catch 0;
            const color = cn.next().?;
            if (mem.eql(u8, color, "red")) {
                game.r = num;
            } else if (mem.eql(u8, color, "green")) {
                game.g = num;
            } else if (mem.eql(u8, color, "blue")) {
                game.b = num;
            }
        }
        return game;
    }
};

pub fn main() !void {
    var splits = mem.splitSequence(u8, file, "\n");
    var part1_sum: u32 = 0;
    while (splits.next()) |line| {
        var _line = line;
        //kill me, delete windows
        if (@import("builtin").os.tag == .windows) {
            _line = mem.trimRight(u8, line, "\r");
        }
        var parts = mem.splitSequence(u8, _line, ": ");
        const id = fmt.parseInt(u16, parts.next().?[5..], 10) catch 0;
        var games = mem.splitSequence(u8, parts.next().?, "; ");
        var possible: bool = true;
        while (games.next()) |game| {
            const g = try Game.parse(game);
            if (!g.is_possible()) {
                possible = false;
            }
        }
        if (possible) {
            part1_sum += id;
        }
    }
    dprint("day 02\n", .{});
    dprint("\t1: {d}\n", .{part1_sum});
}
