Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59994C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 12:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CA5A40A7D;
	Mon,  7 Jul 2025 13:59:08 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2EA594065F
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:59:05 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowAAXBqpetmtosYbMAQ--.21604S15;
 Mon, 07 Jul 2025 19:59:04 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 14/14] net/sxe: add Solve compilation problems.
Date: Mon,  7 Jul 2025 07:58:19 -0400
Message-ID: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707115819.12826-1-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXBqpetmtosYbMAQ--.21604S15
X-Coremail-Antispam: 1UD129KBjvAXoWfWF4rKry3AF4rJFyfZw13Arb_yoW5Aw18Go
 WxtF13AFy5Zrn7J39FgF1kWFW3Xr92grW5Jw45uFZI9Fy3Cr15Ar1Fq343JFnrXw1rta4U
 Za1xZF1jvr47WFWxn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOf7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
 6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
 1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
 Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUeOJOUUUUU=
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
 drivers/net/sxe/base/sxe_compat_version.h |  1 -
 drivers/net/sxe/base/sxe_hw.c             | 21 ++++++++++++++-------
 drivers/net/sxe/base/sxe_offload_common.c |  1 -
 drivers/net/sxe/base/sxe_queue_common.c   |  3 ++-
 drivers/net/sxe/base/sxe_rx_common.c      | 10 ++++++----
 drivers/net/sxe/base/sxe_rx_common.h      |  2 --
 drivers/net/sxe/base/sxe_tx_common.c      |  1 -
 drivers/net/sxe/base/sxevf_hw.c           |  1 -
 drivers/net/sxe/pf/sxe.h                  | 11 +++++------
 drivers/net/sxe/pf/sxe_filter.c           |  1 -
 drivers/net/sxe/pf/sxe_filter.h           |  1 -
 drivers/net/sxe/pf/sxe_irq.h              |  2 --
 drivers/net/sxe/pf/sxe_main.c             | 15 ---------------
 drivers/net/sxe/pf/sxe_offload.c          |  2 --
 drivers/net/sxe/pf/sxe_phy.c              |  9 +++++----
 drivers/net/sxe/pf/sxe_pmd_hdc.c          |  1 -
 drivers/net/sxe/pf/sxe_queue.c            |  2 --
 drivers/net/sxe/pf/sxe_queue.h            |  2 --
 drivers/net/sxe/pf/sxe_rx.c               |  1 -
 drivers/net/sxe/pf/sxe_stats.c            | 21 +++++++++++++++++----
 drivers/net/sxe/pf/sxe_stats.h            |  2 --
 drivers/net/sxe/pf/sxe_tx.c               | 20 --------------------
 drivers/net/sxe/pf/sxe_vec_common.h       |  7 ++++++-
 drivers/net/sxe/pf/sxe_vec_neon.c         |  2 --
 drivers/net/sxe/pf/sxe_vec_sse.c          |  1 -
 drivers/net/sxe/pf/sxe_vf.c               |  1 -
 drivers/net/sxe/pf/sxe_vf.h               |  1 -
 drivers/net/sxe/sxe_drv_type.h            |  4 ----
 drivers/net/sxe/sxe_testpmd.c             |  3 ++-
 drivers/net/sxe/vf/sxevf_ethdev.c         |  6 ++----
 drivers/net/sxe/vf/sxevf_filter.h         |  4 ++--
 drivers/net/sxe/vf/sxevf_irq.c            |  2 --
 drivers/net/sxe/vf/sxevf_irq.h            |  1 -
 drivers/net/sxe/vf/sxevf_main.c           |  1 -
 drivers/net/sxe/vf/sxevf_offload.c        |  1 -
 drivers/net/sxe/vf/sxevf_queue.c          |  2 --
 drivers/net/sxe/vf/sxevf_queue.h          |  1 -
 drivers/net/sxe/vf/sxevf_rx.c             |  1 -
 38 files changed, 61 insertions(+), 107 deletions(-)

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
index 4ccab2ad54..392fc8ac23 100644
--- a/drivers/net/sxe/base/sxe_hw.c
+++ b/drivers/net/sxe/base/sxe_hw.c
@@ -3,6 +3,7 @@
  */
 #ifdef SXE_PHY_CONFIGURE
 #include <linux/mdio.h>
+#include <rte_compat.h>
 #endif
 #if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
 #include "sxe_pci.h"
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
index 4456dbdc2d..2b46a15c8d 100644
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
index 6cdc248ede..d41f6506b3 100644
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
index ff6e97826d..58bf82b6cd 100644
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
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index abba0bd6fa..eaf66a3acb 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -6,14 +6,16 @@
 
 #include <rte_pci.h>
 #include <rte_time.h>
-#include "sxe_filter.h"
+
 #include <stdbool.h>
+
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
@@ -81,9 +83,6 @@ struct sxe_adapter {
 	RTE_ATOMIC(bool)link_thread_running;
 	RTE_ATOMIC(bool)is_stopping;
 	rte_thread_t link_thread_tid;
-	rte_atomic32_t link_thread_running;
-	rte_atomic32_t is_stopping;
-	pthread_t link_thread_tid;
 	bool is_stopped;
 };
 
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index ae4987aafa..01d1acd91b 100644
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
index e56baaf962..b0c6986a7e 100644
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
index 888c4a6276..d34cf7ecc8 100644
--- a/drivers/net/sxe/pf/sxe_offload.c
+++ b/drivers/net/sxe/pf/sxe_offload.c
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
-
 #include "sxe.h"
 #include "sxe_offload.h"
 #include "sxe_logs.h"
diff --git a/drivers/net/sxe/pf/sxe_phy.c b/drivers/net/sxe/pf/sxe_phy.c
index 873f15b69a..ae656d7d58 100644
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
@@ -58,7 +57,7 @@ static uint32_t sxe_setup_link_thread_handler(void *param)
 		PMD_LOG_ERR(INIT, "link setup failed, ret=%d", ret);
 
 	irq->action &= ~SXE_IRQ_LINK_CONFIG;
-	rte_atomic_store_explicit(&adapter->link_thread_running, 0, rte_memory_order_seq_cst);
+	rte_atomic_store_explicit(&(adapter->link_thread_running), 0, rte_memory_order_seq_cst);
 
 	return 0;
 }
@@ -69,7 +68,9 @@ void sxe_wait_setup_link_complete(struct rte_eth_dev *dev,
 	struct sxe_adapter *adapter = dev->data->dev_private;
 	uint32_t timeout = timeout_ms ? timeout_ms : SXE_WARNING_TIMEOUT;
 
-	while (rte_atomic_load_explicit(&adapter->link_thread_running, rte_memory_order_seq_cst)) {
+	while (rte_atomic_load_explicit(&(adapter->link_thread_running),
+		rte_memory_order_seq_cst)) {
+
 		rte_delay_us_sleep(1000);
 		timeout--;
 
@@ -150,7 +151,7 @@ s32 sxe_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 
 	if (!link_up) {
 		sxe_wait_setup_link_complete(dev, 0);
-		if (!rte_atomic_exchange_explicit(&adapter->link_thread_running, 1,
+		if (!rte_atomic_exchange_explicit(&(adapter->link_thread_running), 1,
 				rte_memory_order_seq_cst)) {
 			if (rte_atomic_load_explicit(&adapter->is_stopping,
 				rte_memory_order_seq_cst) ||
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
index deec467563..e6fa4a223d 100644
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
index 65cfcca4c9..b1c53a533a 100644
--- a/drivers/net/sxe/pf/sxe_rx.c
+++ b/drivers/net/sxe/pf/sxe_rx.c
@@ -113,7 +113,6 @@
 
 
 const alignas(RTE_CACHE_LINE_SIZE) u32 sxe_ptype_table[SXE_PACKET_TYPE_MAX] = {
-
 	[SXE_PACKET_TYPE_ETHER] = RTE_PTYPE_L2_ETHER,
 	[SXE_PACKET_TYPE_IPV4] = RTE_PTYPE_L2_ETHER |
 		RTE_PTYPE_L3_IPV4,
diff --git a/drivers/net/sxe/pf/sxe_stats.c b/drivers/net/sxe/pf/sxe_stats.c
index af3c0bf84c..1a3156b966 100644
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
index 78a13e7a0b..062b8dd592 100644
--- a/drivers/net/sxe/pf/sxe_stats.h
+++ b/drivers/net/sxe/pf/sxe_stats.h
@@ -7,8 +7,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
-
-#include "sxe_dpdk_version.h"
 #include "sxe_hw.h"
 
 #define SXE_STATS_FIELD_NAME_SIZE  50
diff --git a/drivers/net/sxe/pf/sxe_tx.c b/drivers/net/sxe/pf/sxe_tx.c
index b50052e0db..27f8b58742 100644
--- a/drivers/net/sxe/pf/sxe_tx.c
+++ b/drivers/net/sxe/pf/sxe_tx.c
@@ -1,17 +1,8 @@
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
 
 #include <rte_net.h>
 
@@ -43,17 +34,10 @@ void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
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
@@ -370,8 +354,6 @@ u16 sxe_pkts_simple_xmit(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num
 }
 
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
-#if defined DPDK_23_11_3 || defined DPDK_24_11_1
-#ifndef DPDK_23_7
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -438,8 +420,6 @@ u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	return nb_recycle_mbufs;
 }
 #endif
-#endif
-#endif
 
 u16 sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
 			   u16 pkts_num)
diff --git a/drivers/net/sxe/pf/sxe_vec_common.h b/drivers/net/sxe/pf/sxe_vec_common.h
index 85605507f5..3ba268f144 100644
--- a/drivers/net/sxe/pf/sxe_vec_common.h
+++ b/drivers/net/sxe/pf/sxe_vec_common.h
@@ -77,7 +77,11 @@ static inline u16
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
@@ -129,6 +133,7 @@ sxe_packets_reassemble(sxe_rx_queue_s *rxq, struct rte_mbuf **rx_bufs,
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
index f47a65279e..2e53087816 100644
--- a/drivers/net/sxe/pf/sxe_vf.c
+++ b/drivers/net/sxe/pf/sxe_vf.c
@@ -6,7 +6,6 @@
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_memcpy.h>
-#include "sxe_dpdk_version.h"
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
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
index 6261f2d320..1ccf0b3f87 100644
--- a/drivers/net/sxe/sxe_drv_type.h
+++ b/drivers/net/sxe/sxe_drv_type.h
@@ -5,14 +5,10 @@
 #ifndef __SXE_DRV_TYPEDEF_H__
 #define __SXE_DRV_TYPEDEF_H__
 
-#ifdef SXE_DPDK
 #include "sxe_types.h"
 #ifndef bool
 #define bool _Bool
 #endif
-#else
-#include <linux/types.h>
-#endif
 
 typedef u8 U8;
 typedef u16 U16;
diff --git a/drivers/net/sxe/sxe_testpmd.c b/drivers/net/sxe/sxe_testpmd.c
index b533ae939b..dea92e1647 100644
--- a/drivers/net/sxe/sxe_testpmd.c
+++ b/drivers/net/sxe/sxe_testpmd.c
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
+
 #include <ethdev_driver.h>
+#include "sxe_drv_type.h"
 #include "sxe_ethdev.h"
 #include "rte_pmd_sxe.h"
-
 #include <cmdline_parse_etheraddr.h>
 #include <cmdline_parse_num.h>
 #include <cmdline_parse_string.h>
diff --git a/drivers/net/sxe/vf/sxevf_ethdev.c b/drivers/net/sxe/vf/sxevf_ethdev.c
index 69740bfa6c..b1655e8642 100644
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
index f6af527cbe..defdf5ecc9 100644
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
@@ -70,3 +68,5 @@ s32 sxevf_mac_addr_add(struct rte_eth_dev *dev,
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
-- 
2.18.4

