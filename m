Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF548CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2A7540697;
	Tue, 23 Sep 2025 16:12:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6E317402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636769; x=1790172769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E2BHBFOdGONM8HvvMC9T0t+4aXEqytlHLBm4AODD000=;
 b=MMcCKiKgJOLQZAe8xB3DKh+RDfD3FUFtub8dfjaEw2zrzSLIBGfQ5Fnn
 g9bOBDXeEeglMVzHoEtHJ6ArdZZBf59EAoUkO6O1FJ7Jy5BHEbFM07qfL
 xYs+qsgEmR2gDoWFb7fvX3Md8b3p6c+TDNCjjH1av8uDJ+s8PE8ek/ebp
 14AFzSkomyawgHN5BbbHVZCXu9ETi+VVqEQgEhwJTD9uFw7y5QixhFfko
 tRjPcSS7qWlS4NfezrzW82z0xuqBVDNWgs5dZxeglPg6XPLjoWshRiD+e
 HwimnhoVsXi1kTJzTUEkyj5pNz3/M0w+6RYD7pJEvlAETCsgXIuR+78mL w==;
X-CSE-ConnectionGUID: 6VrmAL0qS4qyO++ndDyCbw==
X-CSE-MsgGUID: qaUAFQdMRqChnOj7/D1Eyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64554301"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64554301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:12:45 -0700
X-CSE-ConnectionGUID: z2W7/i92R+i1zzhZlcxdrg==
X-CSE-MsgGUID: y8jc8dKMTBSSaovUDHQfUg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 07:12:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC PATCH 5/6] app: remove queue stats from eth stats
Date: Tue, 23 Sep 2025 15:12:05 +0100
Message-ID: <20250923141207.10403-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923141207.10403-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
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

