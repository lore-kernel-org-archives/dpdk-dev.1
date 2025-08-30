Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF4E40B8D;
	Sat, 30 Aug 2025 14:41:07 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 48A9F406FF
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=5NIR2d3ZX7sDc7npCxpVvTwZSGR6WbIGSdFZmp0FoF4=;
 b=opBAGnL5e272YMeRTGosELVt0h9MEmRjbt7gNH7UQLkZFNzqATi4tP9C0rFDSC
 euRiCnbCIVABxoreoOFKsuqrLY4VmYWV55IvhTia6txJS5Z3anasty1yflNB0msR
 lDflkaKMDzGN5t1NRMYys3lCvrr1eXxX11LC0KHEOPndQ=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S16;
 Sat, 30 Aug 2025 20:41:00 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [V5 12/18] net/hinic3: add device initialization
Date: Sat, 30 Aug 2025 20:39:24 +0800
Message-ID: <20250830123942.5037-13-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S16
X-Coremail-Antispam: 1Uf129KBjvAXoW3CFWDArWftr4fCF4rCF43Awb_yoW8Cw1UJo
 W3XrZIqr1Syr18AFyqgwn7ZFy7XFykuas8Jws09an7Xa1kGFyrKa45Cw18JF1FgrnYvr97
 JFyUtan7tayUt3y8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7a0PDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJg+5Cmiyr99mcgABsl
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

From: Xin Wang <wangxin679@h-partners.com>=0D

This patch contains data structures and function codes=0D
related to device initialization.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c | 514 +++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_ethdev.h | 119 +++++++=0D
 2 files changed, 633 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.h=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
new file mode 100644=0D
index 0000000000..e6666a4d87=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -0,0 +1,514 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_pci.h>=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_mbuf.h>=0D
+#include <rte_malloc.h>=0D
+#include <rte_mempool.h>=0D
+#include <rte_errno.h>=0D
+#include <rte_ether.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_csr.h"=0D
+#include "base/hinic3_wq.h"=0D
+#include "base/hinic3_eqs.h"=0D
+#include "base/hinic3_cmdq.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "base/hinic3_hwif.h"=0D
+#include "base/hinic3_hw_cfg.h"=0D
+#include "base/hinic3_hw_comm.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "base/hinic3_nic_event.h"=0D
+#include "hinic3_ethdev.h"=0D
+=0D
+/**=0D
+ * Interrupt handler triggered by NIC for handling specific event.=0D
+ *=0D
+ * @param[in] param=0D
+ * The address of parameter (struct rte_eth_dev *) registered before.=0D
+ */=0D
+static void=0D
+hinic3_dev_interrupt_handler(void *param)=0D
+{=0D
+	struct rte_eth_dev *dev =3D param;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (!hinic3_get_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status)) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "Intr is disabled, ignore intr event, "=0D
+			    "dev_name: %s, port_id: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id);=0D
+		return;=0D
+	}=0D
+=0D
+	/* Aeq0 msg handler. */=0D
+	hinic3_dev_handle_aeq_event(nic_dev->hwdev, param);=0D
+}=0D
+=0D
+static void=0D
+hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	rte_free(nic_dev->txqs);=0D
+	nic_dev->txqs =3D NULL;=0D
+=0D
+	rte_free(nic_dev->rxqs);=0D
+	nic_dev->rxqs =3D NULL;=0D
+}=0D
+=0D
+/**=0D
+ * Init mac_vlan table in hardwares.=0D
+ *=0D
+ * @param[in] eth_dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_init_mac_table(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	u8 addr_bytes[RTE_ETHER_ADDR_LEN];=0D
+	u16 func_id =3D 0;=0D
+	int err =3D 0;=0D
+=0D
+	err =3D hinic3_get_default_mac(nic_dev->hwdev, addr_bytes,=0D
+				     RTE_ETHER_ADDR_LEN);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rte_ether_addr_copy((struct rte_ether_addr *)addr_bytes,=0D
+			    &eth_dev->data->mac_addrs[0]);=0D
+	if (rte_is_zero_ether_addr(&eth_dev->data->mac_addrs[0]))=0D
+		rte_eth_random_addr(eth_dev->data->mac_addrs[0].addr_bytes);=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+	err =3D hinic3_set_mac(nic_dev->hwdev,=0D
+			     eth_dev->data->mac_addrs[0].addr_bytes, 0,=0D
+			     func_id);=0D
+	if (err && err !=3D HINIC3_PF_SET_VF_ALREADY)=0D
+		return err;=0D
+=0D
+	rte_ether_addr_copy(&eth_dev->data->mac_addrs[0],=0D
+			    &nic_dev->default_addr);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Deinit mac_vlan table in hardware.=0D
+ *=0D
+ * @param[in] eth_dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+static void=0D
+hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	u16 func_id =3D 0;=0D
+	int err;=0D
+	int i;=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	for (i =3D 0; i < HINIC3_MAX_UC_MAC_ADDRS; i++) {=0D
+		if (rte_is_zero_ether_addr(&eth_dev->data->mac_addrs[i]))=0D
+			continue;=0D
+=0D
+		err =3D hinic3_del_mac(nic_dev->hwdev,=0D
+				     eth_dev->data->mac_addrs[i].addr_bytes, 0,=0D
+				     func_id);=0D
+		if (err && err !=3D HINIC3_PF_SET_VF_ALREADY)=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Delete mac table failed, dev_name: %s",=0D
+				    eth_dev->data->name);=0D
+=0D
+		memset(&eth_dev->data->mac_addrs[i], 0,=0D
+		       sizeof(struct rte_ether_addr));=0D
+	}=0D
+=0D
+	/* Delete multicast mac addrs. */=0D
+	hinic3_delete_mc_addr_list(nic_dev);=0D
+}=0D
+=0D
+/**=0D
+ * Check the valid CoS bitmap to determine the available CoS IDs and set=0D
+ * the default CoS ID to the highest valid one.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[out] cos_id=0D
+ * Pointer to store the default CoS ID.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, u8 *cos_id)=0D
+{=0D
+	u8 default_cos =3D 0;=0D
+	u8 valid_cos_bitmap;=0D
+	u8 i;=0D
+=0D
+	valid_cos_bitmap =3D hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;=0D
+	if (!valid_cos_bitmap) {=0D
+		PMD_DRV_LOG(ERR, "PF has none cos to support");=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	for (i =3D 0; i < HINIC3_COS_NUM_MAX; i++) {=0D
+		if (valid_cos_bitmap & BIT(i))=0D
+			/* Find max cos id as default cos. */=0D
+			default_cos =3D i;=0D
+	}=0D
+=0D
+	*cos_id =3D default_cos;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	u8 cos_id =3D 0;=0D
+	int err;=0D
+=0D
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {=0D
+		err =3D hinic3_pf_get_default_cos(nic_dev->hwdev, &cos_id);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Get PF default cos failed, err: %d",=0D
+				    err);=0D
+			return err;=0D
+		}=0D
+	} else {=0D
+		err =3D hinic3_vf_get_default_cos(nic_dev->hwdev, &cos_id);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Get VF default cos failed, err: %d",=0D
+				    err);=0D
+			return err;=0D
+		}=0D
+	}=0D
+=0D
+	nic_dev->default_cos =3D cos_id;=0D
+	PMD_DRV_LOG(INFO, "Default cos %d", nic_dev->default_cos);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize Class of Service (CoS). For PF devices, it also sync the lin=
k=0D
+ * status with the physical port.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_set_default_hw_feature(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_init_default_cos(nic_dev);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	if (hinic3_func_type(nic_dev->hwdev) =3D=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	err =3D hinic3_set_link_status_follow(nic_dev->hwdev,=0D
+					    HINIC3_LINK_FOLLOW_PORT);=0D
+	if (err =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED)=0D
+		PMD_DRV_LOG(WARNING, "Don't support to set link status follow "=0D
+				     "phy port status");=0D
+	else if (err)=0D
+		return err;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize the network function, including hardware configuration, memo=
ry=0D
+ * allocation for data structures, MAC address setup, and interrupt enabli=
ng.=0D
+ * It also registers interrupt callbacks and sets default hardware feature=
s.=0D
+ * If any step fails, appropriate cleanup is performed.=0D
+ *=0D
+ * @param[out] eth_dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	struct rte_pci_device *pci_dev =3D NULL;=0D
+	int err;=0D
+=0D
+	pci_dev =3D RTE_ETH_DEV_TO_PCI(eth_dev);=0D
+=0D
+	/* EAL is secondary and eth_dev is already created. */=0D
+	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY) {=0D
+		PMD_DRV_LOG(INFO, "Initialize %s in secondary process",=0D
+			    eth_dev->data->name);=0D
+=0D
+		return 0;=0D
+	}=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	memset(nic_dev, 0, sizeof(*nic_dev));=0D
+	snprintf(nic_dev->dev_name, sizeof(nic_dev->dev_name),=0D
+		     "dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,=0D
+		     pci_dev->addr.bus, pci_dev->addr.devid,=0D
+		     pci_dev->addr.function);=0D
+=0D
+	/* Alloc mac_addrs. */=0D
+	eth_dev->data->mac_addrs =3D rte_zmalloc("hinic3_mac",=0D
+		HINIC3_MAX_UC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);=0D
+	if (!eth_dev->data->mac_addrs) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Allocate %zx bytes to store MAC addresses "=0D
+			    "failed, dev_name: %s",=0D
+			    HINIC3_MAX_UC_MAC_ADDRS *=0D
+				    sizeof(struct rte_ether_addr),=0D
+			    eth_dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_eth_addr_fail;=0D
+	}=0D
+=0D
+	nic_dev->mc_list =3D rte_zmalloc("hinic3_mc",=0D
+		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);=0D
+	if (!nic_dev->mc_list) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Allocate %zx bytes to store multicast "=0D
+			    "addresses failed, dev_name: %s",=0D
+			    HINIC3_MAX_MC_MAC_ADDRS *=0D
+				    sizeof(struct rte_ether_addr),=0D
+			    eth_dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_mc_list_fail;=0D
+	}=0D
+=0D
+	/* Create hardware device. */=0D
+	nic_dev->hwdev =3D rte_zmalloc("hinic3_hwdev", sizeof(*nic_dev->hwdev),=0D
+				     RTE_CACHE_LINE_SIZE);=0D
+	if (!nic_dev->hwdev) {=0D
+		PMD_DRV_LOG(ERR, "Allocate hwdev memory failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_hwdev_mem_fail;=0D
+	}=0D
+	nic_dev->hwdev->pci_dev =3D RTE_ETH_DEV_TO_PCI(eth_dev);=0D
+	nic_dev->hwdev->dev_handle =3D nic_dev;=0D
+	nic_dev->hwdev->eth_dev =3D eth_dev;=0D
+	nic_dev->hwdev->port_id =3D eth_dev->data->port_id;=0D
+=0D
+	err =3D hinic3_init_hwdev(nic_dev->hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init chip hwdev failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_hwdev_fail;=0D
+	}=0D
+=0D
+	nic_dev->max_sqs =3D hinic3_func_max_sqs(nic_dev->hwdev);=0D
+	nic_dev->max_rqs =3D hinic3_func_max_rqs(nic_dev->hwdev);=0D
+=0D
+	err =3D hinic3_init_nic_hwdev(nic_dev->hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init nic hwdev failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_nic_hwdev_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_get_feature_from_hw(nic_dev->hwdev, &nic_dev->feature_cap,=
=0D
+					 1);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Get nic feature from hardware failed, dev_name: %s",=0D
+			eth_dev->data->name);=0D
+		goto get_cap_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_sw_rxtxqs(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_sw_rxtxqs_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_mac_table(eth_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init mac table failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_mac_table_fail;=0D
+	}=0D
+=0D
+	/* Set hardware feature to default status. */=0D
+	err =3D hinic3_set_default_hw_feature(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set hw default features failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto set_default_feature_fail;=0D
+	}=0D
+=0D
+	/* Register callback func to eal lib. */=0D
+	err =3D rte_intr_callback_register(PCI_DEV_TO_INTR_HANDLE(pci_dev),=0D
+					 hinic3_dev_interrupt_handler,=0D
+					 (void *)eth_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Register intr callback failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto reg_intr_cb_fail;=0D
+	}=0D
+=0D
+	/* Enable uio/vfio intr/eventfd mapping. */=0D
+	err =3D rte_intr_enable(PCI_DEV_TO_INTR_HANDLE(pci_dev));=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Enable rte interrupt failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto enable_intr_fail;=0D
+	}=0D
+	tcam_info =3D &nic_dev->tcam;=0D
+	memset(tcam_info, 0, sizeof(struct hinic3_tcam_info));=0D
+	TAILQ_INIT(&tcam_info->tcam_list);=0D
+	TAILQ_INIT(&tcam_info->tcam_dynamic_info.tcam_dynamic_list);=0D
+	TAILQ_INIT(&nic_dev->filter_ethertype_list);=0D
+	TAILQ_INIT(&nic_dev->filter_fdir_rule_list);=0D
+=0D
+	hinic3_mutex_init(&nic_dev->rx_mode_mutex, NULL);=0D
+=0D
+	hinic3_set_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status);=0D
+=0D
+	hinic3_set_bit(HINIC3_DEV_INIT, &nic_dev->dev_status);=0D
+	PMD_DRV_LOG(INFO, "Initialize %s in primary succeed",=0D
+		    eth_dev->data->name);=0D
+=0D
+	/**=0D
+	 * Queue xstats filled automatically by ethdev layer.=0D
+	 */=0D
+	eth_dev->data->dev_flags |=3D RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;=0D
+=0D
+	return 0;=0D
+=0D
+enable_intr_fail:=0D
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),=0D
+					hinic3_dev_interrupt_handler,=0D
+					(void *)eth_dev);=0D
+=0D
+reg_intr_cb_fail:=0D
+set_default_feature_fail:=0D
+	hinic3_deinit_mac_addr(eth_dev);=0D
+=0D
+init_mac_table_fail:=0D
+	hinic3_deinit_sw_rxtxqs(nic_dev);=0D
+=0D
+init_sw_rxtxqs_fail:=0D
+	hinic3_free_nic_hwdev(nic_dev->hwdev);=0D
+=0D
+get_cap_fail:=0D
+init_nic_hwdev_fail:=0D
+	hinic3_free_hwdev(nic_dev->hwdev);=0D
+	eth_dev->dev_ops =3D NULL;=0D
+	eth_dev->rx_queue_count =3D NULL;=0D
+	eth_dev->rx_descriptor_status =3D NULL;=0D
+	eth_dev->tx_descriptor_status =3D NULL;=0D
+=0D
+init_hwdev_fail:=0D
+	rte_free(nic_dev->hwdev);=0D
+	nic_dev->hwdev =3D NULL;=0D
+=0D
+alloc_hwdev_mem_fail:=0D
+	rte_free(nic_dev->mc_list);=0D
+	nic_dev->mc_list =3D NULL;=0D
+=0D
+alloc_mc_list_fail:=0D
+	rte_free(eth_dev->data->mac_addrs);=0D
+	eth_dev->data->mac_addrs =3D NULL;=0D
+=0D
+alloc_eth_addr_fail:=0D
+	PMD_DRV_LOG(ERR, "Initialize %s in primary failed",=0D
+		    eth_dev->data->name);=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct rte_pci_device *pci_dev;=0D
+=0D
+	pci_dev =3D RTE_ETH_DEV_TO_PCI(eth_dev);=0D
+=0D
+	PMD_DRV_LOG(INFO, "Initializing %.4x:%.2x:%.2x.%x in %s process",=0D
+		    pci_dev->addr.domain, pci_dev->addr.bus,=0D
+		    pci_dev->addr.devid, pci_dev->addr.function,=0D
+		    (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) ? "primary"=0D
+								 : "secondary");=0D
+=0D
+	PMD_DRV_LOG(INFO, "Network Interface pmd driver version: %s",=0D
+		    HINIC3_PMD_DRV_VERSION);=0D
+=0D
+	return hinic3_func_init(eth_dev);=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_uninit(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	hinic3_clear_bit(HINIC3_DEV_INIT, &nic_dev->dev_status);=0D
+=0D
+	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)=0D
+		return 0;=0D
+=0D
+	return hinic3_dev_close(dev);=0D
+}=0D
+=0D
+static const struct rte_pci_id pci_id_hinic3_map[] =3D {=0D
+#ifdef CONFIG_SP_VID_DID=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_STANDARD)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_VF)},=0D
+#else=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_STANDARD)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF)},=0D
+#endif=0D
+=0D
+	{.vendor_id =3D 0},=0D
+};=0D
+=0D
+static int=0D
+hinic3_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,=0D
+		 struct rte_pci_device *pci_dev)=0D
+{=0D
+	return rte_eth_dev_pci_generic_probe(pci_dev,=0D
+		sizeof(struct hinic3_nic_dev), hinic3_dev_init);=0D
+}=0D
+=0D
+static int=0D
+hinic3_pci_remove(struct rte_pci_device *pci_dev)=0D
+{=0D
+	return rte_eth_dev_pci_generic_remove(pci_dev, hinic3_dev_uninit);=0D
+}=0D
+=0D
+static struct rte_pci_driver rte_hinic3_pmd =3D {=0D
+	.id_table =3D pci_id_hinic3_map,=0D
+	.drv_flags =3D RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,=0D
+	.probe =3D hinic3_pci_probe,=0D
+	.remove =3D hinic3_pci_remove,=0D
+};=0D
+=0D
+RTE_PMD_REGISTER_PCI(net_hinic3, rte_hinic3_pmd);=0D
+RTE_PMD_REGISTER_PCI_TABLE(net_hinic3, pci_id_hinic3_map);=0D
+=0D
+RTE_INIT(hinic3_init_log)=0D
+{=0D
+	hinic3_logtype =3D rte_log_register("pmd.net.hinic3");=0D
+	if (hinic3_logtype >=3D 0)=0D
+		rte_log_set_level(hinic3_logtype, RTE_LOG_INFO);=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
new file mode 100644=0D
index 0000000000..e0d5b4602c=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -0,0 +1,119 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_ETHDEV_H_=0D
+#define _HINIC3_ETHDEV_H_=0D
+=0D
+#include <rte_ethdev.h>=0D
+#include <rte_ethdev_core.h>=0D
+=0D
+#define HINIC3_PMD_DRV_VERSION "B106"=0D
+=0D
+#define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)=0D
+=0D
+#define HINIC3_PKT_RX_L4_CKSUM_BAD     RTE_MBUF_F_RX_L4_CKSUM_BAD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_BAD     RTE_MBUF_F_RX_IP_CKSUM_BAD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN=0D
+#define HINIC3_PKT_RX_L4_CKSUM_GOOD    RTE_MBUF_F_RX_L4_CKSUM_GOOD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_GOOD    RTE_MBUF_F_RX_IP_CKSUM_GOOD=0D
+#define HINIC3_PKT_TX_TCP_SEG	       RTE_MBUF_F_TX_TCP_SEG=0D
+#define HINIC3_PKT_TX_UDP_CKSUM	       RTE_MBUF_F_TX_UDP_CKSUM=0D
+#define HINIC3_PKT_TX_TCP_CKSUM	       RTE_MBUF_F_TX_TCP_CKSUM=0D
+#define HINIC3_PKT_TX_IP_CKSUM	       RTE_MBUF_F_TX_IP_CKSUM=0D
+#define HINIC3_PKT_TX_VLAN_PKT	       RTE_MBUF_F_TX_VLAN=0D
+#define HINIC3_PKT_TX_L4_MASK	       RTE_MBUF_F_TX_L4_MASK=0D
+#define HINIC3_PKT_TX_SCTP_CKSUM       RTE_MBUF_F_TX_SCTP_CKSUM=0D
+#define HINIC3_PKT_TX_IPV6	       RTE_MBUF_F_TX_IPV6=0D
+#define HINIC3_PKT_TX_IPV4	       RTE_MBUF_F_TX_IPV4=0D
+#define HINIC3_PKT_RX_VLAN	       RTE_MBUF_F_RX_VLAN=0D
+#define HINIC3_PKT_RX_VLAN_STRIPPED    RTE_MBUF_F_RX_VLAN_STRIPPED=0D
+#define HINIC3_PKT_RX_RSS_HASH	       RTE_MBUF_F_RX_RSS_HASH=0D
+#define HINIC3_PKT_TX_TUNNEL_MASK      RTE_MBUF_F_TX_TUNNEL_MASK=0D
+#define HINIC3_PKT_TX_TUNNEL_VXLAN     RTE_MBUF_F_TX_TUNNEL_VXLAN=0D
+#define HINIC3_PKT_TX_OUTER_IP_CKSUM   RTE_MBUF_F_TX_OUTER_IP_CKSUM=0D
+#define HINIC3_PKT_TX_OUTER_IPV6       RTE_MBUF_F_TX_OUTER_IPV6=0D
+#define HINIC3_PKT_RX_LRO	       RTE_MBUF_F_RX_LRO=0D
+#define HINIC3_PKT_TX_L4_NO_CKSUM      RTE_MBUF_F_TX_L4_NO_CKSUM=0D
+=0D
+#define HINCI3_CPY_MEMPOOL_NAME "cpy_mempool"=0D
+/* Mbuf pool for copy invalid mbuf segs. */=0D
+#define HINIC3_COPY_MEMPOOL_DEPTH 1024=0D
+#define HINIC3_COPY_MEMPOOL_CACHE 128=0D
+#define HINIC3_COPY_MBUF_SIZE	  4096=0D
+=0D
+#define HINIC3_DEV_NAME_LEN 32=0D
+#define DEV_STOP_DELAY_MS   100=0D
+#define DEV_START_DELAY_MS  100=0D
+=0D
+#define HINIC3_UINT32_BIT_SIZE (CHAR_BIT * sizeof(uint32_t))=0D
+#define HINIC3_VFTA_SIZE       (4096 / HINIC3_UINT32_BIT_SIZE)=0D
+#define HINIC3_MAX_QUEUE_NUM   64=0D
+=0D
+#define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \=0D
+	((struct hinic3_nic_dev *)(dev)->data->dev_private)=0D
+=0D
+enum hinic3_dev_status {=0D
+	HINIC3_DEV_INIT,=0D
+	HINIC3_DEV_CLOSE,=0D
+	HINIC3_DEV_START,=0D
+	HINIC3_DEV_INTR_EN=0D
+};=0D
+=0D
+enum hinic3_tx_cvlan_type {=0D
+	HINIC3_TX_TPID0,=0D
+};=0D
+=0D
+enum nic_feature_cap {=0D
+	NIC_F_CSUM =3D BIT(0),=0D
+	NIC_F_SCTP_CRC =3D BIT(1),=0D
+	NIC_F_TSO =3D BIT(2),=0D
+	NIC_F_LRO =3D BIT(3),=0D
+	NIC_F_UFO =3D BIT(4),=0D
+	NIC_F_RSS =3D BIT(5),=0D
+	NIC_F_RX_VLAN_FILTER =3D BIT(6),=0D
+	NIC_F_RX_VLAN_STRIP =3D BIT(7),=0D
+	NIC_F_TX_VLAN_INSERT =3D BIT(8),=0D
+	NIC_F_VXLAN_OFFLOAD =3D BIT(9),=0D
+	NIC_F_IPSEC_OFFLOAD =3D BIT(10),=0D
+	NIC_F_FDIR =3D BIT(11),=0D
+	NIC_F_PROMISC =3D BIT(12),=0D
+	NIC_F_ALLMULTI =3D BIT(13),=0D
+};=0D
+=0D
+#define DEFAULT_DRV_FEATURE 0x3FFF=0D
+=0D
+struct hinic3_nic_dev {=0D
+	struct hinic3_hwdev *hwdev; /**< Hardware device. */=0D
+	struct hinic3_txq **txqs;=0D
+	struct hinic3_rxq **rxqs;=0D
+	struct rte_mempool *cpy_mpool;=0D
+=0D
+	u16 num_sqs;=0D
+	u16 num_rqs;=0D
+	u16 max_sqs;=0D
+	u16 max_rqs;=0D
+=0D
+	u16 rx_buff_len;=0D
+	u16 mtu_size;=0D
+=0D
+	u32 rx_mode;=0D
+	u8 rx_queue_list[HINIC3_MAX_QUEUE_NUM];=0D
+	rte_spinlock_t queue_list_lock;=0D
+=0D
+	pthread_mutex_t rx_mode_mutex;=0D
+=0D
+	u32 default_cos;=0D
+	u32 rx_csum_en;=0D
+=0D
+	RTE_ATOMIC(u64) dev_status;=0D
+=0D
+	struct rte_ether_addr default_addr;=0D
+	struct rte_ether_addr *mc_list;=0D
+=0D
+	char dev_name[HINIC3_DEV_NAME_LEN];=0D
+	u64 feature_cap;=0D
+	u32 vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */=0D
+};=0D
+=0D
+#endif /* _HINIC3_ETHDEV_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

