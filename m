Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A3CAC589
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 07:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 057BF40B91;
	Tue,  9 Sep 2025 09:33:14 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 80BE2406BC
 for <dev@dpdk.org>; Tue,  9 Sep 2025 09:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=RZrQkwzjqdhHZ1rdeXmcM5CpRRtMFssURzEM5AfiE/0=;
 b=D8vuLIBCxjluiPX0+CmnCoIoSU37+AxpgQNubGW0lB426lafmnto0WOVDT4bmN
 MFSyGmYpGIFQcAZ+ihsE+0ooaqVFXDOVNkGrSwZR+FNeJFsASQa8q3oUqON4Hg5U
 sqQDZ1cA6Iti79QlVKeZWuj8v3BANt+/iWfwVRJk+mmWo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAXb4cZ2L9oEBzOAQ--.47637S16;
 Tue, 09 Sep 2025 15:33:05 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [V9 12/17] net/hinic3: add device initialization
Date: Tue,  9 Sep 2025 15:31:40 +0800
Message-ID: <20250909073157.14968-13-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250909073157.14968-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250909073157.14968-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgAXb4cZ2L9oEBzOAQ--.47637S16
X-Coremail-Antispam: 1Uf129KBjvAXoW3CFWkXw45Jw4Uur13Ar13Arb_yoW8CFykKo
 W3XrZIgr1Fyr18AF1vgwn7XFy3XFykZas8Jws0ga1xXayxGFyrKa45Cw18tF1FgrnYvr97
 JFy7KFs5tayUt397n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2Xo7DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHgfDCmi-l37gjwAAsB
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
 drivers/net/hinic3/hinic3_ethdev.c | 464 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h | 118 ++++++++
 drivers/net/hinic3/meson.build     |  26 ++
 3 files changed, 608 insertions(+)
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
 create mode 100644 drivers/net/hinic3/meson.build

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
new file mode 100644
index 0000000000..1949260d3d
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -0,0 +1,464 @@
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
+/**
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
+	if (rte_is_zero_ether_addr(&eth_dev->data->mac_addrs[0]))
+		rte_eth_random_addr(eth_dev->data->mac_addrs[0].addr_bytes);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_mac(nic_dev->hwdev,
+			     eth_dev->data->mac_addrs[0].addr_bytes, 0,
+			     func_id);
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
+				     eth_dev->data->mac_addrs[i].addr_bytes, 0,
+				     func_id);
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
+			PMD_DRV_LOG(ERR, "Get PF default cos failed, err: %d",
+				    err);
+			return err;
+		}
+	} else {
+		err = hinic3_vf_get_default_cos(nic_dev->hwdev, &cos_id);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Get VF default cos failed, err: %d",
+				    err);
+			return err;
+		}
+	}
+
+	nic_dev->default_cos = cos_id;
+	PMD_DRV_LOG(INFO, "Default cos %d", nic_dev->default_cos);
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
+		PMD_DRV_LOG(WARNING, "Don't support to set link status follow "
+				     "phy port status");
+	else if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * Initialize the network function, including hardware configuration, memory
+ * allocation for data structures, MAC address setup, and interrupt enabling.
+ * It also registers interrupt callbacks and sets default hardware features.
+ * If any step fails, appropriate cleanup is performed.
+ *
+ * @param[out] eth_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_func_init(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_tcam_info *tcam_info = NULL;
+	struct hinic3_nic_dev *nic_dev = NULL;
+	struct rte_pci_device *pci_dev = NULL;
+	int err;
+
+	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+
+	/* EAL is secondary and eth_dev is already created. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_DRV_LOG(INFO, "Initialize %s in secondary process",
+			    eth_dev->data->name);
+
+		return 0;
+	}
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	memset(nic_dev, 0, sizeof(*nic_dev));
+	snprintf(nic_dev->dev_name, sizeof(nic_dev->dev_name),
+		     "dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,
+		     pci_dev->addr.bus, pci_dev->addr.devid,
+		     pci_dev->addr.function);
+
+	/* Alloc mac_addrs. */
+	eth_dev->data->mac_addrs = rte_zmalloc("hinic3_mac",
+		HINIC3_MAX_UC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);
+	if (!eth_dev->data->mac_addrs) {
+		PMD_DRV_LOG(ERR, "Allocate  MAC addresses failed, dev_name: %s",
+			    eth_dev->data->name);
+		err = -ENOMEM;
+		goto alloc_eth_addr_fail;
+	}
+
+	nic_dev->mc_list = rte_zmalloc("hinic3_mc",
+		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);
+	if (!nic_dev->mc_list) {
+		PMD_DRV_LOG(ERR, "Allocate  MAC addresses failed, dev_name: %s",
+			    eth_dev->data->name);
+		err = -ENOMEM;
+		goto alloc_mc_list_fail;
+	}
+
+	/* Create hardware device. */
+	nic_dev->hwdev = rte_zmalloc("hinic3_hwdev", sizeof(*nic_dev->hwdev),
+				     RTE_CACHE_LINE_SIZE);
+	if (!nic_dev->hwdev) {
+		PMD_DRV_LOG(ERR, "Allocate hwdev memory failed, dev_name: %s",
+			    eth_dev->data->name);
+		err = -ENOMEM;
+		goto alloc_hwdev_mem_fail;
+	}
+	nic_dev->hwdev->pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	nic_dev->hwdev->dev_handle = nic_dev;
+	nic_dev->hwdev->eth_dev = eth_dev;
+	nic_dev->hwdev->port_id = eth_dev->data->port_id;
+
+	err = hinic3_init_hwdev(nic_dev->hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init chip hwdev failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_hwdev_fail;
+	}
+
+	nic_dev->max_sqs = hinic3_func_max_sqs(nic_dev->hwdev);
+	nic_dev->max_rqs = hinic3_func_max_rqs(nic_dev->hwdev);
+
+	err = hinic3_init_nic_hwdev(nic_dev->hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init nic hwdev failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_nic_hwdev_fail;
+	}
+
+	err = hinic3_get_feature_from_hw(nic_dev->hwdev, &nic_dev->feature_cap,
+					 1);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			"Get nic feature from hardware failed, dev_name: %s",
+			eth_dev->data->name);
+		goto get_cap_fail;
+	}
+
+	err = hinic3_init_sw_rxtxqs(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_sw_rxtxqs_fail;
+	}
+
+	err = hinic3_init_mac_table(eth_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init mac table failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_mac_table_fail;
+	}
+
+	/* Set hardware feature to default status. */
+	err = hinic3_set_default_hw_feature(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set hw default features failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto set_default_feature_fail;
+	}
+
+	/* Register callback func to eal lib. */
+	err = rte_intr_callback_register(PCI_DEV_TO_INTR_HANDLE(pci_dev),
+					 hinic3_dev_interrupt_handler,
+					 (void *)eth_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Register intr callback failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto reg_intr_cb_fail;
+	}
+
+	/* Enable uio/vfio intr/eventfd mapping. */
+	err = rte_intr_enable(PCI_DEV_TO_INTR_HANDLE(pci_dev));
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable rte interrupt failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto enable_intr_fail;
+	}
+	tcam_info = &nic_dev->tcam;
+	memset(tcam_info, 0, sizeof(struct hinic3_tcam_info));
+	TAILQ_INIT(&tcam_info->tcam_list);
+	TAILQ_INIT(&tcam_info->tcam_dynamic_info.tcam_dynamic_list);
+	TAILQ_INIT(&nic_dev->filter_ethertype_list);
+	TAILQ_INIT(&nic_dev->filter_fdir_rule_list);
+
+	hinic3_set_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status);
+
+	hinic3_set_bit(HINIC3_DEV_INIT, &nic_dev->dev_status);
+	PMD_DRV_LOG(INFO, "Initialize %s in primary succeed",
+		    eth_dev->data->name);
+
+	/**
+	 * Queue xstats filled automatically by ethdev layer.
+	 */
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+
+	return 0;
+
+enable_intr_fail:
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),
+					hinic3_dev_interrupt_handler,
+					(void *)eth_dev);
+
+reg_intr_cb_fail:
+set_default_feature_fail:
+	hinic3_deinit_mac_addr(eth_dev);
+
+init_mac_table_fail:
+	hinic3_deinit_sw_rxtxqs(nic_dev);
+
+init_sw_rxtxqs_fail:
+	hinic3_free_nic_hwdev(nic_dev->hwdev);
+
+get_cap_fail:
+init_nic_hwdev_fail:
+	hinic3_free_hwdev(nic_dev->hwdev);
+	eth_dev->dev_ops = NULL;
+	eth_dev->rx_queue_count = NULL;
+	eth_dev->rx_descriptor_status = NULL;
+	eth_dev->tx_descriptor_status = NULL;
+
+init_hwdev_fail:
+	rte_free(nic_dev->hwdev);
+	nic_dev->hwdev = NULL;
+
+alloc_hwdev_mem_fail:
+	rte_free(nic_dev->mc_list);
+	nic_dev->mc_list = NULL;
+
+alloc_mc_list_fail:
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
+
+alloc_eth_addr_fail:
+	PMD_DRV_LOG(ERR, "Initialize %s in primary failed",
+		    eth_dev->data->name);
+	return err;
+}
+
+static int
+hinic3_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev;
+
+	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+
+	PMD_DRV_LOG(INFO, "Initializing %.4x:%.2x:%.2x.%x in %s process",
+		    pci_dev->addr.domain, pci_dev->addr.bus,
+		    pci_dev->addr.devid, pci_dev->addr.function,
+		    (rte_eal_process_type() == RTE_PROC_PRIMARY) ? "primary"
+								 : "secondary");
+
+	PMD_DRV_LOG(INFO, "Network Interface pmd driver version: %s",
+		    HINIC3_PMD_DRV_VERSION);
+
+	return hinic3_func_init(eth_dev);
+}
+
+static int
+hinic3_dev_uninit(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	hinic3_clear_bit(HINIC3_DEV_INIT, &nic_dev->dev_status);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	return hinic3_dev_close(dev);
+}
+
+static const struct rte_pci_id pci_id_hinic3_map[] = {
+#ifdef CONFIG_SP_VID_DID
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_STANDARD)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_VF)},
+#else
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_STANDARD)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF)},
+#endif
+
+	{.vendor_id = 0},
+};
+
+static int
+hinic3_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
+		 struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+		sizeof(struct hinic3_nic_dev), hinic3_dev_init);
+}
+
+static int
+hinic3_pci_remove(struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_remove(pci_dev, hinic3_dev_uninit);
+}
+
+static struct rte_pci_driver rte_hinic3_pmd = {
+	.id_table = pci_id_hinic3_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.probe = hinic3_pci_probe,
+	.remove = hinic3_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_hinic3, rte_hinic3_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_hinic3, pci_id_hinic3_map);
+
+RTE_INIT(hinic3_init_log)
+{
+	hinic3_logtype = rte_log_register("pmd.net.hinic3");
+	if (hinic3_logtype >= 0)
+		rte_log_set_level(hinic3_logtype, RTE_LOG_INFO);
+}
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
new file mode 100644
index 0000000000..fbefed10a2
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
+	NIC_F_CSUM = RTE_BIT32(0),
+	NIC_F_SCTP_CRC = RTE_BIT32(1),
+	NIC_F_TSO = RTE_BIT32(2),
+	NIC_F_LRO = RTE_BIT32(3),
+	NIC_F_UFO = RTE_BIT32(4),
+	NIC_F_RSS = RTE_BIT32(5),
+	NIC_F_RX_VLAN_FILTER = RTE_BIT32(6),
+	NIC_F_RX_VLAN_STRIP = RTE_BIT32(7),
+	NIC_F_TX_VLAN_INSERT = RTE_BIT32(8),
+	NIC_F_VXLAN_OFFLOAD = RTE_BIT32(9),
+	NIC_F_IPSEC_OFFLOAD = RTE_BIT32(10),
+	NIC_F_FDIR = RTE_BIT32(11),
+	NIC_F_PROMISC = RTE_BIT32(12),
+	NIC_F_ALLMULTI = RTE_BIT32(13),
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
index 0000000000..e945f20ed5
--- /dev/null
+++ b/drivers/net/hinic3/meson.build
@@ -0,0 +1,26 @@
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
+objs = [base_objs]
+
+sources = files(
+        'hinic3_ethdev.c',
+)
+
+includes += include_directories('base')
\ No newline at end of file
-- 
2.47.0.windows.2

