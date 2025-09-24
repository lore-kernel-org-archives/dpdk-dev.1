Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D2ECAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:47:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB2940661;
	Wed, 24 Sep 2025 18:47:36 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id AA4354065C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:47:35 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-71b9d805f2fso63987446d6.0
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758732455; x=1759337255; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+qhqGVK4Z2brIgiVnKFpXsK3UbVQApay5p858Dnu5M=;
 b=eS4hY0t0+6qqEFxzS2Baf8mWQBRD2CslMj9L8C2nA58uqKyMke9guwg1bx9nMn1YuC
 9GVqfnQdyJmh40aNGceQTVh3vjp8z2TRbQCJM0HRuQcZBlmOQfj+20CN3LTD7l91SAc4
 O1aN1Tuo3qZs7f36NYCBzTHl74MWjJaIE1lJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732455; x=1759337255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+qhqGVK4Z2brIgiVnKFpXsK3UbVQApay5p858Dnu5M=;
 b=F5GIf4q/WPx3VrG79+x/F5ec1Hec3HurvOfYqV1EA1OY63L1Ruz9DNFdwYTxASWK0S
 ISaSVXNoOPAkdN6gz1NAPnoyUN4StR4rmWKE9qgiYlo1xZJFFieyonFbyqhJ3eGqAti9
 SqImUiTbLf4yfnmPgKFBdFyagA3VvS4KU/6bDeI1v2zKk/UnRG9USFqH2zTxFDh+jFIh
 37MaBfpGvzTws7ZE8vhiURdekkkCLF1YQqUQQg7TcMT+ocKc9sRqrNc0fq539KpeuaTu
 LXKk0QaMGpOJgwikE8Z17Z3f3n6p+yaxKxyfOI26+C8P6aTs+S6adBYq9usMEDEv3ojD
 fOaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBhLsQitMkYg4DpcNJxXzqoS5ctYnDA5/7Y+tEjCapl/Zt8dPo4td2r/Jszfy7jGl1GLc=@dpdk.org
X-Gm-Message-State: AOJu0YziyzzUKumBvVctBOsV8l+x2x2b0tgxmcKVDXutrpq1aXD77Gn9
 mr2oEeiVPn8jj+53gSY0zMiCYD3sl/Wx+OYQICQSJW7uFFmsoarTD3cUbvMzlytzOD4=
X-Gm-Gg: ASbGncvM8YtCY5f1AMkXWEaaBguREMy8LHa244LO3yTEUeaczQNKJlbmNfg0vrfkiK3
 k/r8m//uTpcU+c/cqilyrWSgj+Wz72RznUmq8gfPVTKZB6/MqZdawzTzPU1U9oV6EVV8n/h1iJO
 1Ls3ZrGFh1egAsMJrvpSnlQxw1fUPdSjMZeN2dSvUyInobLr+4KipE44rIsBBILP09D8lJO78+a
 2/iBsGCmBU1p0RMUgSZAQWM56J/uMGadi8/3GAETOel+2SsS1rcX8BEq6Ud3OXRQzuuM3Q/6UvR
 Q92tanYFB7tYj7FRsF/xnsvhprDA4QfATQyJ4B+3s5HtN1zTft8iUVvp2OZ2PnYy2DzqpohmKV6
 6Ui8LmIbXnlDITGR516r6yDXh+K6z8zq6ix2/4cYkiWV24g==
X-Google-Smtp-Source: AGHT+IGXd/FxF+/T0yMIxO3eazAgvpFLBl1TdVvTdcNfvwzmsAxveMIF5Jk837XQXwYUgYx1uZQqKA==
X-Received: by 2002:ad4:594f:0:b0:79e:88e2:1e60 with SMTP id
 6a1803df08f44-7fc2ea40b7amr10040116d6.29.1758732454619; 
 Wed, 24 Sep 2025 09:47:34 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7a4c5785d49sm76849996d6.63.2025.09.24.09.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:47:34 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v4 0/3] dts:add tx_offload support in dts
Date: Wed, 24 Sep 2025 12:47:22 -0400
Message-ID: <20250924164725.168773-1-abailey@iol.unh.edu>
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

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 +
 dts/framework/parser.py                       |  30 +
 dts/framework/remote_session/testpmd_shell.py | 738 +++++++++++++++---
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_rx_tx_offload.py          | 128 +++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 7 files changed, 789 insertions(+), 133 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

