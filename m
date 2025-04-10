Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCFDC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 06:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3107540665;
	Thu, 10 Apr 2025 08:54:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D0E47402ED;
 Thu, 10 Apr 2025 08:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744268046; x=1775804046;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N1BLHICTvgDwhnuJON56BDTObuTBKZnJqyp7T1AXDTA=;
 b=KDuP4DVZb8HJR3SEf5q7kX7ZzASYR0lhrWumRPYDYrdpVyDgVsMgOJSR
 f6QnesC0hx2kOH9irWOjN+37W4ioaYmoiA1PP07S6DSYgnGyLUyscaKLC
 BC/RjAadvFH4dwDi6SjvYECPMULYUyvRqhGlegwHAzUXMbzt4LX4kfe91
 w3TMj2I6pCJR2jRmsKQK5otijzJWv41zF99ZkNa7vkBvdeBpq5vM+RM3v
 /xhQfDUZkMBgT3Tq1jh2+OE2kpewd/jYORUKEgwdwW96HeWISq30QT+6X
 1VgkLcXzYMH6ejFE8AWbmsmpmWGQq+Let359ErBm6OFB65tkNTN42dJj1 A==;
X-CSE-ConnectionGUID: 0au14ldqRASx2XC1QnK6uQ==
X-CSE-MsgGUID: Z6m6I3TSTBmL6tBo3pHOZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45662110"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="45662110"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 23:54:04 -0700
X-CSE-ConnectionGUID: Gzn/T2ppTTCygPrjlyKfQQ==
X-CSE-MsgGUID: wW17tJhlRliEAYbSYcB7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="159790093"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 23:54:02 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH] net/intel: fix xstats name
Date: Thu, 10 Apr 2025 13:52:46 +0800
Message-Id: <20250410055246.809646-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
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

The igb and igc xstats name need to be changed correctly.
tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.

Fixes: 38552317dcef ("igb: add extended stats")
Fixes: e6defdfddc3b ("net/igc: enable statistics")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/e1000/igb_ethdev.c | 2 +-
 drivers/net/intel/e1000/igc_ethdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index cbd2f15f5f..40f453c8d9 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -486,7 +486,7 @@ static const struct rte_igb_xstats_name_off rte_igb_stats_strings[] = {
 	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
 	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
+	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
 	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
 	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index e712cfcf7c..68444e4fba 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -181,7 +181,7 @@ static const struct rte_igc_xstats_name_off rte_igc_stats_strings[] = {
 	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
 	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
+	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
 	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
 	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
-- 
2.34.1

