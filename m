Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98137CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 00:15:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75B6E4025A;
	Thu,  7 May 2026 02:15:07 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id A3802400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 02:15:05 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso428082eec.1
 for <dev@dpdk.org>; Wed, 06 May 2026 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778112904;
 x=1778717704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+i/4v9IyDgd9j36RFwfB9S2bWGvnI9+23unE1b+gtuM=;
 b=WPBPF3pmMDnD5pl0NHGvEZUry+mQ4RF28qxEQrDndf2RFIYAjbIfrdvC3WhQn3mgKr
 rE2I0L7DSGzJD5FMA1wYa6Ndl3ZT9PCCiMVi8qbr+t2eno2sXrfYCNExIBIuAnAges1y
 c5JXuQ4sxWiNkh+ZGP4KdeazNX7FRLkDOuGffUnfHekQDmsNU3XbX+t4ByNoxklmfj69
 l24vvCjBiiydrFNRzQTXjJVEicirzpf5+jTkVYXgb+VHE5hkfqZhE4mrH2FwtQ41KquN
 e/r98KA5BBmb6ZrHcIUnptFHASz2f6B0BmIZRWCuad2tjaFiz5W3un4vfKXAomdxLkZ7
 Uu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112904; x=1778717704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+i/4v9IyDgd9j36RFwfB9S2bWGvnI9+23unE1b+gtuM=;
 b=MkHsvCSf5/FYvN1zTbJNWh6fQOuR5mRE17yKsHU83Zb1Ty1Lq0XQsIPvU9T3wvNpwV
 u+QOQqiMEssaeIxYBLlt+e2GF8+IMy6r2gzqWgo4F9ChlNQXVXMnWwdQN7VPgFUwJVHC
 PmjTHV0qnJnd+JmfeeuXXEMsoDfjYzT6XjYEMubEX8wf1Phmedkwb2RMEescDVh5wer3
 Ih0x2vFZOd0UX1ORU1RrHiXbpx6jUwTjAnGVBya9aLhMx7bYh80t3Dp+dKfmhd5D1nPe
 3JtQLqftUkgibwJxLgOKdkW6pefyaqeXk2Ob82I7j9bhf+n5SesN4Jeh9tSfYaonyPkB
 JahQ==
X-Gm-Message-State: AOJu0YyFK6XQ9wYIPyaOQtKgK0Qmv8N8qts294ya3SWSQGWQuR9WpnnY
 lEEgQQx+//5+sn+DaKtcqfNWkbMqIrsyDouH4UQh8Edpg+PmshtB+/BLmrwNa88sQsX9YPA2YuI
 w4z9k
X-Gm-Gg: AeBDiesuEpxHqS0ti5oKzTTjCwDIfyeCRHHB8sBmDHeajDOKhJRFfbwmk6V8Y3PE7Cv
 Xx9wtELXkJ2SW/vOOdMLh9IFwMvjbD55urlSRDIMVEkIK4RpUpox6FbOfY9JSzwLwKH4yOIDhrG
 Eq/fHe12YxEdObQztJDflpDfWGqBtDDvIMljLN3LShmDm9g8oiIpvGKfrqd+fCYr2xNmo/U2n3t
 dWEn9D4EwL/MhtKs4HM0CL2hLf0QFsUAVYKPE1TVJRHYb4qW+RFOMiZVgU2afiuzcUWy+ca/Brb
 ibsqqSUBy6w2nsHOO5Bo1OQjPcvqG8B4rpT+WuXzd/hhwylFdZhL3C5tqPgc4Flhz+0xqpCLdZ1
 HdFK6ybmW2jLIyLsjWW2EXHmtugZg17eZAirKxeRtLHoRFfmd7nu7QzGNHgqUprLa/ILS4lqEkB
 osvbgduQk5qgaiSwm2p4tU27W9nwOPByyxGbPo3Z2BPgk=
X-Received: by 2002:a05:7301:3f16:b0:2ed:23cd:babf with SMTP id
 5a478bee46e88-2f548e95845mr2684410eec.12.1778112904063; 
 Wed, 06 May 2026 17:15:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm5159080eec.30.2026.05.06.17.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:15:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 0/4] flow_compile: textual flow rule compiler
Date: Wed,  6 May 2026 17:06:47 -0700
Message-ID: <20260507001501.608724-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505183917.370281-1-sismis@dyna-nic.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Background
----------

Multiple efforts over the past few cycles have tried to make
testpmd's flow rule grammar reusable from outside testpmd.
External applications that need rte_flow want a documented way
to turn human-written rules into the rte_flow_attr/item/action
arrays accepted by rte_flow_create().

The most recent attempt is Lukas Sismis's series, currently at
v12:

  http://patches.dpdk.org/project/dpdk/list/?series=37384

That series factors testpmd's existing cmdline_flow.c into a
library and updates testpmd to consume it.  It works, but
inherits two properties of cmdline_flow.c that I think are worth
avoiding in a reusable library:

  - Coupling to librte_cmdline.  Even after the v12 split into
    a "simple" part and a "cmdline" part, the parser is still
    organized around testpmd's command interpreter, and v12 has
    cmdline depending on ethdev to break a previous circular
    dependency.  A library used by daemons, control planes, or
    unit tests should not need that.

  - Ad-hoc grammar.  cmdline_flow.c implements parsing per-token
    in long dispatch logic; the grammar emerges from the code
    rather than being stated, and adding a new flow item
    requires touching the parser.

This RFC explores a different shape and is posted to ask the
list which one is preferred before more work goes into either.

I started a new green-field library for parsing flow rules
(with AI assistance for the boilerplate).  It is young but
passes tests and reviews clean under the project's AI review
guidelines.

This series
-----------

lib/flow_compile -- a small new library providing the same
service via a pcap_compile()-style API:

    char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];
    struct rte_flow_compile *fc = rte_flow_compile(rule, errbuf);
    if (fc == NULL)
            fail(errbuf);            /* "line:col: message" */

    rte_flow_compile_create(port_id, fc, &flow_error);
    rte_flow_compile_free(fc);

Design properties:

  - Flex lexer plus bison grammar.  Both are reentrant
    (%option reentrant, %define api.pure full), so multiple
    compilations may run concurrently and the parser holds no
    static mutable state.  The grammar itself is short
    (~200 lines) because all per-type knowledge lives in
    descriptor tables, not in productions.

  - Parser is driven entirely by descriptor tables of items and
    actions.  Adding a new flow item is a table edit, not a
    grammar change.  A custom-setter hook on each field is the
    escape valve for layouts that don't fit a plain byte range
    (bitfields, indirect arrays).

  - Dependencies: rte_ethdev (for rte_flow.h) and rte_net (for
    MAC parsing).  No librte_cmdline.  Flex and bison are
    required at build time to regenerate the lexer and parser;
    if either tool is missing the library is silently skipped
    via meson's has_flex_bison check, the same pattern other
    DPDK components use for optional generators.

  - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;
    rte_flow_compile_free() walks the pattern and action arrays
    and releases every non-NULL slot before freeing the arrays.
    Parse-error paths use the same walker, so partially
    constructed rules clean up uniformly.  ASan/LSan run clean
    on the autotest, including the failure cases.

The grammar follows testpmd's syntax closely so familiar rules
carry over:

    ingress pattern eth / ipv4 src is 10.0.0.1 / end
    actions queue index 3 / count / end

and is documented as a formal BNF in the programmer's guide
chapter (patch 2).

Initial coverage: eth, vlan, ipv4, ipv6, tcp, udp, vxlan,
port_id, port_representor, represented_port items; drop,
passthru, queue, mark, jump, count, port_id and representor
variants, of_pop_vlan, vxlan_decap actions.  Variable-conf
items and actions (RSS, RAW) need custom setters and are
deferred to a follow-up.

What this RFC is *not*
----------------------

Not a replacement for cmdline_flow.c in testpmd.  If the shape
here is acceptable, the next step is a separate series adding a
"flow compile <port> <rule>" command in testpmd alongside the
existing parser, so users can adopt the library incrementally
without breaking scripts that depend on the current syntax.

What I'd like feedback on
-------------------------

1. API shape.  pcap_compile-style (one string -> opaque object ->
   arrays) versus the three-call attr/pattern/actions form
   Sismis's v12 exposes.  What does your application actually
   want?

2. Library placement.  Stand-alone at lib/flow_compile/ versus
   addition to lib/ethdev.  This series treats it as a
   control-path parser layered on top of ethdev rather than
   part of ethdev itself; v12 places its parser inside ethdev.

3. Table-driven extension model.  Is "to add a new flow item,
   add a row to the descriptor table" the right contract?
   Should the tables live alongside each rte_flow_item_*
   definition in rte_flow.h, or in their own file as here?

4. Build-tool dependency.  Flex and bison are not currently
   required to build DPDK.  Adding a library that needs them
   (with a clean has_flex_bison fallback so the rest of DPDK
   still builds without them) is the cleanest way I see to get
   a real grammar. If this gets used by testpmd then
   what is now an optional dependency would get hardened in.

5. Convergence.  If this design is preferred, I'm happy to
   coordinate with Lukas to fold in the testpmd-side changes
   from his series.

6. Readability. AI generated code like this tends to be
   either opaque or too verbose for humans. Often have to
   nudge it into submission.


Stephen Hemminger (4):
  config: add support for using flex and bison
  flow_compile: introduce textual flow rule compiler
  doc: add programmer's guide for flow rule compiler
  test/flow_compile: add unit tests for flow rule compiler

 MAINTAINERS                                |   7 +
 app/test/meson.build                       |   1 +
 app/test/test_flow_compile.c               | 255 ++++++++++
 config/meson.build                         |  23 +
 doc/guides/prog_guide/flow_compile_lib.rst | 302 ++++++++++++
 doc/guides/prog_guide/index.rst            |   1 +
 doc/guides/rel_notes/release_26_07.rst     |   6 +
 lib/flow_compile/flow_compile.l            | 227 +++++++++
 lib/flow_compile/flow_compile.y            | 311 +++++++++++++
 lib/flow_compile/flow_compile_priv.h       | 127 +++++
 lib/flow_compile/flow_compile_setters.c    | 516 +++++++++++++++++++++
 lib/flow_compile/flow_compile_tables.c     | 243 ++++++++++
 lib/flow_compile/meson.build               |  22 +
 lib/flow_compile/rte_flow_compile.h        | 158 +++++++
 lib/flow_compile/rte_flow_compile_api.c    | 160 +++++++
 lib/meson.build                            |   1 +
 16 files changed, 2360 insertions(+)
 create mode 100644 app/test/test_flow_compile.c
 create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
 create mode 100644 lib/flow_compile/flow_compile.l
 create mode 100644 lib/flow_compile/flow_compile.y
 create mode 100644 lib/flow_compile/flow_compile_priv.h
 create mode 100644 lib/flow_compile/flow_compile_setters.c
 create mode 100644 lib/flow_compile/flow_compile_tables.c
 create mode 100644 lib/flow_compile/meson.build
 create mode 100644 lib/flow_compile/rte_flow_compile.h
 create mode 100644 lib/flow_compile/rte_flow_compile_api.c

-- 
2.53.0

