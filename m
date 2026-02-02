Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C8E7DF11
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B60F24027D;
	Mon,  2 Feb 2026 19:38:02 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 6D4544026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 19:38:01 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43596062728so16775f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 10:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770057481;
 x=1770662281; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qRTUkGjHyGotMfzpEWKQ6RhsVI4YGVIFzRtHsEwCVs=;
 b=apbRNp5tHMPJB4HGY6ml9W5oAwEZKG/HL24g5X9rkFztK7wTKyu8YeJqynQbILQPsi
 D8A3AfailDgNuT9JEQwyct5KxmZcI0p7B3Frjivo+jfwti/0LNLZgh3NIdPYbuvukWq/
 5jZlxIHr+pEz/JVqOkIqITBcjaMqKA2USdpKeLnYSuFG+N0D17IM4Hz1wg1G1ZBVmVQL
 XA/2lOF7UTNRgzpTSReB9jtd09VEWud31i+TqrNK5p8+lhJCQl8AsoPBlzxsu1u4DUci
 HLxAplz2LNwFnLC3EUYcBh3/P9o6IGjhfR7/fC3jOjqWm7ZF6mRqrcuKr4oF6iY21jBh
 rjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770057481; x=1770662281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3qRTUkGjHyGotMfzpEWKQ6RhsVI4YGVIFzRtHsEwCVs=;
 b=THTAMO7BprxQTclgdoAAjo8I5zKkw4Xhvps9SMREg33CZFi4n7xAyWOB40wXUdqQIW
 CuQXCYNlwc0KacN+QQcwAVLs6oDtczmaMo4a3lQ3T47VjmH4A3Cbj+ehYEo8E+4//5JL
 yZv3sYq3T340aOYemeqVxGCjWeEReAXK3vYd0WOfmG7/3Bm84ASAUXxyG5vKDcO62bpY
 XjKg6fg23/fmyd71VaVZ4GAUZuU8bj1Qk6lwGDS+N0nz3rDiecpBh10Qa9i5Cy2U9Y/7
 h6GYWvBTo6qO6RJ9d8b9sc2XDw6Ognz0WCbPuDWwBlSmeNAg3/HfcmQGTMhGxGf2U4tB
 U1Ug==
X-Gm-Message-State: AOJu0YzLISeAJU1lcwpT1xWnuQDYyRPOX8rp+gmwOgfSYiRtVtmyh4Gw
 jrUT93ccmVRjUse3zW/sQOc+Ia7WJkrSiaPm3x5JNWfzEam+xPleBHPqSI1pUAQem0Fyy0YdcUL
 bAIh8
X-Gm-Gg: AZuq6aI/YNVpBOWWEVyjnZ2vHBZx0Cgv6ZRuQJzO0Oj4ApUkHxXpzqtgPwOITFfLQK7
 Txr21r7l5IdHsny5ETZNQg9uAJRWl0tTtRie5cWU2kChUxbaIrHsOW3O1hYZKq6VdMW/qGlJhWX
 kYDenETQ7vN5ghxy+Ir3ktcITQFNcVUWbpQuo3inMO6NCabgti4azHEm2rDZRyu9pveeA/WNeYK
 GYo+7e7K2qW/XAUe5EHxGJbHD7DaD5z8gxLNZEV+fSwBIzQZ9yO0qegpG5aV1a9daDPtwWEw3p9
 WKvrW45TeFL2KkMujznElKjNuMaQo6gtRUtPEV9d7Fo23W3jlcefqUQAeb+ypwZvj37WbO4XpPy
 HxQCYmQQ2CT3cBi+MZEHZmz61YBLhCZ7M6D/72d4Rw4YjEy0075HmuXIIWVqXrtyv8L+6Uoa2oT
 +QXwey7pLfcCltOUdnXCpD6gY9mmRbxurJ8tk43o27hT24sH07PEjHKWSydcEh9CU=
X-Received: by 2002:a05:6000:184d:b0:435:a43b:2dde with SMTP id
 ffacd0b85a97d-4361142180dmr761219f8f.15.1770057481006; 
 Mon, 02 Feb 2026 10:38:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322eefsm46863865f8f.30.2026.02.02.10.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 10:38:00 -0800 (PST)
Date: Mon, 2 Feb 2026 10:37:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/6] flow_parser: add shared parser library
Message-ID: <20260202103754.3d996282@phoenix.local>
In-Reply-To: <20260202113659.24052-1-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
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

On Mon,  2 Feb 2026 12:36:52 +0100
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
>   flow_parser: add shared parser library
>   app/testpmd: use shared flow parser library
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser library functional tests
>=20
>  MAINTAINERS                                   |     6 +-
>  app/test-pmd/cmd_flex_item.c                  |    41 +-
>  app/test-pmd/cmdline.c                        |   267 +-
>  app/test-pmd/config.c                         |   112 +-
>  app/test-pmd/flow_parser.c                    |   409 +
>  app/test-pmd/flow_parser_cli.c                |   153 +
>  app/test-pmd/meson.build                      |     5 +-
>  app/test-pmd/testpmd.c                        |     4 +
>  app/test-pmd/testpmd.h                        |   122 +-
>  app/test/meson.build                          |     1 +
>  app/test/test_ethdev_api.c                    |    51 +
>  app/test/test_flow_parser.c                   |   923 ++
>  doc/api/doxy-api-index.md                     |     1 +
>  doc/api/doxy-api.conf.in                      |     1 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |   110 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_03.rst        |     9 +
>  examples/flow_parsing/main.c                  |   292 +
>  examples/flow_parsing/meson.build             |    11 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/ethdev/rte_ethdev.c                       |   107 +
>  lib/ethdev/rte_ethdev.h                       |    55 +
>  lib/flow_parser/meson.build                   |     7 +
>  .../flow_parser/rte_flow_parser.c             | 11420 ++++++++--------
>  lib/flow_parser/rte_flow_parser.h             |   134 +
>  lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
>  lib/meson.build                               |     2 +
>  28 files changed, 9671 insertions(+), 5823 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser_cli.c
>  create mode 100644 app/test/test_flow_parser.c
>  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
>  create mode 100644 examples/flow_parsing/main.c
>  create mode 100644 examples/flow_parsing/meson.build
>  create mode 100644 lib/flow_parser/meson.build
>  rename app/test-pmd/cmdline_flow.c =3D> lib/flow_parser/rte_flow_parser.=
c (55%)
>  create mode 100644 lib/flow_parser/rte_flow_parser.h
>  create mode 100644 lib/flow_parser/rte_flow_parser_private.h
>=20

Queued to next-net.

PS: you made AI very happy...
Review Complete
I've thoroughly reviewed the 6-patch flow parser v10 series against AGENTS.=
md guidelines.
Bottom line: This is an excellent patchset - APPROVED with no errors or war=
nings.
The series introduces a new librte_flow_parser library that extracts testpm=
d's flow command parser into a reusable component. All patches follow DPDK =
conventions meticulously:

=E2=9C=85 Proper commit message formatting and tags
=E2=9C=85 All new APIs marked __rte_experimental with RTE_EXPORT_* macros
=E2=9C=85 Comprehensive testing (unit tests + functional tests + example ap=
p)
=E2=9C=85 Complete documentation (prog guide + API docs + release notes)
=E2=9C=85 Correct SPDX licensing on all files
=E2=9C=85 MAINTAINERS file updated appropriately

This demonstrates exemplary DPDK development practices.
