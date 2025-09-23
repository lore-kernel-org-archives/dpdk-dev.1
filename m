Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E75CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49DCF4068A;
	Tue, 23 Sep 2025 16:12:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0381540689
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636741; x=1790172741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JrJif1+1Upbx6fNsdgIaa/gIPNaKMsZzZAbZGP0AFOI=;
 b=CUO/Uf0zgHjrJfq/u8Yd3ihI+oVJ1y/JD+7XAwJYC53e7osX000Yd+vi
 mqHUMvLBZopLzSi/jO2lPekn0+J1Sl5t7Jqm5fiuuBymmP69w6MhknZ+i
 LOAm3Yc3+FRNJFqiQ4ck+rW21X6LBic4CMaRet1fWXpZtHTrrV571WPRb
 gmMi6K2bwqp7lewbbr9KabkZNCpAqYGChOC7NR4IZGbjVfnANWlqxRKwf
 Iqt/y9/Rq/4m2kJv6bn09HkbKg1hR4vS9dZrRyUzstE5tLGsiby+8bJTB
 u9OdokAQGUNA2um6biWx8DfXIgBmZFTZ4l3w6zIWbfUnV+HzLZmrks5kb Q==;
X-CSE-ConnectionGUID: 6gVbURYMRluzPVQv1n7dUw==
X-CSE-MsgGUID: WsjTq2ufQt+vPDRUKB5Hpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64554242"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64554242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:12:21 -0700
X-CSE-ConnectionGUID: 6wr5Q7czSgyhhkLIzEDZsA==
X-CSE-MsgGUID: w60c60oKQSuSSKmm8PZcvg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 07:12:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [RFC PATCH 2/6] net/ipn3ke: drop unsupported per-queue xstats
Date: Tue, 23 Sep 2025 15:12:02 +0100
Message-ID: <20250923141207.10403-3-bruce.richardson@intel.com>
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

