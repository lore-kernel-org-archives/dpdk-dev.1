Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BFAD46634
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 23:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D544025D;
	Fri, 16 Jan 2026 00:01:33 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 37A954014F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 00:01:31 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so10800955e9.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768518090; x=1769122890; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8bf7ULBXMP8byxH6iulNJKMxN+AIO+E6qMKChMqABGo=;
 b=LcCeW0SBFquVg4c7pkdrb1kjHKw3AW4aiII9W7JjMbehRS1fWxjyubyzxVshG6pPdv
 iLjydLcJo7dyE3IWP3ZA3vz74a4OEsdVt/Tqb3kR4UwKeHWsAIf+vNQlJYubvosBTtk3
 QADgR4VEocy7LD9k4z6V2Xm+8IhJjsO+L2mg34LEwkb6U7XZziSo4oLlXZo9Mhk96dki
 ngK734R8f0UK2hcMl5qrq6y2YNxqE20KcNw8TIyqvVIiAwez/hdsQGCxYjUNkgevTAu+
 pLBLtmDOqDc6uivLjUsh3GDy5XOuW/wZ4lLlYvTd7RL4LhAo1TBjWBsikX7djwhYs1QG
 DQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518090; x=1769122890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bf7ULBXMP8byxH6iulNJKMxN+AIO+E6qMKChMqABGo=;
 b=snguPdZ/bIL2iuByan3axdYTwP9iUtVbIW2tdyWso4urAiDO1QlY+jygsv7Z0DlDhA
 /hnV9RSWbC+dctCcFvS9Q2Sp+IOYSM3auYYJCLXpp/eRtZxqpIKLC0zcXYkDGX+tMHqq
 ENkZRUaIvaoN5ng4pnfyF3L2ogRQbZf+GuxYAUtlHmFQRm/LehPeBWUHfTJltOZtGZe9
 PudVzualoXrM1jxt+9fjIwePaBJDXYZs65EjuJLXnfY3xT9oPzH+cRBttMjTwOjl64Xi
 YC4Cc8MUjW32SW6/JRTphK6cr1GT+T4x6Ts9Iag7isibDQylO3PcKTFlrLECqpfu0F2H
 13Qg==
X-Gm-Message-State: AOJu0YyHP7gTjDY8iDEgl70gdIGRCQhDbBJ/IGrENl4W9C2uSWAnB2de
 s1f9RTQB5GvteEx/9pk1SZnC6v5+f5Z+WxEoHOESmWEC82D/uZ9pcUh0T6BSzdis5PYo9sHfstV
 B4aOE
X-Gm-Gg: AY/fxX7K1po7us8OL61DOuR8nSrGtEMt2dnffTsInCNZfVcA0Gm3vBFQGkrvYXZ4Rep
 llfluLi3Y8ahWf+xqVmmQVpZwHtBXVaqjXRyJWxofnS1T0Ql3A5FX6kGC+09adf/h0kKssizaS9
 aJA+x/hyC5v1yeT5kZnyLbdfMFFVHuRr5o7lsD5SGnLzXWglehP4dsl55ZqxlYoqOuID6/q/4rm
 8rTeLMJGwlKXusLV5eeF2fOdb9Vd9nJVkBA13L4PIq5f0wrVm1egYrpauXgPK1idpDI04c+l90Z
 B0+O02lP25hv6/eE3nunQmJqXR4X1aa0AtXR66TGKQjIIKtIhyUjpSSvz/XezCHQYZVTKrqVNjX
 sGSTgyT1RQ3L+K9SvCKMfZeLmtHq/MK75088yCLDStAc11gbFuUJyAiM7cR7EXQZ+hCGX0n06f1
 C4d8ODtTrC46eIqnqRPQrA3VGjw5/hsCHsckme6TNu2ysEcGahSN5I1AQSclCeEA==
X-Received: by 2002:a05:600c:8685:b0:47a:975b:e3e6 with SMTP id
 5b1f17b1804b1-4801eb035e1mr4875225e9.18.1768518090201; 
 Thu, 15 Jan 2026 15:01:30 -0800 (PST)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dedsm1572918f8f.9.2026.01.15.15.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:01:29 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v3 0/7] flow_parser: add shared parser library
Date: Fri, 16 Jan 2026 00:01:06 +0100
Message-ID: <cover.1768518003.git.sismis@dyna-nic.com>
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
The library (librte_flow_parser) exposes, among others, the following APIs:
- rte_flow_parser_parse(): Parse command strings into structured output
- rte_flow_parser_parse_attr_str(): Parse attributes only
- rte_flow_parser_parse_pattern_str(): Parse patterns only
- rte_flow_parser_parse_actions_str(): Parse actions only

Testpmd is updated to use the shared library, ensuring a single
maintained parser implementation.

Testing and Demo
-------
- Functional tests in dpdk-test
- Example application: examples/flow_parsing

Changes
-------

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
  flow_parser: add shared parser library
  app/testpmd: use shared flow parser library
  examples/flow_parsing: add flow parser demo
  dpdk-test: add flow parser library functional tests
  mailmap: update a new contributor email
  dts: fix invalid f-string syntax in testpmd API

 .mailmap                                      |     2 +-
 MAINTAINERS                                   |     6 +-
 app/test-pmd/cmd_flex_item.c                  |    41 +-
 app/test-pmd/cmdline.c                        |   254 +-
 app/test-pmd/config.c                         |   112 +-
 app/test-pmd/flow_parser.c                    |   406 +
 app/test-pmd/flow_parser.h                    |     8 +
 app/test-pmd/flow_parser_cli.c                |   149 +
 app/test-pmd/meson.build                      |     5 +-
 app/test-pmd/testpmd.c                        |     4 +
 app/test-pmd/testpmd.h                        |   126 +-
 app/test/meson.build                          |     1 +
 app/test/test_flow_parser.c                   |   698 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |     9 +
 dts/api/testpmd/__init__.py                   |     8 +-
 examples/flow_parsing/main.c                  |   288 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 lib/flow_parser/meson.build                   |     6 +
 .../flow_parser/rte_flow_parser.c             | 11320 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |  1306 ++
 lib/meson.build                               |     2 +
 27 files changed, 9300 insertions(+), 5773 deletions(-)
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

-- 
2.43.7

