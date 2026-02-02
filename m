Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051CE7315B
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 11:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B303409FA;
	Mon,  2 Feb 2026 12:37:04 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 0CA92402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 12:37:03 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so32217955e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770032222; x=1770637022; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ae0VeJtRPZFThwVDz0hCENrh2XopiLch5JA8kkV/kv0=;
 b=kroi0CCAJ5kkuPKz9tcsS1xhpvnhkljdoByyJRp9gDlOUWs4BJRZ2JcyTc+US+8DZK
 fX0f0Gc1KmrmY8eft+j7JqQjO7tmWwClE6tdkk/OSrXN37WqwfQK/gowg0yDh2FjTMu+
 f1UMjg+T+l2woK91TtRvbw0tNXrcHW7h/2+wKHHABqn1oY4EfZqvzk431XjVxLDxEYI9
 X4+YST+gWc2QacNcvnVzzAl7ZYQ8LydyINYQrkoIyrBlzLI5ZTYLu6j4ba+9ZGP0zXIN
 qagxouf1Wi50pdeyl88AcNpV8wmVsUnQMSm9GtdDTDqh3iCbRrlU7tRhfvQild6MsPnp
 EldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770032222; x=1770637022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ae0VeJtRPZFThwVDz0hCENrh2XopiLch5JA8kkV/kv0=;
 b=BFK+4M4bUSco07numHqdw9cHB748nrXNVNynhAglFMf82edPx9/9/0csLeL99lJKvM
 lO/Ub9chf6SQLMWnZSVEYjcoKhi8vYOCtSUCezhWx0T8CT2EQ4P0kkwXJgU4X0xJiomr
 5FuQTOhW2bVwK8bu+MQwqPEGHaQZxqfJOdBAB5NGPn9fNuwyEDHOV04LTMxXrk0gDv9P
 z9AOBgofKxQYi4YUcm5xWfdD7eleCGTZLbPjaKb2br6RmGz9ggE6Bxlpa1pOiE1V2oEr
 cdy2dhBPt8dEyBjYnf/AkqvRbspv/Q3vRZIZ+mMX5GZpnyAH9KIALkw2KvRapncI1u2s
 7v3w==
X-Gm-Message-State: AOJu0YxTnCzbgGDqYe0laidq17IpqkParoZMgWI1wM3rG62jpH5uxZ3b
 77q64HYJfDo4rJNGI6WsCNx1Q0RcDCHdgA/n6Mbj7kHZM0afhjwwUOWkKrVxf2BrlXJBGZv4tWo
 jE+dC
X-Gm-Gg: AZuq6aKMfHhhDNFPZ1/pP+AfVbritiip6scoxASUuOk8wwJTm8sZnZdJ2mma6LKt9ym
 Otxg6hAaOlLF7598aIJUlsT+mBT7MlYFN/kIz0nk0XYDiGxRhlNPMzqZWCUsABgqRMq/zTaUo0w
 NzsmrBcw5rQOOANeCw159AnIImj1tCGl4sxx5+IGlSu4f/9v/x6ZgPJDdy/hDv/Si0BnbGP5NJ4
 AlXD3958gds8TSmDdhGoPyZWQe7FgD/KtxS2prNXxcJ6+43qMZakysXECRH1MZwe5MeCwfj0qg6
 jGpQEwv8fEcAGtiSZ0fzX/7Rz+L15HQXkTv5xzSVHbQ5NoMhyUXZ/9VgMW0J7ANLxayxRUMfRks
 N5WWmGX6fa+Yqo1vqKk+8khuF016GI+rPTincWTXnfUiq0BOxC5unIYBhuhvbHaMfIzydV3XjtZ
 6IMwEFeZ//oUgEtB2fGvoJHFnG06x6BETi80Q9UtEi3BXyLQ==
X-Received: by 2002:a05:600c:820e:b0:480:5678:1fdd with SMTP id
 5b1f17b1804b1-482db451f37mr158146645e9.12.1770032221884; 
 Mon, 02 Feb 2026 03:37:01 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee687sm696090615e9.5.2026.02.02.03.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:37:01 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v10 0/6] flow_parser: add shared parser library
Date: Mon,  2 Feb 2026 12:36:52 +0100
Message-ID: <20260202113659.24052-1-sismis@dyna-nic.com>
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
v10:
- rebased to avoid Github Actions CI build failure
- merge conflict solved in rel_notes/release_26_03.rst
- release notes shortened

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
 doc/guides/rel_notes/release_26_03.rst        |     9 +
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
 28 files changed, 9671 insertions(+), 5823 deletions(-)
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

