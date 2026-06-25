Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D615CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 05:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 315374065B;
	Thu, 25 Jun 2026 07:43:02 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 938F7402C6
 for <dev@dpdk.org>; Thu, 25 Jun 2026 07:43:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABnus3ivzxqX48nFQ--.18519S2;
 Thu, 25 Jun 2026 13:42:58 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 05/23] net/sxe2: add link update callback
Date: Thu, 25 Jun 2026 13:42:57 +0800
Message-ID: <20260625054257.52263-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260624020249.3687380-1-liujie5@linkdatatechnology.com>
References: <20260624020249.3687380-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnus3ivzxqX48nFQ--.18519S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw43Kr18WFW5Jr1xtF47urg_yoW8Ar45Xo
 W7Kry7ZF13Jrn7C3yDXrs7CFW5Z3y8Gr4rAa1S9rs8u3W3J345JFyxKw17XF1qg3Z3tr12
 9w1kA3yIyw47WrWkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYe7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
 JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
 WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbnjjDUUUUU==
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

Implement dev_link_update ethdev callback for sxe2 PMD.
The driver reads the link status, speed, and duplex mode from the
hardware registers and updates the ethdev link status using the
appropriate atomic operations.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build     |   1 +
 drivers/net/sxe2/sxe2_cmd_chnl.c |  22 +++++
 drivers/net/sxe2/sxe2_cmd_chnl.h |   2 +
 drivers/net/sxe2/sxe2_drv_cmd.h  |   6 ++
 drivers/net/sxe2/sxe2_ethdev.c   | 158 +++++++++++++++++++++++++------
 drivers/net/sxe2/sxe2_ethdev.h   |  19 ++--
 drivers/net/sxe2/sxe2_mac.c      |  98 +++++++++++++++++++
 drivers/net/sxe2/sxe2_mac.h      |  50 ++++++++++
 8 files changed, 316 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_mac.c
 create mode 100644 drivers/net/sxe2/sxe2_mac.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index c225dd7cd8..b14b5120c1 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -60,4 +60,5 @@ sources += files(
         'sxe2_txrx_poll.c',
         'sxe2_txrx.c',
         'sxe2_txrx_vec.c',
+        'sxe2_mac.c',
 )
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index d16b6528d0..07eeb7f38c 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -321,3 +321,25 @@ int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *
 
 	return ret;
 }
+
+int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_link_info_resp resp = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_LINK_STATUS_GET,
+				 NULL, 0,
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "link status get failed, ret=%d", ret);
+		goto l_end;
+	}
+	adapter->link_ctxt.speed = resp.speed;
+	adapter->link_ctxt.link_up = resp.status;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index ed5e842346..cda676ed97 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -34,4 +34,6 @@ int32_t sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter,
 			      struct sxe2_tx_queue *txq,
 			      uint16_t txq_cnt);
 
+int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
+
 #endif /* SXE2_CMD_CHNL_H */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index ccc9c20ef4..a0f08b5184 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -227,6 +227,12 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_info_get_resp {
 	struct sxe2_drv_msix_caps used_msix;
 } __rte_packed_end;
 
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_link_info_resp {
+	uint32_t speed;
+	uint8_t status;
+	uint8_t rsv[3];
+} __rte_packed_end;
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 066e1faf7e..c00569f05b 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -27,6 +27,7 @@
 #include "sxe2_tx.h"
 #include "sxe2_rx.h"
 #include "sxe2_txrx.h"
+#include "sxe2_mac.h"
 #include "sxe2_common.h"
 #include "sxe2_common_log.h"
 #include "sxe2_host_regs.h"
@@ -78,6 +79,41 @@ static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_
 				      .reg_width = 10},
 };
 
+static int32_t sxe2_dev_configure(struct rte_eth_dev *dev);
+static int32_t sxe2_dev_start(struct rte_eth_dev *dev);
+static int32_t sxe2_dev_stop(struct rte_eth_dev *dev);
+static int32_t sxe2_dev_close(struct rte_eth_dev *dev);
+static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info);
+static const uint32_t *sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev
+				__rte_unused, size_t *no_of_elements __rte_unused);
+
+static const struct eth_dev_ops sxe2_eth_dev_ops = {
+	.dev_configure              = sxe2_dev_configure,
+	.dev_start                  = sxe2_dev_start,
+	.dev_stop                   = sxe2_dev_stop,
+	.dev_close                  = sxe2_dev_close,
+	.dev_infos_get              = sxe2_dev_infos_get,
+	.dev_supported_ptypes_get   = sxe2_dev_supported_ptypes_get,
+	.link_update                = sxe2_link_update,
+
+	.rx_queue_start             = sxe2_rx_queue_start,
+	.rx_queue_stop              = sxe2_rx_queue_stop,
+	.tx_queue_start             = sxe2_tx_queue_start,
+	.tx_queue_stop              = sxe2_tx_queue_stop,
+	.rx_queue_setup             = sxe2_rx_queue_setup,
+	.rx_queue_release           = sxe2_rx_queue_release,
+	.tx_queue_setup             = sxe2_tx_queue_setup,
+	.tx_queue_release           = sxe2_tx_queue_release,
+	.rxq_info_get               = sxe2_rx_queue_info_get,
+	.txq_info_get               = sxe2_tx_queue_info_get,
+	.rx_burst_mode_get          = sxe2_rx_burst_mode_get,
+	.tx_burst_mode_get          = sxe2_tx_burst_mode_get,
+	.tx_done_cleanup            = sxe2_tx_done_cleanup,
+
+	.mtu_set                    = sxe2_mtu_set,
+	.buffer_split_supported_hdr_ptypes_get = sxe2_buffer_split_supported_hdr_ptypes_get,
+};
+
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
@@ -122,6 +158,12 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	sxe2_rx_mode_func_set(dev);
 	sxe2_tx_mode_func_set(dev);
 
+	ret = sxe2_link_update_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize link update, ret:%d", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_queues_start(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "enable queues failed");
@@ -136,16 +178,6 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
-{
-	(void)sxe2_dev_stop(dev);
-	(void)sxe2_queues_release(dev);
-	sxe2_vsi_uninit(dev);
-	sxe2_dev_pci_map_uinit(dev);
-
-	return 0;
-}
-
 static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 			struct rte_eth_dev_info *dev_info)
 {
@@ -270,28 +302,49 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static const struct eth_dev_ops sxe2_eth_dev_ops = {
-	.dev_configure              = sxe2_dev_configure,
-	.dev_start                  = sxe2_dev_start,
-	.dev_stop                   = sxe2_dev_stop,
-	.dev_close                  = sxe2_dev_close,
-	.dev_infos_get              = sxe2_dev_infos_get,
-
-	.rx_queue_start             = sxe2_rx_queue_start,
-	.rx_queue_stop              = sxe2_rx_queue_stop,
-	.tx_queue_start             = sxe2_tx_queue_start,
-	.tx_queue_stop              = sxe2_tx_queue_stop,
-	.rx_queue_setup             = sxe2_rx_queue_setup,
-	.rx_queue_release           = sxe2_rx_queue_release,
-	.tx_queue_setup             = sxe2_tx_queue_setup,
-	.tx_queue_release           = sxe2_tx_queue_release,
+static const uint32_t *
+sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+					   size_t *no_of_elements __rte_unused)
+{
+	static const uint32_t ptypes[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_L4_SCTP,
+
+		RTE_PTYPE_TUNNEL_GRENAT,
+
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER,
+
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN,
+
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_UDP,
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP,
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_SCTP,
+
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_UDP,
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP,
+		RTE_PTYPE_TUNNEL_GRENAT | RTE_PTYPE_INNER_L2_ETHER |
+			RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_SCTP,
+
+		RTE_PTYPE_UNKNOWN
+	};
 
-	.rxq_info_get               = sxe2_rx_queue_info_get,
-	.txq_info_get               = sxe2_tx_queue_info_get,
-	.rx_burst_mode_get          = sxe2_rx_burst_mode_get,
-	.tx_burst_mode_get          = sxe2_tx_burst_mode_get,
-	.tx_done_cleanup            = sxe2_tx_done_cleanup,
-};
+	return ptypes;
+}
 
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type)
@@ -360,6 +413,29 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 	return addr;
 }
 
+static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+
+	ret = sxe2_link_update_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize link update, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_mtu_set(dev, dev->data->mtu);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to set mtu, ret=%d", ret);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static void sxe2_eth_uinit(struct rte_eth_dev *dev __rte_unused)
+{
+}
+
 static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 			struct sxe2_drv_dev_caps_resp *dev_caps)
 {
@@ -789,18 +865,38 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_dev_info_err;
 	}
 
+	ret = sxe2_eth_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
+		goto init_eth_err;
+	}
+
 	goto l_end;
 
+init_eth_err:
 init_dev_info_err:
 	sxe2_vsi_uninit(dev);
 init_vsi_err:
+	sxe2_dev_pci_map_uinit(dev);
 l_end:
 	return ret;
 }
 
+static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
+{
+	(void)sxe2_dev_stop(dev);
+	(void)sxe2_queues_release(dev);
+	sxe2_vsi_uninit(dev);
+	sxe2_dev_pci_map_uinit(dev);
+	sxe2_eth_uinit(dev);
+
+	return 0;
+}
+
 static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
+
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto l_end;
 
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 97d1d1fe14..4193603306 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -120,12 +120,6 @@ enum {
 	SXE2_FLAGS_NBITS
 };
 
-struct sxe2_link_context {
-	rte_spinlock_t link_lock;
-	bool link_up;
-	uint32_t  speed;
-};
-
 struct sxe2_devargs {
 	uint8_t flow_dup_pattern_mode;
 	uint8_t func_flow_direct_en;
@@ -266,6 +260,12 @@ struct sxe2_sched_hw_cap {
 	uint8_t adj_lvl;
 };
 
+struct sxe2_link_context {
+	rte_spinlock_t link_lock;
+	bool link_up;
+	uint32_t  speed;
+};
+
 struct sxe2_adapter {
 	struct sxe2_common_device      *cdev;
 	struct sxe2_dev_info            dev_info;
@@ -275,9 +275,10 @@ struct sxe2_adapter {
 	struct sxe2_irq_context       irq_ctxt;
 	struct sxe2_queue_context     q_ctxt;
 	struct sxe2_vsi_context       vsi_ctxt;
-	struct sxe2_devargs			  devargs;
-	uint16_t                           dev_port_id;
-	uint64_t                           cap_flags;
+	struct sxe2_link_context      link_ctxt;
+	struct sxe2_devargs           devargs;
+	uint16_t                      dev_port_id;
+	uint64_t                      cap_flags;
 	enum sxe2_dev_type            dev_type;
 	struct rte_ether_addr           mac_addr;
 	uint8_t                              port_idx;
diff --git a/drivers/net/sxe2/sxe2_mac.c b/drivers/net/sxe2/sxe2_mac.c
new file mode 100644
index 0000000000..027e831c97
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_mac.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_os.h>
+#include "sxe2_osal.h"
+#include "sxe2_mac.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_host_regs.h"
+
+int32_t sxe2_link_update_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rte_spinlock_init(&adapter->link_ctxt.link_lock);
+
+	ret = sxe2_drv_mac_link_status_get(adapter);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get link status, ret=%d", ret);
+		goto l_end;
+	}
+
+	(void)sxe2_link_update(dev, 0);
+
+l_end:
+	return ret;
+}
+int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete)
+{
+	struct rte_eth_link new_link;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	memset(&new_link, 0, sizeof(new_link));
+
+	switch (adapter->link_ctxt.speed) {
+	case 0:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		break;
+	case 10:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_10M;
+		break;
+	case 100:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_100M;
+		break;
+	case 1000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+	case 10000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	case 20000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_20G;
+		break;
+	case 25000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_25G;
+		break;
+	case 40000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_40G;
+		break;
+	case 50000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_50G;
+		break;
+	case 100000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_100G;
+		break;
+	default:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		break;
+	}
+
+	new_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	new_link.link_status = adapter->link_ctxt.link_up ? RTE_ETH_LINK_UP :
+					     RTE_ETH_LINK_DOWN;
+	new_link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+				RTE_ETH_LINK_SPEED_FIXED);
+
+	return rte_eth_linkstatus_set(dev, &new_link);
+}
+
+int32_t sxe2_mtu_set(struct rte_eth_dev *dev, uint16_t mtu __rte_unused)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->dev_started != 0) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "port %d must be stopped before configuration",
+				dev->data->port_id);
+		return -EBUSY;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/sxe2/sxe2_mac.h b/drivers/net/sxe2/sxe2_mac.h
new file mode 100644
index 0000000000..f2f3edaeff
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_mac.h
@@ -0,0 +1,50 @@
+
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_MAC_H__
+#define __SXE2_MAC_H__
+#include <ethdev_driver.h>
+#include "sxe2_host_regs.h"
+
+#define SXE2_NUM_MACADDR_MAX   64
+
+#define SXE2_DPDK_OFFLOAD_OUTER_INSERT_8021Q SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN1
+#define SXE2_DPDK_OFFLOAD_OUTER_INSERT_8021AD SXE2_VSI_L2TAGSTXVALID_ID_STAG
+#define SXE2_DPDK_OFFLOAD_OUTER_INSERT_QINQ1 SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN2
+#define SXE2_DPDK_OFFLOAD_OUTER_INSERT_VLAN  SXE2_VSI_L2TAGSTXVALID_ID_VLAN
+
+#define SXE2_DPDK_OFFLOAD_OUTER_INSERT_ENABLE SXE2_VSI_L2TAGSTXVALID_L2TAG1_VALID
+
+#define SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021Q SXE2_VSI_TSR_ID_OUT_VLAN1
+#define SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021AD SXE2_VSI_TSR_ID_STAG
+#define SXE2_DPDK_OFFLOAD_OUTER_STRIP_QINQ1 SXE2_VSI_TSR_ID_OUT_VLAN2
+
+#define SXE2_DPDK_OFFLOAD_INNER_INSERT_QINQ1  SXE2_VSI_L2TAGSTXVALID_ID_VLAN
+#define SXE2_DPDK_OFFLOAD_INNER_INSERT_ENABLE SXE2_VSI_L2TAGSTXVALID_L2TAG2_VALID
+
+#define SXE2_DPDK_OFFLOAD_INNER_STRIP_QINQ1 SXE2_VSI_TSR_ID_VLAN
+
+#define SXE2_DPDK_OFFLOAD_FIELD                (0X0F)
+#define SXE2_DPDK_OFFLOAD_TAGID_FIELD          (0X07)
+
+#define SXE2_DPDK_OFFLOAD_OUTER_STRIP_MASK (SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021Q | \
+					SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021AD | \
+					SXE2_DPDK_OFFLOAD_OUTER_STRIP_QINQ1)
+#define SXE2_DPDK_OFFLOAD_STRIP_OFFSET SXE2_VSI_TSR_SHOW_TAG_S
+
+#define SXE2_DPDK_OFFLOAD_INSERT_ENABLE (RTE_BIT32(3))
+
+struct sxe2_mac_mc_list {
+	uint32_t count;
+	struct rte_ether_addr addr[SXE2_NUM_MACADDR_MAX];
+};
+
+int32_t sxe2_link_update_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete);
+
+int32_t sxe2_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
+
+#endif /* __SXE2_MAC_H__ */
-- 
2.52.0

