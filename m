Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56EDD2FED7
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9517840E21;
	Tue, 27 Jan 2026 19:47:43 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 7662340A82
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:47:42 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso24866405e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769539661; x=1770144461; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fz2NHvbb+qMmQ1vFAZXlR68oBulZXyyP6iwGgf9eKpM=;
 b=G3reiSIt46XRd53kMS90qMKiDIXNfboAQBseuKeCklSx5Ss/zB/pPiV3E1Q/Sfv4vE
 Y4/AdymRbxuCmSPQ7qUmcOV+RxV38CLGAHDHxQffVlTGE8P8PK+jXpQ942BEa6DzkDsn
 Cl7+jl9kGQvJAu/b1XHCxCaKB2tc5ghJm7OA8MwxIpCBnMhv/7hbN2S+vmz3dXCegSjJ
 2pxxu/0XTIw7TM8q7DDoQ7pSpicItTwcas8tFZW8tja48/it6eaeOkUkqnt4LAuse/kf
 vrO6EQElGrqWHIeiiS9Nv3MT0E9AOmoYw/QZqLjg0HoiswDzHMhPE9ZC/uHUDCwLDvcU
 mJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539661; x=1770144461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz2NHvbb+qMmQ1vFAZXlR68oBulZXyyP6iwGgf9eKpM=;
 b=xFCkpJHtbvXK8aO0D1VnLXY+D9iRVnHSqebkKV86+UN5fY7Ph6Wza2PDoU3/sj88sO
 QHmejCjF+1AORYB672N84HHIoVw/atd0xIj7cydAop4o+ycPmF2RGPTrlgV6FlHKkPRM
 DCkfQ9B1YErnwGS8GAEORYJZy7N0ZvDdW6n2RcJlDpya1ZwvbmDjT+3Z1rgq7qHHDJ9o
 GuzkISSkkqyeQtxIvnmPRn5ysxWxdmF+s6jKhiPghgI2Rlq2icc4oslu3gOWor/sMqgD
 ohgwvYKiT4KUFKVvKHqM+jN76zHERkwoWG/bn9gDpB4h1gOPDYab/xgZB5w4oMQ5hXb+
 ycIw==
X-Gm-Message-State: AOJu0YyHcheCuDeM3ve4WTF7ZMFdsR4yzf3VhTYAGCo3IvLMApng0cxu
 0JzI0FnZon3Ohl7aUYTqh06cW9+1omjj+z0kb62+y6ZFMrZDdzuPbz4KZOf0JHcKT9MEogp3HaE
 nk8C9
X-Gm-Gg: AZuq6aIYAG6cRAYzgjFnKP1jY3MLAyzV/BHaauERalGqGmQJLhR6TKfAbN7/bUeQO9Z
 4A7YWmHNa8aqDHqRh/cPyVaQj78O/fP1OSslSG1+o1Zjeiaos9y+30dkwGoVvy4OXv8VYo36YXp
 2lFDolJkGgewKaMn0uAcI87vONJRuE9RQflG9uHvvCHpjfA89fxpWsCh/0htvlBi4MhLqSnEFVZ
 +1l3d5li6FsitpvLiMdATlxqJf8qpuP6biPdgcU7eG4Jq+8HwqDO0l/sMdlOZd1O515f2WKlLL8
 I97AXGlW1Fq7deQqQbCNph0WcIfsUWjlrGXGyb/QJrMzRJMrY+DCVAN5Z6Y8WFR8DGJ37lzj7hM
 OccjYvwTF5PtkguRBPzLlVdAv7B218zSueukxapJzaFBDJOzcyQULeO2EXL/AFvFn51F/hM1L8B
 mANPXvSWasDuVgousmUK94CMW2wj3kSF30x+5vqy9+0xgadQ==
X-Received: by 2002:a05:600c:4e15:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-48069c0e746mr33615875e9.14.1769539661258; 
 Tue, 27 Jan 2026 10:47:41 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm716958f8f.27.2026.01.27.10.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:47:40 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v5 0/6] flow_parser: add shared parser library
Date: Tue, 27 Jan 2026 19:47:31 +0100
Message-ID: <20260127184738.200476-1-sismis@dyna-nic.com>
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
  cmdline: include stddef.h for offsetof
  ethdev: add RSS type helper APIs
  flow_parser: add shared parser library
  app/testpmd: use shared flow parser library
  examples/flow_parsing: add flow parser demo
  test: add flow parser library functional tests

 MAINTAINERS                                   |     6 +-
 app/test-pmd/cmd_flex_item.c                  |    41 +-
 app/test-pmd/cmdline.c                        |   268 +-
 app/test-pmd/config.c                         |   112 +-
 app/test-pmd/flow_parser.c                    |   410 +
 app/test-pmd/flow_parser.h                    |    12 +
 app/test-pmd/flow_parser_cli.c                |   153 +
 app/test-pmd/meson.build                      |     5 +-
 app/test-pmd/testpmd.c                        |     4 +
 app/test-pmd/testpmd.h                        |   126 +-
 app/test/meson.build                          |     1 +
 app/test/test_ethdev_api.c                    |    51 +
 app/test/test_flow_parser.c                   |   922 ++
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
 .../flow_parser/rte_flow_parser.c             | 11428 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |   124 +
 lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
 lib/meson.build                               |     2 +
 29 files changed, 9710 insertions(+), 5833 deletions(-)
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
 create mode 100644 lib/flow_parser/rte_flow_parser_private.h

-- 
2.43.7

