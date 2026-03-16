Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE780F506D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:44:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C496140666;
	Mon, 16 Mar 2026 14:44:06 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id BBEF740613
 for <dev@dpdk.org>; Mon, 16 Mar 2026 14:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=hMGxSfecgHzaL4WHvYpcbWQsKynll1JFRJro2W6Dq/E=;
 b=ANWKw5ilc+AXXZs5/Jjmu4y9dlxe1kNCRxARngZGwDCQTQY+KFKDzYUiOnF+JW
 DywwX5ZQzO31zNKAiwQSvw7sFNvfLTiYXSGUmIV6eRF38XGuUfmMiP5ZLlMR8xeF
 gAdO4tx0DIKC1lbg9DAu07P2mJlixVFCB0Hxv4vZX/Hso=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAXOR4WCbhpaIrGAg--.46641S5;
 Mon, 16 Mar 2026 21:43:59 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V2 1/7] net/hinic3: add support for new SPx series NIC
Date: Mon, 16 Mar 2026 21:43:23 +0800
Message-ID: <20260316134335.1640-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260316134335.1640-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260316134335.1640-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgAXOR4WCbhpaIrGAg--.46641S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kXFyDGFWfKF1DJF15XFb_yoWrGF17pF
 1aka9rZr4UKr4jyw1kuw1DAF98J3WfG34jg34SvanY9F4UZF1Yv347GFW8ZrW5t397XFW7
 Zr47Cws7Ww1jgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMWl9UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB-R22m4CR+OTwAA3n
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

From: Feifei Wang <wangfeifei40@huawei.com>

Add new device id to suuport Huawei new SPx series Network Adapters.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_csr.h  | 18 +++++++++---------
 drivers/net/hinic3/base/hinic3_hwif.c | 10 +++++++---
 drivers/net/hinic3/hinic3_ethdev.c    | 14 +++++++-------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index 94b10601c4..c708019c43 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -5,15 +5,15 @@
 #ifndef _HINIC3_CSR_H_
 #define _HINIC3_CSR_H_
 
-#ifdef CONFIG_SP_VID_DID
-#define PCI_VENDOR_ID_SPNIC    0x1F3F
-#define HINIC3_DEV_ID_STANDARD 0x9020
-#define HINIC3_DEV_ID_VF       0x9001
-#else
-#define PCI_VENDOR_ID_HUAWEI   0x19e5
-#define HINIC3_DEV_ID_STANDARD 0x0222
-#define HINIC3_DEV_ID_VF       0x375F
-#endif
+#define PCI_VENDOR_ID_HUAWEI	0x19e5
+
+#define HINIC3_DEV_ID_SP620	0x0222
+#define HINIC3_DEV_ID_VF_SP620	0x375F
+
+#define HINIC3_DEV_ID_SP230	0X0229
+#define HINIC3_DEV_ID_VF_SP230	0x3750
+
+#define HINIC3_DEV_ID_SP920	0x0224
 
 /*
  * Bit30/bit31 for bar index flag.
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/base/hinic3_hwif.c
index 080254bf44..c82b223fa0 100644
--- a/drivers/net/hinic3/base/hinic3_hwif.c
+++ b/drivers/net/hinic3/base/hinic3_hwif.c
@@ -138,7 +138,11 @@
 
 #define HINIC3_GET_REG_ADDR(reg) ((reg) & (HINIC3_REGS_FLAG_MASK))
 
-#define HINIC3_IS_VF_DEV(pdev) ((pdev)->id.device_id == HINIC3_DEV_ID_VF)
+static inline bool hinic3_is_vf_dev(const struct rte_pci_device *pdev)
+{
+	return pdev->id.device_id == HINIC3_DEV_ID_VF_SP620 ||
+	       pdev->id.device_id == HINIC3_DEV_ID_VF_SP230;
+}
 
 uint32_t
 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, uint32_t reg)
@@ -552,7 +556,7 @@ hinic3_get_bar_addr(struct hinic3_hwdev *hwdev)
 	void *db_base = NULL;
 	int cfg_bar;
 
-	cfg_bar = HINIC3_IS_VF_DEV(pci_dev) ? HINIC3_VF_PCI_CFG_REG_BAR
+	cfg_bar = hinic3_is_vf_dev(pci_dev) ? HINIC3_VF_PCI_CFG_REG_BAR
 					    : HINIC3_PF_PCI_CFG_REG_BAR;
 	cfg_regs_base = pci_dev->mem_resource[cfg_bar].addr;
 
@@ -561,7 +565,7 @@ hinic3_get_bar_addr(struct hinic3_hwdev *hwdev)
 			    "mem_resource addr is null, cfg_regs_base is NULL");
 		return -EFAULT;
 	}
-	if (!HINIC3_IS_VF_DEV(pci_dev)) {
+	if (!hinic3_is_vf_dev(pci_dev)) {
 		mgmt_reg_base =
 			pci_dev->mem_resource[HINIC3_PCI_MGMT_REG_BAR].addr;
 		if (mgmt_reg_base == NULL) {
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 0f72728a95..da2d6722d2 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3521,13 +3521,13 @@ hinic3_dev_uninit(struct rte_eth_dev *dev)
 }
 
 static const struct rte_pci_id pci_id_hinic3_map[] = {
-#ifdef CONFIG_SP_VID_DID
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_STANDARD)},
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_VF)},
-#else
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_STANDARD)},
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF)},
-#endif
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP620)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP620)},
+
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP230)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP230)},
+
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP920)},
 
 	{.vendor_id = 0},
 };
-- 
2.45.1.windows.1

