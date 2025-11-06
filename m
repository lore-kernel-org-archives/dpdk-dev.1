Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B5CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AEE940E20;
	Thu,  6 Nov 2025 15:10:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 04A0C40DD7;
 Thu,  6 Nov 2025 15:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438221; x=1793974221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S5/3UcCIRRx11wN0SNC84qa5BhT2AoyaucHrsXRn2g4=;
 b=ZUC9UeJgaeAZvaQv2qrpnWWzaeFdAHDvkewiDGtIeSVdrSjNUyUZQz8W
 Nm4KUpO2QFaEMArdJEolpfKvNXiu+JDesg93wMu3SSN5yVqULrA7yD6nZ
 AxJ2h7Tic9ddM++R7WcI5eM5IzZ0HFGrFViIOOvjoQszk0fP1EnS0A99O
 98BefWQk3cAEainVn5TvT5197Rch5x5RXg3QQCG7N38VMhJXTqBUnuUQo
 dbTpguZFv5Y14rXZ2kncM1aGI6KptOXrHqrlzIyRSsuLwa+uADfNTaJhW
 Wvy6dYEq502kMZQ6Japi7CW647WK86CvNqhZ3I+N490ctjZdv17H2UNr3 A==;
X-CSE-ConnectionGUID: lNawsZf/SLmBaDqRSC37ig==
X-CSE-MsgGUID: IaKhxicZSUGyoPnSG73x4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185355"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:21 -0800
X-CSE-ConnectionGUID: dO63RqkCTqOgKzzx5rTFOg==
X-CSE-MsgGUID: tflUOgp1QUO0ab9K/7CK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054809"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 18/19] net/ixgbe: fix build with shadow warnings enabled
Date: Thu,  6 Nov 2025 14:09:47 +0000
Message-ID: <20251106140948.2894678-19-bruce.richardson@intel.com>
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

