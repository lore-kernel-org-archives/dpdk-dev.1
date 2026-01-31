Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4EDD79769
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AAA6402C1;
	Sat, 31 Jan 2026 11:06:46 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 40AD7402C1
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=UeGqHV5GZVn01/cwyI1+tLxETCrRId1FzjE/8AY44K0=;
 b=GbqUn/1p15KoQkdzPHIGmf15Bc9/uMVdScRYQ626KSigzO3gEcbeUB64Gp/CpU
 38dkdpLo909+5+ZEVC6YFC0NteJKc5jJekf2HWCXLC8dP82XbOBT8eEIrmPXuFv0
 YdVC/wasZ6OPbFk1NYfOo2enF/L8n6gxPYJbH6bPtLGEY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S5;
 Sat, 31 Jan 2026 18:06:41 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 1/7] net/hinic3: add support for new SPx series NIC
Date: Sat, 31 Jan 2026 18:05:57 +0800
Message-ID: <20260131100608.12429-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kuF4xAr4fKw43WF47CFg_yoW5Aw4kpr
 1akFZFvF4UKF42kw1kuw4DCF98J3WfG34jgw1SvanY9FyDAr1Yv347GFW8ZrW5t397XFW7
 Zr47Cws7Ww1jgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE0PfUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRH6BWl91DFJJQAA3G
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
 drivers/net/hinic3/base/hinic3_csr.h  | 16 ++++++++--------
 drivers/net/hinic3/base/hinic3_hwif.c |  4 +++-
 drivers/net/hinic3/hinic3_ethdev.c    | 14 +++++++-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index 94b10601c4..e601ffafa7 100644
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
 #define PCI_VENDOR_ID_HUAWEI   0x19e5
-#define HINIC3_DEV_ID_STANDARD 0x0222
-#define HINIC3_DEV_ID_VF       0x375F
-#endif
+
+#define HINIC3_DEV_ID_SP620    0x0222
+#define HINIC3_DEV_ID_VF_SP620 0x375F
+
+#define HINIC3_DEV_ID_SP230    0X0229
+#define HINIC3_DEV_ID_VF_SP230 0x3750
+
+#define HINIC3_DEV_ID_920      0x0224
 
 /*
  * Bit30/bit31 for bar index flag.
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/base/hinic3_hwif.c
index 080254bf44..24afec3d1b 100644
--- a/drivers/net/hinic3/base/hinic3_hwif.c
+++ b/drivers/net/hinic3/base/hinic3_hwif.c
@@ -138,7 +138,9 @@
 
 #define HINIC3_GET_REG_ADDR(reg) ((reg) & (HINIC3_REGS_FLAG_MASK))
 
-#define HINIC3_IS_VF_DEV(pdev) ((pdev)->id.device_id == HINIC3_DEV_ID_VF)
+#define HINIC3_IS_VF_DEV(pdev) ( \
+	(pdev)->id.device_id == HINIC3_DEV_ID_VF_SP620 || \
+	(pdev)->id.device_id == HINIC3_DEV_ID_VF_SP230)
 
 uint32_t
 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, uint32_t reg)
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 0e25175ba1..a5116264b0 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3525,13 +3525,13 @@ hinic3_dev_uninit(struct rte_eth_dev *dev)
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
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP920)},
 
 	{.vendor_id = 0},
 };
-- 
2.45.1.windows.1

