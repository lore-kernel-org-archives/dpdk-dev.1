Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A41CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 09:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7260F40666;
	Fri,  8 May 2026 11:29:12 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 60F19402E8
 for <dev@dpdk.org>; Fri,  8 May 2026 11:29:08 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=OcYAMnOrLyP9JnTe7tUNplwMmYR2OPhLDsJObzXMxpQ=;
 b=KLBiNIobKWOKFVwZYw75P47tyGjAWMjAjtqpBOu628AzGkXueFLIRg2N87nsCfJ9kMnF1MJwf
 ZEuwQl8OJ70UaH//ENjNcDmtuxKObN0Xcz3wHSeVEY2CTlyaMvJPJJnwDT/TQPcG80TnpjZU+48
 ZpuNlYDMZ6U2btYmrgSMS+k=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gBkCT2CDGz12LD1;
 Fri,  8 May 2026 17:21:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6327E40538;
 Fri,  8 May 2026 17:29:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 17:29:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: [PATCH v1 3/4] net/e1000: add cache stash support via TPH
Date: Fri, 8 May 2026 17:28:54 +0800
Message-ID: <20260508092855.51987-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Implement ethdev generic cache stash operations for igb PMD
using PCIe TPH (Transaction Processing Hints) as the underlying
mechanism.

The implementation supports:
- Query TPH based stash capabilities
- Device-level global enable/disable of TPH
- Per-queue TPH stashing configuration with target lcore
- Configure stashing objects (Rx descriptor, payload, etc.)

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h |   2 +
 drivers/net/intel/e1000/base/e1000_vf.h |   2 +
 drivers/net/intel/e1000/igb_ethdev.c    | 221 ++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 9b1fafd75c..3e8e21b194 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1092,6 +1092,8 @@ struct e1000_hw {
 	u16 vendor_id;
 
 	u8  revision_id;
+
+	u8 tph_mode;
 };
 
 #include "e1000_82541.h"
diff --git a/drivers/net/intel/e1000/base/e1000_vf.h b/drivers/net/intel/e1000/base/e1000_vf.h
index 4bec21c935..dd3cef254e 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.h
+++ b/drivers/net/intel/e1000/base/e1000_vf.h
@@ -248,6 +248,8 @@ struct e1000_hw {
 	u16 vendor_id;
 
 	u8  revision_id;
+
+	u8 tph_mode;
 };
 
 enum e1000_promisc_type {
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index ef1599ac38..7aea37d017 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -241,6 +241,10 @@ static int igb_tx_burst_mode_get(struct rte_eth_dev *dev,
 	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
 static int igb_rx_burst_mode_get(struct rte_eth_dev *dev,
 	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+static int eth_igb_cache_stash_get(struct rte_eth_dev *dev,
+				   struct rte_eth_cache_stash_capability *capa);
+static int eth_igb_cache_stash_set(struct rte_eth_dev *dev, enum rte_eth_cache_stash_op op,
+				   struct rte_eth_cache_stash_config *config);
 
 /*
  * Define VF Stats MACRO for Non "cleared on read" register
@@ -402,6 +406,8 @@ static const struct eth_dev_ops eth_igb_ops = {
 	.timesync_read_time   = igb_timesync_read_time,
 	.timesync_write_time  = igb_timesync_write_time,
 	.read_clock		      = eth_igb_read_clock,
+	.cache_stash_get      = eth_igb_cache_stash_get,
+	.cache_stash_set      = eth_igb_cache_stash_set,
 };
 
 /*
@@ -5692,6 +5698,221 @@ igb_filter_restore(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+eth_igb_cache_stash_get(struct rte_eth_dev *dev, struct rte_eth_cache_stash_capability *capa)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	uint32_t support_modes, st_table_sz;
+	int ret;
+
+	ret = rte_pci_tph_query(pci_dev, &support_modes, &st_table_sz);
+	if (ret != 0)
+		return -ENOTSUP;
+	capa->supported_types = RTE_ETH_CACHE_STASH_TYPE_TPH;
+	capa->supported_objects = RTE_ETH_CACHE_STASH_OBJ_RX_DESC |
+				  RTE_ETH_CACHE_STASH_OBJ_RX_HEADER |
+				  RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD |
+				  RTE_ETH_CACHE_STASH_OBJ_TX_DESC |
+				  RTE_ETH_CACHE_STASH_OBJ_TX_HEADER |
+				  RTE_ETH_CACHE_STASH_OBJ_TX_PAYLOAD;
+	return 0;
+}
+
+static int
+eth_igb_cache_stash_dev_enable(struct rte_eth_dev *dev,
+			       struct rte_eth_cache_stash_config *config)
+{
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	uint32_t support_modes, st_table_sz;
+	uint32_t mode;
+	int ret;
+
+	if (hw->tph_mode != 0) {
+		PMD_DRV_LOG(ERR, "Already enable tph_mode=%u", hw->tph_mode);
+		return -EINVAL;
+	}
+
+	if (config->dev.type != RTE_ETH_CACHE_STASH_TYPE_TPH) {
+		PMD_DRV_LOG(ERR, "Unsupported stash type=%u!", config->dev.type);
+		return -ENOTSUP;
+	}
+
+	ret = rte_pci_tph_query(pci_dev, &support_modes, &st_table_sz);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Query TPH failed! ret=%d", ret);
+		return -ENOTSUP;
+	}
+
+	if (support_modes & RTE_PCI_TPH_MODE_IV)
+		mode = RTE_PCI_TPH_MODE_IV;
+	else if (support_modes & RTE_PCI_TPH_MODE_DS)
+		mode = RTE_PCI_TPH_MODE_DS;
+	else
+		return -ENOTSUP;
+	ret = rte_pci_tph_enable(pci_dev, mode);
+	if (ret == 0)
+		hw->tph_mode = mode;
+
+	return ret;
+}
+
+static void
+eth_igb_cache_stash_dev_clear(struct rte_eth_dev *dev)
+{
+	uint32_t nb_queues = RTE_MAX(dev->data->nb_rx_queues, dev->data->nb_tx_queues);
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_tph_entry ent = {0};
+	uint32_t reg;
+	uint32_t i;
+
+	for (i = 0; i < nb_queues; i++) {
+		ent.cpu = UINT32_MAX;
+		ent.index = i;
+		rte_pci_tph_st_set(pci_dev, &ent, 1);
+		reg = E1000_READ_REG(hw, E1000_RXCTL(i));
+		reg &= ~RTE_BIT32(0);
+		reg &= ~RTE_BIT32(1);
+		reg &= ~RTE_BIT32(2);
+		reg &= ~RTE_BIT32(3);
+		reg &= ~RTE_SHIFT_VAL32(0xFF, 24);
+		E1000_WRITE_REG(hw, E1000_RXCTL(i), reg);
+	}
+}
+
+static int
+eth_igb_cache_stash_dev_disable(struct rte_eth_dev *dev)
+{
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	int ret;
+
+	if (hw->tph_mode == 0) {
+		PMD_DRV_LOG(ERR, "Already disable TPH!");
+		return -EINVAL;
+	}
+
+	eth_igb_cache_stash_dev_clear(dev);
+	ret = rte_pci_tph_disable(pci_dev);
+	if (ret == 0)
+		hw->tph_mode = 0;
+
+	return ret;
+}
+
+static int
+eth_igb_cache_stash_queue_enable(struct rte_eth_dev *dev,
+				 struct rte_eth_cache_stash_config *config)
+{
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	uint32_t queue_id = config->queue.queue_id;
+	struct rte_pci_tph_entry ent = {0};
+	uint32_t reg;
+	uint16_t st;
+	int ret;
+
+	if (hw->tph_mode == 0) {
+		PMD_DRV_LOG(ERR, "Device TPH was not enabled!");
+		return -EINVAL;
+	}
+
+	if (queue_id > RTE_MAX(dev->data->nb_rx_queues, dev->data->nb_tx_queues)) {
+		PMD_DRV_LOG(ERR, "Invalid queue_id when enable stash!");
+		return -EINVAL;
+	}
+
+	ent.cpu = config->queue.lcore_id;
+	ent.index = queue_id;
+	ret = rte_pci_tph_st_get(pci_dev, &ent, 1);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Failed to get device queue=%u st of cpu=%u ret=%u",
+			    queue_id, config->queue.lcore_id, ret);
+		return ret;
+	}
+	st = ent.st;
+
+	reg = E1000_READ_REG(hw, E1000_RXCTL(queue_id));
+	PMD_DRV_LOG(DEBUG, "[Enable] Queue=%u rxctl register init val=0x%x", queue_id, reg);
+	if (config->queue.objects & RTE_ETH_CACHE_STASH_OBJ_RX_DESC) {
+		reg |= RTE_BIT32(0);
+		reg |= RTE_BIT32(1);
+	} else {
+		reg &= ~RTE_BIT32(0);
+		reg &= ~RTE_BIT32(1);
+	}
+	if (config->queue.objects & RTE_ETH_CACHE_STASH_OBJ_RX_HEADER)
+		reg |= RTE_BIT32(2);
+	else
+		reg &= ~RTE_BIT32(2);
+	if (config->queue.objects & RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD)
+		reg |= RTE_BIT32(3);
+	else
+		reg &= ~RTE_BIT32(3);
+	/* I350 must encoding st in high 8bit, and ST in config-space is no needed! */
+	reg |= RTE_SHIFT_VAL32(st, 24);
+	E1000_WRITE_REG(hw, E1000_RXCTL(queue_id), reg);
+	PMD_DRV_LOG(DEBUG, "[Enable] Queue=%u rxctl register after val=0x%x", queue_id, reg);
+
+	PMD_DRV_LOG(DEBUG, "[Enable] Enable device queue=%u st of cpu=%u success!",
+			    queue_id, config->queue.lcore_id);
+
+	return 0;
+}
+
+static int
+eth_igb_cache_stash_queue_disable(struct rte_eth_dev *dev,
+				  struct rte_eth_cache_stash_config *config)
+{
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint32_t queue_id = config->queue.queue_id;
+	uint32_t reg;
+
+	if (hw->tph_mode == 0) {
+		PMD_DRV_LOG(ERR, "Device TPH was not enabled!");
+		return -EINVAL;
+	}
+
+	if (queue_id > RTE_MAX(dev->data->nb_rx_queues, dev->data->nb_tx_queues)) {
+		PMD_DRV_LOG(ERR, "Invalid queue_id when enable stash!");
+		return -EINVAL;
+	}
+
+	reg = E1000_READ_REG(hw, E1000_RXCTL(queue_id));
+	PMD_DRV_LOG(DEBUG, "[Disable] Queue=%u rxctl register init val=0x%x", queue_id, reg);
+	reg &= ~RTE_BIT32(0);
+	reg &= ~RTE_BIT32(1);
+	reg &= ~RTE_BIT32(2);
+	reg &= ~RTE_BIT32(3);
+	reg &= ~RTE_SHIFT_VAL32(0xFF, 24);
+	E1000_WRITE_REG(hw, E1000_RXCTL(queue_id), reg);
+	PMD_DRV_LOG(DEBUG, "[Disable] Queue=%u rxctl register after val=0x%x", queue_id, reg);
+
+	PMD_DRV_LOG(DEBUG, "[Disable] disable device queue=%u st of cpu=%u success!",
+			    queue_id, config->queue.lcore_id);
+
+	return 0;
+}
+
+static int
+eth_igb_cache_stash_set(struct rte_eth_dev *dev, enum rte_eth_cache_stash_op op,
+			struct rte_eth_cache_stash_config *config)
+{
+	switch (op) {
+	case RTE_ETH_CACHE_STASH_OP_DEV_ENABLE:
+		return eth_igb_cache_stash_dev_enable(dev, config);
+	case RTE_ETH_CACHE_STASH_OP_DEV_DISABLE:
+		return eth_igb_cache_stash_dev_disable(dev);
+	case RTE_ETH_CACHE_STASH_OP_QUEUE_ENABLE:
+		return eth_igb_cache_stash_queue_enable(dev, config);
+	case RTE_ETH_CACHE_STASH_OP_QUEUE_DISABLE:
+		return eth_igb_cache_stash_queue_disable(dev, config);
+	default:
+		return -ENOTSUP;
+	}
+}
+
 RTE_PMD_REGISTER_PCI(net_e1000_igb, rte_igb_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_e1000_igb, pci_id_igb_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_e1000_igb, "* igb_uio | uio_pci_generic | vfio-pci");
-- 
2.17.1

