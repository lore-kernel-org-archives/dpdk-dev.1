Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148ABC83F20
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 03:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A36F94069F;
	Mon, 14 Jul 2025 05:55:31 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id C3B7B4064E
 for <dev@dpdk.org>; Mon, 14 Jul 2025 05:55:22 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowADH8qaJf3RoneLPAw--.5262S15;
 Mon, 14 Jul 2025 11:55:20 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 14/14] net/sxe: add Solve compilation problems.
Date: Sun, 13 Jul 2025 23:54:46 -0400
Message-ID: <20250714035446.163709-14-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250714035446.163709-1-liujie5@linkdatatechnology.com>
References: <20250712061846.305072-14-liujie5@linkdatatechnology.com>
 <20250714035446.163709-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADH8qaJf3RoneLPAw--.5262S15
X-Coremail-Antispam: 1UD129KBjvAXoWfWF45ur1xGFykXr4DCFy5CFg_yoWrGF15Co
 WxKF13AFy5Zrn7J39FgF1kWFW3Xr9FgrW5Jw45uFZ09Fy3Cr15Ar1Fq343JFnrXw1FyFyU
 Aa1xZF1jvr47WFW8n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5gAwDUUUU
X-Originating-IP: [60.29.3.194]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

Add Fix compiling issues.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_common.c          |  2 +-
 drivers/net/sxe/base/sxe_compat_platform.h |  1 -
 drivers/net/sxe/base/sxe_compat_version.h  |  1 -
 drivers/net/sxe/base/sxe_hw.c              | 21 +++++++----
 drivers/net/sxe/base/sxe_offload_common.c  |  1 -
 drivers/net/sxe/base/sxe_queue_common.c    |  3 +-
 drivers/net/sxe/base/sxe_rx_common.c       | 10 +++---
 drivers/net/sxe/base/sxe_rx_common.h       |  2 --
 drivers/net/sxe/base/sxe_tx_common.c       |  1 -
 drivers/net/sxe/base/sxevf_hw.c            |  1 -
 drivers/net/sxe/include/sxe/sxe_cli.h      |  6 ++--
 drivers/net/sxe/meson.build                | 42 +++++++++++-----------
 drivers/net/sxe/pf/sxe.h                   | 13 +++----
 drivers/net/sxe/pf/sxe_dcb.c               |  6 ++--
 drivers/net/sxe/pf/sxe_ethdev.c            |  5 ++-
 drivers/net/sxe/pf/sxe_filter.c            |  1 -
 drivers/net/sxe/pf/sxe_filter.h            |  1 -
 drivers/net/sxe/pf/sxe_irq.h               |  2 --
 drivers/net/sxe/pf/sxe_main.c              | 15 --------
 drivers/net/sxe/pf/sxe_offload.c           |  1 -
 drivers/net/sxe/pf/sxe_phy.c               |  4 +--
 drivers/net/sxe/pf/sxe_pmd_hdc.c           |  1 -
 drivers/net/sxe/pf/sxe_queue.c             |  2 --
 drivers/net/sxe/pf/sxe_queue.h             |  2 --
 drivers/net/sxe/pf/sxe_rx.c                |  2 --
 drivers/net/sxe/pf/sxe_stats.c             | 25 +++++++++----
 drivers/net/sxe/pf/sxe_stats.h             |  8 ++---
 drivers/net/sxe/pf/sxe_tx.c                | 23 +-----------
 drivers/net/sxe/pf/sxe_vec_common.h        |  8 ++++-
 drivers/net/sxe/pf/sxe_vec_neon.c          |  2 --
 drivers/net/sxe/pf/sxe_vec_sse.c           |  1 -
 drivers/net/sxe/pf/sxe_vf.c                |  2 --
 drivers/net/sxe/pf/sxe_vf.h                |  1 -
 drivers/net/sxe/sxe_drv_type.h             |  3 --
 drivers/net/sxe/sxe_testpmd.c              |  4 +--
 drivers/net/sxe/vf/sxevf_ethdev.c          |  6 ++--
 drivers/net/sxe/vf/sxevf_filter.h          |  4 +--
 drivers/net/sxe/vf/sxevf_irq.c             |  2 --
 drivers/net/sxe/vf/sxevf_irq.h             |  1 -
 drivers/net/sxe/vf/sxevf_main.c            |  1 -
 drivers/net/sxe/vf/sxevf_msg.c             |  2 +-
 drivers/net/sxe/vf/sxevf_offload.c         |  1 -
 drivers/net/sxe/vf/sxevf_queue.c           |  2 --
 drivers/net/sxe/vf/sxevf_queue.h           |  1 -
 drivers/net/sxe/vf/sxevf_rx.c              |  1 -
 drivers/net/sxe/vf/sxevf_stats.c           |  4 +--
 46 files changed, 100 insertions(+), 148 deletions(-)

diff --git a/drivers/net/sxe/base/sxe_common.c b/drivers/net/sxe/base/sxe_common.c
index 8b3fb13e73..cf6b656680 100644
--- a/drivers/net/sxe/base/sxe_common.c
+++ b/drivers/net/sxe/base/sxe_common.c
@@ -44,7 +44,7 @@ u64 sxe_time_get_real_ms(void)
 
 u64 sxe_trace_id_gen(void)
 {
-	u64 tid	   = getpid() + (pthread_self() << 20);
+	u64 tid	   = (u64)getpid() + ((u64)pthread_self() << 20);
 	u64 index	 = 0;
 	u64 timestamp = sxe_time_get_real_ms();
 
diff --git a/drivers/net/sxe/base/sxe_compat_platform.h b/drivers/net/sxe/base/sxe_compat_platform.h
index eca944da37..bcfc1e040f 100644
--- a/drivers/net/sxe/base/sxe_compat_platform.h
+++ b/drivers/net/sxe/base/sxe_compat_platform.h
@@ -30,7 +30,6 @@
 #define __force
 
 #define min(a, b)	RTE_MIN(a, b)
-
 #ifndef fallthrough
 # define fallthrough do {} while (0)
 #endif
diff --git a/drivers/net/sxe/base/sxe_compat_version.h b/drivers/net/sxe/base/sxe_compat_version.h
index 5b8577067d..f3c6893ad9 100644
--- a/drivers/net/sxe/base/sxe_compat_version.h
+++ b/drivers/net/sxe/base/sxe_compat_version.h
@@ -6,7 +6,6 @@
 #define __SXE_COMPAT_VERSION_H__
 
 #include <stdbool.h>
-#include "sxe_dpdk_version.h"
 
 struct rte_eth_dev;
 enum rte_eth_event_type;
diff --git a/drivers/net/sxe/base/sxe_hw.c b/drivers/net/sxe/base/sxe_hw.c
index 4fe8f84f6b..0034e64151 100644
--- a/drivers/net/sxe/base/sxe_hw.c
+++ b/drivers/net/sxe/base/sxe_hw.c
@@ -3,6 +3,7 @@
  */
 #ifdef SXE_PHY_CONFIGURE
 #include <linux/mdio.h>
+#include <rte_compat.h>
 #endif
 #include <rte_byteorder.h>
 #if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
@@ -1893,7 +1894,7 @@ static void sxe_hw_rx_pkt_buf_size_configure(struct sxe_hw *hw,
 		for (i = 0; i < (num_pb / 2); i++)
 			SXE_REG_WRITE(hw, SXE_RXPBSIZE(i), rx_buf_size);
 
-		fallthrough;
+		/* fallthrough */
 	case (PBA_STRATEGY_EQUAL):
 		rx_buf_size = (total_buf_size / (num_pb - i))
 				<< SXE_RX_PKT_BUF_SIZE_SHIFT;
@@ -2231,7 +2232,7 @@ static s32 sxe_hw_fnav_vm_pool_mask_get(struct sxe_hw *hw,
 	switch (vm_pool & SXE_SAMPLE_VM_POOL_MASK) {
 	case 0x0:
 		*fnavm |= SXE_FNAVM_POOL;
-		fallthrough;
+		/* fallthrough */
 	case 0x7F:
 		break;
 	default:
@@ -2279,13 +2280,13 @@ static s32 sxe_hw_fnav_vlan_mask_get(struct sxe_hw *hw,
 	switch (ntohs(vlan_id) & SXE_SAMPLE_VLAN_MASK) {
 	case 0x0000:
 		*fnavm |= SXE_FNAVM_VLANID;
-		fallthrough;
+		/* fallthrough */
 	case 0x0FFF:
 		*fnavm |= SXE_FNAVM_VLANP;
 		break;
 	case 0xE000:
 		*fnavm |= SXE_FNAVM_VLANID;
-		fallthrough;
+		/* fallthrough */
 	case 0xEFFF:
 		break;
 	default:
@@ -2305,7 +2306,7 @@ static s32 sxe_hw_fnav_flex_bytes_mask_get(struct sxe_hw *hw,
 	switch ((__force u16)flex_bytes & SXE_SAMPLE_FLEX_BYTES_MASK) {
 	case 0x0000:
 		*fnavm |= SXE_FNAVM_FLEX;
-		fallthrough;
+		/* fallthrough */
 	case 0xFFFF:
 		break;
 	default:
@@ -4963,7 +4964,14 @@ bool sxe_hw_is_rss_enabled(struct sxe_hw *hw)
 {
 	bool rss_enable = false;
 	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
-	if (mrqc & SXE_MRQC_RSSEN)
+
+
+	u32 mrqe_val = mrqc & SXE_MRQC_MRQE_MASK;
+	if (mrqe_val == SXE_MRQC_RSSEN ||
+		mrqe_val == SXE_MRQC_RTRSS8TCEN ||
+		mrqe_val == SXE_MRQC_RTRSS4TCEN ||
+		mrqe_val == SXE_MRQC_VMDQRSS32EN ||
+		mrqe_val == SXE_MRQC_VMDQRSS64EN)
 		rss_enable = true;
 
 	return rss_enable;
@@ -5497,7 +5505,6 @@ void sxe_hw_rss_cap_switch(struct sxe_hw *hw, bool is_on)
 {
 	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
 	u32 mrqe_val;
-
 	mrqe_val = mrqc & SXE_MRQC_MRQE_MASK;
 	if (is_on) {
 		mrqe_val = SXE_MRQC_RSSEN;
diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index f87cce67a5..7ecb31f466 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 
 #include "sxe_types.h"
diff --git a/drivers/net/sxe/base/sxe_queue_common.c b/drivers/net/sxe/base/sxe_queue_common.c
index 914718769f..e31ebd005a 100644
--- a/drivers/net/sxe/base/sxe_queue_common.c
+++ b/drivers/net/sxe/base/sxe_queue_common.c
@@ -4,7 +4,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
-#include "sxe_dpdk_version.h"
 #include "sxe_compat_version.h"
 #include <ethdev_driver.h>
 #include <bus_pci_driver.h>
@@ -294,6 +293,7 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
 	q_info->mp = rxq->mb_pool;
 	q_info->mbuf_ring_size = rxq->ring_depth;
 	q_info->receive_tail = &rxq->processing_idx;
+
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 	if (adapter->rx_vec_allowed) {
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
@@ -308,6 +308,7 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
 	q_info->refill_requirement = rxq->batch_alloc_size;
 	q_info->refill_head = &rxq->batch_alloc_trigger;
 #endif
+
 	return;
 }
 
diff --git a/drivers/net/sxe/base/sxe_rx_common.c b/drivers/net/sxe/base/sxe_rx_common.c
index e3fee580df..5e46ff76f3 100644
--- a/drivers/net/sxe/base/sxe_rx_common.c
+++ b/drivers/net/sxe/base/sxe_rx_common.c
@@ -5,7 +5,6 @@
 #include <rte_memory.h>
 #include <rte_memzone.h>
 #include <rte_mbuf.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <rte_prefetch.h>
 #include <rte_malloc.h>
@@ -80,8 +79,6 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 	u16  i, is_using_sse;
 
 	if (sxe_rx_vec_condition_check(dev) ||
-		!rx_batch_alloc_allowed ||
-		rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_128
 		!rx_batch_alloc_allowed
 		) {
 		PMD_LOG_DEBUG(INIT, "Port[%d] doesn't meet Vector Rx "
@@ -111,6 +108,7 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 			dev->recycle_rx_descriptors_refill = sxe_recycle_rx_descriptors_refill_vec;
+
 #endif
 			dev->rx_pkt_burst = sxe_scattered_pkts_vec_recv;
 
@@ -138,12 +136,13 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 			dev->rx_pkt_burst = sxe_single_alloc_lro_pkts_recv;
 		}
 	}
-#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 	else if (*rx_vec_allowed) {
 		PMD_LOG_DEBUG(INIT, "Vector rx enabled, please make sure RX "
 					"burst size no less than %d (port=%d).",
 				 SXE_DESCS_PER_LOOP,
 				 dev->data->port_id);
+
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		dev->recycle_rx_descriptors_refill = sxe_recycle_rx_descriptors_refill_vec;
 
@@ -166,6 +165,7 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 
 		dev->rx_pkt_burst = sxe_pkts_recv;
 	}
+
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 	is_using_sse =
 		(dev->rx_pkt_burst == sxe_scattered_pkts_vec_recv ||
@@ -177,6 +177,7 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 		rxq->is_using_sse = is_using_sse;
 	}
 #endif
+
 }
 
 s32 __sxe_rx_descriptor_status(void *rx_queue, u16 offset)
@@ -340,6 +341,7 @@ const u32 *__sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of
 		ptypes = ptypes_arr;
 		goto l_end;
 	}
+
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 #if defined(RTE_ARCH_X86)
 	if (dev->rx_pkt_burst == sxe_pkts_vec_recv ||
diff --git a/drivers/net/sxe/base/sxe_rx_common.h b/drivers/net/sxe/base/sxe_rx_common.h
index f9afb517d9..d1bf172c89 100644
--- a/drivers/net/sxe/base/sxe_rx_common.h
+++ b/drivers/net/sxe/base/sxe_rx_common.h
@@ -5,8 +5,6 @@
 #ifndef __SXE_RX_COMMON_H__
 #define __SXE_RX_COMMON_H__
 
-#include "sxe_dpdk_version.h"
-
 void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 	bool rx_batch_alloc_allowed, bool *rx_vec_allowed);
 
diff --git a/drivers/net/sxe/base/sxe_tx_common.c b/drivers/net/sxe/base/sxe_tx_common.c
index e4cf514547..5f8a951bbd 100644
--- a/drivers/net/sxe/base/sxe_tx_common.c
+++ b/drivers/net/sxe/base/sxe_tx_common.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <rte_net.h>
diff --git a/drivers/net/sxe/base/sxevf_hw.c b/drivers/net/sxe/base/sxevf_hw.c
index 7425bafedb..914860e912 100644
--- a/drivers/net/sxe/base/sxevf_hw.c
+++ b/drivers/net/sxe/base/sxevf_hw.c
@@ -15,7 +15,6 @@
 #else
 #include "sxe_errno.h"
 #include "sxe_logs.h"
-#include "sxe_dpdk_version.h"
 #include "sxe_compat_version.h"
 #include "sxevf.h"
 #include "sxevf_hw.h"
diff --git a/drivers/net/sxe/include/sxe/sxe_cli.h b/drivers/net/sxe/include/sxe/sxe_cli.h
index 623347dab2..8ffb14f68b 100644
--- a/drivers/net/sxe/include/sxe/sxe_cli.h
+++ b/drivers/net/sxe/include/sxe/sxe_cli.h
@@ -9,7 +9,7 @@
 #include "sxe_drv_type.h"
 #endif
 
-#define SXE_VERSION_LEN				  (32)
+#define SXE_VERION_LEN				  (32)
 #define SXE_MAC_NUM					 (128)
 #define SXE_PORT_TRANSCEIVER_LEN		(32)
 #define SXE_PORT_VENDOR_LEN			 (32)
@@ -47,8 +47,8 @@ typedef enum port_link_speed {
 } port_link_speed_e;
 
 typedef struct sys_soc_info {
-	S8	 fw_ver[SXE_VERSION_LEN];
-	S8	 opt_ver[SXE_VERSION_LEN];
+	S8	 fw_ver[SXE_VERION_LEN];
+	S8	 opt_ver[SXE_VERION_LEN];
 	U8	 soc_status;
 	U8	 pad[3];
 	S32	soc_temp;
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index a3b874b7e2..a3cb935fc0 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -12,34 +12,34 @@ cflags += ['-DSXE_DPDK_SIMD']
 deps += ['hash']
 sources = files(
     'pf/sxe_main.c',
-	'pf/sxe_filter.c',
+    'pf/sxe_filter.c',
     'pf/sxe_flow_ctrl.c',
     'pf/sxe_irq.c',
     'pf/sxe_ethdev.c',
-	'pf/sxe_offload.c',
-	'pf/sxe_queue.c',
-	'pf/sxe_rx.c',
-	'pf/sxe_tx.c',
-	'pf/sxe_stats.c',
-	'pf/sxe_pmd_hdc.c',
+    'pf/sxe_offload.c',
+    'pf/sxe_queue.c',
+    'pf/sxe_rx.c',
+    'pf/sxe_tx.c',
+    'pf/sxe_stats.c',
+    'pf/sxe_pmd_hdc.c',
     'pf/sxe_phy.c',
     'pf/sxe_ptp.c',
     'pf/sxe_vf.c',
     'pf/sxe_dcb.c',
     'vf/sxevf_main.c',
-	'vf/sxevf_filter.c',
-	'vf/sxevf_irq.c',
-	'vf/sxevf_msg.c',
-	'vf/sxevf_ethdev.c',
-	'vf/sxevf_stats.c',
-	'vf/sxevf_rx.c',
-	'vf/sxevf_tx.c',
-	'vf/sxevf_queue.c',
-	'vf/sxevf_offload.c',
+    'vf/sxevf_filter.c',
+    'vf/sxevf_irq.c',
+    'vf/sxevf_msg.c',
+    'vf/sxevf_ethdev.c',
+    'vf/sxevf_stats.c',
+    'vf/sxevf_rx.c',
+    'vf/sxevf_tx.c',
+    'vf/sxevf_queue.c',
+    'vf/sxevf_offload.c',
     'base/sxe_queue_common.c',
-	'base/sxe_rx_common.c',
-	'base/sxe_tx_common.c',
-	'base/sxe_offload_common.c',
+    'base/sxe_rx_common.c',
+    'base/sxe_tx_common.c',
+    'base/sxe_offload_common.c',
     'base/sxe_common.c',
     'base/sxe_hw.c',
     'base/sxevf_hw.c',
@@ -48,9 +48,9 @@ sources = files(
 testpmd_sources = files('sxe_testpmd.c')
 
 if arch_subdir == 'x86'
-	sources += files('pf/sxe_vec_sse.c')
+    sources += files('pf/sxe_vec_sse.c')
 elif arch_subdir == 'arm'
-	sources += files('pf/sxe_vec_neon.c')
+    sources += files('pf/sxe_vec_neon.c')
 endif
 
 includes += include_directories('base')
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 212929cf04..73c9ad55a1 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -6,14 +6,14 @@
 
 #include <rte_pci.h>
 #include <rte_time.h>
-#include "sxe_filter.h"
 #include <stdbool.h>
 #include "sxe_types.h"
-#include "sxe_stats.h"
+#include "sxe_filter.h"
 #include "sxe_irq.h"
+#include "sxe_stats.h"
+#include "sxe_phy.h"
 #include "sxe_vf.h"
 #include "sxe_dcb.h"
-#include "sxe_phy.h"
 #include "sxe_hw.h"
 
 struct sxe_hw;
@@ -25,6 +25,8 @@ struct sxe_vlan_context;
 #define PCI_VENDOR_ID_STARS	  0x1FF2
 #define SXE_DEV_ID_ASIC		  0x10a1
 
+#define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
+
 #ifdef RTE_PMD_PACKET_PREFETCH
 #define rte_packet_prefetch(p)  rte_prefetch1(p)
 #else
@@ -73,13 +75,12 @@ struct sxe_adapter {
 	s8 name[PCI_PRI_STR_SIZE + 1];
 
 	u32 mtu;
+
 	bool rss_reta_updated;
+
 	RTE_ATOMIC(bool) link_thread_running;
 	RTE_ATOMIC(bool) is_stopping;
 	rte_thread_t link_thread_tid;
-	rte_atomic32_t link_thread_running;
-	rte_atomic32_t is_stopping;
-	pthread_t link_thread_tid;
 	bool is_stopped;
 };
 
diff --git a/drivers/net/sxe/pf/sxe_dcb.c b/drivers/net/sxe/pf/sxe_dcb.c
index 7decd70e07..78fc2d4cc9 100644
--- a/drivers/net/sxe/pf/sxe_dcb.c
+++ b/drivers/net/sxe/pf/sxe_dcb.c
@@ -11,6 +11,7 @@
 #include "sxe_ethdev.h"
 #include "sxe_compat_version.h"
 #include "rte_pmd_sxe.h"
+#include <eal_export.h>
 
 #define DCB_RX_CONFIG  1
 #define DCB_TX_CONFIG  1
@@ -584,7 +585,7 @@ static void sxe_dcb_cee_pfc_parse(struct sxe_dcb_config *cfg,
 static s32 sxe_dcb_tc_stats_configure(struct sxe_hw *hw,
 					struct sxe_dcb_config *dcb_config)
 {
-	s32 ret;
+	s32 ret = 0;
 	u8 tc_count = 8;
 	bool vmdq_active = false;
 
@@ -862,8 +863,7 @@ void sxe_dcb_configure(struct rte_eth_dev *dev)
 }
 
 RTE_EXPORT_SYMBOL(rte_pmd_sxe_tc_bw_set)
-s32
-rte_pmd_sxe_tc_bw_set(u8 port,
+s32 rte_pmd_sxe_tc_bw_set(u8 port,
 				u8 tc_num, u8 *bw_weight)
 {
 	struct sxe_adapter *adapter;
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index 0a5b04493d..fd39c4acff 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -8,7 +8,7 @@
 #include <rte_ethdev.h>
 #include <rte_pmd_sxe.h>
 #include <rte_alarm.h>
-
+#include <eal_export.h>
 #include "sxe_types.h"
 #include "sxe_logs.h"
 #include "sxe_compat_platform.h"
@@ -923,8 +923,7 @@ static s32 sxe_dev_reset(struct rte_eth_dev *eth_dev)
 }
 
 RTE_EXPORT_SYMBOL(rte_pmd_sxe_tx_loopback_set)
-s32
-rte_pmd_sxe_tx_loopback_set(u16 port, u8 on)
+s32 rte_pmd_sxe_tx_loopback_set(u16 port, u8 on)
 {
 	struct rte_eth_dev *dev;
 	struct sxe_adapter *adapter;
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index 55c534d692..8d09d8596f 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/sxe/pf/sxe_filter.h b/drivers/net/sxe/pf/sxe_filter.h
index de6170a3f4..7b9026fcfb 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -6,7 +6,6 @@
 #define __SXE_FILTER_H__
 
 #include <rte_ether.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include "sxe_types.h"
 #include "sxe_hw.h"
diff --git a/drivers/net/sxe/pf/sxe_irq.h b/drivers/net/sxe/pf/sxe_irq.h
index b2c5692932..eba70f5361 100644
--- a/drivers/net/sxe/pf/sxe_irq.h
+++ b/drivers/net/sxe/pf/sxe_irq.h
@@ -4,8 +4,6 @@
 
 #ifndef __SXE_IRQ_H__
 #define __SXE_IRQ_H__
-
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 
 #include "sxe_compat_platform.h"
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 49f9dd2f27..6c0891dbde 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -8,7 +8,6 @@
 #include <rte_pci.h>
 
 #include "sxe_version.h"
-#include "sxe_dpdk_version.h"
 #include <bus_pci_driver.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
@@ -245,24 +244,10 @@ RTE_LOG_REGISTER_SUFFIX(sxe_log_rx, pmd.net.sxe.rx, DEBUG);
 RTE_LOG_REGISTER_SUFFIX(sxe_log_tx, pmd.net.sxe.tx, DEBUG);
 RTE_LOG_REGISTER_SUFFIX(sxe_log_hw, pmd.net.sxe.tx_hw, DEBUG);
 #else
-#ifdef DPDK_19_11_6
-s32 sxe_log_init;
-s32 sxe_log_drv;
-RTE_INIT(sxe_init_log)
-{
-	sxe_log_init = rte_log_register("pmd.net.sxe.init");
-	if (sxe_log_init >= 0)
-		rte_log_set_level(sxe_log_init, RTE_LOG_NOTICE);
 
-	sxe_log_drv = rte_log_register("pmd.net.sxe.drv");
-	if (sxe_log_drv >= 0)
-		rte_log_set_level(sxe_log_drv, RTE_LOG_NOTICE);
-}
-#else
 RTE_LOG_REGISTER_SUFFIX(sxe_log_init, pmd.net.sxe.init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(sxe_log_drv, pmd.net.sxe.drv, NOTICE);
 #endif
-#endif
 
 int sxe_eth_dev_callback_process(struct rte_eth_dev *dev,
 	enum rte_eth_event_type event, void *ret_param)
diff --git a/drivers/net/sxe/pf/sxe_offload.c b/drivers/net/sxe/pf/sxe_offload.c
index 4b49cba707..d34cf7ecc8 100644
--- a/drivers/net/sxe/pf/sxe_offload.c
+++ b/drivers/net/sxe/pf/sxe_offload.c
@@ -2,7 +2,6 @@
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
 #include <ethdev_driver.h>
-
 #include "sxe.h"
 #include "sxe_offload.h"
 #include "sxe_logs.h"
diff --git a/drivers/net/sxe/pf/sxe_phy.c b/drivers/net/sxe/pf/sxe_phy.c
index 787b16fb47..afc885545e 100644
--- a/drivers/net/sxe/pf/sxe_phy.c
+++ b/drivers/net/sxe/pf/sxe_phy.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <dev_driver.h>
 #include <rte_cycles.h>
@@ -69,7 +68,8 @@ void sxe_wait_setup_link_complete(struct rte_eth_dev *dev,
 	struct sxe_adapter *adapter = dev->data->dev_private;
 	uint32_t timeout = timeout_ms ? timeout_ms : SXE_WARNING_TIMEOUT;
 
-	while (rte_atomic_load_explicit(&adapter->link_thread_running, rte_memory_order_seq_cst)) {
+	while (rte_atomic_load_explicit(&adapter->link_thread_running,
+		rte_memory_order_seq_cst)) {
 		rte_delay_us_sleep(1000);
 		timeout--;
 
diff --git a/drivers/net/sxe/pf/sxe_pmd_hdc.c b/drivers/net/sxe/pf/sxe_pmd_hdc.c
index 21f751ed26..61dcb6a6c1 100644
--- a/drivers/net/sxe/pf/sxe_pmd_hdc.c
+++ b/drivers/net/sxe/pf/sxe_pmd_hdc.c
@@ -3,7 +3,6 @@
  */
 
 #include <rte_malloc.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include "sxe_compat_version.h"
 #include <semaphore.h>
diff --git a/drivers/net/sxe/pf/sxe_queue.c b/drivers/net/sxe/pf/sxe_queue.c
index 9411da8ff8..75287defda 100644
--- a/drivers/net/sxe/pf/sxe_queue.c
+++ b/drivers/net/sxe/pf/sxe_queue.c
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <dev_driver.h>
 #include "sxe_ethdev.h"
-
 #include "rte_malloc.h"
 #include "sxe.h"
 #include "sxe_hw.h"
diff --git a/drivers/net/sxe/pf/sxe_queue.h b/drivers/net/sxe/pf/sxe_queue.h
index e67baf6135..027aea0755 100644
--- a/drivers/net/sxe/pf/sxe_queue.h
+++ b/drivers/net/sxe/pf/sxe_queue.h
@@ -3,8 +3,6 @@
  */
 #ifndef __SXE_QUEUE_H__
 #define __SXE_QUEUE_H__
-
-#include "sxe_dpdk_version.h"
 #include "sxe_queue_common.h"
 
 #define SXE_TXRX_RING_NUM_MAX	 64
diff --git a/drivers/net/sxe/pf/sxe_rx.c b/drivers/net/sxe/pf/sxe_rx.c
index 65cfcca4c9..9a7a5e71ad 100644
--- a/drivers/net/sxe/pf/sxe_rx.c
+++ b/drivers/net/sxe/pf/sxe_rx.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-
 #include <rte_memory.h>
 #include <rte_memzone.h>
 #include <rte_mbuf.h>
@@ -113,7 +112,6 @@
 
 
 const alignas(RTE_CACHE_LINE_SIZE) u32 sxe_ptype_table[SXE_PACKET_TYPE_MAX] = {
-
 	[SXE_PACKET_TYPE_ETHER] = RTE_PTYPE_L2_ETHER,
 	[SXE_PACKET_TYPE_IPV4] = RTE_PTYPE_L2_ETHER |
 		RTE_PTYPE_L3_IPV4,
diff --git a/drivers/net/sxe/pf/sxe_stats.c b/drivers/net/sxe/pf/sxe_stats.c
index af3c0bf84c..34470eae64 100644
--- a/drivers/net/sxe/pf/sxe_stats.c
+++ b/drivers/net/sxe/pf/sxe_stats.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include "sxe_stats.h"
 #include "sxe.h"
 #include "sxe_logs.h"
@@ -221,7 +220,7 @@ s32 sxe_xstats_get(struct rte_eth_dev *eth_dev,
 	cnt = SXE_XSTAT_CNT;
 	PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt: %" SXE_PRIU64
 			"fc xstat field cnt: %" SXE_PRIU64, cnt,
-			SXE_XSTAT_MAC_CNT, SXE_XSTAT_FC_CNT);
+			(u64)SXE_XSTAT_MAC_CNT, (u64)SXE_XSTAT_FC_CNT);
 
 	if (usr_cnt < cnt) {
 		ret = cnt;
@@ -333,7 +332,7 @@ s32 sxe_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
 	if (usr_cnt < SXE_XSTAT_CNT) {
 		ret = -SXE_ERR_PARAM;
 		PMD_LOG_ERR(DRV, "max: %" SXE_PRIU64 " usr_cnt:%u invalid.(err:%d)",
-				SXE_XSTAT_CNT, usr_cnt, ret);
+				(u64)SXE_XSTAT_CNT, usr_cnt, ret);
 		goto l_out;
 	}
 
@@ -432,7 +431,11 @@ s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
 	s32 ret;
 	u32 size = SXE_XSTAT_CNT;
 	u32 i;
-	u64 value_all[size];
+	u64 *value_all = (u64 *)malloc(size * sizeof(u64));
+	if (value_all == NULL) {
+		perror("value_all malloc failed");
+		return -ENOMEM;
+	}
 
 	if (ids == NULL) {
 		ret = sxe_all_xstats_value_get(eth_dev, values, usr_cnt);
@@ -459,6 +462,9 @@ s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
 	ret = usr_cnt;
 
 l_out:
+	if (value_all != NULL)
+		free(value_all);
+
 	return ret;
 }
 
@@ -470,7 +476,12 @@ s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
 	s32 ret;
 	u32 i;
 	u32 size = SXE_XSTAT_CNT;
-	struct rte_eth_xstat_name xstat_names_all[size];
+	struct rte_eth_xstat_name *xstat_names_all =
+	(struct rte_eth_xstat_name *)malloc(size * sizeof(struct rte_eth_xstat_name));
+	if (xstat_names_all == NULL) {
+		perror("xstat_names_all malloc failed");
+		return -ENOMEM;
+	}
 
 	if (ids == NULL) {
 		ret = sxe_xstats_names_get(eth_dev, xstats_names, usr_cnt);
@@ -490,6 +501,9 @@ s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
 	ret = usr_cnt;
 
 l_out:
+	if (xstat_names_all != NULL)
+		free(xstat_names_all);
+
 	return ret;
 }
 
@@ -573,4 +587,3 @@ void sxe_queue_stats_map_reset(struct rte_eth_dev *eth_dev)
 		sxe_hw_rxq_stat_map_set(hw, reg_idx, 0);
 	}
 }
-
diff --git a/drivers/net/sxe/pf/sxe_stats.h b/drivers/net/sxe/pf/sxe_stats.h
index 78a13e7a0b..320a82a130 100644
--- a/drivers/net/sxe/pf/sxe_stats.h
+++ b/drivers/net/sxe/pf/sxe_stats.h
@@ -7,8 +7,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
-
-#include "sxe_dpdk_version.h"
 #include "sxe_hw.h"
 
 #define SXE_STATS_FIELD_NAME_SIZE  50
@@ -49,11 +47,11 @@ s32 sxe_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
 	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int size);
 
 s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
-					const ulong *ids,
-					ulong *values, u32 usr_cnt);
+					const u64 *ids,
+					u64 *values, u32 usr_cnt);
 
 s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
-	const ulong *ids,
+	const u64 *ids,
 	struct rte_eth_xstat_name *xstats_names,
 	u32 usr_cnt);
 
diff --git a/drivers/net/sxe/pf/sxe_tx.c b/drivers/net/sxe/pf/sxe_tx.c
index b50052e0db..46e65ebcf7 100644
--- a/drivers/net/sxe/pf/sxe_tx.c
+++ b/drivers/net/sxe/pf/sxe_tx.c
@@ -1,18 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
-#if defined DPDK_20_11_5 || defined DPDK_19_11_6
-#include <rte_ethdev_driver.h>
-#include <rte_ethdev_pci.h>
-#elif defined DPDK_21_11_5
-#include <ethdev_driver.h>
-#include <rte_dev.h>
-#else
 #include <ethdev_driver.h>
 #include <dev_driver.h>
-#endif
-
 #include <rte_net.h>
 
 #include "sxe.h"
@@ -43,17 +33,10 @@ void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
 		dev->tx_pkt_prepare = NULL;
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 		if (txq->rs_thresh <= RTE_SXE_MAX_TX_FREE_BUF_SZ &&
-#ifndef DPDK_19_11_6
-			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
-#endif
 			(rte_eal_process_type() != RTE_PROC_PRIMARY ||
 			sxe_txq_vec_setup(txq) == 0)) {
-#if defined DPDK_23_11_3 || defined DPDK_24_11_1
-#ifndef DPDK_23_7
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 			dev->recycle_tx_mbufs_reuse = sxe_recycle_tx_mbufs_reuse_vec;
-#endif
-#endif
 #endif
 			dev->tx_pkt_burst   = sxe_pkts_vector_xmit;
 			PMD_LOG_INFO(INIT, "using vector tx code path");
@@ -72,7 +55,7 @@ void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
 
 		PMD_LOG_INFO(INIT, "using full-featured tx code path");
 		PMD_LOG_INFO(INIT, " - offloads = 0x%" SXE_PRIX64,
-					(unsigned long)txq->offloads);
+							txq->offloads);
 		PMD_LOG_INFO(INIT, " - tx_rs_thresh = %d "
 				   "[RTE_PMD_SXE_MAX_TX_BURST=%d]",
 				txq->rs_thresh,
@@ -370,8 +353,6 @@ u16 sxe_pkts_simple_xmit(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num
 }
 
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
-#if defined DPDK_23_11_3 || defined DPDK_24_11_1
-#ifndef DPDK_23_7
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -438,8 +419,6 @@ u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	return nb_recycle_mbufs;
 }
 #endif
-#endif
-#endif
 
 u16 sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
 			   u16 pkts_num)
diff --git a/drivers/net/sxe/pf/sxe_vec_common.h b/drivers/net/sxe/pf/sxe_vec_common.h
index 85605507f5..90ace4c324 100644
--- a/drivers/net/sxe/pf/sxe_vec_common.h
+++ b/drivers/net/sxe/pf/sxe_vec_common.h
@@ -11,6 +11,7 @@
 #include <dev_driver.h>
 #include <rte_malloc.h>
 #include "sxe.h"
+#include "sxe_queue.h"
 #include "sxe_rx.h"
 
 #define RTE_SXE_MAX_TX_FREE_BUF_SZ	64
@@ -77,7 +78,11 @@ static inline u16
 sxe_packets_reassemble(sxe_rx_queue_s *rxq, struct rte_mbuf **rx_bufs,
 			u16 bufs_num, u8 *split_flags)
 {
-	struct rte_mbuf *pkts[bufs_num];
+	struct rte_mbuf **pkts = (struct rte_mbuf **)malloc(bufs_num * sizeof(struct rte_mbuf *));
+	if (pkts == NULL) {
+		perror("pkts malloc failed");
+		exit(EXIT_FAILURE);
+	}
 	struct rte_mbuf *start = rxq->pkt_first_seg;
 	struct rte_mbuf *end = rxq->pkt_last_seg;
 	u32 pkt_idx, buf_idx;
@@ -129,6 +134,7 @@ sxe_packets_reassemble(sxe_rx_queue_s *rxq, struct rte_mbuf **rx_bufs,
 	rxq->pkt_last_seg = end;
 	memcpy(rx_bufs, pkts, pkt_idx * (sizeof(*pkts)));
 
+	free(pkts);
 	return pkt_idx;
 }
 
diff --git a/drivers/net/sxe/pf/sxe_vec_neon.c b/drivers/net/sxe/pf/sxe_vec_neon.c
index 9012750c98..30d878ea39 100644
--- a/drivers/net/sxe/pf/sxe_vec_neon.c
+++ b/drivers/net/sxe/pf/sxe_vec_neon.c
@@ -1,10 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 #include <stdint.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 
diff --git a/drivers/net/sxe/pf/sxe_vec_sse.c b/drivers/net/sxe/pf/sxe_vec_sse.c
index 8786af75f8..d54542f4a8 100644
--- a/drivers/net/sxe/pf/sxe_vec_sse.c
+++ b/drivers/net/sxe/pf/sxe_vec_sse.c
@@ -4,7 +4,6 @@
 
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 #include <stdint.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_vect.h>
diff --git a/drivers/net/sxe/pf/sxe_vf.c b/drivers/net/sxe/pf/sxe_vf.c
index d75ec913f3..ec713843d9 100644
--- a/drivers/net/sxe/pf/sxe_vf.c
+++ b/drivers/net/sxe/pf/sxe_vf.c
@@ -6,11 +6,9 @@
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_memcpy.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
-
 #include "sxe_logs.h"
 #include "sxe_vf.h"
 #include "sxe_hw.h"
diff --git a/drivers/net/sxe/pf/sxe_vf.h b/drivers/net/sxe/pf/sxe_vf.h
index 05b91540cc..112d98df39 100644
--- a/drivers/net/sxe/pf/sxe_vf.h
+++ b/drivers/net/sxe/pf/sxe_vf.h
@@ -5,7 +5,6 @@
 #ifndef __SXE_VF_H__
 #define __SXE_VF_H__
 
-#include "sxe_dpdk_version.h"
 #include <rte_ethdev.h>
 #include <bus_pci_driver.h>
 
diff --git a/drivers/net/sxe/sxe_drv_type.h b/drivers/net/sxe/sxe_drv_type.h
index 1ccf0b3f87..c67f417d5f 100644
--- a/drivers/net/sxe/sxe_drv_type.h
+++ b/drivers/net/sxe/sxe_drv_type.h
@@ -6,9 +6,6 @@
 #define __SXE_DRV_TYPEDEF_H__
 
 #include "sxe_types.h"
-#ifndef bool
-#define bool _Bool
-#endif
 
 typedef u8 U8;
 typedef u16 U16;
diff --git a/drivers/net/sxe/sxe_testpmd.c b/drivers/net/sxe/sxe_testpmd.c
index b533ae939b..6deb502124 100644
--- a/drivers/net/sxe/sxe_testpmd.c
+++ b/drivers/net/sxe/sxe_testpmd.c
@@ -2,9 +2,9 @@
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
 #include <ethdev_driver.h>
-#include "sxe_ethdev.h"
+#include "sxe_drv_type.h"
 #include "rte_pmd_sxe.h"
-
+#include "sxe_ethdev.h"
 #include <cmdline_parse_etheraddr.h>
 #include <cmdline_parse_num.h>
 #include <cmdline_parse_string.h>
diff --git a/drivers/net/sxe/vf/sxevf_ethdev.c b/drivers/net/sxe/vf/sxevf_ethdev.c
index 1466465fe1..9bcdd11c6f 100644
--- a/drivers/net/sxe/vf/sxevf_ethdev.c
+++ b/drivers/net/sxe/vf/sxevf_ethdev.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include "sxe_dpdk_version.h"
+
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
@@ -252,6 +252,7 @@ static void sxevf_txrx_start(struct rte_eth_dev *eth_dev)
 		txq = eth_dev->data->tx_queues[i];
 		sxevf_tx_ring_switch(hw, txq->reg_idx, true);
 		eth_dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	}
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
@@ -332,7 +333,6 @@ static s32 sxevf_dev_stop(struct rte_eth_dev *dev)
 	sxevf_irq_free(dev);
 
 l_out:
-
 	return 0;
 }
 
@@ -362,7 +362,6 @@ static s32 sxevf_dev_close(struct rte_eth_dev *dev)
 	sxevf_irq_unregister(dev);
 
 l_out:
-
 	return ret;
 }
 
@@ -470,7 +469,6 @@ static s32 sxevf_mtu_set(struct rte_eth_dev *dev, u16 mtu)
 		goto l_out;
 	}
 
-	dev->data->dev_conf.rxmode.max_rx_pkt_len = max_frame;
 	LOG_INFO_BDF("change max frame size to %u success.", max_frame);
 
 l_out:
diff --git a/drivers/net/sxe/vf/sxevf_filter.h b/drivers/net/sxe/vf/sxevf_filter.h
index d468be12cc..6fa51e3af1 100644
--- a/drivers/net/sxe/vf/sxevf_filter.h
+++ b/drivers/net/sxe/vf/sxevf_filter.h
@@ -6,9 +6,7 @@
 #define __SXEVF_FILTER_H__
 
 #include <rte_ether.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
-#endif
 
 #define SXEVF_MTA_ENTRY_NUM_MAX		128
 #define SXEVF_UTA_HASH_BIT_MAX		 4096
@@ -68,3 +66,5 @@ s32 sxevf_mac_addr_add(struct rte_eth_dev *dev,
 s32 sxevf_set_mc_addr_list(struct rte_eth_dev *dev,
 			  struct rte_ether_addr *mc_addr_list,
 			  u32 nb_mc_addr);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_irq.c b/drivers/net/sxe/vf/sxevf_irq.c
index bf768a67f6..3263f56313 100644
--- a/drivers/net/sxe/vf/sxevf_irq.c
+++ b/drivers/net/sxe/vf/sxevf_irq.c
@@ -9,10 +9,8 @@
 #include <rte_alarm.h>
 #include <rte_interrupts.h>
 #include <rte_malloc.h>
-#include "sxe_dpdk_version.h"
 #include <bus_pci_driver.h>
 #include <eal_interrupts.h>
-
 #include "sxevf.h"
 #include "sxe_logs.h"
 #include "sxe_errno.h"
diff --git a/drivers/net/sxe/vf/sxevf_irq.h b/drivers/net/sxe/vf/sxevf_irq.h
index def1167af7..2f9860ba15 100644
--- a/drivers/net/sxe/vf/sxevf_irq.h
+++ b/drivers/net/sxe/vf/sxevf_irq.h
@@ -5,7 +5,6 @@
 #ifndef __SXEVF_IRQ_H__
 #define __SXEVF_IRQ_H__
 
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include "sxe_compat_platform.h"
 
diff --git a/drivers/net/sxe/vf/sxevf_main.c b/drivers/net/sxe/vf/sxevf_main.c
index d418705cf8..b1924c1475 100644
--- a/drivers/net/sxe/vf/sxevf_main.c
+++ b/drivers/net/sxe/vf/sxevf_main.c
@@ -12,7 +12,6 @@
 #include <rte_dev.h>
 
 #include "sxe_version.h"
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
diff --git a/drivers/net/sxe/vf/sxevf_msg.c b/drivers/net/sxe/vf/sxevf_msg.c
index faf6787e74..37d3f2c5dc 100644
--- a/drivers/net/sxe/vf/sxevf_msg.c
+++ b/drivers/net/sxe/vf/sxevf_msg.c
@@ -101,7 +101,7 @@ static s32 sxevf_mailbox_lock(struct sxevf_hw *hw)
 		mailbox |= SXE_VFMAILBOX_VFU;
 		sxevf_mailbox_write(hw, mailbox);
 
-		if (sxevf_mbx_reg_read(hw) && SXE_VFMAILBOX_VFU) {
+		if (sxevf_mbx_reg_read(hw) & SXE_VFMAILBOX_VFU) {
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/sxe/vf/sxevf_offload.c b/drivers/net/sxe/vf/sxevf_offload.c
index 4b0eacf7f0..b39245aa11 100644
--- a/drivers/net/sxe/vf/sxevf_offload.c
+++ b/drivers/net/sxe/vf/sxevf_offload.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 
 #include "sxe_types.h"
diff --git a/drivers/net/sxe/vf/sxevf_queue.c b/drivers/net/sxe/vf/sxevf_queue.c
index 4461d13369..69ef1f6676 100644
--- a/drivers/net/sxe/vf/sxevf_queue.c
+++ b/drivers/net/sxe/vf/sxevf_queue.c
@@ -7,8 +7,6 @@
 #include <rte_byteorder.h>
 #include <rte_mbuf_core.h>
 #include <rte_ethdev.h>
-
-#include "sxe_dpdk_version.h"
 #include "sxevf_rx.h"
 #include "sxevf_tx.h"
 #include "sxe_logs.h"
diff --git a/drivers/net/sxe/vf/sxevf_queue.h b/drivers/net/sxe/vf/sxevf_queue.h
index 9407e941fb..01e2ec216c 100644
--- a/drivers/net/sxe/vf/sxevf_queue.h
+++ b/drivers/net/sxe/vf/sxevf_queue.h
@@ -5,7 +5,6 @@
 #ifndef __SXEVF_QUEUEU_H__
 #define __SXEVF_QUEUEU_H__
 
-#include "sxe_dpdk_version.h"
 #include "sxe_types.h"
 #include "sxe_queue_common.h"
 
diff --git a/drivers/net/sxe/vf/sxevf_rx.c b/drivers/net/sxe/vf/sxevf_rx.c
index aee63d025d..81aab3f315 100644
--- a/drivers/net/sxe/vf/sxevf_rx.c
+++ b/drivers/net/sxe/vf/sxevf_rx.c
@@ -5,7 +5,6 @@
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
 
 #include <rte_common.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 
 #include "sxe_logs.h"
diff --git a/drivers/net/sxe/vf/sxevf_stats.c b/drivers/net/sxe/vf/sxevf_stats.c
index 21407dac42..30ce9753dd 100644
--- a/drivers/net/sxe/vf/sxevf_stats.c
+++ b/drivers/net/sxe/vf/sxevf_stats.c
@@ -97,7 +97,7 @@ s32 sxevf_xstats_get(struct rte_eth_dev *eth_dev,
 	cnt = SXE_HW_XSTATS_CNT;
 	PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt:%" SXE_PRIU64,
 			cnt,
-			SXE_HW_XSTATS_CNT);
+			(u64)SXE_HW_XSTATS_CNT);
 
 	if (usr_cnt < cnt) {
 		ret = cnt;
@@ -118,7 +118,7 @@ s32 sxevf_xstats_get(struct rte_eth_dev *eth_dev,
 	cnt = 0;
 	for (i = 0; i < SXE_HW_XSTATS_CNT; i++) {
 		sxevf_hw_xstat_offset_get(i, &offset);
-		xstats[cnt].value = *(ulong *)(((s8 *)(&stats_info->hw_stats)) + offset);
+		xstats[cnt].value = *(u_long *)(((s8 *)(&stats_info->hw_stats)) + offset);
 		xstats[cnt].id = cnt;
 		cnt++;
 	}
-- 
2.18.4

