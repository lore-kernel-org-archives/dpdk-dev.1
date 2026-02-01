Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655FE6526B
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A90DC402B2;
	Sun,  1 Feb 2026 21:46:53 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id BB5E940150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 21:46:51 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so27629505e9.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769978811; x=1770583611; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TYWdMlKYZ0bpRGkePwmEKaVtUClw5zSP7q2I00dbJeQ=;
 b=dypSrE2Iw3qOO2ixxjhiRFw7KzvyoYFH/sPU9ClfxwrU5qTU4KWvabnX8a02qIUWKT
 ZlC4+OpCbpCbrHv3Kb6r4T11cSjo/vkfFvdyFj/6FMZevrbCngEyc2i5EZLK2+urvkxz
 1RQJ4FoJdw2WWe4q+jVJtL5Q8SODAvQMlmWzAetSc+/N9KPTaq9f13PdlyczIE7ylyR+
 wvKoiuAcUWB1M32gX+dN9yB3rsVmOGg7aOemmm0QlCCsHxtO2KrLtDdWX3U66d6Z2rjS
 o9ZhfxtfPttMqZTQafxqGh4/DVM1/MKoFlNICqIuCx8DC687VkBSkhYWEVavB9fer6au
 +R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769978811; x=1770583611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYWdMlKYZ0bpRGkePwmEKaVtUClw5zSP7q2I00dbJeQ=;
 b=YXE5lnI0vVzlbPJV2inKeBwPOHDivPoV7nQEkJZgqg7TJvi4R1Adei5KZ8cJziC7WZ
 fJQLzhU4VthqniDPEuwzv1kldy2fa2i6GwhKU5MnuBXhI+Jofvx1w4Zkh58ZubMCyr0K
 b1cWNbJVziK4kFrRnDazW6pCisJQzCClmgLfyq/0XTBxvPNZNjJsWpTFV7Wbxq8jN2PT
 tImoEnlLfO2LbflKFJxa8IxpR6/1onqvMpjZzsvslYMSMpLn82MY3/OdBryBhu70MBdR
 3DSt/qowx2PQir2kxb5aFzRqwJEF1r+eXLtnA00Z2ZTQt8OsGX4BXapjtUhc28PMUPwA
 nEFA==
X-Gm-Message-State: AOJu0YyaBV2us0ibyE9g7ikQYPnlVNwQuk1tP2l5xUFPGmZQ+vtqPzBV
 MOUgP3/AXkEIih0jUh3qala3dfHAtRDGsH+/nBnOt9ovFvCyGBR3N6/wBYl/sMg8TuKblgOPYgA
 TV0tp
X-Gm-Gg: AZuq6aKmpJU3rZGpo4WCIztuzz6/Hw+eXpCnt5fIRMtQ7MbCbADBRJPEZW7G4htW/oJ
 T3bXkJEpSil/qQhZLa2x7WQ3744P8BNzc0wJ5ZUuW32h9tATSJafrU3cXLizbZSjfBiql3yADk7
 1D83WouuPlPW5AQQJsV7wKP4cR27KAr67bHvXJGqzBeOjaQ7k3N9lhzfwvJRSu7Zq1KyLaJeYSI
 cdYu/4ht/zXiYAYp0AMe0TZAH/oCFwfjs8zTNNckQUhrqQKmBxXtGIQB+Qbwj1xYVb/l6d24q3C
 HXYroiDPlUWZBsJ6iEbIUcdNojHHNQcT0+TrGGDxEH8gWRhtBqLtvOqqvQNKoBCZ84glE9HCcnU
 4uESUi8goN8PKgD86uHBq3yvfS93ds4y3bxmbvOfY4Yv2KrDPnCCJCedOJ9DVJ6oIq2KVVxWCm3
 FLHRY1I/FJmSbAP4PngYKJNRbEZiLXJWE+GvadRaDQoTJWvw==
X-Received: by 2002:a05:600c:6298:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-482db4bda82mr120259805e9.10.1769978810615; 
 Sun, 01 Feb 2026 12:46:50 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm37721491f8f.8.2026.02.01.12.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 12:46:50 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v9 0/6] flow_parser: add shared parser library
Date: Sun,  1 Feb 2026 21:46:37 +0100
Message-ID: <20260201204643.9951-1-sismis@dyna-nic.com>
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
v9:
- removed extra new line from the flow parser docs file

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
 doc/guides/prog_guide/flow_parser_lib.rst     |   110 +
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
 28 files changed, 9678 insertions(+), 5823 deletions(-)
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

