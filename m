Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D22CF36C26
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 06:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B860340665;
	Mon, 20 Apr 2026 08:36:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A4C834065A;
 Mon, 20 Apr 2026 08:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776667015; x=1808203015;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YFZuOg1hW6DBESZp9n/J/7y0WiNswD3m5eEwbincRHw=;
 b=EeZyzMWj0p/WuUVBfBVq0k1yXUWk3ipa+FlhlPh0YwwCOaZ3VneN5nQ6
 zCMewXQF92qEMXCghyqLJQtvI6EMF+/CM7q2HdVo4yiOhPJ+RQQow8naM
 oxav0NXKex8QcUYTUiA4h+SRA4aaiPR0pzeLtlCo4A5uj4hfrYVZrUQLX
 CUUn6vGlby//n2BFDGC9FlJm4lGdggEb5WtlPTHDtVwOj4Mlvmdd0qv0N
 gN7d68EbkK6hMjntJywkNWumdobrmHhhSrL3LmaOHJFEm/vKgoHHzr6gG
 Bcs2Xu0H7uwqeb0oYGiFAVd+MhlaImHsMy2CnzjgoPMZhru/wgPn2HI8U g==;
X-CSE-ConnectionGUID: FCWPjJGTQTuTucmknmKmRQ==
X-CSE-MsgGUID: Wil+dXoCQFGKChuREurPyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89042555"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89042555"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 23:36:54 -0700
X-CSE-ConnectionGUID: 3nP99qTeTquQi5LvINpqWg==
X-CSE-MsgGUID: EgAutc32RQW+7h95RHSbjg==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2026 23:36:52 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH 4/4] net/cpfl: demote path selection logs from NOTICE to DEBUG
Date: Mon, 20 Apr 2026 11:57:46 +0530
Message-ID: <20260420062746.178145-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420062746.178145-1-shaiq.wani@intel.com>
References: <20260420062746.178145-1-shaiq.wani@intel.com>
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

Demote Rx/Tx path selection messages from NOTICE to DEBUG level
to reduce noise.

Fixes: a8225f2b308d ("net/cpfl: use common Rx path selection infrastructure")
Fixes: 6970745698b9 ("net/cpfl: use common Tx path selection infrastructure")
Cc: stable@dpdk.org
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index ad622b267d..bbf8225d54 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1487,7 +1487,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 
 out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 
 }
@@ -1556,6 +1556,6 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 out:
 	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s Tx (port %d).",
 			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 }
-- 
2.43.0

