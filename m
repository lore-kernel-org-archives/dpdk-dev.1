Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51686CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 12:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 281EF4027F;
	Thu, 18 Jun 2026 14:17:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EFE6B40268;
 Thu, 18 Jun 2026 14:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781785038; x=1813321038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DTTQxnJq63OBdmOQnM0EACbHbkQVxS+fXwBksSJPprY=;
 b=R8r5H0RJyNfgyycVenmlEybc+DPTPOW1JnK8+5tzPKNCOYiMHDdoYRlr
 NEZTprSIP3K+rWiTEJzYmKFocbDS43SHCrkVZlWmcKQgNwza7AtI8wjx4
 04ddVH0k1EGkhdJ5vzfROsViGZK11KaeAcpj82vgb+p1w2163X+hZwBG4
 xlFDKoKXr4bIlD1pG2vx9PDxq0gI1Eas6jrNbeZ+N6O1nO3LAKH/ihPlU
 pj0WB09b8ivRNVaxE9AecT0AZ8mtFC1uBVCUBcFnpkUP3d4Uj0T85yBZa
 eFcg9943Ridyg6E1yAK7ZetGvC2PCP9pl3iQOY9DcvPb4GZz0japK3KGr w==;
X-CSE-ConnectionGUID: 30AqrBaTQKmSpNhwWa0m9w==
X-CSE-MsgGUID: 7aKDF/uGQveGw5GwwH3FdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82728110"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82728110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 05:17:17 -0700
X-CSE-ConnectionGUID: zEimjj2TSCOuiJMyVaYcEg==
X-CSE-MsgGUID: J+tBOO0sQlekz946BsiAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="272435392"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2026 05:17:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] net/iavf: report selected burst mode when no-poll active
Date: Thu, 18 Jun 2026 12:17:11 +0000
Message-ID: <20260618121711.371057-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618094959.97727-1-ciara.loftus@intel.com>
References: <20260618094959.97727-1-ciara.loftus@intel.com>
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

When the no-poll feature is enabled (it is enabled by default), the
device burst functions point at the no-poll wrapper for the lifetime of
the port. As the wrapper occupies the "Disabled" slot in the burst mode
path-info tables, the Rx/Tx burst mode was always reported as "Disabled"
regardless of link state, even though the wrapper only drops traffic
while the link is down and otherwise dispatches to the selected path.

Report the burst mode of the selected path directly by indexing the
path-info tables with the selected path type. This fixes the misreport
while the no-poll wrapper is active and also simplifies the burst mode
lookup: the previous pointer comparison and table search loop are no
longer needed.

Fixes: 0d5a856f5be9 ("net/iavf: support Rx/Tx burst mode info")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* cast func_type to size_t in bounds check to fix -Wsign-compare error
---
 drivers/net/intel/iavf/iavf_rxtx.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index decbc75142..a8ffb92b63 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3567,18 +3567,18 @@ iavf_rx_burst_mode_get(struct rte_eth_dev *dev,
 		       __rte_unused uint16_t queue_id,
 		       struct rte_eth_burst_mode *mode)
 {
-	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
-	size_t i;
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	enum iavf_rx_func_type rx_func_type = adapter->rx_func_type;
 
-	for (i = 0; i < RTE_DIM(iavf_rx_path_infos); i++) {
-		if (pkt_burst == iavf_rx_path_infos[i].pkt_burst) {
-			snprintf(mode->info, sizeof(mode->info), "%s",
-				 iavf_rx_path_infos[i].info);
-			return 0;
-		}
-	}
+	if ((size_t)rx_func_type >= RTE_DIM(iavf_rx_path_infos) ||
+			iavf_rx_path_infos[rx_func_type].info == NULL)
+		return -EINVAL;
 
-	return -EINVAL;
+	snprintf(mode->info, sizeof(mode->info), "%s",
+		 iavf_rx_path_infos[rx_func_type].info);
+
+	return 0;
 }
 
 static const struct ci_tx_path_info iavf_tx_path_infos[] = {
@@ -3685,18 +3685,18 @@ iavf_tx_burst_mode_get(struct rte_eth_dev *dev,
 		       __rte_unused uint16_t queue_id,
 		       struct rte_eth_burst_mode *mode)
 {
-	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
-	size_t i;
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	enum iavf_tx_func_type tx_func_type = adapter->tx_func_type;
 
-	for (i = 0; i < RTE_DIM(iavf_tx_path_infos); i++) {
-		if (pkt_burst == iavf_tx_path_infos[i].pkt_burst) {
-			snprintf(mode->info, sizeof(mode->info), "%s",
-				 iavf_tx_path_infos[i].info);
-			return 0;
-		}
-	}
+	if ((size_t)tx_func_type >= RTE_DIM(iavf_tx_path_infos) ||
+			iavf_tx_path_infos[tx_func_type].info == NULL)
+		return -EINVAL;
 
-	return -EINVAL;
+	snprintf(mode->info, sizeof(mode->info), "%s",
+		 iavf_tx_path_infos[tx_func_type].info);
+
+	return 0;
 }
 
 static uint16_t
-- 
2.43.0

