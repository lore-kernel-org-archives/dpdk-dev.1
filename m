Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AAAD6100B
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D100402C1;
	Thu, 29 Jan 2026 12:42:08 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id A2548402AF
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:42:06 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-480142406b3so6458515e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769686926; x=1770291726; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AEABem8RmX5T9x7AwwFuIhuifGkrcu9ijDgqa84c3OI=;
 b=ZNJfn34laQHS23bzb9MlWvaQyQ5IgRC97UOzk9ZGptKdeScJEUObU8JRJFR+DBUoQ7
 dfhswsINTzRiSmIwsSk9LcMeVaB2bIT1BizGziT3f4vTNgWXBd3tYcMFDKVPsHsxWNlj
 Wsw0LjYfU/o5Pls5ZLhqfF3P55+HaLyQw77ImI7wqWpEHLrShkbZsqXYBVLLkcB/EleF
 pcoBGr7/7ypCBPHHpbBnCxcM7+cdaze9SkJmQtYT8200ahfC86xbYxU/nl9ikTjjkvI5
 1jKRAyrYmYSVcc2yHZak3YX171MwFseVmbOM7lGNfFOEAgf7/1RFp1ICZ6HMO9RALmLj
 8EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686926; x=1770291726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEABem8RmX5T9x7AwwFuIhuifGkrcu9ijDgqa84c3OI=;
 b=DkbR+F5AmRKF6M0/vS6X41SrdPLgr5njxUl4cdRC/KVOssS1IdqtiYb66+EmOD+Lq9
 PWHlBzwdA/rPSbLWxcARXG+D546LdDiXyzLcyEMH2gI/3TVU4pGYKx2k90zgR2x6ws0/
 AHfUYFEWsmoOkzSRwvKfTe2qsjiuihgn+ujLSr8wDPLkRtJyJrRcb7OjCOPcccImeEs9
 i4Pph2/q1TMRCD79PoUqhcMQgmSgBFzqBEoXJEWfBPOlTEoeDbEmPa243mB2FHnOLEIC
 sd3xnd/P4PMBuSnWN5AUkOmdh6L6O8lc6LsZwqdDBOg/GDbyYKv0xLJWCQdtG7pmO8UX
 dEHA==
X-Gm-Message-State: AOJu0Ywe1Ad7z2x76M8mWOyvRD89pMgiACUJShb33jA71UtuDYdJijlb
 QOYY8kkmJyt2PCE5ybO8tg4nJrIEaOoNn6hH9v6UPB91IhBheucRrLLzPkc41v7INqZyBHuo0qY
 DUVEA
X-Gm-Gg: AZuq6aKGYje+ZgSRJNNeunNUl6QrhZ8fVN8/4NLt4BFh7FgI8BJk96J1hlcrW7DH42l
 WSuDd5ezOfquXyJ/qhmbfCXeH0wp+vr7bcWLsQEV+UvzmYX3PB3ZCyCsu172bXNh5ozU7kazMw/
 qr1aY4mb8CUdlFs8Ans602TMeSI6toVK3VPLIOXoh6AML8m9PEnWs/72id4edsj0I2BaFtYSaR1
 8lWgiym9OQLnyK4tTqPLrO5ISX5XMaq7l4L3+vSMJ6PrfcW8+wL4fsie/n+UDjvcBsiv2BTMfKG
 kfTlpC8idIIa/iRXsZjYRS3cdkadBBnSBN+6rrLRrY86kqRF85Cz//QBRzal9U8AdE4DrNJOqKl
 gJRsOhxX8+7vE+Jle1CCsoh8ZU0TIxYEqPv3+jousV0XTcorvAvmc2z5E+0clpe3TKNAYTLJsuq
 kxyoDcdpp3r9WYCc94vMN3YKPKltVp/DdA1I+YSwmKqb7D2Q==
X-Received: by 2002:a05:600c:8b63:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-48069c5fad8mr130458755e9.31.1769686925911; 
 Thu, 29 Jan 2026 03:42:05 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm123071315e9.11.2026.01.29.03.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:42:04 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v8 0/6] flow_parser: add shared parser library
Date: Thu, 29 Jan 2026 12:41:56 +0100
Message-ID: <20260129114202.61185-1-sismis@dyna-nic.com>
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
v8:
- rte_port/queue_id_t typedefs removal to be included in a separate patch series
- move of accidental changes of rte_flow parser library from the testpmd commit
- DynaNIC copyright name update

v7:
- Fixed implicit integer comparison (while (left) -> while (left != 0))
- NULL checks fixed
- arpa header removed for Windows compatibility
- minor comments from the last review addressed

v6:
- Inconsistent Experimental API Version adjusted
- Fixes Tag added to MSVC build commit
- Non-Standard Header Guards updated
- Implicit Pointer Comparison and Return Type issues addressed in many places
- commit message in patch 6 updated

v5:
- removed/replaced (f)printf code from the library 
- reverted back to exporting the internal/private API as it is needed by
  testpmd and cannot be easily split further.
- adjusted length of certain lines
- marking port/queue id typedef as experimental
- updated release rel_notes
- copyeright adjustments

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

Lukas Sismis (6):
  cmdline: include stddef.h for MSVC compatibility
  ethdev: add RSS type helper APIs
  flow_parser: add shared parser library
  app/testpmd: use shared flow parser library
  examples/flow_parsing: add flow parser demo
  test: add flow parser library functional tests

 MAINTAINERS                                   |     6 +-
 app/test-pmd/cmd_flex_item.c                  |    41 +-
 app/test-pmd/cmdline.c                        |   267 +-
 app/test-pmd/config.c                         |   112 +-
 app/test-pmd/flow_parser.c                    |   409 +
 app/test-pmd/flow_parser_cli.c                |   153 +
 app/test-pmd/meson.build                      |     5 +-
 app/test-pmd/testpmd.c                        |     4 +
 app/test-pmd/testpmd.h                        |   122 +-
 app/test/meson.build                          |     1 +
 app/test/test_ethdev_api.c                    |    51 +
 app/test/test_flow_parser.c                   |   923 ++
 doc/api/doxy-api-index.md                     |     1 +
 doc/api/doxy-api.conf.in                      |     1 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   111 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |    16 +
 examples/flow_parsing/main.c                  |   292 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    55 +
 lib/flow_parser/meson.build                   |     7 +
 .../flow_parser/rte_flow_parser.c             | 11420 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |   134 +
 lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
 lib/meson.build                               |     2 +
 28 files changed, 9679 insertions(+), 5823 deletions(-)
 create mode 100644 app/test-pmd/flow_parser.c
 create mode 100644 app/test-pmd/flow_parser_cli.c
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build
 create mode 100644 lib/flow_parser/meson.build
 rename app/test-pmd/cmdline_flow.c => lib/flow_parser/rte_flow_parser.c (55%)
 create mode 100644 lib/flow_parser/rte_flow_parser.h
 create mode 100644 lib/flow_parser/rte_flow_parser_private.h

-- 
2.43.7

