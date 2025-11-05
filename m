Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F23CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CA7B40DDA;
	Wed,  5 Nov 2025 23:37:31 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id D4C9B402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:37:28 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4ed6882991aso3475961cf.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762382248; x=1762987048; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcORcNoeYdLl0gX3G1z0olXPF9fvHmOEIXxy7cA0GAg=;
 b=GPoOIUZEd3XkK1lOwQr1IrczIjVgUYsWL82ehG13xF/jsfO7T+khskSZRORTqxo+bJ
 ObjsU+FIplUCEAdsNVXqC78cq24BgFjv9Ep8OtaG5XVr1mTeGCLvlA0/cEEVDYbVGX+Z
 Zt/zJYrjdCH8pvyE1TzQRMW8AZdKskjB0Dezw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762382248; x=1762987048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcORcNoeYdLl0gX3G1z0olXPF9fvHmOEIXxy7cA0GAg=;
 b=g0aYN86gAGZcIv8j9MQP13vR8qHCknSlz6jCb/Men9Ar3aR+ajaBz2RJbNojG+0ziE
 Df6gsNOoohr4TuQFJoHlvH9lPuj6e//DO7SQrhjiEm8p/4P9Q824+Zmaq1CyLoSM5ct7
 4Ku515KJq+/Z7EFI0VeiOWFTI7XeUlZuUWKFeEaBbHKYYrNGUOg2bswtDMvAjxxvNA1e
 7ioFzRLVXB8yr5ckF2j2AyKuuIOuKGFzCI9lHAej16JKveuHc6rp1VwtX6ohjm1lttS0
 ueynAHtYOmWjUjxKKGjG8pRKr/KbDRg21UaRFtd5mfNjSR8mhMZUWBQUCDqnt/6HGqLV
 H+Uw==
X-Gm-Message-State: AOJu0YxH46JvjPQeJAdCsTVD6+ywYW1cXUnnQmIFMgVxpS1RyUhMtC/Y
 1PFnij9oZlVqOJgNj8HyxnaIoyVy+oDxIcRwgkOZhRnvywI9WSG7AC6n991wtQvHpjc=
X-Gm-Gg: ASbGnctg2f637mNqfV0ikeUB/iO9zMHr72YYud6mke2k4nfP2i00gSA+0znf4Txu67n
 umTnsvZgZWVQaQaVhjhyDw+XOZsKIP+ZV3YGKpGxNDSIbwx/9/S1/1Eu8h5KA1zEf47PECvRGUx
 5sSwxmG2FYAmHzumE14/K1JGq27E7Fxbr4CLAh3qvXVlnv9bIg9wNtPaqZtVWpHTtpgNG4kbwxD
 r/5xGxcNmQXvQPbvW41RYgGrZUkDfrB+ibd5LRwG3/xwpo5KcG48YrT+AxzuMA6eVU4nPj4GfnV
 cFMlY5MQqhPo5pAKQtLwdFzDowK0GlwsG48d6jPQaovZ2+4PwOE52oeJ4Zztfa/5N8HARYRsTPH
 6Ue8nYo/4PuXicx4OP+XKfpXT1n6w0nXSivFyp3h3pLaMhpXRTam+R+XMRpTyvDpUt/19peeiM2
 loEWTF2AOoyy8=
X-Google-Smtp-Source: AGHT+IHyN1fDqfKe9akKFXlzeAQ/klgSSLbtHr1LKRuNbSKTaVw8KbfoucvHJvtSkemUluEhRHhLpw==
X-Received: by 2002:a05:622a:4acf:b0:4eb:a00d:df73 with SMTP id
 d75a77b69052e-4ed8082eeddmr15934431cf.17.1762382248191; 
 Wed, 05 Nov 2025 14:37:28 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813da43asm4883981cf.27.2025.11.05.14.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:37:27 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 0/3] Add TREX Traffic Generator to DTS Framework
Date: Wed,  5 Nov 2025 17:36:25 -0500
Message-ID: <20251105223628.1659390-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251023013049.1368129-1-probb@iol.unh.edu>
References: <20251023013049.1368129-1-probb@iol.unh.edu>
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

v6 changes: 

-Adding some missing full stops in docstrings
-Fixing doc build by updating references to new config paths
-Update pass/fail formula, simplifying it by re-using the measured delta

Nicholas Pratte (3):
  dts: rework traffic generator inheritance structure
  dts: add trex traffic generator to dts framework
  dts: add performance test functions to test suite API

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
 .../remote_session/interactive_shell.py       |   8 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  52 +++-
 .../traffic_generator/__init__.py             |  13 +-
 .../capturing_traffic_generator.py            |  34 +++
 .../performance_traffic_generator.py          |  56 ++++
 .../testbed_model/traffic_generator/scapy.py  |  14 +-
 .../traffic_generator/traffic_generator.py    |  44 +--
 .../testbed_model/traffic_generator/trex.py   | 259 ++++++++++++++++++
 .../TestSuite_single_core_forward_perf.py     | 149 ++++++++++
 dts/tests_config.example.yaml                 |   5 -
 21 files changed, 761 insertions(+), 81 deletions(-)
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

