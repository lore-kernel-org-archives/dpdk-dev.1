Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F7C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D49E4279B;
	Thu, 12 Jun 2025 13:12:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EE86B42791
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726742; x=1781262742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2A0rzHo/QornRD4+VH7Cg6KgMxiVklTDC9ccPTktPUA=;
 b=dWh8h0xLTQcmEkB8PGrE4W5SoW/tCJqWyOdiqhtZGOqs/+pbUmuJ0x/w
 bvruaQk2hO0ZkIEecpbvoq1a+XS6qRYDBgyR0CCgDqCmI9+E9jvrbgVTx
 GzlGQGZI2+nvdhR6EABjBew+6wG0zEnuQZUG5jiyO+jNm/cywwKWwwn0u
 g/KtTpVwRmvS6yMfHz26ujErMdHzr30adqL4ac42ZOrOgNWgs2WEuLjxv
 tEeObRBGCCkPCp7Ol82l5GykUBq1i0L3Ym4K9qAbQWgDTQjCDc8nRizxG
 fOfMulI0QBHBmKHo8XoB1Z7zrxq1NR7HEeT6cm06DoKGBjTFT6QHqheLa A==;
X-CSE-ConnectionGUID: DoVZSgPAQNiogZ8j0Z4+oQ==
X-CSE-MsgGUID: JMu1NPLUQcytbGb3fdY0CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177561"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177561"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:21 -0700
X-CSE-ConnectionGUID: fDKpEMntTV+69kH5Mss+gg==
X-CSE-MsgGUID: VL6oWb/xSSijuuxNTpmYfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371353"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 16/33] net/ixgbe: simplify vector PMD compilation
Date: Thu, 12 Jun 2025 12:11:22 +0100
Message-ID: <bdad11eeaa215a31440b669b618cf9a50a734f4e.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 96 ++++++----------------------
 drivers/net/intel/ixgbe/meson.build  |  2 +
 2 files changed, 22 insertions(+), 76 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index ace21396f8..48675ab964 100644
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
+#define ixgbe_rx_queue_release_mbufs_vec ixgbe_rx_queue_release_mbufs_non_vec
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
@@ -6199,79 +6219,3 @@ ixgbe_config_rss_filter(struct rte_eth_dev *dev,
 
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
-void
-ixgbe_recycle_rx_descriptors_refill_vec(void __rte_unused * rx_queue,
-		uint16_t __rte_unused nb_mbufs)
-{
-}
-
-uint16_t
-ixgbe_recycle_tx_mbufs_reuse_vec(void __rte_unused * tx_queue,
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

