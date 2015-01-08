#!/usr/bin/perl -I./lib/

use Test::Harness;

runtests(
    't/core/context.t',
    't/core/expression.t',
    't/core/loader.t',
    't/core/template.t',
    't/expression/in.t',
    't/expression/defined.t',
    't/filter/add.t',
    't/filter/addslashes.t',
    't/filter/capfirst.t',
    't/filter/center.t',
    't/filter/cut.t',
    't/filter/date.t',
    't/filter/default.t',
    't/filter/default_if_none.t',
    't/filter/dictsort.t',
    't/filter/dictsortreversed.t',
    't/filter/divisibleby.t',
    't/filter/escape.t',
    't/filter/escapejs.t',
    't/filter/filesizeformat.t',
    't/filter/first.t',
    't/filter/floatformat.t',
    't/filter/get_digit.t',
    't/filter/iriencode.t',
    't/filter/join.t',
    't/filter/last.t',
    't/filter/length.t',
    't/filter/length_is.t',
    't/filter/linebreaks.t',
    't/filter/linebreaksbr.t',
    't/filter/linenumbers.t',
    't/filter/ljust.t',
    't/filter/lower.t',
    't/filter/make_list.t',
    't/filter/phone2numeric.t',
    't/filter/pluralize.t',
    't/filter/random.t',
    't/filter/removetags.t',
    't/filter/reverse.t',
    't/filter/rjust.t',
    't/filter/safe.t',
    't/filter/safeseq.t',
    't/filter/slice.t',
    't/filter/slugify.t',
    't/filter/stringformat.t',
    't/filter/striptags.t',
    't/filter/time.t',
    't/filter/timesince.t',
    't/filter/timeuntil.t',
    't/filter/upper.t',
    't/filter/urlencode.t',
    't/tag/autoescape.t',
    't/tag/comment.t',
    't/tag/cycle.t',
    't/tag/debug.t',
    't/tag/filter.t',
    't/tag/firstof.t',
    't/tag/firstofdefined.t',
    't/tag/for.t',
    't/tag/if.t',
    't/tag/ifchanged.t',
    't/tag/ifequal.t',
    't/tag/ifnotequal.t',
    't/tag/include.t',
    't/tag/load.t',
    't/tag/now.t',
    't/tag/regroup.t',
    't/tag/spaceless.t',
    't/tag/ssi.t',
    't/tag/templatetag.t',
    't/tag/url.t',
    't/tag/verbatim.t',
    't/tag/widthratio.t',
    't/tag/with.t',
);