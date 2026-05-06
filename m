Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C4CD342F
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD324028B;
	Wed,  6 May 2026 05:33:43 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 207454026D
 for <dev@dpdk.org>; Wed,  6 May 2026 05:33:42 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-130c653cce4so3148205c88.1
 for <dev@dpdk.org>; Tue, 05 May 2026 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778038421;
 x=1778643221; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpqgtBn/RnCbysNypG8/vabTrYV3o6yXBFkPsToGIws=;
 b=xX7p5sevvkG4+P2lQVqFk4Kw2b3rv3pf7pc+DIzhaZlvuY5hpcrE9XP1b7NyMdz88t
 cZIM1kPTiO/DfR01zrfW0ASEPpGWbXimWUEIoQKa0YERD9ToOLC6BQur8Kmiddrx84sJ
 Y1s6pKe63qnAKEjHN1XEs7VR2wa1g9vTbxc7CL96eLLZ1Ou+YDAQIoqnW8oAoNiTAETu
 ktt7QwnlBMdWhXadF0oUTTFOJWUpXm9SeBoR9pJdtr5ylL8fDnhOKLwIOKL5QZd0dMaQ
 K+equjY25dCOBkxjc2VKX5RYOvS4xmoNDn4hDYU3JWtGFtq1wfpArk10jyAlhu+rSX1K
 xMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038421; x=1778643221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WpqgtBn/RnCbysNypG8/vabTrYV3o6yXBFkPsToGIws=;
 b=fmMU+krb4NI/wOjryYJlwjyMTnyv60likFFKXGpvMP015QAJYURIryXNh58Rd+Ro0k
 bkft2yFAujP0PXfpzEaeZYHQOy9T4ylsjgbDwmyE3xeFsil1OujMg50CASfQdnD7jToi
 q2Tx4/xRAF119821kPJOzq9c7d4u04U8dz6Ekdhb8AcdWxOOfTKpg2s1dcjh2pvn4dNO
 lHWK1oW0rrwkUh/9PeCVawrRNie3lo7TE09agW/X4vzpE0bezJlJiK6HqPftF++fzZKy
 qj/wy2P4V9g5ZacUv6ySd8qMkGT/hZ6tL9LTcFmFIf6m5ipcDQDjnr8CUfZ74MKbxj3Z
 hWmA==
X-Gm-Message-State: AOJu0YzmdA/HyTYVCFD7TofN8A405nl0Oich6cSs13+xnzfSPMfKIxtz
 sWpwQQ65tD+cHA8pUtm9xuz5XZ3RW5e3NBQRxQbpSYPXkTxXj0LcXYGI5BhNiCBidBeueakQ257
 VyjWI
X-Gm-Gg: AeBDieu0KWXqMDVJioAkz7HT1NPT3Zy21zgokNSeZcfzw2NyZyyJN5Uf/cdm43tO0NG
 m8gPTlc3faw2m4VEUWma8/jtis32Rbkb9bRVsTRdA7OrQuBhfUti7nHchJfZyr0uUoSw0ryDBGL
 d8mJHKRsdQq9GMsF0T2qrPIWdT5YvcHANYslrIYpat+gWhNJyirBbyyPmYWVtHf41gnGavgiuR1
 /QV6lJl9/WcJ3MZP/6l2UTKaGLgt7molJK57cCkOR3HWam26bQYVBoezA/ADz+z962Q1Apg7Set
 B9KeHkhYMGS1DWYBCOqqKmxPvQa2/RN4jepNpCqLIjf85PlQD9HpAfOBRrAHD1AjEvVws6RZeTr
 ihN2plPkkDxjGcGpR7K9jf8B2QoWWRZBrbKGuqGPdGZLGhxf2THim/tnrkMZCzJ857JEocQ4AVv
 vFwKLiBoFpWyCcwCermpBBs8eEePNX/gI7q8/AgYMu3PkSr4qQI3xu+A==
X-Received: by 2002:a05:7022:698b:b0:12d:e126:b7c8 with SMTP id
 a92af1059eb24-131965c2123mr945350c88.13.1778038420854; 
 Tue, 05 May 2026 20:33:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9679dc4sm1829479c88.3.2026.05.05.20.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:33:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC PATCH 0/3] flow_compile: textual flow rule compiler
Date: Tue,  5 May 2026 20:29:54 -0700
Message-ID: <20260506033338.480610-1-stephen@networkplumber.org>
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

  http://patches.dpdk.org/project/dpdk/list/?series=37384  (or
  most recent thread on dev@dpdk.org)

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

So I started a new green field library for parsing flow rules
(with the help of AI assistance). It is only a few hours old,
but passes tests and passes review.

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

  - Hand-rolled lexer + recursive descent parser.  No flex/bison.
  - Parser is driven entirely by descriptor tables of items and
    actions.  Adding a new flow item is a table edit, not a
    parser change.  A custom-setter hook on each field covers
    the layouts that do not fit a plain byte range (bitfields,
    indirect arrays).
  - Dependencies: rte_ethdev and rte_net only.  No librte_cmdline,
    no flex/bison.  Builds clean on Linux, FreeBSD, and Windows.
  - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;
    rte_flow_compile_free() walks the pattern and action arrays.
    ASan/LSan run clean on the autotest.

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
items and actions (RSS, RAW) require custom setters and are
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

4. Convergence.  If this design is preferred, I'm happy to
   coordinate with Lukas to fold in the testpmd-side changes
   from his series.

5. API code. Is it readable enough. Lots of code here
   but doing lexer/parser is prime template territory
   and AI has a good chance here.

Stephen Hemminger (3):
  flow_compile: introduce textual flow rule compiler
  doc: add programmer's guide for flow rule compiler
  test/flow_compile: add unit tests for flow rule compiler

 MAINTAINERS                                    |    8 +
 app/test/meson.build                           |    2 +
 app/test/test_flow_compile.c                   |  230 +++
 doc/guides/prog_guide/flow_compile_lib.rst     |  170 ++
 doc/guides/prog_guide/index.rst                |    1 +
 doc/guides/rel_notes/release_26_07.rst         |    5 +
 lib/flow_compile/flow_compile_lex.c            |  488 +++++
 lib/flow_compile/flow_compile_parse.c          |  634 ++++++
 lib/flow_compile/flow_compile_priv.h           |  181 ++
 lib/flow_compile/flow_compile_tables.c         |  245 +++
 lib/flow_compile/meson.build                   |   15 +
 lib/flow_compile/rte_flow_compile.h            |  158 ++
 lib/flow_compile/rte_flow_compile_api.c        |  132 ++
 lib/flow_compile/version.map                   |   13 +
 lib/meson.build                                |    1 +
 15 files changed, 2283 insertions(+)
 create mode 100644 app/test/test_flow_compile.c
 create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
 create mode 100644 lib/flow_compile/flow_compile_lex.c
 create mode 100644 lib/flow_compile/flow_compile_parse.c
 create mode 100644 lib/flow_compile/flow_compile_priv.h
 create mode 100644 lib/flow_compile/flow_compile_tables.c
 create mode 100644 lib/flow_compile/meson.build
 create mode 100644 lib/flow_compile/rte_flow_compile.h
 create mode 100644 lib/flow_compile/rte_flow_compile_api.c
 create mode 100644 lib/flow_compile/version.map

-- 
2.43.7


Stephen Hemminger (3):
  flow_compile: introduce textual flow rule compiler
  doc: add programmer's guide for flow rule compiler
  test/flow_compile: add unit tests for flow rule compiler

 MAINTAINERS                                |   7 +
 app/test/meson.build                       |   1 +
 app/test/test_flow_compile.c               | 234 ++++++++
 doc/guides/prog_guide/flow_compile_lib.rst | 272 +++++++++
 doc/guides/prog_guide/index.rst            |   1 +
 doc/guides/rel_notes/release_26_07.rst     |   6 +
 lib/flow_compile/flow_compile_lex.c        | 510 +++++++++++++++++
 lib/flow_compile/flow_compile_parse.c      | 634 +++++++++++++++++++++
 lib/flow_compile/flow_compile_priv.h       | 181 ++++++
 lib/flow_compile/flow_compile_tables.c     | 245 ++++++++
 lib/flow_compile/meson.build               |  15 +
 lib/flow_compile/rte_flow_compile.h        | 158 +++++
 lib/flow_compile/rte_flow_compile_api.c    | 132 +++++
 lib/meson.build                            |   1 +
 14 files changed, 2397 insertions(+)
 create mode 100644 app/test/test_flow_compile.c
 create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
 create mode 100644 lib/flow_compile/flow_compile_lex.c
 create mode 100644 lib/flow_compile/flow_compile_parse.c
 create mode 100644 lib/flow_compile/flow_compile_priv.h
 create mode 100644 lib/flow_compile/flow_compile_tables.c
 create mode 100644 lib/flow_compile/meson.build
 create mode 100644 lib/flow_compile/rte_flow_compile.h
 create mode 100644 lib/flow_compile/rte_flow_compile_api.c

-- 
2.53.0

