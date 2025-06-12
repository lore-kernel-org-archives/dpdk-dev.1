Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29BC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3E7442707;
	Thu, 12 Jun 2025 13:12:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 796F641143
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726735; x=1781262735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TTMLDqKqRhp4/hssFeJAMZsGfC8mQkjWRlun1ysqRzI=;
 b=jiTJ+M1SVVcMf2tvXfW7Mnuwx1rG7sXLwOyRdFbhWZt1I9UQ1zltK4+I
 PFVOXNJ6DN1t0ZxrqeVkaN+4zLO7z+KMPj/KJvzPDICC44/R79hQoDcGr
 Is7K8kmxcRHTCLr4jDWmP5ToddTyNmgcm8o9xgHLF8+mP7GA1Nj54Zu9Y
 /TtiY7HWahSBky8teh3Isp8oRJ9Q/FjWg8BB8rZNvec8Cuu2LUC+i7hXd
 TArHmWp69az+ft7BRspl+eAx9WO0IRx/HSMUTuWToF2FAY+sx4688unvg
 3pGd8AYh52cSiLmrGlxHsw4zBEIwgHcMCGeRYZg0XBYRO0O3HnGrk7v9v Q==;
X-CSE-ConnectionGUID: w1yjrjJQSImNQ0WiXhbgig==
X-CSE-MsgGUID: Nh3Lj8B/TpCrRIoazOjw6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177554"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177554"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:15 -0700
X-CSE-ConnectionGUID: hnLaVMn/SPisSMVHbwd/Dw==
X-CSE-MsgGUID: KcfdAm/mTEizUPJ20g4Bng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371341"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 12/33] net/ixgbe: decouple scalar and vec rxq free mbufs
Date: Thu, 12 Jun 2025 12:11:18 +0100
Message-ID: <54c722c003e18ded3ec5d19d53dbb24484c62445.1749726639.git.anatoly.burakov@intel.com>
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

Currently, vector Rx queue release mbufs function is only called from
inside the scalar variant. Decouple them to allow both to be defined
separately from each other, and provide a common function that picks
between the two when necessary.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5 -> v6:
    - Rename functions to _vec and _non_vec, and keep common name as is
    
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0777f70a4b..0b949c3cfc 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2967,16 +2967,10 @@ ixgbe_free_sc_cluster(struct rte_mbuf *m)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
 {
 	unsigned i;
 
-	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->vector_rx) {
-		ixgbe_rx_queue_release_mbufs_vec(rxq);
-		return;
-	}
-
 	if (rxq->sw_ring != NULL) {
 		for (i = 0; i < rxq->nb_rx_desc; i++) {
 			if (rxq->sw_ring[i].mbuf != NULL) {
@@ -3003,6 +2997,15 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 			}
 }
 
+static void __rte_cold
+ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+{
+	if (rxq->vector_rx)
+		ixgbe_rx_queue_release_mbufs_vec(rxq);
+	else
+		ixgbe_rx_queue_release_mbufs_non_vec(rxq);
+}
+
 static void __rte_cold
 ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
 {
-- 
2.47.1

