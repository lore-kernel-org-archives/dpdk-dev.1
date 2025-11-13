Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B46CD4F35
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 01:28:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D66C1402D5;
	Thu, 13 Nov 2025 02:28:40 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 973E040151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 02:28:39 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4eda057f3c0so2933141cf.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762997319; x=1763602119; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjfGy9+1L5tGfd8+QjlHhjPb7kScqfmzmtwE6WM+XZI=;
 b=VujBS+hu8hds6seRdoN7dApsxVv/SOEQclIqKdiqh8kOiuJzld8eyA/RSTQbMvhLhr
 6kKfqCT0aVQHR6BN5xFY+x0Vgvm0t1Cr7sbs3JVhN5dasejDOFjZxKyH+vzbnBWPEUqT
 dVUzhRr5ftfnktFDuV97mSifkvhgq/RrqpOjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762997319; x=1763602119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjfGy9+1L5tGfd8+QjlHhjPb7kScqfmzmtwE6WM+XZI=;
 b=nXF6vgkBmLIIq2NCST2P0KqjWSQhfsqwhdcbXVnCiIiAIImqr3JSc3RJ01HVuEGBWY
 50JBUKkhfyoyrn2cDbWROwWLxjRuPP3Fl5/E8a1zpjUHM1daDBVfKKZ2HWmBXqVwDcRg
 QN7S9cOsrNCqSmDtJ++PBrhOvR0DxO244/UZ8vPG2HJBFWv8NajL5roBM7N3dDDj9TQU
 LYfkoCmRmWB/cisgnw2oLVtlyjmqRzJPjaSGCcidBRBXduxkX6cLFuC/VqTA+D81+5wr
 cV929RCFvv70hDYD0xgEF1MAUP0bGTyONMSj0DopfepN/CHXXLRNUEOAXfmyjlT2BR+r
 b1xA==
X-Gm-Message-State: AOJu0YypW2K7f7RG0ECAxzS6FJlrW3t4sLh2dy4xparzwsQ73WBT373O
 shEn5CapceGb3t3ipskMjHUOCURGgnMHXIwy7DOQPAxGGDkzhJl//57s7UbmP56u3jvxViNzveW
 xtdTo7eY=
X-Gm-Gg: ASbGncv8cbqZoyvYCv+CVnoVbUcMtH0RTVIsJYdmdPg56FXb01Q2Y127xsDLbNu05iF
 8pD+N8ZbovkAkeNf1ni6IB4mrse4pGBVpMtm9nDFcZsX+Dw3EWNbwXQuGouo5lI9URFjTdLuCAa
 dZWqLMFbb4GIC1zW8BmPPHoITbL6QIfn6tFwAszs3Cnw8fw23uoShaxfAEttuGPrLdDTieCWHei
 yktyjHdR4FllsWEP7j5tFsp+hz1ZNIxIziDCQlcpt4S+N2A+oeq3STZFuwgcn4Ybmf62+KhKZ59
 ziNuE119wHojMwTSnPZ1iRRmT9C+Ys4cEFWEmRRaQFcPuJJgKWkkdFi861Cv1oAXcoWEjotAVPq
 E1OagNeSGWyIGbyhCUB/nm2ye1t8zSopB0l0Xhbf3sNr/uTz4SyiL8KzwrV8sloniL31q/7NMSh
 +nf0UxkoS5KT8=
X-Google-Smtp-Source: AGHT+IGxN9bhZnVT6qquGrG6Y8GSw55k6FrxPIzs04GERL7uuZOz5k925Q/jwnskSEHiXz1kAVPq2Q==
X-Received: by 2002:ac8:5a06:0:b0:4e8:a9a0:48fa with SMTP id
 d75a77b69052e-4eddbd38006mr82330791cf.30.1762997318857; 
 Wed, 12 Nov 2025 17:28:38 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede86b3820sm3567821cf.4.2025.11.12.17.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:28:38 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v7 0/3] Add TREX Traffic Generator to DTS Framework
Date: Wed, 12 Nov 2025 20:27:29 -0500
Message-ID: <20251113012732.1059669-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251105223628.1659390-1-probb@iol.unh.edu>
References: <20251105223628.1659390-1-probb@iol.unh.edu>
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

