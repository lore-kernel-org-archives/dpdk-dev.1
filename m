Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80169D46C04
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C04F3402B6;
	Wed, 28 Jan 2026 22:58:58 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 8A7FB402A7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:58:57 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so2015345e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769637537; x=1770242337; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BSCGf0MVJPg5jRWBNn5z/I3Q3NcAWnWta9wT4UGco+Y=;
 b=UuBx58b6ISZXp+NFmw8r0wXkVb7xk/mxTM5q+Z1+TCW0581mFnItMDxAgswgGNC1Tw
 mdMFJgHK0je5u4fjO9TGMJjjYXgUY2eU7ZKMEkKY7V5Ld4am+X7FW9QnTYqd64pjOeFT
 g6dwfk2SNVsLz5RkzoWa9yMxtl+AlOVNz7HFq0FmWzoS1UwbWsSrxS7oecfzStM954AT
 4kJ+V3+dO+9zSJbTMAX1DdblL83xBMWHA+kAt4tECKmddDWHDqav8I2dH2AFNMaVElv0
 0wofXK2N1XRnp8cZwYPYBt4Qo2l4dVXc1u2F5KShHE73Pd1lGL3ZnIYaYcHnVUyQ7fLf
 IeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637537; x=1770242337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSCGf0MVJPg5jRWBNn5z/I3Q3NcAWnWta9wT4UGco+Y=;
 b=qJgJikH4SmG/xtddQT1fZRUZsjAp2OZHs16Y9Okld3EKtoYrXq2B5ZoD+2JGYK/iBn
 3kIjWYFSpwcDaPoS986q3OxHChvlY4b8jexqQryH2U1yjVLOlByD8qjutSrzkZdDarRt
 qrYJ7iX6qx0TEf5QnDkzJtWwcdUe4+GtPNKcWZ5ohnzhdNMHYj/El0KKvjOu9Jp1sgJq
 /NOC5UcRfB4yxKzsA0QboWMx/Imh7Vo0nIHDBe4Cslh+YoVtDnMkIm+cFH4IlC9JqkXc
 V2zUcrOoESltGyzSV+KTsXp8IKNDixYCnxGFlw1IM2kPj0yetsXtHeZVIeiaR3/sOD1t
 qu2w==
X-Gm-Message-State: AOJu0YyXHXVSgisWfa4Lipg3UyMKOWw5FXzZuq46slrh4ioUiXl9ZP5/
 QQQSZbiRiCJSDaPgXjPxNDUs+4vICdc83k3QPWdYuq6aBiS3raPTzH0DwbGR3Y2YPnxyw6RAoF5
 puMrx
X-Gm-Gg: AZuq6aJrOWmJbQpxx34d5SMKWePa7n8cr+Y2YJZ7+0tFYaqAHKBHYndgDBE0TYlHQsp
 KDZyTplrxuDMCxAijNYzeRfiBdyZdL10jzSjZh9cc3obcRqm5cMPjqi/2CDzaXP4pAuBEXobwzA
 pkwKpTuNKLKkVQCKxxs/Jpton9G5zEaod8g2N+O/tQKwpwSZR1moGVkwXiInVzOcO73iw/a46qf
 U/ku7ju+pPaOfLx/EqN5MKfbkXcC+NOzTIOQX/NdRPoWZZZErn+xizn/J18yWiLw55RdXQZUrIk
 FtCOqY99WDeVFMFEJNOqbaek2DfxFOyqhP3UBVIoC85k6/j+95pVi/RlZ5tFzlCA6F4CIiiz0Jj
 Y9iLx4r0s0aRX624kgrbXmStq+MM3k1cZ11aM+fEenpe7jPQF4dl3sY06zmlhbjvotXQ6zEpxhV
 23qi4KrEg/YVOeBzZZbrsrlScZMv8wWi+cuktyCVv5+StZ5Q==
X-Received: by 2002:a05:600c:6217:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-48069c0e6f8mr82199355e9.15.1769637536788; 
 Wed, 28 Jan 2026 13:58:56 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm91536885e9.6.2026.01.28.13.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:58:56 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v7 0/6] flow_parser: add shared parser library
Date: Wed, 28 Jan 2026 22:58:32 +0100
Message-ID: <20260128215838.73502-1-sismis@dyna-nic.com>
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
 app/test-pmd/testpmd.h                        |   126 +-
 app/test/meson.build                          |     1 +
 app/test/test_ethdev_api.c                    |    51 +
 app/test/test_flow_parser.c                   |   923 ++
 doc/api/doxy-api-index.md                     |     1 +
 doc/api/doxy-api.conf.in                      |     1 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   111 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |    21 +
 examples/flow_parsing/main.c                  |   292 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    77 +
 lib/flow_parser/meson.build                   |     7 +
 .../flow_parser/rte_flow_parser.c             | 11437 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |   134 +
 lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
 lib/meson.build                               |     2 +
 28 files changed, 9715 insertions(+), 5835 deletions(-)
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

