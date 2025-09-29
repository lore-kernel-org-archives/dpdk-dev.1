Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D0CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:06:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31354402EB;
	Mon, 29 Sep 2025 19:06:20 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 9ECED40289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:06:18 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-855733c47baso706702185a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759165578; x=1759770378; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glmGbbTzltVSEALtOW/r4HEnVYhOW9aBQAhzR6s8Stc=;
 b=NnMeVRtMXIwS49UEKcBmTIzMsVYOaQu0otFV1/qHM1Q9oIL/+E4hO26Kcmu21oKABa
 DNuu9AHE0InXJLb2B9GSmW9rkj709jMC+Lf5tGzc+az1Vy8VY06T9bSBX/EN93f83uJ5
 zzp60eKBurz6yAu6e0ek6IhDY+rfqQNqikoaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759165578; x=1759770378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glmGbbTzltVSEALtOW/r4HEnVYhOW9aBQAhzR6s8Stc=;
 b=LQnIt1GoRwPs3dh//Hzb+ScETEZShjNH9UUvghuyxFRyIv+gI5XJwltvR7EWSxpLK1
 lP0K/hysMJSeNW8eJ9G851A4nxDoN+4DfIx3HcoNeIGZa8JegiAx5w3XmpqD04sMp9PB
 bw4CGmTRx2cB8NCAkwdR9Q+Sl4DZ5dAScBP8vr0o1rUvHPknJTs1dPOWEs392YdIfYjA
 RPDq9xDKmQa4V5B/wAKttIfvcrCcW+V9KaU6MhpFgfg5+jdRPKJeJDez/JPjIpt3ExU5
 yYKvqkyguVpsekobaSzPsZZguMKONEPQorC29c514PkYYwE+Z2gZ5wxxfOtHN+MGk3eO
 phEA==
X-Gm-Message-State: AOJu0Yyt9ofPjiEh5Uzvjnx5EiDqYyvFa+iNmEULqPeJ8uYGgqV/RcUX
 mezLUFNIPUx/hKefiuvh+SonCPpqYpAkVhHQdZ0+9ETF2v8bOwCKFvBcZP6ZuTGpBoc=
X-Gm-Gg: ASbGncuw5AXtHm+7areaQPk6wi3Q1wxtev74R+zpTtW/GwL1onEZGX3mgcnuJow61c3
 g6g3cqr1r4ACZKG/jDbQE1d/LEyXhVuBNQ4ePEN02oMesWeKDeR1zR/ZoF8AfC6D83rIljyzWq4
 llC/6O7x8of2pNH1+UQLI5U5iSM4FkvWrafFx3CNAbvZmHzRuzRyEE11w6ISSwpT4fdvaLsNa6y
 +85l5gViheqnQ1K5ujB4LZnFoKQHkjtdhY5fwB69MRrMulcWgRQpK1hapJmcxi/spCJdfKGLwMQ
 0mOXjdszNyMvhz1xBGsr+hEPeKIHV3EDYRVZ/yaZ0F2/SKJHWI6qac59glZDZFIZrTkTWIc0HXn
 mp1lxEnu1bBPLw0sRbgfeOuvCHtJyS1tXsOA33d79JPOWaQ==
X-Google-Smtp-Source: AGHT+IH97Lrk+EWjCvWH46fszlG+y8PP5VqExFOKxOstQfq8w26RPDbKRyCL2NfVc7OQvBYneuyR9A==
X-Received: by 2002:a05:620a:2a01:b0:850:6d5e:cbda with SMTP id
 af79cd13be357-85aef0c6fb6mr1972846185a.79.1759165577770; 
 Mon, 29 Sep 2025 10:06:17 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28c76f69sm869843885a.27.2025.09.29.10.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:06:17 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 0/3] dts: add tx_offload support in dts
Date: Mon, 29 Sep 2025 13:06:02 -0400
Message-ID: <20250929170606.216623-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902114327.48185-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
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

This patchset introduces the support for Tx offload configuration
through DTS, allowing test cases to be written utilizing Tx offload
capabilities. Along with configuring these capabilities, they are also
added to the NIC capabilities class, in which they can be required by
test suites. Finally, a test suite was created using the aforementioned
changes to update the Rx\Tx offload test suite in legacy DTS.

---
v2:
* Removed mentions of mbuf_fast_free being configured for Rx queues/ports
  as this is not accurate behaviour.
* Clarify argument descriptions in docstrings.
v3:
* Added seperation between port and queue capabilites as it is relevant
  to the added test case that queues support mbuf fast free
  configuration.
* Homogenized methods for getting Rx and Tx offload capabilities and
  configurations
* Moved to use the text parser to gather the configuration, rather than
  returning the raw string output.
* Updated test suites to use the new ports/queues offload flags in the
  requires decorator
* Updated mbuf fast free test suite to test ports and queues
  individually. Along with updating the way it confirms the
  configuration to be consistent with the new process of getting the
  configuration.
* Moved the get configuration method to the get nic capability patch as
  it is more relevant to that patches context.
v4:
* Cleaned up some typing issues in testpmd, and moved where prefixes
  are passed to the capability flags.
* Added documentation page for test suite.
* Removed use of optional in the added test suite.
v5:
* Moved configuration and capability handling to proper files in the
  api directory.
* Updated Tx capability flags to adhere to the new way of handling them.
* Test suites no longer need to worry about using the flag prefixes when
  analyzing offload configurations, but will still need to for required
  capabilities.

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 +
 dts/api/capabilities.py                       | 126 ++++++++--
 dts/api/testpmd/__init__.py                   | 157 +++++++++++-
 dts/api/testpmd/types.py                      | 227 +++++++++++++-----
 dts/dpdk-24.11.3.tar.xz                       | Bin 0 -> 17402176 bytes
 dts/framework/parser.py                       |  30 +++
 dts/framework/testbed_model/capability.py     | 109 +++++++--
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_rx_tx_offload.py          | 126 ++++++++++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 11 files changed, 683 insertions(+), 118 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/dpdk-24.11.3.tar.xz
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

