Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2516E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 12:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AC63402A3;
	Wed, 18 Feb 2026 13:04:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id AF24C4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 13:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771416272; x=1802952272;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XsYt/MBsc0WwbYTZ4QHcZRlWRw+OrVp2HqyRvKGL5PY=;
 b=PY9FU5igQNmG08Mw2bNmBt0TbkrjdkGl8j/pLZJVDSaIxtVf9R+O7dex
 KQibtECWERon7arop9cNV9AKRikpKcNrfFVVdpT1HveCSxJyiA8Fl+hOa
 8SOrjjH6roXQ1V6XuBMJSIV/TaGVbLCBRJmDwUGou6TUIcz1PY4ra+3R8
 HQKsIhw8kvdNNFMxJdRAfUwW0r4dlmlGs1gx0NyXoqr8C5BzbMIFTZzVV
 zo4ji8m8Ns+mdOaeRZxB7t7FLJnin/dSF7vBspc/Ws159HEIMB7doeth8
 2uXwO/4C4P2vupKKN7D4Psj/3GVrw79QS4b+fH0Aw3q8iRzSXqeTAJkyp A==;
X-CSE-ConnectionGUID: i0T+UQtzS+Kc0VGpGi0l5g==
X-CSE-MsgGUID: /TX8Hr9NRZu2uiblG2NE0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83113595"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83113595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 04:04:31 -0800
X-CSE-ConnectionGUID: Ikc/AUnzQJejcxOoKao6/A==
X-CSE-MsgGUID: 1TP+22meTKqMi18ve3kY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214165784"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 18 Feb 2026 04:04:30 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/idpf: remove useless function
Date: Wed, 18 Feb 2026 12:04:12 +0000
Message-ID: <20260218120412.1809390-1-ciara.loftus@intel.com>
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

Commit 376faf4aaa16 ("net/idpf: enable simple Tx function") removed the
one assignment that was performed in the function
idpf_qc_tx_vec_avx512_setup. Without it, the function is useless and
results in USELESS_CALL defects reported by Coverity. Fix these by
removing the function and the logic that calls it in idpf and cpfl.

Coverity issue: 501500
Coverity issue: 501501

Fixes: 376faf4aaa16 ("net/idpf: enable simple Tx function")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c               | 16 ----------------
 drivers/net/intel/idpf/idpf_common_rxtx.h        |  4 ----
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 10 ----------
 drivers/net/intel/idpf/idpf_rxtx.c               | 16 ----------------
 4 files changed, 46 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 11451e1666..36ee452876 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1551,20 +1551,4 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
 	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
 			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
-
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256 &&
-			idpf_tx_path_infos[ad->tx_func_type].features.single_queue) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			txq = dev->data->tx_queues[i];
-			if (txq == NULL)
-				continue;
-			if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width ==
-					RTE_VECT_SIMD_512)
-				idpf_qc_tx_vec_avx512_setup(txq);
-		}
-	}
-#endif /* CC_AVX512_SUPPORT */
-#endif /* RTE_ARCH_X86 */
 }
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 914cab0f25..cc11ea43b9 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -231,10 +231,6 @@ int idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq);
 __rte_internal
 int idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq);
 __rte_internal
-int idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq);
-__rte_internal
-int idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq);
-__rte_internal
 uint16_t idpf_dp_singleq_recv_pkts_avx512(void *rx_queue,
 					  struct rte_mbuf **rx_pkts,
 					  uint16_t nb_pkts);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index fe870617bc..bcf8fec14c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1357,13 +1357,3 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	return idpf_splitq_xmit_pkts_vec_avx512_cmn(tx_queue, tx_pkts, nb_pkts);
 }
-
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
-int __rte_cold
-idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
-{
-	if (!txq)
-		return 0;
-
-	return 0;
-}
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 6317112353..448d5fb425 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -897,20 +897,4 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
 	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
 			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
-
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256 &&
-			idpf_tx_path_infos[ad->tx_func_type].features.single_queue) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			txq = dev->data->tx_queues[i];
-			if (txq == NULL)
-				continue;
-			if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width ==
-					RTE_VECT_SIMD_512)
-				idpf_qc_tx_vec_avx512_setup(txq);
-		}
-	}
-#endif /* CC_AVX512_SUPPORT */
-#endif /* RTE_ARCH_X86 */
 }
-- 
2.43.0

