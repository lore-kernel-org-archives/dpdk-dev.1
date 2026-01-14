Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA5D37E44
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F58540A79;
	Wed, 14 Jan 2026 16:45:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C2E0C40A72;
 Wed, 14 Jan 2026 16:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405506; x=1799941506;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QmhrqqkDXXIJbiUhz63Tyis71OZFAbHGF1MnYEC9kiI=;
 b=Jn7qE1/B8r5RjoAaf/SvOvIw1CCi+Ppt4XO9Tp2DZH3Btu3Q+SnGSXBw
 +qlQOwpXft8WSdWpcj7yUmGn9hood507Ltkhp9X3qkrPJ6W4tbUcHgFJ1
 kLPfwLm13Mdq3JsMCZsnIAyK4UPaYIff2lWGMKtuGiqdMcIQccELGrsEf
 vLexCvTdblFVUrthx+DRvVsO2AeeRuA6GWB9jej6ESPvoLMtd92ZX4+RE
 +u2L0y73PG/oyxVE0iAUuBKZk+NwTJDbjorHGcAS7PUtGvti4tLiRYZzc
 nxCujKmdRrcyb+8N776l68lZ7KOENUO+4APGyS32as2kyQGTQNVd2D4bC A==;
X-CSE-ConnectionGUID: 7CzXSP6xT3mG1bVa+ESUAQ==
X-CSE-MsgGUID: UWT6Sr7bTNuijyh+n5iUJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870784"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870784"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:05 -0800
X-CSE-ConnectionGUID: 2O2kvHkGRkqIK+zSJJkb8Q==
X-CSE-MsgGUID: DC165iY0SqaV3KlPVl8d0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924911"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Declan Doherty <declan.doherty@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Huisong Li <lihuisong@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH v4 03/31] ethdev: fix variable shadowing issues
Date: Wed, 14 Jan 2026 15:44:17 +0000
Message-ID: <20260114154450.2969716-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

