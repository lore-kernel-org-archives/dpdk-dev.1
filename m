Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D859C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42A4B40E3E;
	Fri,  6 Jun 2025 19:09:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B766640E2A
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229797; x=1780765797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fxIsv34bMQQt6+/73/WWU9BVwMkzSBSS8ixLgIzf250=;
 b=GYyjgNmebDvAWlJoXOb+psrI3BF+svpXXB5rYoInk4+RRDqR057OYA9H
 YAYNifUjQbFKCZS7ugCogLsM8y7xP0QQe/TXnRg/5kWWtcQomsCWiUEdf
 rpXfeNiWL2Oxjph3WjTGkcgLrd2sxujoBkH0LzSZfjzKSXFVCOwRnlHGd
 j17096kmNfEKqbqInvyjTBTq6rg6gOKBynnyMM7Ff+JcNOQnjNbRVFqf7
 TbapM/E4owlG8bqSL8Bl/oY7MLOaYokN2mUih7Z8ViLiIniH/Jgk0tiVE
 kKET3iAlIWN9Z7T70qkkv61Cjrk4CVgz01lDeKR5/g/yLjBiQ2N329Kz+ A==;
X-CSE-ConnectionGUID: ebUfWBlDT+qbYvjBjZvxCg==
X-CSE-MsgGUID: Qb4bnj1RRV2i5r5Aqy4G5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828443"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:56 -0700
X-CSE-ConnectionGUID: QaDos3dnRzam9Z5JOMhAag==
X-CSE-MsgGUID: 8ISqaWipSTKJ7bxx+4LiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808207"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 17/34] net/ixgbe: simplify vector PMD compilation
Date: Fri,  6 Jun 2025 18:08:56 +0100
Message-ID: <8a419475997b26463897b751cfcbc8e3d94ec921.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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

Currently, vector code is guarded by platform checks, and unused functions
are implemented using stubs.

Simplify things the following way:

- Define a compilation flag `IXGBE_VPMD_SUPPORTED` that will enable or
  disable vector code support regardless of platform
- Wrap platform checks with said definition
- Remove all stubs and replace them with macros that alias either to
  existing scalar implementations, or NULL

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 94 ++++++----------------------
 drivers/net/intel/ixgbe/meson.build  |  2 +
 2 files changed, 22 insertions(+), 74 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index f7682e16c1..a64f6e7e6a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -52,7 +52,23 @@
 #include "base/ixgbe_common.h"
 #include "ixgbe_rxtx.h"
 
+#ifdef IXGBE_VPMD_SUPPORTED
 #include "ixgbe_rxtx_vec_common.h"
+#else
+/* alias unsupported Rx/Tx vector functions to scalar implementations */
+#define ixgbe_recv_pkts_vec ixgbe_recv_pkts
+#define ixgbe_recv_scattered_pkts_vec ixgbe_recv_pkts_lro_single_alloc
+#define ixgbe_xmit_pkts_vec ixgbe_xmit_pkts_simple
+/* ensure all vector checks/setup always fail */
+#define ixgbe_rx_vec_dev_conf_condition_check(unused) (RTE_SET_USED(unused), -1)
+#define ixgbe_rxq_vec_setup(unused) RTE_SET_USED(unused)
+#define ixgbe_txq_vec_setup(unused) (RTE_SET_USED(unused), -1)
+/* use scalar mbuf release function */
+#define ixgbe_rx_queue_release_mbufs_vec ixgbe_rx_queue_release_mbufs
+/* these are not applicable to scalar paths */
+#define ixgbe_recycle_rx_descriptors_refill_vec NULL
+#define ixgbe_recycle_tx_mbufs_reuse_vec NULL
+#endif
 
 #ifdef RTE_LIBRTE_IEEE1588
 #define IXGBE_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
@@ -2602,11 +2618,13 @@ static const struct {
 	{	ixgbe_xmit_pkts, "Scalar"},
 	{	ixgbe_xmit_pkts_simple, "Scalar simple"},
 	{       ixgbe_vf_representor_tx_burst, "Scalar representor"},
+#ifdef IXGBE_VPMD_SUPPORTED
 #ifdef RTE_ARCH_X86
 	{	ixgbe_xmit_pkts_vec, "Vector SSE"},
 #elif defined(RTE_ARCH_ARM)
 	{	ixgbe_xmit_pkts_vec, "Vector NEON"},
 #endif
+#endif
 };
 
 int
@@ -4942,6 +4960,7 @@ static const struct {
 	{	ixgbe_recv_pkts_lro_bulk_alloc, "Scalar LRO bulk alloc"},
 	{	ixgbe_recv_pkts_lro_single_alloc, "Scalar LRO single alloc"},
 	{       ixgbe_vf_representor_rx_burst, "Scalar representor"},
+#ifdef IXGBE_VPMD_SUPPORTED
 #ifdef RTE_ARCH_X86
 	{	ixgbe_recv_pkts_vec, "Vector SSE"},
 	{	ixgbe_recv_scattered_pkts_vec, "Vector SSE scattered"},
@@ -4949,6 +4968,7 @@ static const struct {
 	{	ixgbe_recv_pkts_vec, "Vector NEON"},
 	{	ixgbe_recv_scattered_pkts_vec, "Vector NEON scattered"},
 #endif
+#endif
 };
 
 int
@@ -6199,77 +6219,3 @@ ixgbe_config_rss_filter(struct rte_eth_dev *dev,
 
 	return 0;
 }
-
-/* Stubs needed for linkage when RTE_ARCH_PPC_64, RTE_ARCH_RISCV or
- * RTE_ARCH_LOONGARCH is set.
- */
-#if defined(RTE_ARCH_PPC_64) || defined(RTE_ARCH_RISCV) || \
-	defined(RTE_ARCH_LOONGARCH)
-int
-ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev __rte_unused *dev)
-{
-	return -1;
-}
-
-void ixgbe_recycle_rx_descriptors_refill_vec(void __rte_unused * rx_queue,
-		uint16_t __rte_unused nb_mbufs)
-{
-}
-
-uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void __rte_unused * tx_queue,
-	struct rte_eth_recycle_rxq_info __rte_unused * recycle_rxq_info)
-{
-	return 0;
-}
-
-uint16_t
-ixgbe_recv_pkts_vec(
-	void __rte_unused *rx_queue,
-	struct rte_mbuf __rte_unused **rx_pkts,
-	uint16_t __rte_unused nb_pkts)
-{
-	return 0;
-}
-
-uint16_t
-ixgbe_recv_scattered_pkts_vec(
-	void __rte_unused *rx_queue,
-	struct rte_mbuf __rte_unused **rx_pkts,
-	uint16_t __rte_unused nb_pkts)
-{
-	return 0;
-}
-
-int
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue __rte_unused *rxq)
-{
-	return -1;
-}
-
-uint16_t
-ixgbe_xmit_pkts_vec(void __rte_unused * tx_queue, struct rte_mbuf __rte_unused * *tx_pkts,
-		__rte_unused uint16_t nb_pkts)
-{
-	return 0;
-}
-
-uint16_t
-ixgbe_xmit_fixed_burst_vec(void __rte_unused *tx_queue,
-		struct rte_mbuf __rte_unused **tx_pkts,
-		uint16_t __rte_unused nb_pkts)
-{
-	return 0;
-}
-
-int
-ixgbe_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return -1;
-}
-
-void
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue __rte_unused *rxq)
-{
-	return;
-}
-#endif
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index e6f0fd135e..7e737ee7b4 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -26,9 +26,11 @@ deps += ['hash', 'security']
 if arch_subdir == 'x86'
     sources += files('ixgbe_rxtx_vec_common.c')
     sources += files('ixgbe_rxtx_vec_sse.c')
+    cflags += ['-DIXGBE_VPMD_SUPPORTED']
 elif arch_subdir == 'arm'
     sources += files('ixgbe_rxtx_vec_common.c')
     sources += files('ixgbe_rxtx_vec_neon.c')
+    cflags += ['-DIXGBE_VPMD_SUPPORTED']
 endif
 
 headers = files('rte_pmd_ixgbe.h')
-- 
2.47.1

