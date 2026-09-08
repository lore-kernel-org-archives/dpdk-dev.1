Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7BBC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B3842789;
	Tue,  8 Sep 2026 17:22:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2F5824028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880935; x=1820416935;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=m73bFb0abRApxIaSnWAmNfyTi9SNizPmCnE1j6X6mLw=;
 b=N5pFxmUIG1t+sBIJvLTQ6SfufgmN2pquZXfTKaikpYebcAgEFAU8+B1f
 vXnPfiDFGWauoMe7EakJGarkpV5dhfkcRHpzjmaNxz3tBT/Sa2cpJajW8
 +iQZRZx2JXJkKJeNhOqNmDYQjiwIvAlOEZXnhtPJdbyBsaYjsEKH5O0F8
 FG2Z2yv6286zlskmawEmf7kJx/v34nj8DqqtOdvaXpdmsZSvMW+Cpj3nP
 5y50jg1yxmPMA5NSDuN3/Bz/EvxTjMXwLd5NTAtmNPkGt8CYjujED2dZ/
 RXl6pPAnYCk+gCaWUbWrTqPRPQshwapdWM9UZJh+5IsIauXdbj4bw9iIb g==;
X-CSE-ConnectionGUID: cALQI5C7TPq6CanYSWuHMA==
X-CSE-MsgGUID: WV7+H9IfRPOufi03NkB3bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330184"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:14 -0700
X-CSE-ConnectionGUID: jo1yd6kaS2Gjx9/LYhsKgw==
X-CSE-MsgGUID: x0dMdVoYT+6E6QKwhwAEVg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 12/19] net/ixgbe: advertise flow keep capability
Date: Tue,  8 Sep 2026 16:20:54 +0100
Message-ID: <d236b16894e1c5bc31297ae3757492ab1484bb9b.1788880124.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788880122.git.anatoly.burakov@intel.com>
 <cover.1788880122.git.anatoly.burakov@intel.com>
References: 
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

The ixgbe driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 0f2188f6a9..b8bcd12b6a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3968,6 +3968,9 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = ixgbe_reta_size_get(hw->mac.type);
 	dev_info->flow_type_rss_offloads = IXGBE_RSS_OFFLOAD_ALL;
 
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T ||
 			hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T_L)
-- 
2.52.0

