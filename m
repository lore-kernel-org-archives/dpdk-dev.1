Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E8CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE0940A67;
	Mon, 29 Sep 2025 17:00:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 98ABE40289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759158018; x=1790694018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JrJif1+1Upbx6fNsdgIaa/gIPNaKMsZzZAbZGP0AFOI=;
 b=QZb31yAXT7dhuOwAZnulQ2hBdyqGk2WuReXmRCQtYPZpqRhP102tFiD8
 61OpHB5EAjtA5pnVuWgsD/W9hz9QnuAWNbTtGFsXNTSxYJPhqMKZtqRd7
 QWRm2YWJffFDdB7GHMlNQzxSPA7GOJ1TqSkDF1yvFC6ar1n0jQft0DXnV
 9U4pXIVJJYEKs40wV9JNHk/ELBiVTuqrw9e52DNQkCyUW1Iph99v5oT2M
 LDX7Hop7tTc9ChTNghRHllnAcZpCamEGPF0GND3PO1lqDLx3SUUjtTYy1
 f/qTZqDEgCsc39mHITJTaW8k1CXYb8oIBjlLzJpMKFLgMqF80MryzxeIU A==;
X-CSE-ConnectionGUID: VVujm1hkSwuFXsM2946YPg==
X-CSE-MsgGUID: pNJFzE8AQBuY3rfrkqZIvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84017112"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="84017112"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:00:17 -0700
X-CSE-ConnectionGUID: 5Oum5qV5QzuQcEIfZb14iA==
X-CSE-MsgGUID: CbkSsmsSRP6EgDkimRCCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178637997"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2025 08:00:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/6] net/ipn3ke: drop unsupported per-queue xstats
Date: Mon, 29 Sep 2025 16:00:05 +0100
Message-ID: <20250929150009.1542208-3-bruce.richardson@intel.com>
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

The ipn3ke driver does not actually report per-queue stats, it always
sets the values to zero, so drop the flag causing auto-generation of
these meaningless xstats.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ipn3ke/ipn3ke_representor.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index feb57420c3..c5aca0ea8f 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -2124,7 +2124,6 @@ ipn3ke_rpst_stats_get
 	uint16_t port_id = 0;
 	char *ch;
 	int cnt = 0;
-	int i = 0;
 	struct rte_afu_device *afu_dev = NULL;
 	struct ipn3ke_hw *hw = NULL;
 	struct ipn3ke_rpst_hw_port_stats hw_stats;
@@ -2200,13 +2199,6 @@ ipn3ke_rpst_stats_get
 		stats->oerrors   = hw_stats.eth.tx_discards
 					+ hw_stats.eth.tx_errors;
 		stats->rx_nombuf = 0;
-		for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-			stats->q_ipackets[i] = 0;
-			stats->q_opackets[i] = 0;
-			stats->q_ibytes[i] = 0;
-			stats->q_obytes[i] = 0;
-			stats->q_errors[i] = 0;
-		}
 	} else {
 		ipn3ke_rpst_read_10g_lineside_stats_registers(hw,
 							port_id,
@@ -2931,8 +2923,7 @@ ipn3ke_rpst_init(struct rte_eth_dev *ethdev, void *init_params)
 		return -ENODEV;
 	}
 
-	ethdev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR |
-					RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	ethdev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
 
 	rte_spinlock_lock(&ipn3ke_link_notify_list_lk);
 	TAILQ_INSERT_TAIL(&ipn3ke_rpst_list, rpst, next);
-- 
2.48.1

