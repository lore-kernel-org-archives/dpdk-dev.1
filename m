Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F3CCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A5D4021E;
	Fri, 29 May 2026 15:35:30 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 53760400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:28 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 604DA7A0098;
 Fri, 29 May 2026 09:35:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 29 May 2026 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061727; x=
 1780148127; bh=V6a7j7ECmvTp2FA0Bcwob4G4rXiyC8Q3XFCIVz6AEQM=; b=g
 IQjvqRiAYRb2jwNBve006vuEoIbM6CQTG3UAPEKoPRj4TBGqz59bZDQ+M806LrZQ
 kU+cpmyPbchksBc5A7lGBSt1bAPOOwdNOUfZP8rplK/3BECUeRVCHku4vPa3RiVh
 duMO0NgsALHt735SiCjIro/J2/H65FdRhGk0f+UblReiLJE5GSiwmbWiubpvjpf3
 0VzFif7vRBb3f+dlYQuK+aVon3QxCaCkuaGcQX3efWKE45TDECzpwN2x+wvQIBb1
 CoCivp1QPxWpjCWYyHRdqPeIaQK5gDkYl6cAfyoLUL6+nNRaIzhyAgAAH7IrXR95
 rjbfSSe5lVYHN+gXQPMyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061727; x=1780148127; bh=V
 6a7j7ECmvTp2FA0Bcwob4G4rXiyC8Q3XFCIVz6AEQM=; b=ArM3NL4/SS+Xj+bbm
 179VHd6kwXO+RgXrpz/ws3AZ3AEYOX8B4n8RdpS9KSEsoCQ4q+ZztcoD2WDVhBdC
 iGOZcVs2U+/7MJSoMPF7/0o428m8zdPxPHc8lo050o/QisJglMYt8k6psye3oK4x
 4nZQ+ZtnWQnnD/RKwE8Nn7/vWKggXSxYEB3yOT13QJnmFiWyb3VvafrDzc0u3nL9
 Cnn0mqcOYHbOnUXk3CoVLFFajmd1ofEhw/aphR7gLVNknB7CkoQp7S/zrjE3+7XZ
 L70lToYxVWaQ0GlbyhQrHk5S//G133spaaDKa0zrLiGDNGFgNtYdTpI6y1N8acel
 1bsVA==
X-ME-Sender: <xms:HpYZagPpQFCg5NC6TNJncodcdJHUcZBBRt_0Q-1sHPTPgvUnScNV5w>
 <xme:HpYZajTVaqfT32maf1k4zqlzQM_zjWYvrU1l3RBg1ZjouqQcYrd8_JBTWxnhPqoFQ
 _jbha7iRAQDsfC2Y08Y4thL0cGQmbJiZPxxhvoTD1Lcy5bCjPK1RQ>
X-ME-Received: <xmr:HpYZaqCI-PZnS2DArdk-K-UmqsukjeljK5ecxT-GpTN4vxUo3p9lAL1JEvw0hvI758L7kPEh5eC5uBBihNxTfdgJhIYRFm0>
X-ME-Proxy-Cause: dmFkZTE3poQ72lyOLUtTls1iSE7jC1cJW+MwUIT4Kv644ZOrdNRKfQ3/Ev2gXgL395veoh
 ZDdDjLNSO0BG2KHpNIwo2dedZS3b32AgoiPrSkQK080JNV3qskw91CJsXhQZC3e3ycJ3Se
 KN6SHiNywBxxxsKjfeWSX5APDcmRKffqT9WfPe7MtMaXzo3bkvgDnD78AQ/3mlvaYa0TPN
 SLRcV4tweUNBMms/TSSl1iNBPpWug9xdFZbzi1A97ZkW3VS6oHW+6Gk+78N/5RM4vbcms/
 3U8SKm8B1c/qgSmjmyTj2xQPClqshWpEG250DNhdWY0QdMyhpQEDT0oNzp/PKMy5jCCDEp
 rHDxpg53WWOSnjovWxk7uFVJ3At1TT0NguN1JC40p+dK4ezGnbRSWJ846jyeYRzaglXNKv
 OPqaZLzZaDqzIxTtplizueu3mR8ZSCsOaMydbIURSh2iz5IRVlLNCanUmPxir+1R7+ED7N
 qIqyuPmcmGt0oXIFSa07CDa9HkTs4EVt+niIseFq24h4kjy3S0dQ3zvGcylU5lrKhU3bIA
 n3Un0T2fkzaxCm80Nek3bqRDOnY8XjbsFVGrh3K08sa72cGUwftpHWCS4eT9p1uviLx/wC
 SdlThV7cRO6mEcqx4XL480R82iPlJQRFP1Zd8GxpKjzd6Y7jezYwAoLLB4eg
X-ME-Proxy: <xmx:HpYZaqiLpf6eu4Orxe98PcBEPVeN6zeu3Lzxbn7-Y4BkNBk_hYxt-Q>
 <xmx:HpYZarNcHstPJnYG-zQ5Z96w2rrAmK5sYVcO7oZICfKTCwyYKEIBkg>
 <xmx:HpYZaj6TFJoHBmwmA648pdWBFy7AVAV--x_xtQisLKj7VIdoh2DdMw>
 <xmx:HpYZah3j-oHkVz5M9Q0Fd8AiL-FIOMGPExeZtXoUOJwE9pWFhCSpxA>
 <xmx:H5YZagsD4Ea9B-wT58JZCTegs0bjHlzlbrJ1IqDdy1u2dQ0pixk_fFvu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/10] selective Rx
Date: Fri, 29 May 2026 15:33:54 +0200
Message-ID: <20260529133522.2646044-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c                    | 102 ++++---
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
 35 files changed, 831 insertions(+), 239 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

