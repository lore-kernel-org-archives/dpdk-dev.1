Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A97CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39DFB40661;
	Wed, 24 Sep 2025 09:53:56 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id E920B40A7A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=uBM9fMArdVbNqEgw+SclDR1K709yhtKRappXrVR5jzQ=;
 b=Ed+sAJ7ubXf91erm/6KcCs5WZ2/1O/NZBmcy2DOwACUD9zXzfXOqHRUKezOBLn
 Eul6m7gUMvhk2qrGD+aZ/L8t7sqwsXmvebuadb/DJ/cg4UmfOtgTRRJ/6igyzMXW
 7yEmpVr2D65Q7YzIaomaJJn0MC0j1p+z5U6rGqjElW6mc=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S16;
 Wed, 24 Sep 2025 15:53:47 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V13 12/18] net/hinic3: add futions for initialization
Date: Wed, 24 Sep 2025 15:51:59 +0800
Message-ID: <20250924075216.18750-13-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250924075216.18750-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250924075216.18750-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S16
X-Coremail-Antispam: 1Uf129KBjvAXoW3CFWkXw4rAFW8GF13JFyDAwb_yoW8JF18Co
 W3XrsIqr1Syr1xAFyqgwn7ZF17XFykZas8Crs8Ga1xXayxGFyrKas8A3yfJF1Ygr9Yqrn7
 AFyUtF4ktayUt34kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcmL9UUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHgnSCmjTYNHWDAAAsf
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

From: Xin Wang <wangxin679@h-partners.com>

This patch contains data structures and function codes
related to device initialization.

Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 256 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h | 118 +++++++++++++
 drivers/net/hinic3/meson.build     |  25 +++
 3 files changed, 399 insertions(+)
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
 create mode 100644 drivers/net/hinic3/meson.build

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
new file mode 100644
index 0000000000..d4f1c592cd
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+#include <ethdev_pci.h>
+#include <eal_interrupts.h>
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_csr.h"
+#include "base/hinic3_wq.h"
+#include "base/hinic3_eqs.h"
+#include "base/hinic3_cmdq.h"
+#include "base/hinic3_hwdev.h"
+#include "base/hinic3_hwif.h"
+#include "base/hinic3_hw_cfg.h"
+#include "base/hinic3_hw_comm.h"
+#include "base/hinic3_nic_cfg.h"
+#include "base/hinic3_nic_event.h"
+#include "hinic3_ethdev.h"
+
+/*
+ * Init mac_vlan table in hardwares.
+ *
+ * @param[in] eth_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_init_mac_table(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev =
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	uint8_t addr_bytes[RTE_ETHER_ADDR_LEN];
+	uint16_t func_id = 0;
+	int err = 0;
+
+	err = hinic3_get_default_mac(nic_dev->hwdev, addr_bytes,
+				     RTE_ETHER_ADDR_LEN);
+	if (err)
+		return err;
+
+	rte_ether_addr_copy((struct rte_ether_addr *)addr_bytes,
+			    &eth_dev->data->mac_addrs[0]);
+	if (rte_is_zero_ether_addr(&eth_dev->data->mac_addrs[0]) ||
+	   rte_is_broadcast_ether_addr(&eth_dev->data->mac_addrs[0]))
+		rte_eth_random_addr(eth_dev->data->mac_addrs[0].addr_bytes);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_mac(nic_dev->hwdev,
+			     eth_dev->data->mac_addrs[0].addr_bytes, 0, func_id);
+	if (err && err != HINIC3_PF_SET_VF_ALREADY)
+		return err;
+
+	rte_ether_addr_copy(&eth_dev->data->mac_addrs[0],
+			    &nic_dev->default_addr);
+
+	return 0;
+}
+
+/**
+ * Delete all multicast MAC addresses from the NIC device.
+ *
+ * This function iterates over the list of multicast MAC addresses and removes
+ * each address from the NIC device by calling `hinic3_del_mac`. After each
+ * deletion, the address is reset to zero.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ */
+static void
+hinic3_delete_mc_addr_list(struct hinic3_nic_dev *nic_dev)
+{
+	uint16_t func_id;
+	uint32_t i;
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	for (i = 0; i < HINIC3_MAX_MC_MAC_ADDRS; i++) {
+		if (rte_is_zero_ether_addr(&nic_dev->mc_list[i]))
+			break;
+
+		hinic3_del_mac(nic_dev->hwdev, nic_dev->mc_list[i].addr_bytes, 0, func_id);
+		memset(&nic_dev->mc_list[i], 0, sizeof(struct rte_ether_addr));
+	}
+}
+
+/**
+ * Deinit mac_vlan table in hardware.
+ *
+ * @param[in] eth_dev
+ * Pointer to ethernet device structure.
+ */
+static void
+hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev =
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	uint16_t func_id = 0;
+	int err;
+	int i;
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	for (i = 0; i < HINIC3_MAX_UC_MAC_ADDRS; i++) {
+		if (rte_is_zero_ether_addr(&eth_dev->data->mac_addrs[i]))
+			continue;
+
+		err = hinic3_del_mac(nic_dev->hwdev,
+				     eth_dev->data->mac_addrs[i].addr_bytes, 0, func_id);
+		if (err && err != HINIC3_PF_SET_VF_ALREADY)
+			PMD_DRV_LOG(ERR,
+				    "Delete mac table failed, dev_name: %s",
+				    eth_dev->data->name);
+
+		memset(&eth_dev->data->mac_addrs[i], 0,
+		       sizeof(struct rte_ether_addr));
+	}
+
+	/* Delete multicast mac addrs. */
+	hinic3_delete_mc_addr_list(nic_dev);
+}
+
+/**
+ * Check the valid CoS bitmap to determine the available CoS IDs and set
+ * the default CoS ID to the highest valid one.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[out] cos_id
+ * Pointer to store the default CoS ID.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
+{
+	uint8_t default_cos = 0;
+	uint8_t valid_cos_bitmap;
+	uint8_t i;
+
+	valid_cos_bitmap = hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;
+	if (!valid_cos_bitmap) {
+		PMD_DRV_LOG(ERR, "PF has none cos to support");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < HINIC3_COS_NUM_MAX; i++) {
+		if (valid_cos_bitmap & RTE_BIT32(i))
+			/* Find max cos id as default cos. */
+			default_cos = i;
+	}
+
+	*cos_id = default_cos;
+
+	return 0;
+}
+
+static int
+hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)
+{
+	uint8_t cos_id = 0;
+	int err;
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		err = hinic3_pf_get_default_cos(nic_dev->hwdev, &cos_id);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Get PF default cos failed, err: %d", err);
+			return err;
+		}
+	} else {
+		err = hinic3_vf_get_default_cos(nic_dev->hwdev, &cos_id);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Get VF default cos failed, err: %d", err);
+			return err;
+		}
+	}
+
+	nic_dev->default_cos = cos_id;
+	PMD_DRV_LOG(DEBUG, "Default cos %d", nic_dev->default_cos);
+	return 0;
+}
+
+/**
+ * Initialize Class of Service (CoS). For PF devices, it also sync the link
+ * status with the physical port.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_set_default_hw_feature(struct hinic3_nic_dev *nic_dev)
+{
+	int err;
+
+	err = hinic3_init_default_cos(nic_dev);
+	if (err)
+		return err;
+
+	if (hinic3_func_type(nic_dev->hwdev) == TYPE_VF)
+		return 0;
+
+	err = hinic3_set_link_status_follow(nic_dev->hwdev,
+					    HINIC3_LINK_FOLLOW_PORT);
+	if (err == HINIC3_MGMT_CMD_UNSUPPORTED)
+		PMD_DRV_LOG(WARNING, "Don't support to set link status follow phy port status");
+	else if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+hinic3_init_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)
+{
+	uint32_t txq_size;
+	uint32_t rxq_size;
+
+	/* Allocate software txq array. */
+	txq_size = nic_dev->max_sqs * sizeof(*nic_dev->txqs);
+	nic_dev->txqs =
+		rte_zmalloc("hinic3_txqs", txq_size, RTE_CACHE_LINE_SIZE);
+	if (!nic_dev->txqs) {
+		PMD_DRV_LOG(ERR, "Allocate txqs failed");
+		return -ENOMEM;
+	}
+
+	/* Allocate software rxq array. */
+	rxq_size = nic_dev->max_rqs * sizeof(*nic_dev->rxqs);
+	nic_dev->rxqs =
+		rte_zmalloc("hinic3_rxqs", rxq_size, RTE_CACHE_LINE_SIZE);
+	if (!nic_dev->rxqs) {
+		/* Free txqs. */
+		rte_free(nic_dev->txqs);
+		nic_dev->txqs = NULL;
+
+		PMD_DRV_LOG(ERR, "Allocate rxqs failed");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void
+hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)
+{
+	rte_free(nic_dev->txqs);
+	nic_dev->txqs = NULL;
+
+	rte_free(nic_dev->rxqs);
+	nic_dev->rxqs = NULL;
+}
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
new file mode 100644
index 0000000000..f75e34a8b7
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_ETHDEV_H_
+#define _HINIC3_ETHDEV_H_
+
+#include <rte_ethdev.h>
+#include <rte_ethdev_core.h>
+
+#define HINIC3_PMD_DRV_VERSION "B106"
+
+#define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
+
+#define HINIC3_PKT_RX_L4_CKSUM_BAD     RTE_MBUF_F_RX_L4_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_BAD     RTE_MBUF_F_RX_IP_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN
+#define HINIC3_PKT_RX_L4_CKSUM_GOOD    RTE_MBUF_F_RX_L4_CKSUM_GOOD
+#define HINIC3_PKT_RX_IP_CKSUM_GOOD    RTE_MBUF_F_RX_IP_CKSUM_GOOD
+#define HINIC3_PKT_TX_TCP_SEG	       RTE_MBUF_F_TX_TCP_SEG
+#define HINIC3_PKT_TX_UDP_CKSUM	       RTE_MBUF_F_TX_UDP_CKSUM
+#define HINIC3_PKT_TX_TCP_CKSUM	       RTE_MBUF_F_TX_TCP_CKSUM
+#define HINIC3_PKT_TX_IP_CKSUM	       RTE_MBUF_F_TX_IP_CKSUM
+#define HINIC3_PKT_TX_VLAN_PKT	       RTE_MBUF_F_TX_VLAN
+#define HINIC3_PKT_TX_L4_MASK	       RTE_MBUF_F_TX_L4_MASK
+#define HINIC3_PKT_TX_SCTP_CKSUM       RTE_MBUF_F_TX_SCTP_CKSUM
+#define HINIC3_PKT_TX_IPV6	       RTE_MBUF_F_TX_IPV6
+#define HINIC3_PKT_TX_IPV4	       RTE_MBUF_F_TX_IPV4
+#define HINIC3_PKT_RX_VLAN	       RTE_MBUF_F_RX_VLAN
+#define HINIC3_PKT_RX_VLAN_STRIPPED    RTE_MBUF_F_RX_VLAN_STRIPPED
+#define HINIC3_PKT_RX_RSS_HASH	       RTE_MBUF_F_RX_RSS_HASH
+#define HINIC3_PKT_TX_TUNNEL_MASK      RTE_MBUF_F_TX_TUNNEL_MASK
+#define HINIC3_PKT_TX_TUNNEL_VXLAN     RTE_MBUF_F_TX_TUNNEL_VXLAN
+#define HINIC3_PKT_TX_OUTER_IP_CKSUM   RTE_MBUF_F_TX_OUTER_IP_CKSUM
+#define HINIC3_PKT_TX_OUTER_IPV6       RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_RX_LRO	       RTE_MBUF_F_RX_LRO
+#define HINIC3_PKT_TX_L4_NO_CKSUM      RTE_MBUF_F_TX_L4_NO_CKSUM
+
+#define HINCI3_CPY_MEMPOOL_NAME "cpy_mempool"
+/* Mbuf pool for copy invalid mbuf segs. */
+#define HINIC3_COPY_MEMPOOL_DEPTH 1024
+#define HINIC3_COPY_MEMPOOL_CACHE 128
+#define HINIC3_COPY_MBUF_SIZE	  4096
+
+#define HINIC3_DEV_NAME_LEN 32
+#define DEV_STOP_DELAY_MS   100
+#define DEV_START_DELAY_MS  100
+#define HINIC3_FLUSH_QUEUE_TIMEOUT 3000
+
+#define HINIC3_UINT32_BIT_SIZE (CHAR_BIT * sizeof(uint32_t))
+#define HINIC3_VFTA_SIZE       (4096 / HINIC3_UINT32_BIT_SIZE)
+#define HINIC3_MAX_QUEUE_NUM   64
+
+#define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \
+	((struct hinic3_nic_dev *)(dev)->data->dev_private)
+
+enum hinic3_dev_status {
+	HINIC3_DEV_INIT,
+	HINIC3_DEV_CLOSE,
+	HINIC3_DEV_START,
+	HINIC3_DEV_INTR_EN
+};
+
+enum hinic3_tx_cvlan_type {
+	HINIC3_TX_TPID0,
+};
+
+enum nic_feature_cap {
+	NIC_F_CSUM		= RTE_BIT32(0),
+	NIC_F_SCTP_CRC		= RTE_BIT32(1),
+	NIC_F_TSO		= RTE_BIT32(2),
+	NIC_F_LRO		= RTE_BIT32(3),
+	NIC_F_UFO		= RTE_BIT32(4),
+	NIC_F_RSS		= RTE_BIT32(5),
+	NIC_F_RX_VLAN_FILTER	= RTE_BIT32(6),
+	NIC_F_RX_VLAN_STRIP	= RTE_BIT32(7),
+	NIC_F_TX_VLAN_INSERT	= RTE_BIT32(8),
+	NIC_F_VXLAN_OFFLOAD	= RTE_BIT32(9),
+	NIC_F_IPSEC_OFFLOAD	= RTE_BIT32(10),
+	NIC_F_FDIR		= RTE_BIT32(11),
+	NIC_F_PROMISC		= RTE_BIT32(12),
+	NIC_F_ALLMULTI		= RTE_BIT32(13),
+};
+
+#define DEFAULT_DRV_FEATURE 0x3FFF
+
+struct hinic3_nic_dev {
+	struct hinic3_hwdev *hwdev; /**< Hardware device. */
+	struct hinic3_txq **txqs;
+	struct hinic3_rxq **rxqs;
+	struct rte_mempool *cpy_mpool;
+
+	uint16_t num_sqs;
+	uint16_t num_rqs;
+	uint16_t max_sqs;
+	uint16_t max_rqs;
+
+	uint16_t rx_buff_len;
+	uint16_t mtu_size;
+
+	uint32_t rx_mode;
+	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];
+	rte_spinlock_t queue_list_lock;
+
+	uint32_t default_cos;
+	uint32_t rx_csum_en;
+
+	RTE_ATOMIC(uint64_t)dev_status;
+
+	struct rte_ether_addr default_addr;
+	struct rte_ether_addr *mc_list;
+
+	char dev_name[HINIC3_DEV_NAME_LEN];
+	uint64_t feature_cap;
+	uint32_t vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */
+};
+
+#endif /* _HINIC3_ETHDEV_H_ */
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
new file mode 100644
index 0000000000..018b300f75
--- /dev/null
+++ b/drivers/net/hinic3/meson.build
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+if (arch_subdir != 'x86' and arch_subdir != 'arm'
+        or not dpdk_conf.get('RTE_ARCH_64'))
+    build = false
+    reason = 'only supported on x86_64 and aarch64'
+    subdir_done()
+endif
+
+cflags += ['-DHW_CONVERT_ENDIAN']
+
+subdir('base')
+
+sources = files(
+        'hinic3_ethdev.c',
+)
+
+includes += include_directories('base')
\ No newline at end of file
-- 
2.47.0.windows.2

