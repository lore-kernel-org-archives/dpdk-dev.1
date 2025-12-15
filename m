Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8247D5B16C
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:07:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEA2402D3;
	Mon, 15 Dec 2025 15:07:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 86F1340151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807669; x=1797343669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SipxIo6RtskqYCnMLt4m5df01K8sKD8B6f5oK2dHCX8=;
 b=OdhXircjwCrtO9epF1z2lhLs3CADSKxVsSchNlTG/pIacIkvqx1nZoTO
 uvJ74G/EZrFou5wM2H8gZPDRX2M9ozwdpGhmFc0GHmAC+f8oYibBF95wk
 nJWpsaivX0VghKyEjghrqB2snc1ohRvin3Rbr5QLfShLBqDTw0bVq7DaF
 9o8XPCuPL3FVFr/X0YW4P71GaRPfjeAUVfpcZRII0rt/yzxvJogevVkkF
 AZIzoI+B182ndhUHSuuhidyzcNraloagm0wmIg+MA7VqkC0/o2dILiAKU
 Oo2UIP77VJG08IsV19qQ2fj0R4830imm5l5eIvTBLJDaYkh0k8n1ZhYXZ Q==;
X-CSE-ConnectionGUID: b9AhHctGQ2CSEJbdOFJ4Ng==
X-CSE-MsgGUID: /AxMf3NkQ06bVj9tMZChhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078681"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:47 -0800
X-CSE-ConnectionGUID: Wz4T4Q7WRp+Bi+gkiV/ylA==
X-CSE-MsgGUID: dEYrcHGER/eSgtbTo0jhXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996391"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:47 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/8] net/i40e: ensure all Tx paths are selectable
Date: Mon, 15 Dec 2025 14:05:46 +0000
Message-ID: <20251215140553.2283531-2-ciara.loftus@intel.com>
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
Fix this by editing the i40e_tx_func_type enum and only defining a value
for the Tx path if it is implemented in the i40e_tx_path_infos array.

Fixes: dc9c426f991f ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 6 ++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 1fe504d0cd..c3240be960 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1246,11 +1246,17 @@ enum i40e_rx_func_type {
 enum i40e_tx_func_type {
 	I40E_TX_DEFAULT,
 	I40E_TX_SCALAR_SIMPLE,
+#ifdef RTE_ARCH_X86
 	I40E_TX_SSE,
 	I40E_TX_AVX2,
+#ifdef CC_AVX512_SUPPORT
 	I40E_TX_AVX512,
+#endif
+#elif defined(RTE_ARCH_ARM64)
 	I40E_TX_NEON,
+#elif defined(RTE_ARCH_PPC_64)
 	I40E_TX_ALTIVEC,
+#endif
 };
 
 /*
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index a7d80e2bc0..f3c9d41686 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3626,10 +3626,14 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
+#ifdef RTE_ARCH_X86
 			ad->tx_func_type == I40E_TX_SSE ||
-			ad->tx_func_type == I40E_TX_NEON ||
-			ad->tx_func_type == I40E_TX_ALTIVEC ||
 			ad->tx_func_type == I40E_TX_AVX2)
+#elif defined(RTE_ARCH_ARM64)
+			ad->tx_func_type == I40E_TX_NEON)
+#elif defined(RTE_ARCH_PPC_64)
+			ad->tx_func_type == I40E_TX_ALTIVEC)
+#endif
 		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
 }
 
-- 
2.43.0

