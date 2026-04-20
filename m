Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94DF36C2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 06:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 822DA402DF;
	Mon, 20 Apr 2026 08:36:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 275DD402B6;
 Mon, 20 Apr 2026 08:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776667013; x=1808203013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O4bLktbRW2dNEfE4Bpfo2XemD1TomFQcItWQ8oD/+uw=;
 b=KLQ+TfmF76ay/+zbcf+/FkrOFog0VqrkkCXHkhJToqskSq6t85CspMXX
 v8/923SrCzCeoas9ehLoTitGOhmf2q4RNTFTpjepsfL6EyvkA2Q2eWNKy
 OLLRkxRYB95yWMmlhEoCOim/HaBHId4YO78zGQYzJ65ZnTuN+6rS6WAei
 CEnV4QwnIjfOIZxQ9kT3B3/wWsWjou9igtScdvgVq1uDKR4QVawpfOMi9
 6iavwORnm+U9mYTA59L32IclOo/NM8jUvUCWRMGpjKkyS2Rt55HMCUiKX
 yJo3pNTyJlWNz5ZeR74ZvOioZFkP0KXZD52S3Wa+6/BxObLQg/K0omvv1 Q==;
X-CSE-ConnectionGUID: rbK3AiNwR2u/cTYWsl2Wmw==
X-CSE-MsgGUID: Lj3c1EEVS9y3gBi64rmMOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89042554"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89042554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 23:36:52 -0700
X-CSE-ConnectionGUID: B+lW7berTtyYaj81h4nBnw==
X-CSE-MsgGUID: 7SFtEG+VTHalCtThD4S8JA==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2026 23:36:50 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH 3/4] net/idpf: demote path selection logs from NOTICE to DEBUG
Date: Mon, 20 Apr 2026 11:57:45 +0530
Message-ID: <20260420062746.178145-4-shaiq.wani@intel.com>
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

Fixes: 12b1c2901761 ("net/idpf: use common Rx path selection infrastructure")
Fixes: 7cab7e67363a ("net/idpf: use common Tx path selection infrastructure")
Cc: stable@dpdk.org
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index b316c77b62..20cfc3a506 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -835,7 +835,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 
 out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 
 }
@@ -902,6 +902,6 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 out:
 	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s Tx (port %d).",
 			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 }
-- 
2.43.0

