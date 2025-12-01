Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6DAD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACBDD402EA;
	Mon,  1 Dec 2025 12:45:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7B6D0402E9;
 Mon,  1 Dec 2025 12:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589507; x=1796125507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QmhrqqkDXXIJbiUhz63Tyis71OZFAbHGF1MnYEC9kiI=;
 b=E0LifUZhTxGKwHaMS/ewQ063gX1Ogvj/XSuEf2g6wf5A2ssb3RUnrnmr
 FUN/sP7Xzsss9PdOzgRu7Exv2nxBT4EJeWH2YqQa8O2x0hXc7EEFYL0p4
 jixTydVXC/Pcc/Dm9o+C73T6uVlfs7av4Tbxj960SSWgssDNL+KeyzPcE
 TJwLvu44sxQzDv4CRBEA2VRy7n+Z04Z62SsJTUdO1CfmLOPL98LMIW/Q6
 eprCUYPgsCH5+8TjsITMGiDGOsQKgWo+DQfIFCas4qbidizLKWv1vs4ba
 r6uEtT8BqrMujYeSrxkuz25DoeYduRnlrSivWpBhEN+YP0tRF3n152AXL Q==;
X-CSE-ConnectionGUID: okUS/4gpRQOxJzAEoy7l8g==
X-CSE-MsgGUID: MYq0tF0BQsqBCP4NVJuujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991694"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991694"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:06 -0800
X-CSE-ConnectionGUID: 47WHtOtUTDelSuokOHPVQg==
X-CSE-MsgGUID: M7vFszjKS9Kg3OG16DkjyQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 03/31] ethdev: fix variable shadowing issues
Date: Mon,  1 Dec 2025 11:44:20 +0000
Message-ID: <20251201114448.1441377-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

Remove unneeded extra variable definitions, and rename variables as
necessary to ensure clean compile with -Wshadow warnings enabled.

Fixes: e489007a411c ("ethdev: add generic create/destroy ethdev APIs")
Fixes: 1bb4a528c41f ("ethdev: fix max Rx packet length")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c | 6 +++---
 lib/ethdev/rte_ethdev.c    | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index f89562b237..2ec665be0f 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -310,7 +310,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_create)
 int
 rte_eth_dev_create(struct rte_device *device, const char *name,
 	size_t priv_data_size,
-	ethdev_bus_specific_init ethdev_bus_specific_init,
+	ethdev_bus_specific_init bus_specific_init,
 	void *bus_init_params,
 	ethdev_init_t ethdev_init, void *init_params)
 {
@@ -358,8 +358,8 @@ rte_eth_dev_create(struct rte_device *device, const char *name,
 
 	ethdev->device = device;
 
-	if (ethdev_bus_specific_init) {
-		retval = ethdev_bus_specific_init(ethdev, bus_init_params);
+	if (bus_specific_init) {
+		retval = bus_specific_init(ethdev, bus_init_params);
 		if (retval) {
 			RTE_ETHDEV_LOG_LINE(ERR,
 				"ethdev bus specific initialisation failed");
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..2659e8d9eb 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2471,7 +2471,6 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	if (local_conf.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
 		uint32_t overhead_len;
 		uint32_t max_rx_pktlen;
-		int ret;
 
 		overhead_len = eth_dev_get_overhead_len(dev_info.max_rx_pktlen,
 				dev_info.max_mtu);
-- 
2.51.0

