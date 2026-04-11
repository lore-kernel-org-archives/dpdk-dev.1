Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A5F3ED67
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 23:41:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B29964026A;
	Sun, 12 Apr 2026 01:41:15 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 229BC40268
 for <dev@dpdk.org>; Sun, 12 Apr 2026 01:41:14 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso219853eec.0
 for <dev@dpdk.org>; Sat, 11 Apr 2026 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775950873;
 x=1776555673; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wumJUU74VQ8xCAFT/w2u8WZIz7OAfHk6dYbRzzD7kqA=;
 b=y6V2RKcs3n3QGmLtpJ4WPr0rTS0wn7cM32GIAuB9JL333X8sg7wVfhLlGSet4MLrev
 l61YaFA7k5YpYbcsZlHWbESztfFHDX3PQnX51lYmDr9gilkYR3cSMQIZlHCswMTCR/ls
 jRQcqvcyEA0ShgyzZfWwatM4in3aKtfqyNkaQQBfuYJrffO5pznlxz/59c0gNtLbwbLA
 Bdz3vzMRXYjas6Kor9/8fpzsUecAq9fHUkkfRSBT0yFbU1EKSYC7px6nu8RX2OQBDAFo
 0hjRCPfpBk9sdGn54Mf9juln3YuefOoIgEprOhSNu1Jnfj7Or6wVoO+B2RGHnhFbjJTu
 3Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775950873; x=1776555673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wumJUU74VQ8xCAFT/w2u8WZIz7OAfHk6dYbRzzD7kqA=;
 b=Icx0mUvvCii1bP4MuS1QHE413hbRBGl8/Es7RSBGDGQoERhuTsRZEqtNYWE6SX2u3m
 at7NcKPxVdBZDOmdHtRqdSZvY7ToZWaCCfdAubMOZWmr7Qs1UrMTYrJajzwdaFLT1YLt
 40XV3bxIuvoedAJchDzLtACJNee1VdGyX7M/S4/yxrvn3rlKnwBAgPjlQds8M2dGo+Zv
 ZYNI7sOC9tMEBk8jOokCg15iOgHXvSq+hY0jVwvIpAH1OdbKdGHiBZ1rgUWvfcIIBBfc
 SZeCXxLsqiWIGI/q8Qq/AqE7mh9xz/RrfF/mkELNMwdY82J9zcJqks1OBAiHCj24GI1U
 IG/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6aHq/J8/5fo1jMkbB/9QspK605cH5uwq+DXnKwAbFDPjweL1+QSeSjzvcVlPuUE+3mHk=@dpdk.org
X-Gm-Message-State: AOJu0YyoZMVDLC8BvYXZ3X5jJew74an1z1Kc6+VqpzY/qRMX0TdtX+E7
 cMJQD7NhOt1o6H0YED0PcC+aFQ3dthLJC0IkjCTQKbRHqiOWkMAVV7Uu2DdGTM76+aY=
X-Gm-Gg: AeBDieuAX1P5EQ0SXQU/axd/o1VT08uCJZTgawXLN/oyLpv2kRIQqpmlpI4umIM9NkH
 V2tke9d7I4G6OUO0voGN3RqzsMCWXOqqpIO9EHMVPXVELwZwUTaHAys82SrmDsmbJnzjWSUpxSf
 CgzPdHQFi5par1TkVR0EerMuSqyzD1UzfA01N5US8vJkplQbvoCGt0PaxsLJ3Rk9csPXcjTXyt6
 sF8McIKC+sjKg5bLec8Yuk7lppbG4Ad4PlWEFIm7pLElxZV0ZiaZwKboqhSPKpSaDryuIz+g28D
 cLbNDcejU2T17EpujY84L0nPLrz/et26RS3pwbodH5s5VwjFGN8F3EmsOsBsPCqlpIayxQpu/wi
 bh9lYaIQ9FzhO6l3Q5+OW/r2P/5r6bmTGl5YGK/UaaR+mQ0T0qpUeNGhiEnrtIe0rKMUQmZj7VE
 kb6cSBCsOMCSAwAw04K5YbjUw+/98lqYbIQ6E=
X-Received: by 2002:a05:7022:6982:b0:12a:7181:2f1a with SMTP id
 a92af1059eb24-12c34e6913amr4973831c88.5.1775950872704; 
 Sat, 11 Apr 2026 16:41:12 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c4acc7d6fsm324950c88.5.2026.04.11.16.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 16:41:12 -0700 (PDT)
Date: Sat, 11 Apr 2026 16:41:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: orika@nvidia.com, dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v11 0/6] flow_parser: add shared parser library
Message-ID: <20260411164109.04a4de16@phoenix.local>
In-Reply-To: <cover.1775850858.git.sismis@dyna-nic.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
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

On Fri, 10 Apr 2026 22:15:38 +0200
Lukas Sismis <sismis@dyna-nic.com> wrote:

> This series extracts the testpmd flow CLI parser into a reusable library,
> enabling external applications to parse rte_flow rules using testpmd synt=
ax.
>=20
> Motivation
> ----------
> External applications like Suricata IDS [1] need to express hardware filt=
ering
> rules in a consistent, human-readable format. Rather than inventing custom
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
>=20
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
>=20
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
>=20
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.
>=20
> Testing and Demo
> -------
> - Functional tests in dpdk-test
> - Example application: examples/flow_parsing
>=20
> Changes
> -------
> v11:
> - targetting 26.07 now
> - MAJOR overhaul of the patch set to make every part of the library API p=
ublic
>   and reusable, while only parsing flow testpmd commands.
> - library splitted into a "simple" part and "cmdline" part
> - testpmd changed to use the "cmdline" part of the library, and also to h=
andle
>   most of the "set" commands itself, while still using the library to par=
se=20
>   the parameters of the "set" commands. Previous "operation callbacks" ar=
e now
>   replaced by command-codes (enum) and the caller is expected to handle=20
>   the command execution itself. Likewise, the ownership of helper structu=
res,
>   e.g. for vxlan/raw/sample etc. is in the hands of the caller, and the l=
ibrary
>   only uses/fills them in with the parsed parameters.
>=20
> v10:
> - rebased to avoid Github Actions CI build failure
> - merge conflict solved in rel_notes/release_26_03.rst
> - release notes shortened
>=20
> v9:
> - removed extra new line from the flow parser docs file
>=20
> v8:
> - rte_port/queue_id_t typedefs removal to be included in a separate patch=
 series
> - move of accidental changes of rte_flow parser library from the testpmd =
commit
> - DynaNIC copyright name update
>=20
> v7:
> - Fixed implicit integer comparison (while (left) -> while (left !=3D 0))
> - NULL checks fixed
> - arpa header removed for Windows compatibility
> - minor comments from the last review addressed
>=20
> v6:
> - Inconsistent Experimental API Version adjusted
> - Fixes Tag added to MSVC build commit
> - Non-Standard Header Guards updated
> - Implicit Pointer Comparison and Return Type issues addressed in many pl=
aces
> - commit message in patch 6 updated
>=20
> v5:
> - removed/replaced (f)printf code from the library=20
> - reverted back to exporting the internal/private API as it is needed by
>   testpmd and cannot be easily split further.
> - adjusted length of certain lines
> - marking port/queue id typedef as experimental
> - updated release rel_notes
> - copyeright adjustments
>=20
> v4:
> - ethdev changes in separate commit
> - library's public API only exposes attribute, pattern and action parsing,
>   while the full command parsing is kept internal for testpmd usage only.
> - Addressed Stephen's comments from V3
> - dpdk-test now have tests focused on public and internal library functio=
ns
>=20
> v3:
> - Add more functional tests
> - More concise MAINTAINERS updates
> - Updated license headers
> - A thing to note: When playing with flow commands, I figured, some may u=
se
>   non-flow commands, such as raw decap/encap, policy meter and others.
>   Flow parser library itself now supports `set` command to set e.g. the d=
ecap/
>   encap parameters, as the flow syntax only supports defining the index o=
f the
>   encap/decap configs. The library, however, does not support e.g. `creat=
e`
>   command to create policy meters, as that is just an ID and it can be cr=
eated
>   separately using rte_meter APIs.
>=20
> [1] https://github.com/OISF/suricata/pull/13950
>=20
> Lukas Sismis (6):
>   cmdline: include stddef.h for MSVC compatibility
>   ethdev: add RSS type helper APIs
>   ethdev: add flow parser library
>   app/testpmd: use flow parser from ethdev
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser functional tests
>=20
>  MAINTAINERS                                   |     6 +-
>  app/test-pmd/cmd_flex_item.c                  |    47 +-
>  app/test-pmd/cmdline.c                        |   249 +-
>  app/test-pmd/config.c                         |   115 +-
>  app/test-pmd/flow_parser.c                    |   288 +
>  app/test-pmd/flow_parser_cli.c                |   479 +
>  app/test-pmd/meson.build                      |     3 +-
>  app/test-pmd/testpmd.h                        |   135 +-
>  app/test/meson.build                          |     2 +
>  app/test/test_ethdev_api.c                    |    56 +
>  app/test/test_flow_parser.c                   |   791 +
>  app/test/test_flow_parser_simple.c            |   445 +
>  doc/api/doxy-api-index.md                     |     2 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |    99 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_07.rst        |    11 +
>  doc/guides/sample_app_ug/flow_parsing.rst     |    60 +
>  doc/guides/sample_app_ug/index.rst            |     1 +
>  examples/flow_parsing/main.c                  |   409 +
>  examples/flow_parsing/meson.build             |     8 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/ethdev/meson.build                        |     5 +-
>  lib/ethdev/rte_ethdev.c                       |   109 +
>  lib/ethdev/rte_ethdev.h                       |    60 +
>  .../ethdev/rte_flow_parser.c                  | 12250 ++++++++--------
>  lib/ethdev/rte_flow_parser.h                  |   130 +
>  lib/ethdev/rte_flow_parser_cmdline.h          |   739 +
>  lib/meson.build                               |     2 +-
>  29 files changed, 9936 insertions(+), 6569 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser_cli.c
>  create mode 100644 app/test/test_flow_parser.c
>  create mode 100644 app/test/test_flow_parser_simple.c
>  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
>  create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst
>  create mode 100644 examples/flow_parsing/main.c
>  create mode 100644 examples/flow_parsing/meson.build
>  rename app/test-pmd/cmdline_flow.c =3D> lib/ethdev/rte_flow_parser.c (59=
%)
>  create mode 100644 lib/ethdev/rte_flow_parser.h
>  create mode 100644 lib/ethdev/rte_flow_parser_cmdline.h
>=20

Better, no callbacks but still has a big problem.
Making every application suck in cmdline is bad idea.
Maybe flow parser needs to be part of cmdline not ethdev?
In current form, this patch is not something I would accept.

Long winded AI review attached:
=3D=3D=3D Patch Review: flow_parser v11 (via Claude) =3D=3D=3D

Patch 2/6: ethdev: add RSS type helper APIs

  No issues found =E2=80=94 patch omitted from review.

Patch 3/6: ethdev: add flow parser library

  Warning: Adding cmdline as a mandatory dependency of libethdev
  (deps +=3D [..., 'cmdline']) means every application linking ethdev now
  pulls in the cmdline library even if it never uses the flow parser.
  The flow parser should be a separate library (librte_flow_parser)
  that depends on both ethdev and cmdline, rather than embedding it
  inside ethdev and inflicting the cmdline dependency on all ethdev
  consumers.  The cover letter says "The library (librte_flow_parser)"
  but the implementation puts everything into lib/ethdev/.

  Warning: rte_flow_parser_parse_flow_rule() returns pointers into
  static internal storage (flow_parser_simple_parse_buf) but its
  Doxygen does not say so.  The individual helpers
  (parse_pattern_str, parse_actions_str) document "Points to internal
  storage valid until the next parse call" =E2=80=94 the same caveat must
  appear on parse_flow_rule's pattern and actions output parameters.
  Without it, callers will assume the returned pointers are stable.

  Warning: parser_str_strip_trailing_end() has inconsistent return
  values.  When the input does not end with "/ end", the function
  returns strlen(src) (preserving trailing whitespace).  But when the
  input is shorter than 3 characters, it returns length with trailing
  whitespace stripped.  If the intent is "strip / end or return full
  length unchanged," the short-string path should also return
  strlen(src).

  Warning: The RTE_EXPORT_EXPERIMENTAL_SYMBOL() macros are placed in
  a block at the bottom of rte_flow_parser.c, detached from the
  function definitions they refer to.  In the rest of the DPDK
  codebase (and in patch 2/6 of this series) the export macro is
  placed immediately before each function definition.  This style
  inconsistency makes it easy for the export list to drift out of
  sync with the actual functions.

  Info: rte_flow_parser_parse() casts result_size to unsigned int
  when passing to cmd_flow_parse.  The check "result_size > UINT32_MAX"
  guards against truncation, which is correct, but the function
  signature accepts size_t while all internal consumers use unsigned
  int =E2=80=94 consider documenting the practical upper bound.

Patch 4/6: app/testpmd: use flow parser from ethdev

  No issues found =E2=80=94 the dispatch switch correctly covers all command
  enum values and the tunnel_ops conversion is straightforward.
  Patch omitted from review.

Patch 5/6: examples/flow_parsing: add flow parser demo

  No issues found =E2=80=94 patch omitted from review.

Patch 6/6: test: add flow parser functional tests

  No issues found =E2=80=94 patch omitted from review.

Patch 1/6: cmdline: include stddef.h for MSVC compatibility

  No issues found =E2=80=94 patch omitted from review.
