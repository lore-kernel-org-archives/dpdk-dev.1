Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CECD040C
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 21:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 222994028B;
	Mon,  5 Jan 2026 22:31:01 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 967294026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 22:30:59 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso10045235e9.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767648659; x=1768253459; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7UjDQ9+s3C25wevXQrfVCCuvkhUsSWv9aa/wFiwjmWs=;
 b=oUg9x41aQ/Q285/z3fO5hJno9gPJIrvyINTPIbAExT7ZIVhTybG5rKk/UDoH+gKVhf
 bcVcg9eFevqnZGfzcd1597U3kTAq10J7fTbdOk17wdTg6wGrRBtMNg/SCp8VOKU4L00/
 PjHukVqNb77KaWk0kebxqI6a6MHvv+lnv4+wq2d+BRi8isNhJQwGHwtctV1QQ/Ujmyg4
 usabYZBPaYYouZo49KDrvsg4B9LftYe5DrBg0nCSXhu75OdArMzOxCHNqzzq9dQAqJs2
 1ILWay3yz0SgsD3yWbVuMm+WJXoNgfPa9ufbjfqcznNxMuW4qiPm+dVvtChRO1bjPVaA
 HncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767648659; x=1768253459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UjDQ9+s3C25wevXQrfVCCuvkhUsSWv9aa/wFiwjmWs=;
 b=Pd/NUNrLmcunfXmtmx4hyp1QsdYtBi2v5fIhaQdQOUlM1hrekUbRZSzvBFprXEz3Gh
 oxaXyrX5NuROAOzSV499jJtZpwUzSJn3aj2YdIiY1JPARsLAUVsbfXgUD5MQjRJ5r5g/
 x+ZHseDjKVjYNEjjl87d1RrI33O1Pjm0E4o/Z9VYwz8ckaWckNHdkBU/9lBvEDqFrAmZ
 k+OHl+rumLK5VYxIlLt+HssScU2BJ+xys9uUlSc9Kg9ScYbpAd1GCPcJWnzVlSWwOsw6
 LBDq5sA/VSpgpfT+w0QCJYOKhCwqF2hP8+JGB/tyL8FCkj2egEW9wZ00l6z6ccC8rQhd
 5dLg==
X-Gm-Message-State: AOJu0YyrVgyVn1ouJPIEGJS7QZzn9CXGsgntKd26Xq2nNiGQhwB+qYay
 +7UTvx3uru6E8XBmodyJyLUwWYciMG8LsWqlBkLPPtRd4MwRpJ35/dW90nmQfI7SxP/FvOdF3n+
 YkYCmvXA=
X-Gm-Gg: AY/fxX5Htv9U6waBSf1CwSZD4Jzlynn9qJyZXxhcQnYkXWIn9ugb4MGaidlH5Drtzdq
 W+TNVCeXZMh+l6C1acxZgsXrqgzf4iLtS8etES5slo5BerFXjwMID9t6d9348ifSBl9bbHumks+
 smy/vLcP1A1TM45xt5UeFnYRMCv4ti26cyu+DASV2tG3vPN0iDq/T2BoY2NSx43630IqgP/tJUq
 SbQoz/9Hx+heJLKKP4nVtczCYnFmT3KpBIxFHihjgcCpVQuCunZV6RhQ+AbbHzqrPqweT1KOE5G
 PG9ornqoIEBa0Rr0CWFciihe/QmtTBfJhI7dNpXf19JFvrRlPWThxlQhMo7KRgelRqH6W+ulLeE
 A6BURCl4QPmzqK64X0LntosI0lnkBmK3HRagUD/fWMPwbYmHdVXBD3nIz/2fs4fnp2Rv6ptAPNV
 l42VYGexlUepi19TsRTuAnBAnEhXsUJLMT6QnGUohD1DpojQ==
X-Google-Smtp-Source: AGHT+IHg8bByPBxxg9NRjNLSgFsvjNnNbzXxXyeQPLp6euKgCJohPONGLyI51Hq4EOge1dVxLFxt6Q==
X-Received: by 2002:a05:600c:4fd3:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-47d7f41f018mr7335505e9.13.1767648658575; 
 Mon, 05 Jan 2026 13:30:58 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm8796285e9.6.2026.01.05.13.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:30:58 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v1 0/5] flow_parser: add shared parser library
Date: Mon,  5 Jan 2026 22:30:18 +0100
Message-ID: <20260105213025.749383-1-sismis@dyna-nic.com>
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




Note:
This initial submission is to mainly trigger QA, but feedback is highly 
appreciated.

[1] https://github.com/OISF/suricata/pull/13950

Lukas Sismis (5):
  flow_parser: add shared parser library
  app/testpmd: integrate shared flow parser library
  examples/flow_parsing: add flow parser demo
  test: add flow parser unit tests
  doc: add flow parser library maintainers

 .mailmap                                      |     3 +-
 MAINTAINERS                                   |     3 +
 app/test-pmd/cmd_flex_item.c                  |    41 +-
 app/test-pmd/cmdline.c                        |   215 +-
 app/test-pmd/config.c                         |   109 +-
 app/test-pmd/flow_parser.c                    |   745 ++
 app/test-pmd/flow_parser.h                    |     8 +
 app/test-pmd/flow_parser_cli.c                |   149 +
 app/test-pmd/meson.build                      |     5 +-
 app/test-pmd/testpmd.c                        |     4 +
 app/test-pmd/testpmd.h                        |   124 +-
 app/test/meson.build                          |     1 +
 app/test/test_flow_parser.c                   |   226 +
 doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_03.rst        |     9 +
 examples/flow_parsing/main.c                  |   348 +
 examples/flow_parsing/meson.build             |    11 +
 examples/meson.build                          |     1 +
 lib/ethdev/rte_ethdev.c                       |   107 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 lib/flow_parser/meson.build                   |     6 +
 .../flow_parser/rte_flow_parser.c             | 10727 ++++++++--------
 lib/flow_parser/rte_flow_parser.h             |  1296 ++
 lib/meson.build                               |     1 +
 25 files changed, 8858 insertions(+), 5482 deletions(-)
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

