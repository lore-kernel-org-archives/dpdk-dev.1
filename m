Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE15D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55E7F40B98;
	Mon,  1 Dec 2025 12:45:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 75A1140A6B;
 Mon,  1 Dec 2025 12:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589522; x=1796125522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f0ewhLl11o+Mw2Xkce5b0liEslnlfZ3q1hlFa+b6Tyg=;
 b=INwvExh46L2TfSHAiKgtgxy6Un3toYogWqIt7axivxz/lONdT0nrtAXA
 zsiaPskgI4C0kLkSTDEFv5pEqE416UCB3YA7BIUu9DgmpYFSbLX9+R3H2
 m/LhwOC70KFrwlfIBvtkQukOi7nKK7aLsstfw14MLjfoekfkZyO9oSjpz
 qeSVImcSlvKF7Fs2pJE6ZKw7XbU/1W0FoZ9FQ0C5vF7RFKbT8vfcox9sS
 OOzqKeCnBQUjwFmJd1Yj0abdkcT797ebf3+jpPS1Xm1ZE4BBgL0TzhUvi
 o83dsKR07h/Kbo6NabiqByShRao7ot6OPN+uf237Lz0v7daJB+mqF2KOC g==;
X-CSE-ConnectionGUID: nVAoboSnSo2OP/tSBoCi1Q==
X-CSE-MsgGUID: gJBRucMVSIafYXv1e8G0zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991744"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991744"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:21 -0800
X-CSE-ConnectionGUID: UrW1oDEaSqqu58DNKfzywg==
X-CSE-MsgGUID: jI0rel1UT+2fHo1luPadPA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 17/31] net/ixgbe: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:34 +0000
Message-ID: <20251201114448.1441377-18-bruce.richardson@intel.com>
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

The loop counter "i" was shadowed, with it being used in a macro and
also as a local variable in the function using that macro. Fix the issue
by making "i" a loop-local variable in all contexts.

Fixes: 76c6f89e80d4 ("ixgbe: support new flow director masks")
Fixes: 2c6b19af78e3 ("ethdev: increase flow type limit from 32 to 64")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

