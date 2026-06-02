Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CECD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B92E1402AB;
	Tue,  2 Jun 2026 23:40:44 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 8C337402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:40:42 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 96EFD1D00061;
 Tue,  2 Jun 2026 17:40:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 02 Jun 2026 17:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436441; x=
 1780522841; bh=zM+HouCbsSRhTW0BKEL4hDlvR91ox0Qe4wf5OE4Gzy4=; b=B
 ovEnuI4i4X9F7r2vnMSzl09g2t2XMS4TuIJuEJNhpL9l0HHZxrPQju6DfEU99xhm
 vkFPoGwYFNqMJ5cx05aDWMrf2UsPvjRWkLXDTdfDDqoLkccHvupEgZEG6+mVRHp7
 M7l63M66sUtbTqAfUfpy1ZgAlutlxOh3EVnPNNl+tJBfyV7uKI0CUv4WOmWs7p7d
 wy9nHzyUh9j2jpmAwOrlI0c3ItU/IYxD3YSXnCLtFja5ovNo9xlOX8RunqDX/Ynb
 jHMsqplODHhANpEVTtlGbCYQ1H4dfCq24MVkbSI3DZFvx2YGQOZ2pv+8h2GiyWG7
 IZz9Fisvyr7aTkGqdVqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436441; x=1780522841; bh=z
 M+HouCbsSRhTW0BKEL4hDlvR91ox0Qe4wf5OE4Gzy4=; b=WAEcoNlR+rJGx2w/a
 biMBX2iVCbhH4D2Q6s2x1Vm4K++1dxQ+ROYOGpJSv294e3nWaD3aNPnNLutli1Dy
 zj7CwuZjgqqSxO1nLX2nwCrgAK/VU2Rxy8eBplvZJ6LFrlrADs7SYSDddVJvd35+
 FI1FSAIJZX3LNuw5/WnXSxPHBvvFaA13h+f3O8akekgleSceA1Zz9WxEY3NUS5UE
 ATSa/tRmLpGLoKEb3YCfbrKAzRa2+5joaMsMpUhpFrBtUGw9Neg0wFwAKrp8MhJ2
 vSTzu/Kht3MKn6nwQhbvapb6SuE7jQaBueZZSvce0W8o0K1+dVyHIsoIIiQNM6jw
 PAYjQ==
X-ME-Sender: <xms:2U0fav-haG2ZoL8GHS128n9CxiJuRN34J81zNoTI-XkusYGc9gCx8w>
 <xme:2U0faoAA19E2J_bPhLQBusYlSceDsFjKxATt1uyjOJOOf0PUMwwjTLWXWdqt1tA-Z
 gInfNgG_qGJqPLSsbdgPlSNHqhxVyhlGXUOxTJ171mDu-W-TLdr>
X-ME-Received: <xmr:2U0favw__QeilXbtFNdtDn9M5AXFLpXKZcOLbKmVrx9DHGO0P3z72oKVssmwTZSWqGuD0XYj0GyBKlSfluDslMxy70c0VSY>
X-ME-Proxy-Cause: dmFkZTGG5QG5Qo2LZmwXqqvuNNhi19An1/OHLJk+jOD2py8sn4MHJ4nPNbpF72I9jcWzu9
 VRXulbNmYCwD6P0ncbx/mcv4YJNui8c/fgayxuJKLu8KViRzeO3nUh6MWQLuXClMzS5Cj8
 rGYRxhOHw1xRA2LiD2IIw/+mInaTwnWkoindQu+nHp7U5jBZaN3J+BFQd3qCMFkOOO1Ca5
 nMIBjlMLIFzcLvRFfxIx3nkf72Y5pOksU189GTlSPd0bT1sX/nBi1/z0aUkYxn4GdUtn1h
 5Qya9RZnaklBolACp5VLIPUz1oq85G1wGWWORjSm0JoyS9m/5i4wZtp1BhN6MlMw37EbKZ
 /VpBgOKPLNzuthfHcee4WYhlPF2zJlkpWCW/XjNTDHtbm0tgQzJpd6eBCiP7/+bAHOvLi+
 TPYuQY2wReU8c+GyU7TSG7unB+P+SuQQZ1md2RT/hmZFdehYYa7IC7ZsITACcrhkuyBxRI
 VisJpQQUzrdYiHARdxQxtHlT3Je2A2LSderR8fdZLWKU+x3hy3NZTgOdhpAebiM2/XlCQf
 V9qdKcYIdI+gepFndh7T3bX6yLvr0lGe2BrhxJiYABstqBOEVdoMUmMbDDO9jSon2iv/3J
 UDly93hEoXSMt1qnk6lP86yG8NBrnyl/p8SGxVQlxHMN5UMHgtfNkpng953g
X-ME-Proxy: <xmx:2U0fatRFNEupxeK0OC1qFRDleC90BLMaQI6UkbUSF4-dAgYfmWqzhA>
 <xmx:2U0fam8pt2db9gaBR0Fncn29zbMD38w4-xRghZo0aUv4SElODNDIDg>
 <xmx:2U0fakqnZFTrHCmO-NSL4wZ0ZQW5N6zLFKcni_dvtMK4JC-WMcwc2g>
 <xmx:2U0fajk0Jqu76HDNBrCxb2-DJTgpdxFuJUoPxgGcdjtJjQkM6gRVMQ>
 <xmx:2U0faneRRR1zqKhlQNWVmdLCOkvIbMZb_IcgTNPl7HSSJaTQKJ3qmBnA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/10] selective Rx
Date: Tue,  2 Jun 2026 23:38:31 +0200
Message-ID: <20260602214036.3606359-1-thomas@monjalon.net>
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

Note 1: mlx5 support patch is not correctly indented
to make review easier. An indent patch follows to be squashed.

Note 2: DTS patch is an attempt to test the feature on day 1,
it is not mandatory if it is blocking the merge.

v2: rework after Gregory
v3: fix bugs found with AI by Stephen
v4: fix packet type in DTS test
v5: fix mlx5 Rx to handle discarding first segment


Gregory Etelson (4):
  ethdev: introduce selective Rx
  app/testpmd: support selective Rx
  common/mlx5: add null MR functions
  net/mlx5: support selective Rx

Thomas Monjalon (6):
  app/testpmd: print Rx split capabilities
  net/mlx5: fix Rx split segment counter type
  net/mlx5: reindent previous changes
  common/mlx5: remove callbacks for MR registration
  dts: fix topology capability comparison
  dts: add selective Rx tests

 app/test-pmd/config.c                         |  17 ++
 app/test-pmd/testpmd.c                        |  71 ++++-
 devtools/libabigail.abignore                  |   7 +
 doc/guides/nics/features.rst                  |  14 +
 doc/guides/nics/features/default.ini          |   1 +
 doc/guides/nics/features/mlx5.ini             |   1 +
 doc/guides/nics/mlx5.rst                      |  86 ++++--
 doc/guides/rel_notes/release_26_07.rst        |  11 +
 doc/guides/testpmd_app_ug/run_app.rst         |  20 ++
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
 drivers/common/mlx5/mlx5_common.c             |   6 +-
 drivers/common/mlx5/mlx5_common_mr.c          |  37 ++-
 drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  31 ++-
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
 drivers/net/mlx5/mlx5_rx.c                    | 130 +++++----
 drivers/net/mlx5/mlx5_rx.h                    |   5 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  75 +++--
 drivers/net/mlx5/mlx5_trigger.c               |  64 ++++-
 dts/api/capabilities.py                       |   2 +
 dts/api/testpmd/__init__.py                   |  17 ++
 dts/api/testpmd/types.py                      |   6 +
 dts/framework/testbed_model/capability.py     |  10 +-
 dts/tests/TestSuite_rx_split.py               | 262 ++++++++++++++++++
 lib/ethdev/rte_ethdev.c                       |  24 +-
 lib/ethdev/rte_ethdev.h                       |  14 +-
 35 files changed, 852 insertions(+), 246 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

