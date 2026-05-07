Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82ACD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FA724026D;
	Thu,  7 May 2026 04:54:57 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 8DCAB400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 04:54:56 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so696583eec.0
 for <dev@dpdk.org>; Wed, 06 May 2026 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778122495;
 x=1778727295; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=vkGDcCnpJbJxYT6aUXw89l+8MbuPg1KEXOQkI8DhjtQ=;
 b=OZbghYzLgk22hr0VxqQZdGtuYP2kr08EuJIZIx/6/OVY7mcqZ4KGwJGgxhq0OWhYMp
 BYs+uK9dGa+e2izYQnXwRaw9M0kiy+Ji6+444qA/WkU6l0tizco3zHNSeZtMJbiRleDa
 XAhJS0yk6oQtJeBo28kcTMSOzqtl8qASfWp78vv4dXnR1KnOfxreU5/SsBfQ+2lzbQ6i
 yyEhv+dmvdVUhz9QPM81mAGkt3kIvMabvt8WUthYnzgHHIiEy/uyUXygBQxY6x7kWoje
 1t407yVAHGlHDCJKlf9tymngACMGhKdI8ZeX68ms7eo9Wxs/5Z75jzlWy7/qhPWiFH+9
 UdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122495; x=1778727295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vkGDcCnpJbJxYT6aUXw89l+8MbuPg1KEXOQkI8DhjtQ=;
 b=iUOZC5Dw0Wj9/EZZqA+3hEefiOJ2uh+SRGHXbvcTqcVLCTnbgl3f6HfUtMcXEkpD8/
 9uErDsSI1SHtp2fE3heQPj0OvcWqom/ab4gEfhE1AMGRxprRPkwH8JWCx7ixnGkcqhEV
 K/yrM8csPCFUate+gLZiecZv/nc5Hu3+kbMXgx376bJ4gTTDMau9MajE+kGLuK/QxoBg
 OreqZFVp4SEfHRcYDX+CDf1VPNT4EBpbiTMxejDRKP8w/2/FR0a7l9G6EYW4WxZu9aeh
 waQWzRHSK7hRXxLNKUaWqP5hqRV4Oop3f9YmidTzi7oPCTV7RTh/teQK6+MMYC/q7CeL
 qWnw==
X-Gm-Message-State: AOJu0YykaqWrfMoW3U/LhcmDXSY3AuiiEKX2DdHsNlUcXAx53s62skI/
 Xw1zHc6dRxUaGZET+HtoX18k0zlhbhXzNK8s2ENygh8iWUdfiJPfjtyDAjkqAIWfS/XcZzaC15C
 l0yui
X-Gm-Gg: AeBDiesB7d+cq31m5HbC+JByDhl9786E+fAzSW4R5AiZDbH+FC0yOqTAIcxeX7ICkqk
 TChMfteTmK3MwJjthBG4E3yFrG796SBenSn+4QZmiUa7trTlBbz3jy89IkilieF/lKiQbuDTzvG
 hRuzp5K4XTcRlMrilbk+k9ED2iCmI+P4ZhbNwCXK946qhEGkmxzicWBWV4Gd0gQ3DX5Np5LJ7kV
 gFyFW+1epBhkiqVvzF7bh3qW8sN/0GOU+DNFmO/0Wy7gAClOCMUZiDf2pIWM/qo+Y8+trF9BqG+
 i9UcTDl+6F4vHOQdukKlQwFvMEigYkMK9HzvgzIYm9Rqa9eZr5XGCUW5XeoENvo/PSCLntE0XRM
 kKB1DgGZOj5XJbmERzdnnmapZWa6hBTHfgKUqoC/UZPKgENeO00aSpekduxqwTp5SG7lpqotmao
 xA8ws7MFtlhq5NCUughGXVJtT+1fhSyUKz2RQje2VACI9/J0rE36Kkbm53
X-Received: by 2002:a05:7300:a984:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-2f55034e59emr2738733eec.23.1778122495102; 
 Wed, 06 May 2026 19:54:55 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec593dsm6652107eec.6.2026.05.06.19.54.54
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:54:54 -0700 (PDT)
Date: Wed, 6 May 2026 19:54:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [RFC v2 0/4] flow_compile: textual flow rule compiler
Message-ID: <20260506195452.6875e00f@phoenix.local>
In-Reply-To: <20260507001501.608724-1-stephen@networkplumber.org>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Wed,  6 May 2026 17:06:47 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Background
> ----------
>=20
> Multiple efforts over the past few cycles have tried to make
> testpmd's flow rule grammar reusable from outside testpmd.
> External applications that need rte_flow want a documented way
> to turn human-written rules into the rte_flow_attr/item/action
> arrays accepted by rte_flow_create().
>=20
> The most recent attempt is Lukas Sismis's series, currently at
> v12:
>=20
>   http://patches.dpdk.org/project/dpdk/list/?series=3D37384
>=20
> That series factors testpmd's existing cmdline_flow.c into a
> library and updates testpmd to consume it.  It works, but
> inherits two properties of cmdline_flow.c that I think are worth
> avoiding in a reusable library:
>=20
>   - Coupling to librte_cmdline.  Even after the v12 split into
>     a "simple" part and a "cmdline" part, the parser is still
>     organized around testpmd's command interpreter, and v12 has
>     cmdline depending on ethdev to break a previous circular
>     dependency.  A library used by daemons, control planes, or
>     unit tests should not need that.
>=20
>   - Ad-hoc grammar.  cmdline_flow.c implements parsing per-token
>     in long dispatch logic; the grammar emerges from the code
>     rather than being stated, and adding a new flow item
>     requires touching the parser.
>=20
> This RFC explores a different shape and is posted to ask the
> list which one is preferred before more work goes into either.
>=20
> I started a new green-field library for parsing flow rules
> (with AI assistance for the boilerplate).  It is young but
> passes tests and reviews clean under the project's AI review
> guidelines.
>=20
> This series
> -----------
>=20
> lib/flow_compile -- a small new library providing the same
> service via a pcap_compile()-style API:
>=20
>     char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];
>     struct rte_flow_compile *fc =3D rte_flow_compile(rule, errbuf);
>     if (fc =3D=3D NULL)
>             fail(errbuf);            /* "line:col: message" */
>=20
>     rte_flow_compile_create(port_id, fc, &flow_error);
>     rte_flow_compile_free(fc);
>=20
> Design properties:
>=20
>   - Flex lexer plus bison grammar.  Both are reentrant
>     (%option reentrant, %define api.pure full), so multiple
>     compilations may run concurrently and the parser holds no
>     static mutable state.  The grammar itself is short
>     (~200 lines) because all per-type knowledge lives in
>     descriptor tables, not in productions.
>=20
>   - Parser is driven entirely by descriptor tables of items and
>     actions.  Adding a new flow item is a table edit, not a
>     grammar change.  A custom-setter hook on each field is the
>     escape valve for layouts that don't fit a plain byte range
>     (bitfields, indirect arrays).
>=20
>   - Dependencies: rte_ethdev (for rte_flow.h) and rte_net (for
>     MAC parsing).  No librte_cmdline.  Flex and bison are
>     required at build time to regenerate the lexer and parser;
>     if either tool is missing the library is silently skipped
>     via meson's has_flex_bison check, the same pattern other
>     DPDK components use for optional generators.
>=20
>   - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;
>     rte_flow_compile_free() walks the pattern and action arrays
>     and releases every non-NULL slot before freeing the arrays.
>     Parse-error paths use the same walker, so partially
>     constructed rules clean up uniformly.  ASan/LSan run clean
>     on the autotest, including the failure cases.
>=20
> The grammar follows testpmd's syntax closely so familiar rules
> carry over:
>=20
>     ingress pattern eth / ipv4 src is 10.0.0.1 / end
>     actions queue index 3 / count / end
>=20
> and is documented as a formal BNF in the programmer's guide
> chapter (patch 2).
>=20
> Initial coverage: eth, vlan, ipv4, ipv6, tcp, udp, vxlan,
> port_id, port_representor, represented_port items; drop,
> passthru, queue, mark, jump, count, port_id and representor
> variants, of_pop_vlan, vxlan_decap actions.  Variable-conf
> items and actions (RSS, RAW) need custom setters and are
> deferred to a follow-up.
>=20
> What this RFC is *not*
> ----------------------
>=20
> Not a replacement for cmdline_flow.c in testpmd.  If the shape
> here is acceptable, the next step is a separate series adding a
> "flow compile <port> <rule>" command in testpmd alongside the
> existing parser, so users can adopt the library incrementally
> without breaking scripts that depend on the current syntax.
>=20
> What I'd like feedback on
> -------------------------
>=20
> 1. API shape.  pcap_compile-style (one string -> opaque object ->
>    arrays) versus the three-call attr/pattern/actions form
>    Sismis's v12 exposes.  What does your application actually
>    want?
>=20
> 2. Library placement.  Stand-alone at lib/flow_compile/ versus
>    addition to lib/ethdev.  This series treats it as a
>    control-path parser layered on top of ethdev rather than
>    part of ethdev itself; v12 places its parser inside ethdev.
>=20
> 3. Table-driven extension model.  Is "to add a new flow item,
>    add a row to the descriptor table" the right contract?
>    Should the tables live alongside each rte_flow_item_*
>    definition in rte_flow.h, or in their own file as here?
>=20
> 4. Build-tool dependency.  Flex and bison are not currently
>    required to build DPDK.  Adding a library that needs them
>    (with a clean has_flex_bison fallback so the rest of DPDK
>    still builds without them) is the cleanest way I see to get
>    a real grammar. If this gets used by testpmd then
>    what is now an optional dependency would get hardened in.
>=20
> 5. Convergence.  If this design is preferred, I'm happy to
>    coordinate with Lukas to fold in the testpmd-side changes
>    from his series.
>=20
> 6. Readability. AI generated code like this tends to be
>    either opaque or too verbose for humans. Often have to
>    nudge it into submission.
>=20
>=20
> Stephen Hemminger (4):
>   config: add support for using flex and bison
>   flow_compile: introduce textual flow rule compiler
>   doc: add programmer's guide for flow rule compiler
>   test/flow_compile: add unit tests for flow rule compiler
>=20
>  MAINTAINERS                                |   7 +
>  app/test/meson.build                       |   1 +
>  app/test/test_flow_compile.c               | 255 ++++++++++
>  config/meson.build                         |  23 +
>  doc/guides/prog_guide/flow_compile_lib.rst | 302 ++++++++++++
>  doc/guides/prog_guide/index.rst            |   1 +
>  doc/guides/rel_notes/release_26_07.rst     |   6 +
>  lib/flow_compile/flow_compile.l            | 227 +++++++++
>  lib/flow_compile/flow_compile.y            | 311 +++++++++++++
>  lib/flow_compile/flow_compile_priv.h       | 127 +++++
>  lib/flow_compile/flow_compile_setters.c    | 516 +++++++++++++++++++++
>  lib/flow_compile/flow_compile_tables.c     | 243 ++++++++++
>  lib/flow_compile/meson.build               |  22 +
>  lib/flow_compile/rte_flow_compile.h        | 158 +++++++
>  lib/flow_compile/rte_flow_compile_api.c    | 160 +++++++
>  lib/meson.build                            |   1 +
>  16 files changed, 2360 insertions(+)
>  create mode 100644 app/test/test_flow_compile.c
>  create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
>  create mode 100644 lib/flow_compile/flow_compile.l
>  create mode 100644 lib/flow_compile/flow_compile.y
>  create mode 100644 lib/flow_compile/flow_compile_priv.h
>  create mode 100644 lib/flow_compile/flow_compile_setters.c
>  create mode 100644 lib/flow_compile/flow_compile_tables.c
>  create mode 100644 lib/flow_compile/meson.build
>  create mode 100644 lib/flow_compile/rte_flow_compile.h
>  create mode 100644 lib/flow_compile/rte_flow_compile_api.c
>=20

Interesting that CI AI review generates lots of false positives on this.
Think the CI infrastructure version of AGENTS.md is out of date,
or it is using a weak AI model.


Systematically debunked CI review false positives through code analysis
You're right =E2=80=94 the entire review is false positives, and several of=
 them violate the explicit rules in AGENTS.md. Walking through each item:

Patch 1/4 =E2=80=94 meson flex_gen / bison_gen initialization

Vague speculation phrased as a question ("Does the code need to..."). The v=
ariables are only referenced under if has_flex_bison (or equivalent) elsewh=
ere, which is exactly the pattern the snippet establishes. AGENTS.md forbid=
s "vague suggestions like 'should be verified' or 'should be checked'."

Patch 2/4 =E2=80=94 nul_terminate with buflen =3D=3D 0

False positive. If buflen =3D=3D 0 and srclen =3D=3D 0, then srclen >=3D bu=
flen is true (0 >=3D 0), so the function returns NULL without writing. Also=
, every call site uses sizeof(_buf) on a non-empty stack buffer, so buflen =
is never zero in practice. The function is safe both abstractly and in cont=
ext.

Patch 2/4 =E2=80=94 MAC validation before memcpy

False positive. The code already gates the memcpy on rte_ether_unformat_add=
r(buf, &ea) !=3D 0. The reviewer is speculating that a documented-success r=
eturn might leave ea undefined, with no basis. AGENTS.md: don't speculate.

Patch 2/4 =E2=80=94 hex_nibble validation

False positive. The lexer regex is 0[xX][0-9A-Fa-f]{17,} =E2=80=94 only hex=
 digits can ever reach hex_nibble(). The function is correct by constructio=
n of its only caller.

Patch 2/4 =E2=80=94 cap * sizeof(*p) overflow

Theoretically possible but practically unreachable: the cap doubles per ite=
m parsed, so overflow would require parsing a multi-gigabyte rule string wi=
th billions of items. Not a real bug. AGENTS.md says report bugs at >=3D50%=
 confidence =E2=80=94 this is well below that.

Patch 2/4 =E2=80=94 leak when later rte_zmalloc fails in begin_item

False positive, and the author specifically anticipated this. Note the comm=
ent cc->out->npattern++; /* publish so cleanup walker sees it */ =E2=80=94 =
npattern is incremented before the spec/mask/last allocations. On YYABORT, =
rte_flow_compile_free() walks pattern[0..npattern] and calls rte_free() on =
each spec/mask/last, and rte_free(NULL) is a no-op. So if spec succeeds and=
 mask fails, spec is freed and mask/last are skipped. The cleanup design is=
 correct.

Patch 2/4 =E2=80=94 scanner leak in success path

This is the most egregious one. The reviewer asks the question, then litera=
lly writes "Wait, looking more carefully =E2=80=94 does the code call flow_=
compile_yylex_destroy(scanner) in all error paths?" The answer is yes =E2=
=80=94 flow_compile_yylex_destroy(scanner) is called unconditionally after =
flow_compile_yyparse(), before the if (rc !=3D 0) check, so it runs on both=
 success and failure. AGENTS.md explicitly bans this self-contradicting pat=
tern: "Do NOT report an issue then contradict yourself."

Patch 2/4 =E2=80=94 strtoull() overflow check

False positive. The code does errno =3D 0; ... strtoull(...); if (errno !=
=3D 0 || *end !=3D '\0') FAIL(...). That is the canonical strtoull overflow=
 check (ERANGE on overflow). The reviewer is asking documented library beha=
vior questions.

Patch 2/4 =E2=80=94 partially initialized fc in rte_flow_compile_free

False positive. out is allocated with rte_zmalloc so npattern/nactions star=
t at 0; pattern/actions slots are zeroed by memset in begin_item/begin_acti=
on before publication; and rte_free(NULL) is safe. There is no stale-value =
path.

Patch 3/4 =E2=80=94 included with no findings

AGENTS.md: "OMIT patches that have no issues. Do not include a patch in you=
r output just to say 'no issues found' or to summarize what the patch does.=
" The reviewer included it to say it looked good.

Patch 4/4 =E2=80=94 alignment of p[1].spec for IPv4

False positive. rte_zmalloc returns at least cache-line aligned memory by d=
efault =E2=80=94 far stricter than struct rte_flow_item_ipv4 requires. The =
struct isn't packed in a way that would change this. Pure FUD.

Meta-observation

Almost every item is phrased as "Does this code...?" rather than a concrete=
 claim. AGENTS.md is explicit: "either it's wrong or don't mention it." The=
 Socratic-question framing is the tell =E2=80=94 when the reviewer can't co=
mmit to "this is wrong," it usually means it isn't, and the question should=
n't be in the output.

Of the eleven items in the review, zero are real bugs. You can safely ignor=
e the entire review.



