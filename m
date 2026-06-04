Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE1CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57247402D3;
	Thu,  4 Jun 2026 21:33:30 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id D05A04028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:33:28 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 3DAFEEC00EF;
 Thu,  4 Jun 2026 15:33:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 15:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601608; x=
 1780688008; bh=98uAIOYyLY8pjgR8o4/ZR/tQfjG9hEd792CkS6UYbg8=; b=g
 85hj2mFLu0gmcIpn1PeRPTSjNfWrH2rZgvTw0oiNVnRrjJ8N1WkSd6dEYRzT0H2K
 +NPeZrVrem4x+bxHxmN7yRz7JgXxDEihOBq6O8tvtZvlPV3YZT6/wNVhiQK/1V1u
 D5BKSL7NeldVmcolpXWAcj1ONoymYUModDeJURIOV+yWgFzCN5z/VBlsuh6cO4+G
 dCjhomLJr7YgbsxG9+KG1s/XqmhbtW//b8Jc8LmczANTlNHOOaphX553Nw16uzpM
 CfgsWvREbLuikwmGV1j3MbheVRhyA/WabatPN9p+dJAuiNR3mcbMHHpNXGHpKYee
 FnUs932O/Z7xqs71ZAqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601608; x=1780688008; bh=9
 8uAIOYyLY8pjgR8o4/ZR/tQfjG9hEd792CkS6UYbg8=; b=cJersgQBYlidQXBUr
 JJtZqaHgDTjCDqBO1eIF44pjboye/N2Rxc7C51KpRG/vZaqDubmY2S47KdkDRpLN
 l4n9SyRVVxS10uXNjvokDbPWNWBwHGKDYalon/qOuCTk01o616zK2u+clGXOBUU7
 7sIUt3SJFmt8YBFcPjCPHsjCddfJMPLRudEojvzXWQZdtdtBG6+Kh/RzNJXP3ejd
 YaWy8K/x8qfIHMA+q1dzLPGHbSQNw/ru5ttcQOilLeGoUu5djK09Zqshx3E7pOSU
 o07rXlHBfqC6XuwOMzUeOKL3s9UVE0zIyIK4BcNVHEwc/c/iLBN3qVgXyj4lKygV
 skJmQ==
X-ME-Sender: <xms:B9MhahgU70_ZbqzZLhXWH-U4BSa7MUeSXMP8taoF0bSX1PyGEOddCQ>
 <xme:B9MhaiULpOzHriiSI1tj6PlnPhTQ85t0V0M1Wg9n-zl_IWahpAb_cEEA8uHIFxZbX
 lGf7udR2TBLqcnXqa-0AqMupuGwrW9e2SkKzwu4uHHxk6KNk46u4w>
X-ME-Received: <xmr:B9Mhaj0G946YbcRCmvuo74kxqSJWnuCURfoR3EH2HdNUJzJygvtrHIkVxaoGjIr1j7SsO5NWDv2zqcnSa8Xlpl9RR4OwE_Y>
X-ME-Proxy-Cause: dmFkZTFBVtFu73v6kEfmvEVYm2wybPSOOTBO2QZQTLxMmhRKicwazOPAhmwg6YOl/udFjG
 9CMckWvsaG3S/jXdOqGQ5YBD4798m4D3rAKVoB8d50ghLHACp09RRpMyKxbxJtg2kE4byq
 Wp+HcF41u2/fePWGB0Uoi0ggfcS2OmIDt7CA/hRM1+p1IN9erhF5steHvQA9oFz66G1z/y
 O12rNKrmv1xf2hrywdgv534RP7gMBVDK99h9nsQJRbuaOBkZo8ScTD2/4XPDewNtPAzPjR
 ComfayxCQpZAQ5JXvsrV1I8vr239TJi7FrAX9RwQ6Hiol1JR4VNExV6vm4spCCRsmuhAOF
 ZtDNV85aot5i7iNBuqmvuuSFMtZLh9oSyAMPM7AuHZqqfFa+YPRhw+SAEorroXeD3sW1Nk
 Y1BHmsPyXrJQIaYstBJ5gbjQ38Pxu9VtSfNnMFOQpn/Y+PM7EWrqAUKOj1SHgGrYDagqqD
 DTqGOHWka37pJckUZK/kJiAyGRwpRFKjFPb0rzCvg11u0euO7tud37wsRODajcgkTYFrRC
 a02p1HO1MAsCIRVfcd0IXOBDBQHIvDtqq7OWRxXsmxSEENjjOidjPdjlpC545xRdDIPMfK
 Oqf3Al+CF1dvRkRjzc7j6LxrevH8l5djNoBLJgk76nRUGZVC4QNnYXoHbOpQ
X-ME-Proxy: <xmx:B9MhaoEVmE2XJnb6tks8KCNA5n02eugq2ruqgVn-crdIOVdO2he8TA>
 <xmx:B9MhahgESJJwXE7hAHaqOfRZwMjYQYXNQ8gXdFdntNLTZYxrBFVceQ>
 <xmx:B9Mhaj-XUboVjinHWiEQ95c97CEaZ9WAheC5nCtH2F-KM_HJSUDGuw>
 <xmx:B9Mhaop9epwczXx4oV8iTQRiFS7NWmix4ofbhjGovE7surZzLALWIA>
 <xmx:CNMhapj98qo9KID0A7szUaavNU5mk6D7pXsx7LCy1Coc9QPRKIytHuYe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/9] selective Rx
Date: Thu,  4 Jun 2026 21:30:52 +0200
Message-ID: <20260604193324.1996141-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260202160903.254621-1-getelson@nvidia.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
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

This is a new feature in ethdev with tests and mlx5 implementation.
Selective Rx allows to receive partial data,
saving some hardware bandwidth.

v2: rework after Gregory
v3: fix bugs found with AI by Stephen
v4: fix packet type in DTS test
v5: fix mlx5 Rx to handle discarding first segment
v6: fix reindent patch
v7: fix mlx5 CQE error handling + outdated mcqe + redundant assignment
v8: use --mbuf-size 0 in testpmd instead of changing --rxoffs behaviour


Gregory Etelson (4):
  ethdev: introduce selective Rx
  app/testpmd: support selective Rx
  common/mlx5: add null MR functions
  net/mlx5: support selective Rx

Thomas Monjalon (5):
  app/testpmd: print Rx split capabilities
  net/mlx5: fix Rx split segment counter type
  common/mlx5: remove callbacks for MR registration
  dts: fix topology capability comparison
  dts: add selective Rx tests

 app/test-pmd/config.c                         |  17 ++
 app/test-pmd/parameters.c                     |   5 +-
 app/test-pmd/testpmd.c                        |  34 ++-
 devtools/libabigail.abignore                  |   7 +
 doc/guides/nics/features.rst                  |  14 +
 doc/guides/nics/features/default.ini          |   1 +
 doc/guides/nics/features/mlx5.ini             |   1 +
 doc/guides/nics/mlx5.rst                      |  86 ++++--
 doc/guides/rel_notes/release_26_07.rst        |  11 +
 doc/guides/testpmd_app_ug/run_app.rst         |  16 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   3 +-
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
 drivers/common/mlx5/mlx5_common.c             |   6 +-
 drivers/common/mlx5/mlx5_common_mr.c          |  37 ++-
 drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  31 +-
 drivers/compress/mlx5/mlx5_compress.c         |   4 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   2 -
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   6 +-
 drivers/net/mlx5/mlx5.c                       |   7 +
 drivers/net/mlx5/mlx5.h                       |   4 +-
 drivers/net/mlx5/mlx5_ethdev.c                |  25 ++
 drivers/net/mlx5/mlx5_flow_aso.c              |  21 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  11 +-
 drivers/net/mlx5/mlx5_flow_quota.c            |   6 +-
 drivers/net/mlx5/mlx5_hws_cnt.c               |  19 +-
 drivers/net/mlx5/mlx5_rx.c                    | 187 +++++++-----
 drivers/net/mlx5/mlx5_rx.h                    |   5 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  95 +++++--
 drivers/net/mlx5/mlx5_trigger.c               |  64 ++++-
 dts/api/capabilities.py                       |   2 +
 dts/api/testpmd/__init__.py                   |  17 ++
 dts/api/testpmd/types.py                      |   6 +
 dts/framework/testbed_model/capability.py     |  10 +-
 dts/tests/TestSuite_rx_split.py               | 265 ++++++++++++++++++
 lib/ethdev/rte_ethdev.c                       |  24 +-
 lib/ethdev/rte_ethdev.h                       |  17 +-
 37 files changed, 859 insertions(+), 289 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

