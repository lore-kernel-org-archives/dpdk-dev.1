Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26BC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A2084275B;
	Thu, 12 Jun 2025 13:12:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 560F342799
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726743; x=1781262743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xjo7scfY+F3t4cxV5hL9XfijA2cQX/4e1M53BtP98Ts=;
 b=YLxJtZkI//HAawmTyISxjPVcLvZJ4kS4PAnJhLTj3zJArZp3V/kebN7t
 J47gx2c0vxJPQN8yhhsB2Jf9Q+YCMq+zAaWXeaYps3s+zuoYSmI18YCRa
 Rw2hjAQtJRujthNrdXcgq+FcRDHV5tM/NPTekquYwemRiWzHdBHLfrGVi
 NuEVS8XsgaG+YVcb0QM5a2lvIu7UNvdLrFAx3yU2ksLkM22Yl3Ei0dQCA
 ViMxSjYwq+xogS9sMaJWvsaYbJORgSoEb7baIAChkhL8A5lr8+gpuH8/F
 iiL43g/z3cuPOl2nJbQGED53ftvD5TSCjUZjzEKu3OjuMQ+CrDxl0gNLf w==;
X-CSE-ConnectionGUID: B0hlpmgaTDeZztn+Ro+gGA==
X-CSE-MsgGUID: qvqz2OBKTFmPwlLYUS1CBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177565"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177565"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:22 -0700
X-CSE-ConnectionGUID: vWZ+ygavShGnrPiNixpjoA==
X-CSE-MsgGUID: j3g2bRGmQaCjR340bm3esw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371357"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 17/33] net/ixgbe: replace always-true check
Date: Thu, 12 Jun 2025 12:11:23 +0100
Message-ID: <405e9d5d7a072aba08400a9222e7e808fb8a6a61.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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
index 48675ab964..cdf0d33955 100644
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

