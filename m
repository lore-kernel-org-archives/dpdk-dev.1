Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ED10854CE
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 02:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 980AD40613;
	Wed, 18 Mar 2026 03:19:49 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 6F755402B3
 for <dev@dpdk.org>; Wed, 18 Mar 2026 03:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=z8iGcp45B4ahasf4d4xS1GVbPzr3yZ7yzh14phTaA1c=;
 b=XOcqpYIrwRKamMggity69hrQG06oJRxDNvx29NFplQum3apno81zLYtSEgbrOq
 5uXF3UarU+FaXIMLoYGq4IHlu1kG72jww16laJDrJHdwz+u0Ulgjlfr3COuKwFOT
 a6onPrB768I5Z8UJSEU2obuOYdqn7R7NP+mUpshHfKKt0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDH7y+zC7ppBxnpAg--.15041S5;
 Wed, 18 Mar 2026 10:19:42 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V3 1/7] net/hinic3: add support for new SPx series NIC
Date: Wed, 18 Mar 2026 10:19:01 +0800
Message-ID: <20260318021914.1807-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260318021914.1807-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260318021914.1807-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDH7y+zC7ppBxnpAg--.15041S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kXFyDGFWfKF1DJF15XFb_yoWrGF17pF
 1aka9rZr4UKr4jyw1kuw1DAF98J3WfG34jg34SvanY9F4UZF1Yv347GFW8ZrW5t397XFW2
 9r47Cws7Ww1jgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URlksUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB76BWm6C75t3wAA3B
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

Add new device id to suuport Huawei new SPx series Network Adapters.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_csr.h  | 18 +++++++++---------=0D
 drivers/net/hinic3/base/hinic3_hwif.c | 10 +++++++---=0D
 drivers/net/hinic3/hinic3_ethdev.c    | 14 +++++++-------=0D
 3 files changed, 23 insertions(+), 19 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base=
/hinic3_csr.h=0D
index 94b10601c4..eceb34e9fd 100644=0D
--- a/drivers/net/hinic3/base/hinic3_csr.h=0D
+++ b/drivers/net/hinic3/base/hinic3_csr.h=0D
@@ -5,15 +5,15 @@=0D
 #ifndef _HINIC3_CSR_H_=0D
 #define _HINIC3_CSR_H_=0D
 =0D
-#ifdef CONFIG_SP_VID_DID=0D
-#define PCI_VENDOR_ID_SPNIC    0x1F3F=0D
-#define HINIC3_DEV_ID_STANDARD 0x9020=0D
-#define HINIC3_DEV_ID_VF       0x9001=0D
-#else=0D
-#define PCI_VENDOR_ID_HUAWEI   0x19e5=0D
-#define HINIC3_DEV_ID_STANDARD 0x0222=0D
-#define HINIC3_DEV_ID_VF       0x375F=0D
-#endif=0D
+#define PCI_VENDOR_ID_HUAWEI	0x19e5=0D
+=0D
+#define HINIC3_DEV_ID_SP620	0x0222=0D
+#define HINIC3_DEV_ID_VF_SP620	0x375F=0D
+=0D
+#define HINIC3_DEV_ID_SP230	0x0229=0D
+#define HINIC3_DEV_ID_VF_SP230	0x3750=0D
+=0D
+#define HINIC3_DEV_ID_SP920	0x0224=0D
 =0D
 /*=0D
  * Bit30/bit31 for bar index flag.=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/bas=
e/hinic3_hwif.c=0D
index 080254bf44..c82b223fa0 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwif.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hwif.c=0D
@@ -138,7 +138,11 @@=0D
 =0D
 #define HINIC3_GET_REG_ADDR(reg) ((reg) & (HINIC3_REGS_FLAG_MASK))=0D
 =0D
-#define HINIC3_IS_VF_DEV(pdev) ((pdev)->id.device_id =3D=3D HINIC3_DEV_ID_=
VF)=0D
+static inline bool hinic3_is_vf_dev(const struct rte_pci_device *pdev)=0D
+{=0D
+	return pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP620 ||=0D
+	       pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP230;=0D
+}=0D
 =0D
 uint32_t=0D
 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, uint32_t reg)=0D
@@ -552,7 +556,7 @@ hinic3_get_bar_addr(struct hinic3_hwdev *hwdev)=0D
 	void *db_base =3D NULL;=0D
 	int cfg_bar;=0D
 =0D
-	cfg_bar =3D HINIC3_IS_VF_DEV(pci_dev) ? HINIC3_VF_PCI_CFG_REG_BAR=0D
+	cfg_bar =3D hinic3_is_vf_dev(pci_dev) ? HINIC3_VF_PCI_CFG_REG_BAR=0D
 					    : HINIC3_PF_PCI_CFG_REG_BAR;=0D
 	cfg_regs_base =3D pci_dev->mem_resource[cfg_bar].addr;=0D
 =0D
@@ -561,7 +565,7 @@ hinic3_get_bar_addr(struct hinic3_hwdev *hwdev)=0D
 			    "mem_resource addr is null, cfg_regs_base is NULL");=0D
 		return -EFAULT;=0D
 	}=0D
-	if (!HINIC3_IS_VF_DEV(pci_dev)) {=0D
+	if (!hinic3_is_vf_dev(pci_dev)) {=0D
 		mgmt_reg_base =3D=0D
 			pci_dev->mem_resource[HINIC3_PCI_MGMT_REG_BAR].addr;=0D
 		if (mgmt_reg_base =3D=3D NULL) {=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 0f72728a95..da2d6722d2 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -3521,13 +3521,13 @@ hinic3_dev_uninit(struct rte_eth_dev *dev)=0D
 }=0D
 =0D
 static const struct rte_pci_id pci_id_hinic3_map[] =3D {=0D
-#ifdef CONFIG_SP_VID_DID=0D
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_STANDARD)},=0D
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_SPNIC, HINIC3_DEV_ID_VF)},=0D
-#else=0D
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_STANDARD)},=0D
-	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF)},=0D
-#endif=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP620)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP620)},=0D
+=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP230)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP230)},=0D
+=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP920)},=0D
 =0D
 	{.vendor_id =3D 0},=0D
 };=0D
-- =0D
2.45.1.windows.1=0D
=0D

