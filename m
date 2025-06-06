Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE3C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F1A340E2D;
	Fri,  6 Jun 2025 19:09:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3046E40E38
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229798; x=1780765798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xceQvRVIEnIwJib2h0cHeKBruBScGVCFeDfW/xXakks=;
 b=PPMYGyLAofglaI5ONoKgoHfVOTPTYcn0e06IQMEgRf2XTPqWkqZBVeCj
 s+GiCg5ws5KilJ2EpKc2XkV2D0uswKC7zwB9V7BmrS3Dh7D/kNxSQIyKr
 y7daRx3M1UtNfcBcb9MreN8y3g+OSetftRg/IjlmrKamyl+8B/hDzB3FF
 N61pLxd/StNTY3CRAEesv8PmtYj/Z2B9PF+U/g3LmCBtZAzBpkg2MMvDI
 5fVXvJ1Az/k9pcxlcyI6EoIpuTW6ET1+R976qCVsIJ8M3rB4C66LEaWPT
 beE956oj2dXBRLl2BLD4Y99PsjNoP6l7MMqThPMGm11YrUQ1Quz+2hhZa w==;
X-CSE-ConnectionGUID: oH4g1O0gRmKYV2NQ02/IfA==
X-CSE-MsgGUID: jZbmbSFtSAyShHccMeqxaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828444"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828444"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:58 -0700
X-CSE-ConnectionGUID: yQ2Y7rR5TOWf+TQdVGmTTQ==
X-CSE-MsgGUID: ZyLQ1ipkRNOXMW5IGkd16Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808213"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 18/34] net/ixgbe: replace always-true check
Date: Fri,  6 Jun 2025 18:08:57 +0100
Message-ID: <7233d9783ac569ba042fd1dff48dffbd550c361a.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
References: 
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

There is an option `RTE_PMD_PACKET_PREFETCH` in `rte_config.h` that is
always set to 1 by default, and that controls some prefetch behavior in the
driver. However, there's another prefetch behavior that is controlled by
`RTE_PMD_USE_PREFETCH`, which is always defined unconditionally (literally
using `#if 1` construct).

Replace the check to also use `RTE_PMD_PACKET_PREFETCH` to allow turning it
off at build time.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a64f6e7e6a..5f0aedb4cd 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -92,11 +92,7 @@
 #define IXGBE_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ IXGBE_TX_OFFLOAD_MASK)
 
-#if 1
-#define RTE_PMD_USE_PREFETCH
-#endif
-
-#ifdef RTE_PMD_USE_PREFETCH
+#ifdef RTE_PMD_PACKET_PREFETCH
 /*
  * Prefetch a cache line into all cache levels.
  */
-- 
2.47.1

