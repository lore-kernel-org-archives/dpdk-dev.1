Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:10:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98FB94065A;
	Thu,  6 Nov 2025 15:10:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 72B8A40431;
 Thu,  6 Nov 2025 15:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438206; x=1793974206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mnWuuScGQCYX3OnXRC76SZ/PWCaXYLhgEwsvmlWUb7U=;
 b=QZfGedfa+MFxZkp23wx2K4z8XIfE++XJA8lTAw53neIbml+UKkf4mSeo
 O+WsTejEiwlc+n1JfALJYWcAQJXqQWp6ik7eRtz8KYz0NLnIOnIT4AGdz
 0i/zAkuzIvfYyHLcOheZ4mtxX5SFkGNCO4Q46hY6JbvzDLVpGPmARHtho
 Nx3MZ0yAccSPlZrwoTJHbUcFjsIhOfeZbyzkckS11zEadHJ+uzBmkZXhF
 ziMjRx62ZOqZ4Gvt3JpfzUNeokMSpJ4ZrvQpnMhBtDM6rzIjqfK4UsSej
 22MYuxzurda0eKnZDJmuunNQpJWcLkdV+CVBGkfWeu3HoiCmJh78H/QAo w==;
X-CSE-ConnectionGUID: ZXJkShQJQgGCl3sJQXcbNA==
X-CSE-MsgGUID: CpkX8VZKQZ6ci0qnynBQpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185293"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185293"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:05 -0800
X-CSE-ConnectionGUID: Qn9m2mAEREGBhAdmMELmXA==
X-CSE-MsgGUID: mo3fbx3xT0K4NQA7Ne2M7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054705"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 02/19] ethdev: fix variable shadowing issues
Date: Thu,  6 Nov 2025 14:09:31 +0000
Message-ID: <20251106140948.2894678-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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
2.48.1

