Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07784CE9D64
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16A674069F;
	Tue,  6 Jan 2026 16:38:54 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id F05DA402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:38:51 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so6975035e9.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713930; x=1768318730; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ELIEZeC3DXU0ijXd5RSgxkSf7ogBdBc2wZntwUCphXg=;
 b=nCxKhZzuNroYDR4goZSK5EUx7oABS/dSFmOBsiE3NREDhE/saDvDBV8A7wqd+5i+9P
 Q3OuT+meL64YDKRjya6c9h+zu8LVUXHaJN7q1hswxQVoDjZ4wcbOu5Re8WoUhAndjuI5
 6SjBhDAmFiYJ8TvTQwYTDfBCew5LTrx0xDpSREpNlelfAMHwaaQtEKzSZwXubjTNGVcY
 IzEq+Va6x3hX7IV+7Z8gJ58fJ7kLGIXdwnK/nCW5U2xhkxahbJGuHBJFRG7Z+e+iaUCi
 bJNiRR8XxTL23DdpVlS+LMZWcio88ymdU2Wgo2mqyr065AG1Dlemc+UDXHMWHrr19GAh
 h5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713930; x=1768318730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELIEZeC3DXU0ijXd5RSgxkSf7ogBdBc2wZntwUCphXg=;
 b=IuutjuwfnY2DxJhxWL1YEqy1yUTMFLkycZm52GR2QItkFsk0y5CjCac6Jj56FewXTa
 oQJzTGwvSb3G71WltfN6/pyQOoKmCA1VjWc5XKPssOlDIefyDGi1/F1AS+qUtQ5KXL5a
 yJgaexHxuPlmGKW1C4/yOqA+17+SGe2HFDWO8lTqzB4jb9KdT9BRX0u+RZFm0xLEegD1
 0KZHYlTODcfSCVZ9cg8hoGdfOKDbzLPi8OVA/IQl3/ZEc6BUmoSy6aTiqyHJqjt9q5MX
 spBwdFHtTefSs73PDwX3XOOm1Pid6x+zeB1RwdMPU/n6RVYLG7aRzTuYn52FfN8+1PWp
 YYrQ==
X-Gm-Message-State: AOJu0YxsGO0+FvTMFSzotGkP9c6d6+MeX1olAi2s2t44Zzs4Q6EEsm1v
 YQH4IltIy6Gh1s7+u2HhRnCUI+uhI9XbPFknE90L7Bw4zLNSdo29QiA/41rR+9tNgWY1SRcZ9sZ
 fX3GX
X-Gm-Gg: AY/fxX6YUcLkicvlDNRr2J2UfYpGtqyYEiaO0fFU8Nzyll9afF4ig+jE0ynP/N8WemB
 zDmZNhpojBe4w6BDAnqBYorexDPs8XYtfk99iuo3VvXOeedMyfoRQF+mdH672YBNillloAF3ktw
 eL8DUppiOs+aWQBBnmYBITBPGmkN4A+CyFh7MUFsUS2Sa0yeXQw3U2M7lvZ2MEGf7dEosS8xige
 gleLA/1A3BVCUQVaKghSyOap7lJBEag6xwzWx1Qs1ADdS8dS8MeVV8ZbKJkq4OW1TMat9sLvH7p
 ONtbp2axL9bjCe6rUn+sDJ3s5gwLw7xecy5sYm3KWTcACT4jzPcSQRqSndRuYD1G5pOd+GXyC8h
 W82YeZw7k37bYYT25Hnz0hbFpdf27HF6wL4uxXG81s5r9Et/gv76N4a43IE1uTJUQRqDs5WuMC0
 YuOjBMQZlwwz7rdz4vTBuoxQ+G0kWtoF2Jw4uAP5XCwlSwMA==
X-Google-Smtp-Source: AGHT+IGa6YijMpJvSdeTl3h8FY/Tqj/yP0Qw7LvCYtFuo4PN6FbPxa35iQ0BSap3qT0pMybkh4iavQ==
X-Received: by 2002:a05:600c:4ec7:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-47d7f0a73a5mr31382515e9.37.1767713930042; 
 Tue, 06 Jan 2026 07:38:50 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:38:49 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [RFC PATCH v2 0/7] flow_parser: add shared parser library
Date: Tue,  6 Jan 2026 16:38:30 +0100
Message-ID: <20260106153838.398033-1-sismis@dyna-nic.com>
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
The library (librte_flow_parser) exposes:
- rte_flow_parser_parse(): Parse command strings into structured output
- rte_flow_parser_parse_attr_str(): Parse attributes only
- rte_flow_parser_parse_pattern_str(): Parse patterns only
- rte_flow_parser_parse_actions_str(): Parse actions only

Testpmd is updated to use the shared library, ensuring a single
maintained parser implementation.

Testing
-------
- Unit tests: flow_parser_autotest, flow_parser_helpers_autotest
- Example application: examples/flow_parsing
- All existing testpmd flow commands work unchanged



[1] https://github.com/OISF/suricata/pull/13950
 
Lukas Sismis (7):
  flow_parser: add shared parser library
  app/testpmd: integrate shared flow parser library
  examples/flow_parsing: add flow parser demo
  test: add flow parser unit tests
  doc: add flow parser library maintainers
  dts: fix invalid f-string syntax in testpmd API
  cmdline: include stddef.h before defining offsetof

 .mailmap                                      |     2 +-
 MAINTAINERS                                   |     3 +
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
 app/test/test_flow_parser.c                   |   226 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |     9 +
 dts/api/testpmd/__init__.py                   |     8 +-
 examples/flow_parsing/main.c                  |   345 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 lib/flow_parser/meson.build                   |     6 +
 .../flow_parser/rte_flow_parser.c             | 10774 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |  1304 ++
 lib/meson.build                               |     2 +
 27 files changed, 8600 insertions(+), 5507 deletions(-)
 create mode 100644 app/test-pmd/flow_parser.c
 create mode 100644 app/test-pmd/flow_parser.h
 create mode 100644 app/test-pmd/flow_parser_cli.c
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build
 create mode 100644 lib/flow_parser/meson.build
 rename app/test-pmd/cmdline_flow.c => lib/flow_parser/rte_flow_parser.c (57%)
 create mode 100644 lib/flow_parser/rte_flow_parser.h

-- 
2.43.7

