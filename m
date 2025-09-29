Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD2CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87FBE40B8F;
	Mon, 29 Sep 2025 17:00:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6FE8240289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759158021; x=1790694021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E2BHBFOdGONM8HvvMC9T0t+4aXEqytlHLBm4AODD000=;
 b=nF6UZD/EeQC6t1pgWzWTyz7BZyaG8r35U1vpvpY7faJM2FzfItZVWsYA
 35jDcPTyHxp+S/1v3ILKArMDcEiKP0gAKzjkVLcQ2wypr4JVJexLz26PN
 c16CQjT2vdvnOojBKKP5/hM7TKKR7zPZadRZfeLHqrkBX09eFhOF7tN7Y
 iMJ2seUFCuRfyaO0L8KZXKAcT2DzPDjvvqX7s/9cOo5h8N+RkkV6ZkFD6
 ePNZ0vnJY12pNtKwJTI+goZ4U7L5GUvC3J8vW4QQJMp4pHQ6ZLTOwp/6C
 wieS23T3Xrr5FrIIcmObLeSCMEGfasDhOTyJX0VtbSM5wcmVQXsSduRv/ g==;
X-CSE-ConnectionGUID: l7uS3dFVTCmVxpMbQ17XCg==
X-CSE-MsgGUID: vJWZ7JyuRWCIcvaAt0FNyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84017131"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="84017131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:00:20 -0700
X-CSE-ConnectionGUID: BdfRMRBwS6C5642oveG0Gg==
X-CSE-MsgGUID: jNKtmq3/QiOBeGI8tY0H4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178638042"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2025 08:00:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/6] app: remove queue stats from eth stats
Date: Mon, 29 Sep 2025 16:00:08 +0100
Message-ID: <20250929150009.1542208-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929150009.1542208-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
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

Adjust applications to take account of the fact that queue stats are no
longer part of ethdev stats.

- For proc-info, we have to drop the output of the stats, since they are
  no longer present.
- For the virtual_pmd in the test app, we adjust our stats_get function.
- For testpmd, we can no longer reference the queue stats counter to
  check it, however, the range is checked in the ethdev APIs anyway, so
  just remove the check.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/proc-info/main.c   | 16 ----------------
 app/test-pmd/config.c  |  6 ------
 app/test/virtual_pmd.c |  3 ++-
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index be67386658..1b9979b7c8 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -657,7 +657,6 @@ static void
 nic_stats_display(uint16_t port_id)
 {
 	struct rte_eth_stats stats;
-	uint8_t i;
 
 	static const char *nic_stats_border = "########################";
 
@@ -673,21 +672,6 @@ nic_stats_display(uint16_t port_id)
 	       "  TX-bytes:  %-10"PRIu64"\n", stats.opackets, stats.oerrors,
 	       stats.obytes);
 
-	printf("\n");
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-		printf("  Stats reg %2d RX-packets: %-10"PRIu64
-		       "  RX-errors: %-10"PRIu64
-		       "  RX-bytes: %-10"PRIu64"\n",
-		       i, stats.q_ipackets[i], stats.q_errors[i], stats.q_ibytes[i]);
-	}
-
-	printf("\n");
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-		printf("  Stats reg %2d TX-packets: %-10"PRIu64
-		       "  TX-bytes: %-10"PRIu64"\n",
-		       i, stats.q_opackets[i], stats.q_obytes[i]);
-	}
-
 	printf("  %s############################%s\n",
 		   nic_stats_border, nic_stats_border);
 }
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c1bd6921ea..ff170159a1 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6727,12 +6727,6 @@ set_qmap(portid_t port_id, uint8_t is_rx, uint16_t queue_id, uint8_t map_value)
 	if (is_rx ? (rx_queue_id_is_invalid(queue_id)) : (tx_queue_id_is_invalid(queue_id)))
 		return;
 
-	if (map_value >= RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-		fprintf(stderr, "map_value not in required range 0..%d\n",
-			RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
-		return;
-	}
-
 	if (!is_rx) { /* tx */
 		ret = rte_eth_dev_set_tx_queue_stats_mapping(port_id, queue_id,
 							     map_value);
diff --git a/app/test/virtual_pmd.c b/app/test/virtual_pmd.c
index b7d74a467a..aa37e4073c 100644
--- a/app/test/virtual_pmd.c
+++ b/app/test/virtual_pmd.c
@@ -181,7 +181,8 @@ virtual_ethdev_link_update_fail(struct rte_eth_dev *bonding_eth_dev __rte_unused
 }
 
 static int
-virtual_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+virtual_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	struct eth_queue_stats *qstats __rte_unused)
 {
 	struct virtual_ethdev_private *dev_private = dev->data->dev_private;
 
-- 
2.48.1

