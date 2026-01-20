Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA6FD262AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA602402BD;
	Wed, 21 Jan 2026 00:24:29 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id EA68340278
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:24:28 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so34823705e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768951468; x=1769556268; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fI9Rx3U0bWV0t0fb2TBwTmouCuEJigbKMyo3CBujOXo=;
 b=ClOqfQflJubrf7J2S7PnUUIR6U4vTEwUhb1ui7zH1n7/0B1eNs51JybTP3j1cUGERe
 6RMlpc3pn3Qyxf40lP4o1TvsZ+xJMsbn4nYd2HFIRX9w9W/Wl2h6IrpHY+X+GoQ5S4cl
 yEPnrTyjHZbZYN9oPsmHdnF2I2MJ5mrBqBp47c2iORypt5MJmA4LhJWE41xHgJcNRM5e
 YcI8BIFo6N2PUAwJB6B/bbtQ2kV2R6+SJXSEpNAaZceNRoIGYjV1mKX3Zfb0D4XkvpJA
 JgSYXBSgtW1FkfBmvwW2DsFKHgloUR2rx2UtZF31SIzf9z6qVFsMrpL9dFAZ+Om+4tuQ
 5uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768951468; x=1769556268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fI9Rx3U0bWV0t0fb2TBwTmouCuEJigbKMyo3CBujOXo=;
 b=jWbNmh8CO+4u0Rn+ryYq4IJGNYKLbN9g+5kqpi3rzgtJWGsFNsdPX4h7MCmSei8EwZ
 2KgRxUH1Q1gRoqBBkJk+GsTH67Y/zf6A1kpMTpwLUL3W/nFc5nYjGuGme7C31pyGpssk
 5gZC73riClu2fTuRu3SlKKOd9u9RYnl1xF7T2L+wj7eZKGsFZBmWQ/eY8Xm83UsYq3Jl
 Y9psqgq9M87OtSEqG/gCWPLon+3SLDFxIfHPtK9gHzN8pznntxzGiFPAnHzaFIaVYHa9
 GOLEbgwnZndQ2D7TcikILOP+MOXPOEKU9j8+QQX+LsvbNjax9yuOVT5nc1/PfTTlZltD
 w/og==
X-Gm-Message-State: AOJu0YwVOOhdSDkTcjv8oW7WrPc5Ry9DDGGCwHfa+MCbajS5TnAzPZh/
 mxTcWk3cDmJah5K4bCOnXaikXp0pOItdG+Ci4DraDk++fH3YoQo+qGlM3yUzswNyNbSet++uYa9
 9igUv
X-Gm-Gg: AY/fxX6udLLMLoi4hfAFn/947NM4/NVJk6fmzXOViwzNs8WRxZ6bgQ90QS8RkLMzO/9
 oADSHu7LK2NzYzV2fNL5IvXa0zAuSYwdcC2OoD2e0kob/offMhI5Hlqaz6iqwosS72bC4Yba9uC
 M6rLcKJlv77EF/SN7pY6ZDH2grk4cZ0t7nR4RBmF3Myvfr8BjspY7M7nwP4dNzCEpFKCASk6Re9
 Tps4DmYT0yR8qeHUYTqsC7umapUN8M/7xe7e/U0Y+wqnH04p59R7bU+FLzzkrUy5Mli7an2egY1
 Gn2pJQg+stDuxk8wqVn6R1qGQBCbXXWLaJFbYW23mZSYcHT/E3rBLV0LfzIt1mSsUv74+IHRlgA
 o4qzgdYRCZ+8B5Z+CDwNZu0BQrLKrBDh9aAeBeJqknYKofnq9yA2ZNEBJvgtPjlsgxEvLuev9y7
 pXGOTGh6fZ6oCB3r6FIdCeEOziQGAOtuMe+ygW4tQgwjC+pw==
X-Received: by 2002:a05:600c:3b29:b0:480:3338:292d with SMTP id
 5b1f17b1804b1-4803e7f1b47mr54785115e9.31.1768951468195; 
 Tue, 20 Jan 2026 15:24:28 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804249c5e9sm5865505e9.1.2026.01.20.15.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:24:27 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v4 0/7] flow_parser: add shared parser library
Date: Wed, 21 Jan 2026 00:24:17 +0100
Message-ID: <20260120232424.195059-1-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
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

This series extracts the testpmd flow CLI parser into a reusable library,
enabling external applications to parse rte_flow rules using testpmd syntax.

Motivation
----------
External applications like Suricata IDS [1] need to express hardware filtering
rules in a consistent, human-readable format. Rather than inventing custom
syntax, reusing testpmd's well-tested flow grammar provides immediate
compatibility with existing documentation and user knowledge.

Note: This library provides only one way to create rte_flow structures.
Applications can also construct rte_flow_attr, rte_flow_item[], and
rte_flow_action[] directly in C code.

Design
------
The library (librte_flow_parser) exposes the following APIs:
- rte_flow_parser_parse_attr_str(): Parse attributes only
- rte_flow_parser_parse_pattern_str(): Parse patterns only
- rte_flow_parser_parse_actions_str(): Parse actions only

Testpmd is updated to use the library, ensuring a single
maintained parser implementation.

Testing and Demo
-------
- Functional tests in dpdk-test
- Example application: examples/flow_parsing

Changes
-------

v4:
- ethdev changes in separate commit
- library's public API only exposes attribute, pattern and action parsing,
  while the full command parsing is kept internal for testpmd usage only.
- Addressed Stephen's comments from V3
- dpdk-test now have tests focused on public and internal library functions

v3:
- Add more functional tests
- More concise MAINTAINERS updates
- Updated license headers
- A thing to note: When playing with flow commands, I figured, some may use
  non-flow commands, such as raw decap/encap, policy meter and others.
  Flow parser library itself now supports `set` command to set e.g. the decap/
  encap parameters, as the flow syntax only supports defining the index of the
  encap/decap configs. The library, however, does not support e.g. `create`
  command to create policy meters, as that is just an ID and it can be created
  separately using rte_meter APIs.

[1] https://github.com/OISF/suricata/pull/13950


Lukas Sismis (7):
  cmdline: include stddef.h for offsetof
  ethdev: add RSS type helper APIs
  flow_parser: add shared parser library
  app/testpmd: use shared flow parser library
  examples/flow_parsing: add flow parser demo
  dpdk-test: add flow parser library functional tests
  mailmap: update a new contributor email

 .mailmap                                      |     2 +-
 MAINTAINERS                                   |     6 +-
 app/test-pmd/cmd_flex_item.c                  |    41 +-
 app/test-pmd/cmdline.c                        |   268 +-
 app/test-pmd/config.c                         |   112 +-
 app/test-pmd/flow_parser.c                    |   406 +
 app/test-pmd/flow_parser.h                    |     8 +
 app/test-pmd/flow_parser_cli.c                |   149 +
 app/test-pmd/meson.build                      |     5 +-
 app/test-pmd/testpmd.c                        |     4 +
 app/test-pmd/testpmd.h                        |   126 +-
 app/test/meson.build                          |     1 +
 app/test/test_ethdev_api.c                    |    51 +
 app/test/test_flow_parser.c                   |   923 ++
 doc/api/doxy-api-index.md                     |     1 +
 doc/api/doxy-api.conf.in                      |     1 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   115 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |     9 +
 examples/flow_parsing/main.c                  |   291 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 lib/flow_parser/meson.build                   |     7 +
 .../flow_parser/rte_flow_parser.c             | 11377 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |   124 +
 lib/flow_parser/rte_flow_parser_internal.h    |  1236 ++
 lib/meson.build                               |     2 +
 30 files changed, 9642 insertions(+), 5805 deletions(-)
 create mode 100644 app/test-pmd/flow_parser.c
 create mode 100644 app/test-pmd/flow_parser.h
 create mode 100644 app/test-pmd/flow_parser_cli.c
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build
 create mode 100644 lib/flow_parser/meson.build
 rename app/test-pmd/cmdline_flow.c => lib/flow_parser/rte_flow_parser.c (55%)
 create mode 100644 lib/flow_parser/rte_flow_parser.h
 create mode 100644 lib/flow_parser/rte_flow_parser_internal.h

-- 
2.43.7

