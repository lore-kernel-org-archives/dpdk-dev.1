Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6928CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:50:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1CEF4027F;
	Thu, 18 Jun 2026 11:50:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id CC73740268;
 Thu, 18 Jun 2026 11:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781776224; x=1813312224;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NVJ7j0O7mOgrws+PPMlKmmuLBX6egj4wd6M9Ug9fKDo=;
 b=To4mU53IIsPnedyN6UobpGm2pebLxaa/9C7JR0i+mdYu9Sq++SuCbK1/
 bMEPhl9UVDVihrrjZCWU5giIOn3n6xI6DjOHyNtAL3LPV8o2B/bL0jbvE
 6864DlYzrC845wyE6vfMygio0opu75VKbErMYjr5i674d7mf5klMvaWWb
 zwd/2T3ZUk0bFYdbIGS1TFJP3UDo4g+3KFgs2xS7CeHxwIyPB4awJ0wOL
 U8vEupJuA5lHTKXUlbeFJkXdXRE6n0OaENPNaxPsElON6Ols1PRL59qwx
 vuOIO8lChEQiLvELuGMg+y7LS/N67awQiO8ikoHccAeKW6ibgH2WZpGuR Q==;
X-CSE-ConnectionGUID: j+S7+7sZQzKoqGvQ37iBSQ==
X-CSE-MsgGUID: Ow9Xv6c8Qga3tDxPXlosUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82699878"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82699878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 02:50:23 -0700
X-CSE-ConnectionGUID: 7TJVcAplSjCfEwS9sHEOjA==
X-CSE-MsgGUID: MIrlPi5uSFWLI5bvsC34ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="252641101"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa004.jf.intel.com with ESMTP; 18 Jun 2026 02:50:21 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: report selected burst mode when no-poll active
Date: Thu, 18 Jun 2026 09:49:59 +0000
Message-ID: <20260618094959.97727-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/net/intel/iavf/iavf_rxtx.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index decbc75142..9cc09583a3 100644
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
+	if (rx_func_type >= RTE_DIM(iavf_rx_path_infos) ||
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
+	if (tx_func_type >= RTE_DIM(iavf_tx_path_infos) ||
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

