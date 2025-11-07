Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD4FCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA9140E34;
	Fri,  7 Nov 2025 16:51:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AC91440E2A;
 Fri,  7 Nov 2025 16:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530685; x=1794066685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S5/3UcCIRRx11wN0SNC84qa5BhT2AoyaucHrsXRn2g4=;
 b=MxiMiidZinyAemZpHcGpbA6jsP9YZHtNk+i0cG87dCKf1p679HnZWLqq
 mg0I7K3crepU7qn5KSh5+T2SGXmUmbgP5Mtc23N8rRFaDgDxkM4XUDqVp
 5VLocZ0ONY1oLefUMKExtx6kYZoq5/v3sxzSnofIpQfZpJwhKN23+plQs
 iNhHXhHyIY9WQUMfy8dBc0DBOiSdE80XX4J0RyxDiNgQ2yEWJxSz+IIJQ
 eBceeOhZ5G/Pt0rARhaGwb/cqzMiPMd9qa8G7HQh1sdig15gd87Lzwpg/
 bKDk3+MiEJwqKGqrhiWU/Ycqft2vVy7cRlLzRV+pITsutq72PRE30EgsH A==;
X-CSE-ConnectionGUID: +ql14zjJRi67R41UQPVCUw==
X-CSE-MsgGUID: 0lGNa2nzQPKPphJ3zX/2Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151857"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:24 -0800
X-CSE-ConnectionGUID: OhoKgX+STd+5oUkZRqQtFQ==
X-CSE-MsgGUID: ks+5dV8AQqG+zLZD22amtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321718"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Helin Zhang <helin.zhang@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [RFC PATCH v2 18/33] net/ixgbe: fix build with shadow warnings enabled
Date: Fri,  7 Nov 2025 15:50:14 +0000
Message-ID: <20251107155034.436809-19-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

The loop counter "i" was shadowed, with it being used in a macro and
also as a local variable in the function using that macro. Fix the issue
by making "i" a loop-local variable in all contexts.

Fixes: 76c6f89e80d4 ("ixgbe: support new flow director masks")
Fixes: 2c6b19af78e3 ("ethdev: increase flow type limit from 32 to 64")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_fdir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b6351bc2cf..97ef185583 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -67,8 +67,7 @@
 
 #define IPV6_MASK_TO_ADDR(ipv6m, ipaddr) do { \
 	uint8_t ipv6_addr[16]; \
-	uint8_t i; \
-	for (i = 0; i < sizeof(ipv6_addr); i++) { \
+	for (uint8_t i = 0; i < sizeof(ipv6_addr); i++) { \
 		if ((ipv6m) & (1 << i)) \
 			ipv6_addr[i] = UINT8_MAX; \
 		else \
@@ -1282,7 +1281,7 @@ ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	uint32_t fdirctrl, max_num, i;
+	uint32_t fdirctrl, max_num;
 	uint8_t offset;
 
 	fdirctrl = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
@@ -1317,7 +1316,7 @@ ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info
 		fdir_info->flow_types_mask[0] = 0ULL;
 	else
 		fdir_info->flow_types_mask[0] = IXGBE_FDIR_FLOW_TYPES;
-	for (i = 1; i < RTE_FLOW_MASK_ARRAY_SIZE; i++)
+	for (uint32_t i = 1; i < RTE_FLOW_MASK_ARRAY_SIZE; i++)
 		fdir_info->flow_types_mask[i] = 0ULL;
 
 	fdir_info->flex_payload_unit = sizeof(uint16_t);
-- 
2.48.1

