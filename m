Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA076C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 22:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F18E40662;
	Tue,  3 Jun 2025 00:38:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4171940281
 for <dev@dpdk.org>; Tue,  3 Jun 2025 00:38:15 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EC3293B;
 Mon,  2 Jun 2025 15:37:58 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 955DA3F5A1;
 Mon,  2 Jun 2025 15:38:14 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, nd@arm.com, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v5 4/4] net/i40e: enable TPH in i40e
Date: Mon,  2 Jun 2025 22:38:04 +0000
Message-ID: <20250602223805.816816-5-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602223805.816816-1-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
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

Adds stashing_capabilities_get, stashing_{rx,tx}_hinst_set functions
to eth_dev_ops of the i40e driver. Enables TPH in device-specific
mode, so that steering-tags are set in LAN queue contexts.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 128 +++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 90eba3419f..326e323dfb 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -18,6 +18,7 @@
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_ether.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <rte_memzone.h>
@@ -410,6 +411,11 @@ static int i40e_fec_get_capability(struct rte_eth_dev *dev,
 	struct rte_eth_fec_capa *speed_fec_capa, unsigned int num);
 static int i40e_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
 static int i40e_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
+static int i40e_stashing_cap_get(struct rte_eth_dev *dev, uint16_t *objects);
+static int i40e_stashing_rx_hints_set(struct rte_eth_dev *dev, uint16_t queue_id,
+				     struct rte_eth_stashing_config *config);
+static int i40e_stashing_tx_hints_set(struct rte_eth_dev *dev, uint16_t queue_id,
+				     struct rte_eth_stashing_config *config);
 
 static const char *const valid_keys[] = {
 	ETH_I40E_FLOATING_VEB_ARG,
@@ -527,6 +533,9 @@ static const struct eth_dev_ops i40e_eth_dev_ops = {
 	.fec_get_capability           = i40e_fec_get_capability,
 	.fec_get                      = i40e_fec_get,
 	.fec_set                      = i40e_fec_set,
+	.stashing_capabilities_get    = i40e_stashing_cap_get,
+	.stashing_rx_hints_set        = i40e_stashing_rx_hints_set,
+	.stashing_tx_hints_set        = i40e_stashing_tx_hints_set,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -3878,6 +3887,7 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_CACHE_STASHING;
 
 	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
 						sizeof(uint32_t);
@@ -12544,6 +12554,124 @@ i40e_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa)
 	return 0;
 }
 
+static int
+i40e_stashing_cap_get(struct rte_eth_dev *dev, uint16_t *objects)
+{
+	RTE_SET_USED(dev);
+
+	*objects = RTE_ETH_DEV_STASH_OBJECT_DESC |
+		   RTE_ETH_DEV_STASH_OBJECT_HEADER |
+		   RTE_ETH_DEV_STASH_OBJECT_PAYLOAD;
+
+	return 0;
+}
+
+static int
+i40e_stashing_hints_set(struct rte_eth_dev *dev, uint16_t queue_id,
+			struct rte_eth_stashing_config *config,
+			enum i40e_hmc_lan_rsrc_type hmc_type)
+{
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	int err = I40E_SUCCESS;
+	struct i40e_hmc_obj_rxq rxq;
+	struct i40e_hmc_obj_txq txq;
+
+	if (!config) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	struct rte_tph_info tph = {
+		.cpu_id = config->lcore_id,
+		.cache_level = config->cache_level,
+		.flags = RTE_PCI_TPH_MEM_TYPE_VMEM | RTE_PCI_TPH_HINT_BIDIR,
+		.index = 0,
+	};
+
+	if (!pci_dev->tph_enabled)
+		err = rte_pci_tph_enable(pci_dev, RTE_PCI_TPH_CAP_ST_DS);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed enabling TPH");
+		goto out;
+	}
+
+	err = rte_pci_tph_st_get(pci_dev, &tph, 1);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed ST read for lcore: %u and cache-level: %u",
+			    tph.cpu_id, tph.cache_level);
+		goto out;
+	}
+
+	switch (hmc_type) {
+	case I40E_HMC_LAN_RX:
+		err = i40e_get_lan_rx_queue_context(hw, queue_id, &rxq);
+		if (err != I40E_SUCCESS) {
+			PMD_DRV_LOG(ERR, "Failed to get LAN RX queue context");
+			goto out;
+		}
+
+		rxq.cpuid = tph.st;
+
+		if (config->objects & RTE_ETH_DEV_STASH_OBJECT_DESC) {
+			rxq.tphrdesc_ena = 1;
+			rxq.tphwdesc_ena = 1;
+		}
+
+		if (config->objects & RTE_ETH_DEV_STASH_OBJECT_PAYLOAD)
+			rxq.tphdata_ena = 1;
+
+		if (config->objects & RTE_ETH_DEV_STASH_OBJECT_HEADER)
+			rxq.tphhead_ena = 1;
+
+		err = i40e_set_lan_rx_queue_context(hw, queue_id, &rxq);
+		if (err != I40E_SUCCESS)
+			PMD_DRV_LOG(ERR, "Failed to set LAN RX queue context");
+		break;
+	case I40E_HMC_LAN_TX:
+		err = i40e_get_lan_tx_queue_context(hw, queue_id, &txq);
+		if (err != I40E_SUCCESS) {
+			PMD_DRV_LOG(ERR, "Failed to get LAN TX queue context");
+			goto out;
+		}
+
+		txq.cpuid = tph.st;
+
+		if (config->objects & RTE_ETH_DEV_STASH_OBJECT_DESC) {
+			txq.tphrdesc_ena = 1;
+			txq.tphwdesc_ena = 1;
+		}
+
+		if (config->objects & (RTE_ETH_DEV_STASH_OBJECT_PAYLOAD |
+			       RTE_ETH_DEV_STASH_OBJECT_HEADER))
+			txq.tphrpacket_ena = 1;
+
+		err = i40e_set_lan_tx_queue_context(hw, queue_id, &txq);
+		if (err != I40E_SUCCESS)
+			PMD_DRV_LOG(ERR, "Failed to set LAN TX queue context");
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+out:
+	return err;
+}
+
+static int
+i40e_stashing_rx_hints_set(struct rte_eth_dev *dev, uint16_t queue_id,
+			  struct rte_eth_stashing_config *config)
+{
+	return i40e_stashing_hints_set(dev, queue_id, config, I40E_HMC_LAN_RX);
+}
+
+static int
+i40e_stashing_tx_hints_set(struct rte_eth_dev *dev, uint16_t queue_id,
+			  struct rte_eth_stashing_config *config)
+{
+	return i40e_stashing_hints_set(dev, queue_id, config, I40E_HMC_LAN_TX);
+}
+
 RTE_LOG_REGISTER_SUFFIX(i40e_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(i40e_logtype_driver, driver, NOTICE);
 #ifdef RTE_ETHDEV_DEBUG_RX
-- 
2.43.0

