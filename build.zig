const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Public package module. Consumers should import this as:
    // const zcrawl = @import("zcrawl");
    _ = b.addModule("zcrawl", .{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/lib.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_lib_tests = b.addRunArtifact(lib_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_lib_tests.step);

    // Keep tokenizer conformance tests isolated from unrelated DOM/DSL tests
    // imported by src/lib.zig.
    const token_module = b.createModule(.{
        .root_source_file = b.path("src/token.zig"),
        .target = target,
        .optimize = optimize,
    });
    const parse_error_module = b.createModule(.{
        .root_source_file = b.path("src/parse_error.zig"),
        .target = target,
        .optimize = optimize,
    });
    const named_character_reference_module = b.createModule(.{
        .root_source_file = b.path("src/namedCharacterReference.zig"),
        .target = target,
        .optimize = optimize,
    });
    const tokenizer_module = b.createModule(.{
        .root_source_file = b.path("src/tokenizer.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "token.zig", .module = token_module },
            .{ .name = "parse_error.zig", .module = parse_error_module },
            .{ .name = "namedCharacterReference.zig", .module = named_character_reference_module },
        },
    });

    const html5lib_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("test/tokenizer-html5lib.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "token.zig", .module = token_module },
                .{ .name = "parse_error.zig", .module = parse_error_module },
                .{ .name = "tokenizer", .module = tokenizer_module },
            },
        }),
    });
    const run_html5lib_tests = b.addRunArtifact(html5lib_tests);
    const html5lib_test_step = b.step("test-html5lib", "Run the tests from html5lib/html5lib-tests");
    html5lib_test_step.dependOn(&run_html5lib_tests.step);
}
