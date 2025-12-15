Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3AD5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7006402EB;
	Mon, 15 Dec 2025 15:07:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 20EF540151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807670; x=1797343670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/O4eNNo5NEaQ9PI+1HU2yYpIA13zCmoXxpHh2Yq6NRE=;
 b=AoKM/DAtjpumM9iGz257fWeMEDN0M9n00NhEjB06kfAfwZ3q/SoEEIHA
 9CxweY5QiEtCoZT49ulNLzBpEApwd9EyZ8dXLZtMCEAha5gmRMKCGB0iV
 HSWG5gLs8TFV1aNb6631pShgQsi9TtldtXtJRxkHvP0hnQ2PnjiaUZXYJ
 X8fDD9KEolZrsMh3nPV+fxz7wdi4NYTfY63QGZWB9Ry/427Bu0awTSku4
 0Awwf4E8loZqtPnxOvymxuLYKNHgjZqFqdM3nNrW5dMz3K8RyedUv7S26
 Hlz6BLIgYb9wnMyiwTx/OidiQAY3fD5O2P7E6haJRVbMQltxE5XT0auO+ A==;
X-CSE-ConnectionGUID: ABSZrUp/RcGmGuqicfZ3cw==
X-CSE-MsgGUID: JYi7/xBKTWaZIiJ+MFE2xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078687"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:49 -0800
X-CSE-ConnectionGUID: ndyFYQhHTAqpl3lGdU90Tg==
X-CSE-MsgGUID: UwM/FPu3R2OIkRVkUFC4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996399"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:48 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/8] net/ice: ensure all Tx paths are selectable
Date: Mon, 15 Dec 2025 14:05:48 +0000
Message-ID: <20251215140553.2283531-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Tx paths are defined. The Tx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the ice_tx_func_type enum and only defining a value
for the Tx path if it is implemented in the ice_tx_path_infos array.

Fixes: 058abc74f380 ("net/ice: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index a2379a68c2..d1d31760d5 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -211,11 +211,15 @@ enum ice_rx_func_type {
 enum ice_tx_func_type {
 	ICE_TX_DEFAULT,
 	ICE_TX_SIMPLE,
+#ifdef RTE_ARCH_X86
 	ICE_TX_SSE,
 	ICE_TX_AVX2,
 	ICE_TX_AVX2_OFFLOAD,
+#ifdef CC_AVX512_SUPPORT
 	ICE_TX_AVX512,
 	ICE_TX_AVX512_OFFLOAD,
+#endif
+#endif
 };
 
 struct ice_adapter;
-- 
2.43.0

