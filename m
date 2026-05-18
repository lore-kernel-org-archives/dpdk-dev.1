Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E47CCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 09:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D4AC40696;
	Mon, 18 May 2026 11:14:26 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C8F46402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 11:14:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHVAhi2ApqIPmbEA--.3979S10;
 Mon, 18 May 2026 17:14:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v16 08/11] net/sxe2: support queue setup and control
Date: Mon, 18 May 2026 17:14:02 +0800
Message-ID: <20260518091405.3295896-9-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
References: <20260516074618.2343883-12-liujie5@linkdatatechnology.com>
 <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHVAhi2ApqIPmbEA--.3979S10
X-Coremail-Antispam: 1UD129KBjvAXoWftw18AF4fZF18JFy3tryrZwb_yoWrJw4UZo
 WSgr47XFn3Wr1xCrZ5Wr4xuFW7Zay8uw4DA3yfurn8ua15Gay7Ka47G34UXFyUKan5tF4k
 WFyIv34fKrW7J3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
 6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
 C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F2
 4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
 JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7V
 AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
 IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
X-Originating-IP: [118.112.177.181]
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add support for Rx and Tx queue setup, release, and management.
Implement eth_dev_ops callbacks for rx_queue_setup, tx_queue_setup,
rx_queue_release, and tx_queue_release.

This includes:
- Allocating memory for hardware ring descriptors.
- Initializing software ring structures and hardware head/tail pointers.
- Implementing proper resource cleanup logic to prevent memory leaks
  during queue reconfiguration or device close.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build   |   2 +
 drivers/net/sxe2/sxe2_ethdev.c |  82 +++--
 drivers/net/sxe2/sxe2_ethdev.h |  15 +-
 drivers/net/sxe2/sxe2_rx.c     | 559 +++++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_rx.h     |  34 ++
 drivers/net/sxe2/sxe2_tx.c     | 420 +++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_tx.h     |  32 ++
 7 files changed, 1118 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_rx.c
 create mode 100644 drivers/net/sxe2/sxe2_rx.h
 create mode 100644 drivers/net/sxe2/sxe2_tx.c
 create mode 100644 drivers/net/sxe2/sxe2_tx.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 00c38b147c..3dfe54903a 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -18,6 +18,8 @@ sources += files(
         'sxe2_cmd_chnl.c',
         'sxe2_vsi.c',
         'sxe2_queue.c',
+        'sxe2_tx.c',
+        'sxe2_rx.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 204add9c98..6abb4672f6 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -24,6 +24,8 @@
 #include "sxe2_ethdev.h"
 #include "sxe2_drv_cmd.h"
 #include "sxe2_cmd_chnl.h"
+#include "sxe2_tx.h"
+#include "sxe2_rx.h"
 #include "sxe2_common.h"
 #include "sxe2_common_log.h"
 #include "sxe2_host_regs.h"
@@ -86,14 +88,6 @@ static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static void __rte_cold sxe2_txqs_all_stop(struct rte_eth_dev *dev __rte_unused)
-{
-}
-
-static void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev __rte_unused)
-{
-}
-
 static int32_t sxe2_dev_stop(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
@@ -112,16 +106,6 @@ static int32_t sxe2_dev_stop(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static int32_t __rte_cold sxe2_txqs_all_start(struct rte_eth_dev *dev __rte_unused)
-{
-	return 0;
-}
-
-static int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev __rte_unused)
-{
-	return 0;
-}
-
 static int32_t sxe2_queues_start(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
@@ -307,10 +291,18 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_stop                   = sxe2_dev_stop,
 	.dev_close                  = sxe2_dev_close,
 	.dev_infos_get              = sxe2_dev_infos_get,
+
+	.rx_queue_setup             = sxe2_rx_queue_setup,
+	.tx_queue_setup             = sxe2_tx_queue_setup,
+	.rx_queue_release           = sxe2_rx_queue_release,
+	.tx_queue_release           = sxe2_tx_queue_release,
+
+	.rxq_info_get               = sxe2_rx_queue_info_get,
+	.txq_info_get               = sxe2_tx_queue_info_get,
 };
 
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
-		enum sxe2_pci_map_resource res_type)
+						    enum sxe2_pci_map_resource res_type)
 {
 	struct sxe2_pci_map_context *map_ctxt = &adapter->map_ctxt;
 	struct sxe2_pci_map_bar_info *bar_info = NULL;
@@ -334,6 +326,48 @@ struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter
 	return bar_info;
 }
 
+void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
+			     enum sxe2_pci_map_resource res_type,
+			     uint16_t idx_in_func)
+{
+	struct sxe2_pci_map_context *map_ctxt = &adapter->map_ctxt;
+	struct sxe2_pci_map_segment_info *seg_info = NULL;
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	void *addr = NULL;
+	uintptr_t calc_addr = 0;
+	uint8_t reg_width = 0;
+	uint8_t i = 0;
+
+	bar_info = sxe2_dev_get_bar_info(adapter, res_type);
+	if (bar_info == NULL) {
+		PMD_DEV_LOG_WARN(adapter, INIT, "Failed to get bar info, res_type=[%d]",
+				res_type);
+		goto l_end;
+	}
+	seg_info = bar_info->seg_info;
+
+	reg_width = map_ctxt->addr_info[res_type].reg_width;
+	if (reg_width == 0) {
+		PMD_DEV_LOG_WARN(adapter, INIT, "Invalid reg width with resource type %d",
+				 res_type);
+		goto l_end;
+	}
+
+	for (i = 0; i < bar_info->map_cnt; i++) {
+		seg_info = &bar_info->seg_info[i];
+		if (res_type == seg_info->type) {
+			calc_addr = (uintptr_t)seg_info->addr;
+			calc_addr += (uintptr_t)seg_info->page_inner_offset;
+			calc_addr += (uintptr_t)reg_width * (uintptr_t)idx_in_func;
+			addr = (void *)calc_addr;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return addr;
+}
+
 static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 			struct sxe2_drv_dev_caps_resp *dev_caps)
 {
@@ -402,7 +436,9 @@ static int32_t sxe2_dev_caps_get(struct sxe2_adapter *adapter)
 }
 
 int32_t sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
-		enum sxe2_pci_map_resource res_type, uint64_t org_len, uint64_t org_offset)
+			     enum sxe2_pci_map_resource res_type,
+			     uint64_t org_len,
+			     uint64_t org_offset)
 {
 	struct sxe2_pci_map_bar_info *bar_info = NULL;
 	struct sxe2_pci_map_segment_info *seg_info = NULL;
@@ -478,8 +514,10 @@ static int32_t sxe2_hw_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
-int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter, uint32_t res_type,
-				 uint32_t item_cnt, uint32_t item_base)
+int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter,
+				 uint32_t res_type,
+				 uint32_t item_cnt,
+				 uint32_t item_base)
 {
 	struct sxe2_pci_map_addr_info *addr_info = NULL;
 	int32_t ret = 0;
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 843e652616..001413e75a 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -293,14 +293,21 @@ struct sxe2_adapter {
 #define SXE2_DEV_TO_PCI(eth_dev) \
 		RTE_DEV_TO_PCI((eth_dev)->device)
 
+void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
+			    enum sxe2_pci_map_resource res_type,
+			    uint16_t idx_in_func);
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
-		enum sxe2_pci_map_resource res_type);
+						    enum sxe2_pci_map_resource res_type);
 
 int32_t sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
-		enum sxe2_pci_map_resource res_type, uint64_t org_len, uint64_t org_offset);
+			     enum sxe2_pci_map_resource res_type,
+			     uint64_t org_len, uint64_t org_offset);
 
-int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter, uint32_t res_type,
-		uint32_t item_cnt, uint32_t item_base);
+int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter,
+				 uint32_t res_type,
+				 uint32_t item_cnt,
+				 uint32_t item_base);
 
 void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
 
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
new file mode 100644
index 0000000000..a04c1808a6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -0,0 +1,559 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <ethdev_driver.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_queue.h"
+#include "sxe2_rx.h"
+#include "sxe2_cmd_chnl.h"
+
+#include "sxe2_osal.h"
+#include "sxe2_common_log.h"
+
+static void *sxe2_rx_doorbell_tail_addr_get(struct sxe2_adapter *adapter, uint16_t queue_id)
+{
+	return sxe2_pci_map_addr_get(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL,
+				     queue_id);
+}
+
+static void sxe2_rx_head_tail_init(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq)
+{
+	rxq->rdt_reg_addr = sxe2_rx_doorbell_tail_addr_get(adapter, rxq->queue_id);
+	SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, 0);
+}
+
+static void __rte_cold sxe2_rx_queue_reset(struct sxe2_rx_queue *rxq)
+{
+	uint16_t i = 0;
+	uint16_t len = 0;
+	static const union sxe2_rx_desc zeroed_desc = {{0}};
+
+	len = rxq->ring_depth + SXE2_RX_PKTS_BURST_BATCH_NUM;
+	for (i = 0; i < len; ++i)
+		rxq->desc_ring[i] = zeroed_desc;
+
+	memset(&rxq->fake_mbuf, 0, sizeof(rxq->fake_mbuf));
+	for (i = rxq->ring_depth; i < len; i++)
+		rxq->buffer_ring[i] = &rxq->fake_mbuf;
+
+	rxq->hold_num            = 0;
+	rxq->next_ret_pkt        = 0;
+	rxq->processing_idx      = 0;
+	rxq->completed_pkts_num  = 0;
+	rxq->batch_alloc_trigger = rxq->rx_free_thresh - 1;
+
+	rxq->pkt_first_seg = NULL;
+	rxq->pkt_last_seg  = NULL;
+
+	rxq->realloc_num   = 0;
+	rxq->realloc_start = 0;
+}
+
+void __rte_cold sxe2_rx_queue_mbufs_release(struct sxe2_rx_queue *rxq)
+{
+	uint16_t i;
+
+	if (rxq->buffer_ring != NULL) {
+		for (i = 0; i < rxq->ring_depth; i++) {
+			if (rxq->buffer_ring[i] != NULL) {
+				rte_pktmbuf_free(rxq->buffer_ring[i]);
+				rxq->buffer_ring[i] = NULL;
+			}
+		}
+	}
+
+	if (rxq->completed_pkts_num) {
+		for (i = 0; i < rxq->completed_pkts_num; ++i) {
+			if (rxq->completed_buf[rxq->next_ret_pkt + i] != NULL) {
+				rte_pktmbuf_free(rxq->completed_buf[rxq->next_ret_pkt + i]);
+				rxq->completed_buf[rxq->next_ret_pkt + i] = NULL;
+			}
+		}
+		rxq->completed_pkts_num = 0;
+	}
+}
+
+const struct sxe2_rxq_ops sxe2_default_rxq_ops = {
+	.queue_reset      = sxe2_rx_queue_reset,
+	.mbufs_release    = sxe2_rx_queue_mbufs_release,
+};
+
+static struct sxe2_rxq_ops sxe2_rx_default_ops_get(void)
+{
+	return sxe2_default_rxq_ops;
+}
+
+void __rte_cold sxe2_rx_queue_info_get(struct rte_eth_dev *dev,
+		uint16_t queue_id, struct rte_eth_rxq_info *qinfo)
+{
+	struct sxe2_rx_queue *rxq = NULL;
+
+	if (queue_id >= dev->data->nb_rx_queues) {
+		PMD_LOG_ERR(RX, "rx queue:%u is out of range:%u",
+			queue_id, dev->data->nb_rx_queues);
+		goto end;
+	}
+
+	rxq = dev->data->rx_queues[queue_id];
+	if (rxq == NULL) {
+		PMD_LOG_ERR(RX, "rx queue:%u is NULL", queue_id);
+		goto end;
+	}
+
+	qinfo->mp           = rxq->mb_pool;
+	qinfo->nb_desc      = rxq->ring_depth;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->conf.rx_free_thresh    = rxq->rx_free_thresh;
+	qinfo->conf.rx_drop_en        = rxq->drop_en;
+	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
+
+end:
+	return;
+}
+
+int32_t __rte_cold sxe2_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rx_queue *rxq;
+	int32_t ret;
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->rx_queue_state[rx_queue_id] ==
+			RTE_ETH_QUEUE_STATE_STOPPED) {
+		ret = 0;
+		goto l_end;
+	}
+
+	rxq = dev->data->rx_queues[rx_queue_id];
+	if (rxq == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	ret = sxe2_drv_rxq_switch(adapter, rxq, false);
+	if (ret) {
+		PMD_LOG_ERR(RX, "Failed to switch rx queue %u off, ret = %d",
+				rx_queue_id, ret);
+		if (ret == -EPERM)
+			goto l_free;
+		goto l_end;
+	}
+
+l_free:
+	rxq->ops.mbufs_release(rxq);
+	rxq->ops.queue_reset(rxq);
+	dev->data->rx_queue_state[rx_queue_id] =
+		RTE_ETH_QUEUE_STATE_STOPPED;
+l_end:
+	return ret;
+}
+
+static void __rte_cold sxe2_rx_queue_free(struct sxe2_rx_queue *rxq)
+{
+	if (rxq != NULL) {
+		rxq->ops.mbufs_release(rxq);
+		if (rxq->buffer_ring != NULL) {
+			rte_free(rxq->buffer_ring);
+			rxq->buffer_ring = NULL;
+		}
+		rte_memzone_free(rxq->mz);
+		rte_free(rxq);
+	}
+}
+
+void __rte_cold sxe2_rx_queue_release(struct rte_eth_dev *dev,
+					uint16_t queue_idx)
+{
+	(void)sxe2_rx_queue_stop(dev, queue_idx);
+	sxe2_rx_queue_free(dev->data->rx_queues[queue_idx]);
+	dev->data->rx_queues[queue_idx] = NULL;
+}
+
+void __rte_cold sxe2_all_rxqs_release(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	uint16_t nb_rxq;
+
+	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
+		if (data->rx_queues[nb_rxq] == NULL)
+			continue;
+		sxe2_rx_queue_release(dev, nb_rxq);
+		data->rx_queues[nb_rxq] = NULL;
+	}
+	data->nb_rx_queues = 0;
+}
+
+static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16_t queue_idx,
+		uint16_t ring_depth, uint32_t socket_id)
+{
+	struct sxe2_rx_queue *rxq;
+	const struct rte_memzone *tz;
+	uint16_t len;
+
+	if (dev->data->rx_queues[queue_idx] != NULL) {
+		sxe2_rx_queue_release(dev, queue_idx);
+		dev->data->rx_queues[queue_idx] = NULL;
+	}
+
+	rxq = rte_zmalloc_socket("rx_queue", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, socket_id);
+
+	if (rxq == NULL) {
+		PMD_LOG_ERR(RX, "rx queue[%d] alloc failed", queue_idx);
+		goto l_end;
+	}
+
+	rxq->ring_depth = ring_depth;
+	len = rxq->ring_depth + SXE2_RX_PKTS_BURST_BATCH_NUM;
+
+	rxq->buffer_ring = rte_zmalloc_socket("rx_buffer_ring",
+					  sizeof(struct rte_mbuf *) * len,
+					  RTE_CACHE_LINE_SIZE, socket_id);
+
+	if (!rxq->buffer_ring) {
+		PMD_LOG_ERR(RX, "Rxq malloc mbuf mem failed");
+		rte_free(rxq);
+		rxq = NULL;
+		goto l_end;
+	}
+
+	tz = rte_eth_dma_zone_reserve(dev, "rx_dma", queue_idx,
+					SXE2_RX_RING_SIZE, SXE2_DESC_ADDR_ALIGN, socket_id);
+	if (tz == NULL) {
+		PMD_LOG_ERR(RX, "Rxq malloc desc mem failed");
+		rte_free(rxq->buffer_ring);
+		rxq->buffer_ring = NULL;
+		rte_free(rxq);
+		rxq = NULL;
+		goto l_end;
+	}
+
+	rxq->mz = tz;
+	memset(tz->addr, 0, SXE2_RX_RING_SIZE);
+	rxq->base_addr = tz->iova;
+	rxq->desc_ring = (union sxe2_rx_desc *)tz->addr;
+
+l_end:
+	return rxq;
+}
+
+int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
+			uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+			const struct rte_eth_rxconf *rx_conf,
+			struct rte_mempool *mp)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi *vsi = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_rx_queue *rxq;
+	uint64_t offloads;
+	int32_t ret;
+	uint16_t rx_nseg;
+	uint16_t i;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (nb_desc % SXE2_RX_DESC_RING_ALIGN != 0 ||
+		nb_desc > SXE2_MAX_RING_DESC ||
+		nb_desc < SXE2_MIN_RING_DESC) {
+		PMD_LOG_ERR(RX, "param desc num:%u is invalid", nb_desc);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (mp != NULL)
+		rx_nseg = 1;
+	else
+		rx_nseg = rx_conf->rx_nseg;
+
+	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
+
+	if (rx_nseg > 1 && !(offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+		PMD_LOG_ERR(RX, "Port %u queue %u Buffer split offload not configured, but rx_nseg is %u",
+					dev->data->port_id, queue_idx, rx_nseg);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) && !(rx_nseg > 1)) {
+		PMD_LOG_ERR(RX, "Port %u queue %u Buffer split offload configured, but rx_nseg is %u",
+					dev->data->port_id, queue_idx, rx_nseg);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) &&
+		(offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)) {
+		PMD_LOG_ERR(RX, "port_id %u queue %u, LRO can't be configure with Keep crc.",
+					dev->data->port_id, queue_idx);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	rxq = sxe2_rx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
+	if (rxq == NULL) {
+		PMD_LOG_ERR(RX, "rx queue[%d] resource alloc failed", queue_idx);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	if (offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)
+		dev->data->lro = 1;
+
+	if (rx_nseg > 1) {
+		for (i = 0; i < rx_nseg; i++) {
+			rte_memcpy(&rxq->rx_seg[i], &rx_conf->rx_seg[i].split,
+					sizeof(struct rte_eth_rxseg_split));
+		}
+		rxq->mb_pool = rxq->rx_seg[0].mp;
+	} else {
+		rxq->mb_pool = mp;
+	}
+
+	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
+	rxq->port_id = dev->data->port_id;
+	rxq->offloads = offloads;
+	if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		rxq->crc_len = RTE_ETHER_CRC_LEN;
+	else
+		rxq->crc_len = 0;
+
+	rxq->queue_id = queue_idx;
+	rxq->idx_in_func = vsi->rxqs.base_idx_in_func + queue_idx;
+	rxq->drop_en = rx_conf->rx_drop_en;
+	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
+	rxq->vsi = vsi;
+	rxq->ops = sxe2_rx_default_ops_get();
+	rxq->ops.queue_reset(rxq);
+	dev->data->rx_queues[queue_idx] = rxq;
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+struct rte_mbuf *sxe2_mbuf_raw_alloc(struct rte_mempool *mp)
+{
+	return rte_mbuf_raw_alloc(mp);
+}
+
+static int32_t __rte_cold sxe2_rx_queue_mbufs_alloc(struct sxe2_rx_queue *rxq)
+{
+	struct rte_mbuf **buf_ring = rxq->buffer_ring;
+	struct rte_mbuf *mbuf = NULL;
+	struct rte_mbuf *mbuf_pay;
+	volatile union sxe2_rx_desc *desc;
+	uint64_t dma_addr;
+	int32_t ret;
+	uint16_t i, j;
+
+	for (i = 0; i < rxq->ring_depth; i++) {
+		mbuf = sxe2_mbuf_raw_alloc(rxq->mb_pool);
+		if (mbuf == NULL) {
+			PMD_LOG_ERR(RX, "Rx queue is not available or setup");
+			ret = -ENOMEM;
+			goto l_err_free_mbuf;
+		}
+
+		buf_ring[i] = mbuf;
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+		mbuf->nb_segs = 1;
+		mbuf->port = rxq->port_id;
+
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		desc = &rxq->desc_ring[i];
+		if (!(rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+			mbuf->next = NULL;
+			desc->read.hdr_addr = 0;
+			desc->read.pkt_addr = dma_addr;
+		} else {
+			mbuf_pay = rte_mbuf_raw_alloc(rxq->rx_seg[1].mp);
+			if (unlikely(!mbuf_pay)) {
+				PMD_LOG_ERR(RX, "Failed to allocate payload mbuf for RX");
+				ret = -ENOMEM;
+				goto l_err_free_mbuf;
+			}
+
+			mbuf_pay->next = NULL;
+			mbuf_pay->data_off = RTE_PKTMBUF_HEADROOM;
+			mbuf_pay->nb_segs = 1;
+			mbuf_pay->port = rxq->port_id;
+			mbuf->next = mbuf_pay;
+
+			desc->read.hdr_addr = dma_addr;
+			desc->read.pkt_addr =
+				rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf_pay));
+		}
+
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+		desc->read.rsvd1 = 0;
+		desc->read.rsvd2 = 0;
+#endif
+	}
+
+	ret = 0;
+	goto l_end;
+
+l_err_free_mbuf:
+	for (j = 0; j <= i; j++) {
+		if (buf_ring[j] != NULL && buf_ring[j]->next != NULL) {
+			rte_pktmbuf_free(buf_ring[j]->next);
+			buf_ring[j]->next = NULL;
+		}
+
+		if (buf_ring[j] != NULL) {
+			rte_pktmbuf_free(buf_ring[j]);
+			buf_ring[j] = NULL;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t __rte_cold sxe2_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
+{
+	struct sxe2_rx_queue *rxq;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret;
+	PMD_INIT_FUNC_TRACE();
+
+	rxq = dev->data->rx_queues[rx_queue_id];
+	if (rxq == NULL) {
+		PMD_LOG_ERR(RX, "Rx queue %u is not available or setup",
+				rx_queue_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (dev->data->rx_queue_state[rx_queue_id] ==
+			RTE_ETH_QUEUE_STATE_STARTED) {
+		ret = 0;
+		goto l_end;
+	}
+
+	ret = sxe2_rx_queue_mbufs_alloc(rxq);
+	if (ret) {
+		PMD_LOG_ERR(RX, "Rx queue %u apply desc ring fail",
+			rx_queue_id);
+		ret =  -ENOMEM;
+		goto l_end;
+	}
+
+	sxe2_rx_head_tail_init(adapter, rxq);
+
+	ret = sxe2_drv_rxq_ctxt_cfg(adapter, rxq, 1);
+	if (ret) {
+		PMD_LOG_ERR(RX, "Rx queue %u config ctxt fail, ret=%d",
+			rx_queue_id, ret);
+
+		(void)sxe2_drv_rxq_switch(adapter, rxq, false);
+		rxq->ops.mbufs_release(rxq);
+		rxq->ops.queue_reset(rxq);
+		goto l_end;
+	}
+
+	SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, rxq->ring_depth - 1);
+	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
+l_end:
+	return  ret;
+}
+
+int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct sxe2_rx_queue *rxq;
+	uint16_t nb_rxq;
+	uint16_t nb_started_rxq;
+	int32_t ret;
+	PMD_INIT_FUNC_TRACE();
+
+	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
+		rxq = dev->data->rx_queues[nb_rxq];
+		if (!rxq || rxq->rx_deferred_start)
+			continue;
+
+		ret = sxe2_rx_queue_start(dev, nb_rxq);
+		if (ret) {
+			PMD_LOG_ERR(RX, "Fail to start rx queue %u", nb_rxq);
+			goto l_free_started_queue;
+		}
+
+		rte_atomic_store_explicit(&rxq->sw_stats.pkts, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.bytes, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.drop_pkts, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.drop_bytes, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.unicast_pkts, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.broadcast_pkts, 0,
+			rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&rxq->sw_stats.multicast_pkts, 0,
+			rte_memory_order_relaxed);
+	}
+	ret = 0;
+	goto l_end;
+
+l_free_started_queue:
+	for (nb_started_rxq = 0; nb_started_rxq <= nb_rxq; nb_started_rxq++)
+		(void)sxe2_rx_queue_stop(dev, nb_started_rxq);
+l_end:
+	return ret;
+}
+
+void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct sxe2_adapter *adapter  = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi     *vsi      = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats   *sw_stats_prev = &vsi->vsi_stats.vsi_sw_stats_prev;
+	struct sxe2_rx_queue *rxq = NULL;
+	int32_t ret;
+	uint16_t nb_rxq;
+	PMD_INIT_FUNC_TRACE();
+
+	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
+		ret = sxe2_rx_queue_stop(dev, nb_rxq);
+		if (ret) {
+			PMD_LOG_ERR(RX, "Fail to start rx queue %u", nb_rxq);
+			continue;
+		}
+
+		rxq = dev->data->rx_queues[nb_rxq];
+		if (rxq) {
+			sw_stats_prev->ipackets +=
+				rte_atomic_load_explicit(&rxq->sw_stats.pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->ierrors +=
+				rte_atomic_load_explicit(&rxq->sw_stats.drop_pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->ibytes +=
+				rte_atomic_load_explicit(&rxq->sw_stats.bytes,
+					rte_memory_order_relaxed);
+
+			sw_stats_prev->rx_sw_unicast_packets +=
+				rte_atomic_load_explicit(&rxq->sw_stats.unicast_pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->rx_sw_broadcast_packets +=
+				rte_atomic_load_explicit(&rxq->sw_stats.broadcast_pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->rx_sw_multicast_packets +=
+				rte_atomic_load_explicit(&rxq->sw_stats.multicast_pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->rx_sw_drop_packets +=
+				rte_atomic_load_explicit(&rxq->sw_stats.drop_pkts,
+					rte_memory_order_relaxed);
+			sw_stats_prev->rx_sw_drop_bytes +=
+				rte_atomic_load_explicit(&rxq->sw_stats.drop_bytes,
+					rte_memory_order_relaxed);
+		}
+	}
+}
diff --git a/drivers/net/sxe2/sxe2_rx.h b/drivers/net/sxe2/sxe2_rx.h
new file mode 100644
index 0000000000..138a9d56c9
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_rx.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_RX_H__
+#define __SXE2_RX_H__
+
+#include "sxe2_queue.h"
+
+int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
+				uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+				const struct rte_eth_rxconf *rx_conf,
+				struct rte_mempool *mp);
+
+int32_t __rte_cold sxe2_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
+
+void __rte_cold sxe2_rx_queue_mbufs_release(struct sxe2_rx_queue *rxq);
+
+void __rte_cold sxe2_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
+
+void __rte_cold sxe2_all_rxqs_release(struct rte_eth_dev *dev);
+
+void __rte_cold sxe2_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		struct rte_eth_rxq_info *qinfo);
+
+int32_t __rte_cold sxe2_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
+
+int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev);
+
+void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev);
+
+struct rte_mbuf *sxe2_mbuf_raw_alloc(struct rte_mempool *mp);
+
+#endif /* __SXE2_RX_H__ */
diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
new file mode 100644
index 0000000000..a05beb8c7a
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -0,0 +1,420 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_common.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <ethdev_driver.h>
+#include "sxe2_tx.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_cmd_chnl.h"
+
+static void *sxe2_tx_doorbell_addr_get(struct sxe2_adapter *adapter, uint16_t queue_id)
+{
+	return sxe2_pci_map_addr_get(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX,
+				     queue_id);
+}
+
+static void sxe2_tx_tail_init(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq)
+{
+	txq->tdt_reg_addr = sxe2_tx_doorbell_addr_get(adapter, txq->queue_id);
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, 0);
+}
+
+void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq)
+{
+	uint16_t prev, i;
+	volatile union sxe2_tx_data_desc *txd;
+	static const union sxe2_tx_data_desc zeroed_desc = {{0}};
+	struct sxe2_tx_buffer *tx_buffer = txq->buffer_ring;
+
+	for (i = 0; i < txq->ring_depth; i++)
+		txq->desc_ring[i] = zeroed_desc;
+
+	prev = txq->ring_depth - 1;
+	for (i = 0; i < txq->ring_depth; i++) {
+		txd = &txq->desc_ring[i];
+		if (txd == NULL)
+			continue;
+
+		txd->wb.dd = rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE);
+		tx_buffer[i].mbuf       = NULL;
+		tx_buffer[i].last_id    = i;
+		tx_buffer[prev].next_id = i;
+		prev = i;
+	}
+
+	txq->desc_used_num = 0;
+	txq->desc_free_num = txq->ring_depth - 1;
+	txq->next_use      = 0;
+	txq->next_clean    = txq->ring_depth - 1;
+	txq->next_dd       = txq->rs_thresh  - 1;
+	txq->next_rs       = txq->rs_thresh  - 1;
+}
+
+void __rte_cold sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq)
+{
+	uint32_t i;
+
+	if (txq != NULL && txq->buffer_ring != NULL) {
+		for (i = 0; i < txq->ring_depth; i++) {
+			if (txq->buffer_ring[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(txq->buffer_ring[i].mbuf);
+				txq->buffer_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+static void sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq)
+{
+	if (txq != NULL && txq->buffer_ring != NULL)
+		rte_free(txq->buffer_ring);
+}
+
+const struct sxe2_txq_ops sxe2_default_txq_ops = {
+	.queue_reset      = sxe2_tx_queue_reset,
+	.mbufs_release    = sxe2_tx_queue_mbufs_release,
+	.buffer_ring_free = sxe2_tx_buffer_ring_free,
+};
+
+static struct sxe2_txq_ops sxe2_tx_default_ops_get(void)
+{
+	return sxe2_default_txq_ops;
+}
+
+static int32_t sxe2_txq_arg_validate(struct rte_eth_dev *dev, uint16_t ring_depth,
+		uint16_t *rs_thresh, uint16_t *free_thresh, const struct rte_eth_txconf *tx_conf)
+{
+	int32_t ret = 0;
+
+	if ((ring_depth % SXE2_TX_DESC_RING_ALIGN) != 0 ||
+		ring_depth > SXE2_MAX_RING_DESC ||
+		ring_depth < SXE2_MIN_RING_DESC) {
+		PMD_LOG_ERR(TX, "number:%u of receive descriptors is invalid", ring_depth);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	*free_thresh = (uint16_t)((tx_conf->tx_free_thresh) ?
+			tx_conf->tx_free_thresh : DEFAULT_TX_FREE_THRESH);
+	*rs_thresh   = (uint16_t)((tx_conf->tx_rs_thresh) ?
+			tx_conf->tx_rs_thresh : DEFAULT_TX_RS_THRESH);
+
+	if (*rs_thresh >= (ring_depth - 2)) {
+		PMD_LOG_ERR(TX, "tx_rs_thresh must be less than the number "
+			"of tx descriptors minus 2. (tx_rs_thresh:%u port:%u)",
+			*rs_thresh, dev->data->port_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (*free_thresh >= (ring_depth - 3)) {
+		PMD_LOG_ERR(TX, "tx_free_thresh must be less than the number "
+			"of tx descriptors minus 3. (tx_free_thresh:%u port:%u)",
+			*free_thresh, dev->data->port_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (*rs_thresh > *free_thresh) {
+		PMD_LOG_ERR(TX, "tx_rs_thresh must be less than or equal to "
+			"tx_free_thresh. (tx_free_thresh:%u tx_rs_thresh:%u port:%u)",
+			*free_thresh, *rs_thresh, dev->data->port_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((ring_depth % *rs_thresh) != 0) {
+		PMD_LOG_ERR(TX, "tx_rs_thresh must be a divisor of the "
+			"number of tx descriptors. (tx_rs_thresh:%u port:%d ring_depth:%u)",
+			*rs_thresh, dev->data->port_id, ring_depth);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+void __rte_cold sxe2_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		struct rte_eth_txq_info *qinfo)
+{
+	struct sxe2_tx_queue *txq = NULL;
+
+	txq = dev->data->tx_queues[queue_id];
+	if (txq == NULL) {
+		PMD_LOG_WARN(TX, "tx queue:%u is NULL", queue_id);
+		goto end;
+	}
+
+	qinfo->nb_desc                = txq->ring_depth;
+
+	qinfo->conf.tx_thresh.pthresh = txq->pthresh;
+	qinfo->conf.tx_thresh.hthresh = txq->hthresh;
+	qinfo->conf.tx_thresh.wthresh = txq->wthresh;
+	qinfo->conf.tx_free_thresh    = txq->free_thresh;
+	qinfo->conf.tx_rs_thresh      = txq->rs_thresh;
+	qinfo->conf.offloads          = txq->offloads;
+	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
+
+end:
+	return;
+}
+
+int32_t __rte_cold sxe2_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tx_queue *txq;
+	int32_t ret;
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->tx_queue_state[queue_id] ==
+			RTE_ETH_QUEUE_STATE_STOPPED) {
+		ret = 0;
+		goto l_end;
+	}
+
+	txq = dev->data->tx_queues[queue_id];
+	if (txq == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+
+	ret = sxe2_drv_txq_switch(adapter, txq, false);
+	if (ret) {
+		PMD_LOG_ERR(TX, "Failed to switch tx queue %u off",
+				queue_id);
+		goto l_end;
+	}
+
+	txq->ops.mbufs_release(txq);
+	txq->ops.queue_reset(txq);
+	dev->data->tx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static void __rte_cold sxe2_tx_queue_free(struct sxe2_tx_queue *txq)
+{
+	if (txq != NULL) {
+		txq->ops.mbufs_release(txq);
+		txq->ops.buffer_ring_free(txq);
+
+		rte_memzone_free(txq->mz);
+		rte_free(txq);
+	}
+}
+
+void __rte_cold sxe2_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx)
+{
+	(void)sxe2_tx_queue_stop(dev, queue_idx);
+	sxe2_tx_queue_free(dev->data->tx_queues[queue_idx]);
+	dev->data->tx_queues[queue_idx] = NULL;
+}
+
+void __rte_cold sxe2_all_txqs_release(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	uint16_t nb_txq;
+
+	for (nb_txq = 0; nb_txq < data->nb_tx_queues; nb_txq++) {
+		if (data->tx_queues[nb_txq] == NULL)
+			continue;
+
+		sxe2_tx_queue_release(dev, nb_txq);
+		data->tx_queues[nb_txq] = NULL;
+	}
+	data->nb_tx_queues = 0;
+}
+
+static struct sxe2_tx_queue
+*sxe2_tx_queue_alloc(struct rte_eth_dev *dev, uint16_t queue_idx,
+		uint16_t ring_depth, uint32_t socket_id)
+{
+	struct sxe2_tx_queue *txq;
+	const struct rte_memzone *tz;
+
+	if (dev->data->tx_queues[queue_idx]) {
+		sxe2_tx_queue_release(dev, queue_idx);
+		dev->data->tx_queues[queue_idx] = NULL;
+	}
+
+	txq = rte_zmalloc_socket("tx_queue", sizeof(struct sxe2_tx_queue),
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq == NULL) {
+		PMD_LOG_ERR(TX, "tx queue:%d alloc failed", queue_idx);
+		goto l_end;
+	}
+
+	tz = rte_eth_dma_zone_reserve(dev, "tx_dma", queue_idx,
+			sizeof(union sxe2_tx_data_desc) * SXE2_MAX_RING_DESC,
+			SXE2_DESC_ADDR_ALIGN, socket_id);
+	if (tz == NULL) {
+		PMD_LOG_ERR(TX, "tx desc ring alloc failed, queue_id:%d", queue_idx);
+		rte_free(txq);
+		txq = NULL;
+		goto l_end;
+	}
+
+	txq->buffer_ring = rte_zmalloc_socket("tx_buffer_ring",
+		sizeof(struct sxe2_tx_buffer) * ring_depth,
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->buffer_ring == NULL) {
+		PMD_LOG_ERR(TX, "tx buffer alloc failed, queue_id:%d", queue_idx);
+		rte_memzone_free(tz);
+		rte_free(txq);
+		txq = NULL;
+		goto l_end;
+	}
+
+	txq->mz = tz;
+	txq->base_addr = tz->iova;
+	txq->desc_ring = (volatile union sxe2_tx_data_desc *)tz->addr;
+
+l_end:
+	return txq;
+}
+
+int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
+		uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+		const struct rte_eth_txconf *tx_conf)
+{
+	int32_t ret = 0;
+	uint16_t tx_rs_thresh;
+	uint16_t tx_free_thresh;
+	struct sxe2_tx_queue *txq;
+	struct sxe2_adapter  *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi      *vsi     = adapter->vsi_ctxt.main_vsi;
+	uint64_t offloads;
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_txq_arg_validate(dev, nb_desc, &tx_rs_thresh, &tx_free_thresh, tx_conf);
+	if (ret) {
+		PMD_LOG_ERR(TX, "tx queue:%u arg validate failed", queue_idx);
+		goto end;
+	}
+
+	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
+
+	txq = sxe2_tx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
+	if (txq == NULL) {
+		PMD_LOG_ERR(TX, "failed to alloc sxe2vf tx queue:%u resource", queue_idx);
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	txq->vlan_flag         = SXE2_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
+	txq->ring_depth        = nb_desc;
+	txq->rs_thresh         = tx_rs_thresh;
+	txq->free_thresh       = tx_free_thresh;
+	txq->pthresh           = tx_conf->tx_thresh.pthresh;
+	txq->hthresh           = tx_conf->tx_thresh.hthresh;
+	txq->wthresh           = tx_conf->tx_thresh.wthresh;
+	txq->queue_id          = queue_idx;
+	txq->idx_in_func       = vsi->txqs.base_idx_in_func + queue_idx;
+	txq->port_id           = dev->data->port_id;
+	txq->offloads          = offloads;
+	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->vsi               = vsi;
+	txq->ops               = sxe2_tx_default_ops_get();
+	txq->ops.queue_reset(txq);
+
+	dev->data->tx_queues[queue_idx] = txq;
+	ret = 0;
+
+end:
+	return ret;
+}
+
+int32_t __rte_cold sxe2_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	int32_t    ret = 0;
+	struct sxe2_tx_queue *txq;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->tx_queue_state[queue_id] == RTE_ETH_QUEUE_STATE_STARTED) {
+		ret = 0;
+		goto l_end;
+	}
+
+	txq = dev->data->tx_queues[queue_id];
+	if (txq == NULL) {
+		PMD_LOG_ERR(TX, "tx queue:%u is not available or setup", queue_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_drv_txq_ctxt_cfg(adapter, txq, 1);
+	if (ret) {
+		PMD_LOG_ERR(TX, "tx queue:%u config ctxt fail", queue_id);
+
+		(void)sxe2_drv_txq_switch(adapter, txq, false);
+		txq->ops.mbufs_release(txq);
+		txq->ops.queue_reset(txq);
+		goto l_end;
+	}
+
+	sxe2_tx_tail_init(adapter, txq);
+
+	dev->data->tx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+int32_t __rte_cold sxe2_txqs_all_start(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct sxe2_tx_queue *txq;
+	uint16_t nb_txq;
+	uint16_t nb_started_txq;
+	int32_t ret;
+	PMD_INIT_FUNC_TRACE();
+
+	for (nb_txq = 0; nb_txq < data->nb_tx_queues; nb_txq++) {
+		txq = dev->data->tx_queues[nb_txq];
+		if (!txq || txq->tx_deferred_start)
+			continue;
+
+		ret = sxe2_tx_queue_start(dev, nb_txq);
+		if (ret) {
+			PMD_LOG_ERR(TX, "Fail to start tx queue %u", nb_txq);
+			goto l_free_started_queue;
+		}
+	}
+	ret = 0;
+	goto l_end;
+
+l_free_started_queue:
+	for (nb_started_txq = 0; nb_started_txq <= nb_txq; nb_started_txq++)
+		(void)sxe2_tx_queue_stop(dev, nb_started_txq);
+
+l_end:
+	return ret;
+}
+
+void __rte_cold sxe2_txqs_all_stop(struct rte_eth_dev *dev)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	uint16_t nb_txq;
+	int32_t ret;
+
+	for (nb_txq = 0; nb_txq < data->nb_tx_queues; nb_txq++) {
+		ret = sxe2_tx_queue_stop(dev, nb_txq);
+		if (ret) {
+			PMD_LOG_WARN(TX, "Fail to stop tx queue %u", nb_txq);
+			continue;
+		}
+	}
+}
diff --git a/drivers/net/sxe2/sxe2_tx.h b/drivers/net/sxe2/sxe2_tx.h
new file mode 100644
index 0000000000..c929b1bee2
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_tx.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TX_H__
+#define __SXE2_TX_H__
+#include "sxe2_queue.h"
+
+void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq);
+
+int32_t __rte_cold sxe2_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
+
+void sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq);
+
+int32_t __rte_cold sxe2_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
+
+int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
+		uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+		const struct rte_eth_txconf *tx_conf);
+
+void __rte_cold sxe2_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
+
+void __rte_cold sxe2_all_txqs_release(struct rte_eth_dev *dev);
+
+void __rte_cold sxe2_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		struct rte_eth_txq_info *qinfo);
+
+int32_t __rte_cold sxe2_txqs_all_start(struct rte_eth_dev *dev);
+
+void __rte_cold sxe2_txqs_all_stop(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_TX_H__ */
-- 
2.47.3

