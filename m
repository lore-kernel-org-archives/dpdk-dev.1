Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C8CD4F2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 01:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA0340289;
	Thu, 13 Nov 2025 02:27:36 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 0AC8640151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 02:27:36 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8738c6fdbe8so2960236d6.1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762997255; x=1763602055; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zjfGy9+1L5tGfd8+QjlHhjPb7kScqfmzmtwE6WM+XZI=;
 b=WJuz6R/7VfTuE2392SkZvDM1VLI6r5fvopvjfXJ3lCS+PIOni9XInmEBYSJDiuz0yR
 OvY/FkWP2jLPSPjOpkLV366j4HX43TI+p5gZtoX7P5gsN6BCvLMZ98v1HYBd+Hg/Yzno
 dKpDJMJJIMA350AU7XqvZ+JbJL8B5dw5mZPlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762997255; x=1763602055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjfGy9+1L5tGfd8+QjlHhjPb7kScqfmzmtwE6WM+XZI=;
 b=SjAEB01268hpXZVJK+K9UqsLzufETOvvByMVZDF1ej0cx3jcpXuCj60fWjEwxzOqfc
 1+LBgtqKjvA6EMcuO8ZyiqvjLNNWnybyOhS/gm+EK5Zh9EkTqIBB5vrAHG1r6lLU/Woq
 TDuAhU10dEP4SQDlnF0oPuv2RNRZYHkDG9AN8QnomJ0TAmTso1DS7hYsPCYRAw/frA5P
 Rv3wmj0mudpdfoDADSK3N79wYUzYd/yLhlhAJ/IbBLutLHuiGFHjmv+CIWIgGaY88aCG
 zDsNaT5wxFhfk8PUU5xthAC+3W8yLXQE1bpuvFB1sIfFmPOQ0exR+XaWmBi4YG9AL7AU
 0TAA==
X-Gm-Message-State: AOJu0Yz7nEC0ZL68949q81/RtfZ9zKStEIoPTf/lX24XUkAvf47Ajx0l
 NfBvu773/zvsGHeGi4XLSmJQbr4Fyf4oDmG7tFuQ1ZQOXiEs7S14deq2srI97WbPK/U=
X-Gm-Gg: ASbGncuAAIzheZhnub00GRtbh335P+7tTFJllhOPR9TO1AdSsPhI5PtrPL+MMpVVmp2
 vT4L4Yye1Z69LZiGAcH4oREqeUDo4RJLtlN5+9v7fXeSmHidWFYGeOfhG0WsoQu5Xbuvq2XbVmA
 E1xctwvGB5FkpIhfXKoBY8KzloypTCowQCPgIB9JneK+Qr4FFKyRjlqG+LobLjs9nIWZuzt+8wU
 uhMxs5BrFI17lUszKEzFBstbJythMP8bpvHphXkvxRgJVZL0SxhcEWHij++nOVVEn9+q5rb2Bjz
 KgkQ6wLg1K5vgNggJnIdFuXRLu3TDtHWCIn0IPgVw9EPgnLMFtXACVKvUVv0J2T62+rCZc3Y0BS
 /l/nqEUDhigSFoBvv1cz1maItn9F3AwMlYQ0WKc613F9CEeSAGypRZMd9HLbaFdWqtTcE+aIC0L
 0uPtI46x8E3HI=
X-Google-Smtp-Source: AGHT+IF2C2XeBugS/cmKCH4jjWpc0Gb9itg37iSTjPE4hV8aE7JYe/Y32keTOndCn8spSF3dsDu6mw==
X-Received: by 2002:a05:6214:2021:b0:882:4e6c:5fe1 with SMTP id
 6a1803df08f44-882818a8d8emr22134466d6.23.1762997255306; 
 Wed, 12 Nov 2025 17:27:35 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882862c6449sm2752846d6.12.2025.11.12.17.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:27:34 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v7 0/3] Add TREX Traffic Generator to DTS Framework
Date: Wed, 12 Nov 2025 20:26:22 -0500
Message-ID: <20251113012625.1058035-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

This series adds support for performance traffic generators, and
includes an implementation for using the TREX traffic generator for
performance testing. It also includes a new testsuite which measures the
single core forwarding performance of a SUT in millions of packets per
second.

v7 changes:
- Added missing spdx tag
- Per DTS meeting conversation, add 16B descriptor tag to Intel builds
  to allow for the highest throughput on performance testing

Nicholas Pratte (3):
  dts: rework traffic generator inheritance structure
  dts: add trex traffic generator to dts framework
  dts: add performance test functions and support

 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 doc/guides/tools/dts.rst                      |  55 +++-
 dts/api/packet.py                             |  39 ++-
 dts/api/test.py                               |  32 +++
 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   6 +-
 dts/configurations/tests_config.example.yaml  |  17 ++
 dts/framework/config/test_run.py              |  22 +-
 dts/framework/context.py                      |   5 +-
 dts/framework/remote_session/blocking_app.py  |  12 +-
 dts/framework/remote_session/dpdk.py          |  15 +-
 .../remote_session/interactive_shell.py       |   8 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  52 +++-
 .../traffic_generator/__init__.py             |  13 +-
 .../capturing_traffic_generator.py            |  34 +++
 .../performance_traffic_generator.py          |  59 ++++
 .../testbed_model/traffic_generator/scapy.py  |  14 +-
 .../traffic_generator/traffic_generator.py    |  44 +--
 .../testbed_model/traffic_generator/trex.py   | 259 ++++++++++++++++++
 .../TestSuite_single_core_forward_perf.py     | 149 ++++++++++
 dts/tests_config.example.yaml                 |   5 -
 22 files changed, 778 insertions(+), 82 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (88%)
 create mode 100644 dts/configurations/tests_config.example.yaml
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py
 create mode 100644 dts/tests/TestSuite_single_core_forward_perf.py
 delete mode 100644 dts/tests_config.example.yaml

-- 
2.49.0

