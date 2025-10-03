Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9DCCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23B244065E;
	Fri,  3 Oct 2025 13:02:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0B7EF4025F
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489353; x=1791025353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1QDQPU/fxyvAeDSvuM1Ie5vhJ1mgLkfobi8s04FC+FM=;
 b=BwcWt3cJZ/v5ANGHiskqtE7yt/rmlnUhUyqXw3MN5SnEunnK5Nm4dKyH
 Ijnz34hPZe8i8Op6Vy5GNu6etbpgzrOrSPOBf3U8AgPVmx2as7CBDHqic
 YB/WeWE8xMtG6lQV8imxz/ViYceLGuXUjIYeVgx9xPA+6mdykBaPT+1R6
 Ti++5opXl90FI0sc2ZFEsxjhxwcg9oTbWN/IWNiW8MPxuCPsNsWtN3c3f
 XW+hYLZ3XuEOBk3Tg3Y7GJh/Wo3yYVYV2+7vXf8m0L/yqX7AjhQgEK7ah
 +PTDBD5S4LGMw73enOoEWYsYev6e7ugkyguaYnBRj3dno6EtuxbVKUSku Q==;
X-CSE-ConnectionGUID: nRZ29A78RheAFZ4CUGQKFg==
X-CSE-MsgGUID: NZNnDNsFSrC/cAbRxMYzmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72873479"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72873479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:02:18 -0700
X-CSE-ConnectionGUID: wZ9mC9VWTQ22GUD6anOjoA==
X-CSE-MsgGUID: 63oNLvO5Q+6MgwXwN990Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179077641"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 04:02:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v3 2/7] net/ipn3ke: drop unsupported per-queue xstats
Date: Fri,  3 Oct 2025 12:01:56 +0100
Message-ID: <20251003110201.1541183-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
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
Reviewed-by: Rosen Xu <rosen.xu@altera.com>
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

