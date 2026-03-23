Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C5EC01A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF9104042E;
	Mon, 23 Mar 2026 09:05:30 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 20B6D4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=rNJHe/nEYdCetOav3GaMC2WdevVgQFtlzc2ksktsAdk=;
 b=kZfAyzogwvbund9qpSGPGNmttoOKpzgTBco+koPmtJkadZvAUmDqVBdI56Q3ER
 3VX15ehql+YCwkgULuRPC3hvccOdneDCOarQHNEqWH1loNlY92iDhvCgtlejMSum
 2L852tZEzkzPHjU/aPl8o+W5bkIsbmkGRamzYI14vCzSw=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHa3Y_9MBp30tVAw--.29038S5;
 Mon, 23 Mar 2026 16:05:25 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v7 1/7] net/hinic3: add support for new SPx series NIC
Date: Mon, 23 Mar 2026 16:04:44 +0800
Message-ID: <20260323080455.2699-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260323080455.2699-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260323080455.2699-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHa3Y_9MBp30tVAw--.29038S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF1fCr4kXw4fWFW7uF4DArb_yoWxGF1kpF
 43CFZ8urWDKr4UAw1v9w1DCF95Ja18K34j934IyayF9Fn8Xr1jv3yUGFW8ZrW5t34kZa47
 ur12k397Cw1jgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiAwsUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwXY4mnA9EU1sAAA3V
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

Add new device id to support Huawei new SPx series Network Adapters.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 doc/guides/nics/features/hinic3.ini    | 11 ++++++++---
 doc/guides/nics/hinic3.rst             |  5 ++++-
 doc/guides/rel_notes/release_26_03.rst |  8 ++++++++
 drivers/net/hinic3/base/hinic3_csr.h   | 18 +++++++++---------
 drivers/net/hinic3/base/hinic3_hwif.c  | 10 +++++++---
 drivers/net/hinic3/hinic3_ethdev.c     | 14 +++++++-------
 6 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index bc70c887cb..74fea318ee 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -20,14 +20,18 @@ Allmulticast mode    = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
 RSS hash             = Y
+RSS key update       = Y
 RSS reta update      = Y
+SR-IOV               = Y
 VLAN filter          = Y
 Flow control         = Y
 CRC offload          = Y
+VLAN offload         = Y
+QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Inner L3 checksum    = Y
-Inner L4 checksum    = Y
+Inner L3 checksum    = P
+Inner L4 checksum    = P
 Packet type parsing  = Y
 Basic stats          = Y
 Extended stats       = Y
@@ -40,12 +44,13 @@ ARMv8                = Y
 
 [rte_flow items]
 any                  = Y
-eth                  = Y
+eth                  = P
 icmp                 = Y
 ipv4                 = Y
 ipv6                 = Y
 tcp                  = Y
 udp                  = Y
 vxlan                = Y
+
 [rte_flow actions]
 queue                = Y
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index e10f6bb450..a6117c713f 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -16,16 +16,19 @@ Features
 - Receiver Side Scaling (RSS)
 - Flow filtering
 - Checksum offload
+- VLAN/QinQ stripping and inserting
 - TSO offload
 - Promiscuous mode
 - Port hardware statistics
+- Jumbo frames
 - Link state information
 - Link flow control
 - Scattered and gather for TX and RX
 - Allmulticast mode
 - MTU update
 - Multicast MAC filter
-- Flow API
+- NUMA support
+- Generic Flow API
 - Set Link down or up
 - VLAN filter and VLAN offload
 - SR-IOV - Partially supported at this point, VFIO only
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 3d2ed19eb8..a29c460c6a 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -81,6 +81,14 @@ New Features
   * Added application-initiated device reset.
   * Added support for receive flow steering.
 
+* **Updated Huawei hinic3 ethernet driver.**
+
+  * Added support for Huawei new SPx NICs, include SP230 and SP920(DPU).
+  * Added support for GENEVE tunnel TSO, IP-in-IP tunnel TSO of SP230.
+  * Added support for VXLAN-GPE CKSUM of SP620.
+  * Added support for tunnel packet outer UDP checksum.
+  * Added support for QinQ of SP620.
+
 * **Updated Intel idpf ethernet driver.**
 
   * Added support for time sync features.
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index 94b10601c4..eceb34e9fd 100644
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
+#define HINIC3_DEV_ID_SP230	0x0229
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

