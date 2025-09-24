Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FCCCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:55:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0221440DD3;
	Wed, 24 Sep 2025 09:53:58 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0828D40A7D
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=dr7UMm0yjH4UfKkPPoy5/8EtnNsFcFeir7ciLHfsxC0=;
 b=N2ayesffEwfr6ZWHbkv/rzAx3Z6fj9WVqeqWi0sGT2Hbr1IVlSMekcGhmim+pl
 xXHRSfEgmI7PHdwW1C+0DW+JCAwIz0wZEODSFTBcbQmLxwPeFYQQOZ9F9yAJTJ2v
 8It5D7Nn4ozqyTg0P/Eyt7RO4KghqwJUy7pbtEAzAb6oo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S18;
 Wed, 24 Sep 2025 15:53:49 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [V13 14/18] net/hinic3: add device initialization
Date: Wed, 24 Sep 2025 15:52:01 +0800
Message-ID: <20250924075216.18750-15-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250924075216.18750-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250924075216.18750-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S18
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4rKr1ftr4xXFWUury5CFg_yoWfAFyrpa
 y5Was5JrZrJr47Aws5tw4xuFy5Za1Sq34UKr93C3WY9w45Zr1q9ryxtr47AFZ5t39rZF47
 uF4kCayqvr1jg3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbPEhUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHh7SCmjTYNHWFgAAsS
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

Add device initializationd function codes.

Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 273 +++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 1846f55183..d88f049332 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2871,3 +2871,276 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 };
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
+		"dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,
+		pci_dev->addr.bus, pci_dev->addr.devid,
+		pci_dev->addr.function);
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
+	if (HINIC3_FUNC_TYPE(nic_dev->hwdev) == TYPE_VF)
+		eth_dev->dev_ops = &hinic3_pmd_vf_ops;
+	else
+		eth_dev->dev_ops = &hinic3_pmd_ops;
+
+	err = hinic3_init_nic_hwdev(nic_dev->hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init nic hwdev failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_nic_hwdev_fail;
+	}
+
+	err = hinic3_get_feature_from_hw(nic_dev->hwdev, &nic_dev->feature_cap, 1);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Get nic feature from hardware failed, dev_name: %s",
+			    eth_dev->data->name);
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
+	PMD_DRV_LOG(DEBUG, "Initialize %s in primary succeed",
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
+				     hinic3_dev_interrupt_handler,
+				     (void *)eth_dev);
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
+	PMD_DRV_LOG(DEBUG, "Network Interface pmd driver version: %s",
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
-- 
2.47.0.windows.2

