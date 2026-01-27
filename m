Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C211D2FEDF
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 21:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED47540F1A;
	Tue, 27 Jan 2026 22:05:38 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 6E26F40E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:37 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so52811555e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769547937; x=1770152737; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d03pe+DJ5+1+5up0tStTKLG69okMielCZ9f2ZBKnN1g=;
 b=h2AUXSAFSZf/SfyCziYX5l5d40kgJAqQJCY7pMOLkZwSb/DrSl2AVS01b8Zd6iAnkr
 3g6x9X4KVepA5enGvplGtIrj53MPuasKMUvGDuq1lUS/mMtMCFvsCrj3yrf2UccKOW9n
 okwfJP02qqg4KUxrAz8P+KnMiOhQabkz1VtWGNcR4joGdg+QwjRFsKXCgqkaxJzSPplg
 V10+wKS56mOhlNfhjwZTDZvQFZwszyEB7A/fR3O/GYuZZvBY4GtDq1S7IRbwaUdi2zeX
 jb0SeBN5ekIr3A8NkUbqaIs8KGn0093Ahr89w7HIeyzwxszc6OMeupd71unXl2qC4LcM
 JJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769547937; x=1770152737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d03pe+DJ5+1+5up0tStTKLG69okMielCZ9f2ZBKnN1g=;
 b=aptay48la/jm9ylYs7hhvIIfXM7gvrJrw/QPghiSu5617DbsRrt72ZnVz5XIPrwyHt
 KBOXzBIpbwuEdji04s9kGA3Ddm21iIhb/EbdoD/eRT4IagLujiLkJSYnj3Aq6ouy3+sH
 ksSqdWwQ0A7TObbcBm2s5rqYeuoukPneeFe4pWj80UdTqcm1dmAK1S25SH0QbG+wpdkZ
 oknYFhae6nMsSP6dXdsi+zuukQvJDuEVYndJqUeybuZ6+g+B859BOMPBlzdh0Q45xh4Z
 qt68JE+/LgDE6RbFOZ+rCSmi2HDw2Lm5+SCXmg/kposrnS76RyhdLbp3bkiZbqYwOZbm
 vfHg==
X-Gm-Message-State: AOJu0Yw/t4XsOisjLuxTHeASLoZQ71qGDCsLXKyiP3i5DlM1kd7AX5t1
 fsYVrm4LhryL9yT0tPNTSq0U6gr+/w9eoZLAxufQ1EAeObbQIwAUWRXapx0k98OOL6hsSAgMO6V
 Bgmja
X-Gm-Gg: AZuq6aKgFZ8nvaO79sYfuxVJME6+dWwMzotLOIzVrKC3FtCz3bVQekRLGU+x/8zhpZM
 a3phlVw5eX4xuKiTeCa50O4A8YarwlaKjKv7BI1xw1kLmfsc5NAcW0PzfSzhL6QVn+r9PzPZ6v3
 H5b6G7U2drRN6CxJ3aMTYsjRqpRmFKkxfsguUlvkVdIZOsw3ZAsCzzqWUI1ESEjNJO4PMYFLjtr
 W3G7EarjjLx8JZKbcsiwuRhyUZCNVRvGzB/+U10lFf7nWPZOsu00Tj8nBNJKvDUhJyU4zL1fA+K
 A0DJe1zvlwljbQVpJ61xxq2d8DEkYjHnLWb7dinGgewq/7ocq3jeRYd+kNFAfUoe2sl4WaeinDw
 JKe5weoSpAdEcIdpNhRnTM+WRcRhLNw0Vx93tyFsN50ZMjE8Dw67aJ7Lgl0eJtTEuFL7oCHivC+
 jlNxTGxAIGmM78D2jMb0aK8AbLWWkerG843ntShK6M/p2qBw==
X-Received: by 2002:a05:600c:3e16:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-48069c40595mr40105415e9.7.1769547936581; 
 Tue, 27 Jan 2026 13:05:36 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm2021762f8f.15.2026.01.27.13.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 13:05:35 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v6 0/6] flow_parser: add shared parser library
Date: Tue, 27 Jan 2026 22:05:25 +0100
Message-ID: <20260127210532.301464-1-sismis@dyna-nic.com>
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
 examples/flow_parsing/main.c                  |   291 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    77 +
 lib/flow_parser/meson.build                   |     7 +
 .../flow_parser/rte_flow_parser.c             | 11430 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |   124 +
 lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
 lib/meson.build                               |     2 +
 28 files changed, 9698 insertions(+), 5834 deletions(-)
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

