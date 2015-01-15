#!/usr/bin/perl
use strict; use warnings FATAL => 'all'; 
use Test::More;

use DTL::Fast qw(get_template select_template);

my $dirs = ['./t/tmpl'];
my $dirs2 = [@$dirs, './t/tmpl2'];

my( $template, $test_string);

$template = get_template('simple.txt', 'dirs' => $dirs);
isa_ok($template, 'DTL::Fast::Template');
my $chunks = $template->{'chunks'};
isa_ok($chunks, 'ARRAY', 'Chunks generated');
my $chunk = $chunks->[0];
isa_ok($chunk, 'DTL::Fast::Template::Text', 'Text element');
is($chunk->render, 'simple', 'Simple template loading');

$test_string = <<'_EOT_';
This is a parent main text

This is a parent more text
_EOT_
$template = get_template('parent.txt', 'dirs' => $dirs);
isa_ok($template, 'DTL::Fast::Template');
is($template->render, $test_string, 'Parent template loading');

$test_string = <<'_EOT_';
Child main text

This is a parent more text
_EOT_
$template = get_template('child0.txt', 'dirs' => $dirs);
isa_ok($template, 'DTL::Fast::Template');
is($template->render, $test_string, 'One-level of inheritance, first block');

$test_string = <<'_EOT_';
This is a parent main text

Child more text
_EOT_
$template = get_template('child1.txt', 'dirs' => $dirs);
isa_ok($template, 'DTL::Fast::Template');
is($template->render, $test_string, 'One-level of inheritance, second block');

$test_string = <<'_EOT_';
Child main text

Child more text
_EOT_
$template = get_template('child2.txt', 'dirs' => $dirs);
isa_ok($template, 'DTL::Fast::Template');
is($template->render, $test_string, 'Two-level of inheritance, both blocks');

$template = get_template('child0.txt', 'dirs' => $dirs);

is( $DTL::Fast::TEMPLATES_CACHE_HITS, 3, 'Templates cache');
is( $DTL::Fast::OBJECTS_CACHE_HITS, 1, 'Objecst cache');

$template = get_template('simple2.txt', 'dirs' => $dirs2);
is( $template->render, 'simple2-text', 'Multiple directories search');

$test_string = <<'_EOT_';
This is a parent main text

Override from another directory
_EOT_
$template = get_template('childother.txt', 'dirs' => $dirs2);
is( $template->render, $test_string, 'Cross-directory inheritance');

$template = select_template(['simple3.txt', 'simple.txt'], 'dirs' => $dirs2);
is( $template->render, 'simple3-text', 'Multi-directory template selecting, backward');

$template = select_template(['simple.txt', 'simple3.txt'], 'dirs' => $dirs2);
is( $template->render, 'simple', 'Multi-directory template selecting, forward');

eval{ $template = get_template('orphan.txt', 'dirs' => $dirs2 )};
ok( $@ =~ /_missing_parent\.txt/, 'Missing parent exception');

eval{$template = get_template('badinclude.txt', 'dirs' => $dirs2 )->render};
ok( $@ =~ /_missing_include\.txt/, 'Missing include exception');

eval{$template = get_template('inherit_recursive0.txt', 'dirs' => $dirs2 )->render};
ok( $@ =~ /Recursive inheritance detected/, "Recursive inheritance");

eval{$template = get_template('include_recursive0.txt', 'dirs' => $dirs2 )->render};
ok( $@ =~ /Recursive inclusion detected/, "Recursive inclusion");

$test_string = <<'_EOT_';
This is level 0
This is level 1
This is level 2
_EOT_

$template = get_template('included_lvl_2.txt', 'dirs' => $dirs2);
is( $template->render, $test_string, 'Multi-level inheritance with blocks extension');

done_testing();
