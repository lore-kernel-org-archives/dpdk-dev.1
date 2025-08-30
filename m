Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEFCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B75140653;
	Sat, 30 Aug 2025 14:40:55 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 962A440151
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/Plmk2VD4m+9S1GWXlTmO+UPuxEbufv74/WakzYhu68=;
 b=C3hnSiCTEt6n2WwJcYTt4LQrh0FYWsYA82wfbx+VijURx60vr5HJgfbDaKuZfU
 Ws8JKgxhgpkcnWKVfWkQXtaBR5oSllG3/UvLAkxyDmmRUaWMkwBDXOUqva4atpEW
 wADWl32u5Jd09mYgjcLdR2m7X+hlHjYz8ysOiCdB3+UBY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S7;
 Sat, 30 Aug 2025 20:40:49 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 03/18] net/hinic3: add hardware interfaces of BAR operation
Date: Sat, 30 Aug 2025 20:39:15 +0800
Message-ID: <20250830123942.5037-4-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S7
X-Coremail-Antispam: 1Uf129KBjvAXoWfCFyDJr4DJr4DXrW8AFyfCrg_yoW5GFW3Zo
 W7Gr45Kr4Fyr18CF4vvrZ7JFsrGrZ3uwn8Gaya9an2ga1Iqr98tasxGw1xXry0934DWr17
 XF98Aw1qkr1Fywnrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU24rWUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHhC5Cmiy3cEiigAAsT
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

From: Yi Chen <chenyi221@huawei.com>=0D

This patch adds some HW interfaces for bar operatioin interfaces,=0D
including: mapped bar address geeting, HW attributes getting,=0D
msi-x reg operation, function type getting and so on.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_hwif.c | 779 ++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_hwif.h | 142 +++++=0D
 2 files changed, 921 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/bas=
e/hinic3_hwif.c=0D
new file mode 100644=0D
index 0000000000..ede4aa311f=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hwif.c=0D
@@ -0,0 +1,779 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_bus_pci.h>=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_csr.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+=0D
+#define WAIT_HWIF_READY_TIMEOUT 10000=0D
+=0D
+#define DB_IDX(db, db_base) \=0D
+	((u32)(((ulong)(db) - (ulong)(db_base)) / HINIC3_DB_PAGE_SIZE))=0D
+=0D
+#define HINIC3_AF0_FUNC_GLOBAL_IDX_SHIFT 0=0D
+#define HINIC3_AF0_P2P_IDX_SHIFT	 12=0D
+#define HINIC3_AF0_PCI_INTF_IDX_SHIFT	 17=0D
+#define HINIC3_AF0_VF_IN_PF_SHIFT	 20=0D
+#define HINIC3_AF0_FUNC_TYPE_SHIFT	 28=0D
+=0D
+#define HINIC3_AF0_FUNC_GLOBAL_IDX_MASK 0xFFF=0D
+#define HINIC3_AF0_P2P_IDX_MASK		0x1F=0D
+#define HINIC3_AF0_PCI_INTF_IDX_MASK	0x7=0D
+#define HINIC3_AF0_VF_IN_PF_MASK	0xFF=0D
+#define HINIC3_AF0_FUNC_TYPE_MASK	0x1=0D
+=0D
+#define HINIC3_AF0_GET(val, member) \=0D
+	(((val) >> HINIC3_AF0_##member##_SHIFT) & HINIC3_AF0_##member##_MASK)=0D
+=0D
+#define HINIC3_AF1_PPF_IDX_SHIFT	  0=0D
+#define HINIC3_AF1_AEQS_PER_FUNC_SHIFT	  8=0D
+#define HINIC3_AF1_MGMT_INIT_STATUS_SHIFT 30=0D
+#define HINIC3_AF1_PF_INIT_STATUS_SHIFT	  31=0D
+=0D
+#define HINIC3_AF1_PPF_IDX_MASK		 0x3F=0D
+#define HINIC3_AF1_AEQS_PER_FUNC_MASK	 0x3=0D
+#define HINIC3_AF1_MGMT_INIT_STATUS_MASK 0x1=0D
+#define HINIC3_AF1_PF_INIT_STATUS_MASK	 0x1=0D
+=0D
+#define HINIC3_AF1_GET(val, member) \=0D
+	(((val) >> HINIC3_AF1_##member##_SHIFT) & HINIC3_AF1_##member##_MASK)=0D
+=0D
+#define HINIC3_AF2_CEQS_PER_FUNC_SHIFT	   0=0D
+#define HINIC3_AF2_DMA_ATTR_PER_FUNC_SHIFT 9=0D
+#define HINIC3_AF2_IRQS_PER_FUNC_SHIFT	   16=0D
+=0D
+#define HINIC3_AF2_CEQS_PER_FUNC_MASK	  0x1FF=0D
+#define HINIC3_AF2_DMA_ATTR_PER_FUNC_MASK 0x7=0D
+#define HINIC3_AF2_IRQS_PER_FUNC_MASK	  0x7FF=0D
+=0D
+#define HINIC3_AF2_GET(val, member) \=0D
+	(((val) >> HINIC3_AF2_##member##_SHIFT) & HINIC3_AF2_##member##_MASK)=0D
+=0D
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_NXT_PF_SHIFT 0=0D
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_PF_SHIFT	16=0D
+=0D
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_NXT_PF_MASK 0xFFF=0D
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_PF_MASK     0xFFF=0D
+=0D
+#define HINIC3_AF3_GET(val, member) \=0D
+	(((val) >> HINIC3_AF3_##member##_SHIFT) & HINIC3_AF3_##member##_MASK)=0D
+=0D
+#define HINIC3_AF4_DOORBELL_CTRL_SHIFT 0=0D
+#define HINIC3_AF4_DOORBELL_CTRL_MASK  0x1=0D
+=0D
+#define HINIC3_AF4_GET(val, member) \=0D
+	(((val) >> HINIC3_AF4_##member##_SHIFT) & HINIC3_AF4_##member##_MASK)=0D
+=0D
+#define HINIC3_AF4_SET(val, member) \=0D
+	(((val) & HINIC3_AF4_##member##_MASK) << HINIC3_AF4_##member##_SHIFT)=0D
+=0D
+#define HINIC3_AF4_CLEAR(val, member) \=0D
+	((val) & (~(HINIC3_AF4_##member##_MASK << HINIC3_AF4_##member##_SHIFT)))=
=0D
+=0D
+#define HINIC3_AF5_OUTBOUND_CTRL_SHIFT 0=0D
+#define HINIC3_AF5_OUTBOUND_CTRL_MASK  0x1=0D
+=0D
+#define HINIC3_AF5_GET(val, member) \=0D
+	(((val) >> HINIC3_AF5_##member##_SHIFT) & HINIC3_AF5_##member##_MASK)=0D
+=0D
+#define HINIC3_AF5_SET(val, member) \=0D
+	(((val) & HINIC3_AF5_##member##_MASK) << HINIC3_AF5_##member##_SHIFT)=0D
+=0D
+#define HINIC3_AF5_CLEAR(val, member) \=0D
+	((val) & (~(HINIC3_AF5_##member##_MASK << HINIC3_AF5_##member##_SHIFT)))=
=0D
+=0D
+#define HINIC3_AF6_PF_STATUS_SHIFT 0=0D
+#define HINIC3_AF6_PF_STATUS_MASK  0xFFFF=0D
+=0D
+#define HINIC3_AF6_FUNC_MAX_QUEUE_SHIFT 23=0D
+#define HINIC3_AF6_FUNC_MAX_QUEUE_MASK	0x1FF=0D
+=0D
+#define HINIC3_AF6_MSIX_FLEX_EN_SHIFT 22=0D
+#define HINIC3_AF6_MSIX_FLEX_EN_MASK  0x1=0D
+=0D
+#define HINIC3_AF6_SET(val, member)                  \=0D
+	((((u32)(val)) & HINIC3_AF6_##member##_MASK) \=0D
+	 << HINIC3_AF6_##member##_SHIFT)=0D
+=0D
+#define HINIC3_AF6_GET(val, member) \=0D
+	(((val) >> HINIC3_AF6_##member##_SHIFT) & HINIC3_AF6_##member##_MASK)=0D
+=0D
+#define HINIC3_AF6_CLEAR(val, member) \=0D
+	((val) & (~(HINIC3_AF6_##member##_MASK << HINIC3_AF6_##member##_SHIFT)))=
=0D
+=0D
+#define HINIC3_PPF_ELECTION_IDX_SHIFT 0=0D
+=0D
+#define HINIC3_PPF_ELECTION_IDX_MASK 0x3F=0D
+=0D
+#define HINIC3_PPF_ELECTION_SET(val, member)           \=0D
+	(((val) & HINIC3_PPF_ELECTION_##member##_MASK) \=0D
+	 << HINIC3_PPF_ELECTION_##member##_SHIFT)=0D
+=0D
+#define HINIC3_PPF_ELECTION_GET(val, member)               \=0D
+	(((val) >> HINIC3_PPF_ELECTION_##member##_SHIFT) & \=0D
+	 HINIC3_PPF_ELECTION_##member##_MASK)=0D
+=0D
+#define HINIC3_PPF_ELECTION_CLEAR(val, member)          \=0D
+	((val) & (~(HINIC3_PPF_ELECTION_##member##_MASK \=0D
+		    << HINIC3_PPF_ELECTION_##member##_SHIFT)))=0D
+=0D
+#define HINIC3_MPF_ELECTION_IDX_SHIFT 0=0D
+=0D
+#define HINIC3_MPF_ELECTION_IDX_MASK 0x1F=0D
+=0D
+#define HINIC3_MPF_ELECTION_SET(val, member)           \=0D
+	(((val) & HINIC3_MPF_ELECTION_##member##_MASK) \=0D
+	 << HINIC3_MPF_ELECTION_##member##_SHIFT)=0D
+=0D
+#define HINIC3_MPF_ELECTION_GET(val, member)               \=0D
+	(((val) >> HINIC3_MPF_ELECTION_##member##_SHIFT) & \=0D
+	 HINIC3_MPF_ELECTION_##member##_MASK)=0D
+=0D
+#define HINIC3_MPF_ELECTION_CLEAR(val, member)          \=0D
+	((val) & (~(HINIC3_MPF_ELECTION_##member##_MASK \=0D
+		    << HINIC3_MPF_ELECTION_##member##_SHIFT)))=0D
+=0D
+#define HINIC3_GET_REG_FLAG(reg) ((reg) & (~(HINIC3_REGS_FLAG_MASK)))=0D
+=0D
+#define HINIC3_GET_REG_ADDR(reg) ((reg) & (HINIC3_REGS_FLAG_MASK))=0D
+=0D
+#define HINIC3_IS_VF_DEV(pdev) ((pdev)->id.device_id =3D=3D HINIC3_DEV_ID_=
VF)=0D
+=0D
+u32=0D
+hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)=0D
+{=0D
+	if (HINIC3_GET_REG_FLAG(reg) =3D=3D HINIC3_MGMT_REGS_FLAG)=0D
+		return be32_to_cpu(rte_read32(hwif->mgmt_regs_base +=0D
+					      HINIC3_GET_REG_ADDR(reg)));=0D
+	else=0D
+		return be32_to_cpu(rte_read32(hwif->cfg_regs_base +=0D
+					      HINIC3_GET_REG_ADDR(reg)));=0D
+}=0D
+=0D
+void=0D
+hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)=0D
+{=0D
+	if (HINIC3_GET_REG_FLAG(reg) =3D=3D HINIC3_MGMT_REGS_FLAG)=0D
+		rte_write32(cpu_to_be32(val),=0D
+			    hwif->mgmt_regs_base + HINIC3_GET_REG_ADDR(reg));=0D
+	else=0D
+		rte_write32(cpu_to_be32(val),=0D
+			    hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg));=0D
+}=0D
+=0D
+/**=0D
+ * Judge whether HW initialization ok.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hwif_ready(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	u32 addr, attr1;=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR1_ADDR;=0D
+	attr1 =3D hinic3_hwif_read_reg(hwdev->hwif, addr);=0D
+	if (attr1 =3D=3D HINIC3_PCIE_LINK_DOWN)=0D
+		return -EBUSY;=0D
+=0D
+	if (!HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS))=0D
+		return -EBUSY;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+wait_hwif_ready(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	ulong timeout =3D 0;=0D
+=0D
+	do {=0D
+		if (!hwif_ready(hwdev))=0D
+			return 0;=0D
+=0D
+		rte_delay_ms(1);=0D
+		timeout++;=0D
+	} while (timeout <=3D WAIT_HWIF_READY_TIMEOUT);=0D
+=0D
+	PMD_DRV_LOG(ERR, "Hwif is not ready");=0D
+	return -EBUSY;=0D
+}=0D
+=0D
+/**=0D
+ * Set the attributes as members in hwif.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device.=0D
+ * @param[in] attr0=0D
+ * The first attribute that was read from the hw.=0D
+ * @param[in] attr1=0D
+ * The second attribute that was read from the hw.=0D
+ * @param[in] attr2=0D
+ * The third attribute that was read from the hw.=0D
+ * @param[in] attr3=0D
+ * The fourth attribute that was read from the hw.=0D
+ */=0D
+static void=0D
+set_hwif_attr(struct hinic3_hwif *hwif, u32 attr0, u32 attr1, u32 attr2,=0D
+	      u32 attr3)=0D
+{=0D
+	hwif->attr.func_global_idx =3D HINIC3_AF0_GET(attr0, FUNC_GLOBAL_IDX);=0D
+	hwif->attr.port_to_port_idx =3D HINIC3_AF0_GET(attr0, P2P_IDX);=0D
+	hwif->attr.pci_intf_idx =3D HINIC3_AF0_GET(attr0, PCI_INTF_IDX);=0D
+	hwif->attr.vf_in_pf =3D HINIC3_AF0_GET(attr0, VF_IN_PF);=0D
+	hwif->attr.func_type =3D HINIC3_AF0_GET(attr0, FUNC_TYPE);=0D
+=0D
+	hwif->attr.ppf_idx =3D HINIC3_AF1_GET(attr1, PPF_IDX);=0D
+	hwif->attr.num_aeqs =3D BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));=0D
+=0D
+	hwif->attr.num_ceqs =3D (u8)HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);=0D
+	hwif->attr.num_irqs =3D HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);=0D
+	hwif->attr.num_dma_attr =3D BIT(HINIC3_AF2_GET(attr2, DMA_ATTR_PER_FUNC))=
;=0D
+=0D
+	hwif->attr.global_vf_id_of_pf =3D=0D
+		HINIC3_AF3_GET(attr3, GLOBAL_VF_ID_OF_PF);=0D
+}=0D
+=0D
+/**=0D
+ * Read and set the attributes as members in hwif.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device.=0D
+ */=0D
+static void=0D
+get_hwif_attr(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 addr, attr0, attr1, attr2, attr3;=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR0_ADDR;=0D
+	attr0 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR1_ADDR;=0D
+	attr1 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR2_ADDR;=0D
+	attr2 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR3_ADDR;=0D
+	attr3 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	set_hwif_attr(hwif, attr0, attr1, attr2, attr3);=0D
+}=0D
+=0D
+/**=0D
+ * Update message signaled interrupt information.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device.=0D
+ */=0D
+void=0D
+hinic3_update_msix_info(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 attr6 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);=0D
+	hwif->attr.num_queue =3D HINIC3_AF6_GET(attr6, FUNC_MAX_QUEUE);=0D
+	hwif->attr.msix_flex_en =3D HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);=0D
+	PMD_DRV_LOG(INFO, "msix_flex_en: %u, queue msix: %u",=0D
+		    hwif->attr.msix_flex_en, hwif->attr.num_queue);=0D
+}=0D
+=0D
+void=0D
+hinic3_set_pf_status(struct hinic3_hwif *hwif, enum hinic3_pf_status statu=
s)=0D
+{=0D
+	u32 attr6 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);=0D
+=0D
+	attr6 =3D HINIC3_AF6_CLEAR(attr6, PF_STATUS);=0D
+	attr6 |=3D HINIC3_AF6_SET(status, PF_STATUS);=0D
+=0D
+	if (hwif->attr.func_type =3D=3D TYPE_VF)=0D
+		return;=0D
+=0D
+	hinic3_hwif_write_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR, attr6);=0D
+}=0D
+=0D
+enum hinic3_pf_status=0D
+hinic3_get_pf_status(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 attr6 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);=0D
+=0D
+	return HINIC3_AF6_GET(attr6, PF_STATUS);=0D
+}=0D
+=0D
+static enum hinic3_doorbell_ctrl=0D
+hinic3_get_doorbell_ctrl_status(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 attr4 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);=0D
+=0D
+	return HINIC3_AF4_GET(attr4, DOORBELL_CTRL);=0D
+}=0D
+=0D
+static enum hinic3_outbound_ctrl=0D
+hinic3_get_outbound_ctrl_status(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 attr5 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);=0D
+=0D
+	return HINIC3_AF5_GET(attr5, OUTBOUND_CTRL);=0D
+}=0D
+=0D
+void=0D
+hinic3_enable_doorbell(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 addr, attr4;=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR4_ADDR;=0D
+	attr4 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	attr4 =3D HINIC3_AF4_CLEAR(attr4, DOORBELL_CTRL);=0D
+	attr4 |=3D HINIC3_AF4_SET(ENABLE_DOORBELL, DOORBELL_CTRL);=0D
+=0D
+	hinic3_hwif_write_reg(hwif, addr, attr4);=0D
+}=0D
+=0D
+void=0D
+hinic3_disable_doorbell(struct hinic3_hwif *hwif)=0D
+{=0D
+	u32 addr, attr4;=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_ATTR4_ADDR;=0D
+	attr4 =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	attr4 =3D HINIC3_AF4_CLEAR(attr4, DOORBELL_CTRL);=0D
+	attr4 |=3D HINIC3_AF4_SET(DISABLE_DOORBELL, DOORBELL_CTRL);=0D
+=0D
+	hinic3_hwif_write_reg(hwif, addr, attr4);=0D
+}=0D
+=0D
+/**=0D
+ * Try to set hwif as ppf and set the type of hwif in this case.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device=0D
+ */=0D
+static void=0D
+set_ppf(struct hinic3_hwif *hwif)=0D
+{=0D
+	struct hinic3_func_attr *attr =3D &hwif->attr;=0D
+	u32 addr, val, ppf_election;=0D
+=0D
+	addr =3D HINIC3_CSR_PPF_ELECTION_ADDR;=0D
+=0D
+	val =3D hinic3_hwif_read_reg(hwif, addr);=0D
+	val =3D HINIC3_PPF_ELECTION_CLEAR(val, IDX);=0D
+=0D
+	ppf_election =3D HINIC3_PPF_ELECTION_SET(attr->func_global_idx, IDX);=0D
+	val |=3D ppf_election;=0D
+=0D
+	hinic3_hwif_write_reg(hwif, addr, val);=0D
+=0D
+	/* Check PPF. */=0D
+	val =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	attr->ppf_idx =3D HINIC3_PPF_ELECTION_GET(val, IDX);=0D
+	if (attr->ppf_idx =3D=3D attr->func_global_idx)=0D
+		attr->func_type =3D TYPE_PPF;=0D
+}=0D
+=0D
+/**=0D
+ * Get the mpf index from the hwif.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device.=0D
+ */=0D
+static void=0D
+get_mpf(struct hinic3_hwif *hwif)=0D
+{=0D
+	struct hinic3_func_attr *attr =3D &hwif->attr;=0D
+	u32 mpf_election, addr;=0D
+=0D
+	addr =3D HINIC3_CSR_GLOBAL_MPF_ELECTION_ADDR;=0D
+=0D
+	mpf_election =3D hinic3_hwif_read_reg(hwif, addr);=0D
+	attr->mpf_idx =3D HINIC3_MPF_ELECTION_GET(mpf_election, IDX);=0D
+}=0D
+=0D
+/**=0D
+ * Try to set hwif as mpf and set the mpf idx in hwif.=0D
+ *=0D
+ * @param[in] hwif=0D
+ * The hardware interface of a pci function device.=0D
+ */=0D
+static void=0D
+set_mpf(struct hinic3_hwif *hwif)=0D
+{=0D
+	struct hinic3_func_attr *attr =3D &hwif->attr;=0D
+	u32 addr, val, mpf_election;=0D
+=0D
+	addr =3D HINIC3_CSR_GLOBAL_MPF_ELECTION_ADDR;=0D
+=0D
+	val =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	val =3D HINIC3_MPF_ELECTION_CLEAR(val, IDX);=0D
+	mpf_election =3D HINIC3_MPF_ELECTION_SET(attr->func_global_idx, IDX);=0D
+=0D
+	val |=3D mpf_election;=0D
+	hinic3_hwif_write_reg(hwif, addr, val);=0D
+}=0D
+=0D
+int=0D
+hinic3_alloc_db_addr(void *hwdev, void **db_base,=0D
+		     enum hinic3_db_type queue_type)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev || !db_base)=0D
+		return -EINVAL;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+	*db_base =3D hwif->db_base + queue_type * HINIC3_DB_PAGE_SIZE;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+void=0D
+hinic3_set_msix_auto_mask_state(void *hwdev, u16 msix_idx,=0D
+				enum hinic3_msix_auto_mask flag)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+	u32 mask_bits;=0D
+	u32 addr;=0D
+=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	if (flag)=0D
+		mask_bits =3D HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);=0D
+	else=0D
+		mask_bits =3D HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);=0D
+=0D
+	mask_bits =3D mask_bits |=0D
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;=0D
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);=0D
+}=0D
+=0D
+/**=0D
+ * Set msix state.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device object.=0D
+ * @param[in] msix_idx=0D
+ * MSIX(Message Signaled Interrupts) index.=0D
+ * @param[in] flag=0D
+ * MSIX state flag, 0-enable, 1-disable.=0D
+ */=0D
+void=0D
+hinic3_set_msix_state(void *hwdev, u16 msix_idx, enum hinic3_msix_state fl=
ag)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+	u32 mask_bits;=0D
+	u32 addr;=0D
+	u8 int_msk =3D 1;=0D
+=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	if (flag)=0D
+		mask_bits =3D HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);=0D
+	else=0D
+		mask_bits =3D HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);=0D
+	mask_bits =3D mask_bits |=0D
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;=0D
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);=0D
+}=0D
+=0D
+static void=0D
+disable_all_msix(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	u16 num_irqs =3D hwdev->hwif->attr.num_irqs;=0D
+	u16 i;=0D
+=0D
+	for (i =3D 0; i < num_irqs; i++)=0D
+		hinic3_set_msix_state(hwdev, i, HINIC3_MSIX_DISABLE);=0D
+}=0D
+=0D
+/**=0D
+ * Clear msix resend bit.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device object.=0D
+ * @param[in] msix_idx=0D
+ * MSIX(Message Signaled Interrupts) index=0D
+ * @param[in] clear_resend_en=0D
+ * Clear resend en flag, 1-clear.=0D
+ */=0D
+void=0D
+hinic3_misx_intr_clear_resend_bit(void *hwdev, u16 msix_idx, u8 clear_rese=
nd_en)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+	u32 msix_ctrl =3D 0, addr;=0D
+=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	msix_ctrl =3D HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |=0D
+		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);=0D
+=0D
+	addr =3D HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;=0D
+	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);=0D
+}=0D
+=0D
+#ifdef HINIC3_RELEASE=0D
+static int=0D
+wait_until_doorbell_flush_states(struct hinic3_hwif *hwif,=0D
+				 enum hinic3_doorbell_ctrl states)=0D
+{=0D
+	enum hinic3_doorbell_ctrl db_ctrl;=0D
+	u32 cnt =3D 0;=0D
+=0D
+	if (!hwif)=0D
+		return -EINVAL;=0D
+=0D
+	while (cnt < HINIC3_WAIT_DOORBELL_AND_OUTBOUND_TIMEOUT) {=0D
+		db_ctrl =3D hinic3_get_doorbell_ctrl_status(hwif);=0D
+		if (db_ctrl =3D=3D states)=0D
+			return 0;=0D
+=0D
+		rte_delay_ms(1);=0D
+		cnt++;=0D
+	}=0D
+=0D
+	return -EFAULT;=0D
+}=0D
+#endif=0D
+=0D
+static int=0D
+wait_until_doorbell_and_outbound_enabled(struct hinic3_hwif *hwif)=0D
+{=0D
+	enum hinic3_doorbell_ctrl db_ctrl;=0D
+	enum hinic3_outbound_ctrl outbound_ctrl;=0D
+	u32 cnt =3D 0;=0D
+=0D
+	while (cnt < HINIC3_WAIT_DOORBELL_AND_OUTBOUND_TIMEOUT) {=0D
+		db_ctrl =3D hinic3_get_doorbell_ctrl_status(hwif);=0D
+		outbound_ctrl =3D hinic3_get_outbound_ctrl_status(hwif);=0D
+		if (outbound_ctrl =3D=3D ENABLE_OUTBOUND &&=0D
+		    db_ctrl =3D=3D ENABLE_DOORBELL)=0D
+			return 0;=0D
+=0D
+		rte_delay_ms(1);=0D
+		cnt++;=0D
+	}=0D
+=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+static int=0D
+hinic3_get_bar_addr(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct rte_pci_device *pci_dev =3D hwdev->pci_dev;=0D
+	struct hinic3_hwif *hwif =3D hwdev->hwif;=0D
+	void *cfg_regs_base =3D NULL;=0D
+	void *mgmt_reg_base =3D NULL;=0D
+	void *db_base =3D NULL;=0D
+	int cfg_bar;=0D
+=0D
+	cfg_bar =3D HINIC3_IS_VF_DEV(pci_dev) ? HINIC3_VF_PCI_CFG_REG_BAR=0D
+					    : HINIC3_PF_PCI_CFG_REG_BAR;=0D
+=0D
+	cfg_regs_base =3D pci_dev->mem_resource[cfg_bar].addr;=0D
+	if (!HINIC3_IS_VF_DEV(pci_dev)) {=0D
+		mgmt_reg_base =3D=0D
+			pci_dev->mem_resource[HINIC3_PCI_MGMT_REG_BAR].addr;=0D
+		if (mgmt_reg_base =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "mgmt_reg_base addr is null");=0D
+			return -EFAULT;=0D
+		}=0D
+	}=0D
+	db_base =3D pci_dev->mem_resource[HINIC3_PCI_DB_BAR].addr;=0D
+	if (cfg_regs_base =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "mem_resource addr is null, cfg_regs_base is NULL");=0D
+		return -EFAULT;=0D
+	} else if (db_base =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "mem_resource addr is null, db_base is NULL");=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	/* If function is VF, mgmt_regs_base will be NULL. */=0D
+	if (!mgmt_reg_base)=0D
+		hwif->cfg_regs_base =3D=0D
+			(u8 *)cfg_regs_base + HINIC3_VF_CFG_REG_OFFSET;=0D
+	else=0D
+		hwif->cfg_regs_base =3D cfg_regs_base;=0D
+	hwif->mgmt_regs_base =3D mgmt_reg_base;=0D
+	hwif->db_base =3D db_base;=0D
+	hwif->db_dwqe_len =3D pci_dev->mem_resource[HINIC3_PCI_DB_BAR].len;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize the hw interface.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device object.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_init_hwif(void *dev)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D NULL;=0D
+	struct hinic3_hwif *hwif;=0D
+	int err;=0D
+	u32 attr4, attr5;=0D
+=0D
+	hwif =3D rte_zmalloc("hinic_hwif", sizeof(struct hinic3_hwif),=0D
+			   RTE_CACHE_LINE_SIZE);=0D
+	if (!hwif)=0D
+		return -ENOMEM;=0D
+=0D
+	hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	hwdev->hwif =3D hwif;=0D
+=0D
+	err =3D hinic3_get_bar_addr(hwdev);=0D
+	if (err !=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "get bar addr fail");=0D
+		goto hwif_ready_err;=0D
+	}=0D
+=0D
+	err =3D wait_hwif_ready(hwdev);=0D
+	if (err !=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "Chip status is not ready");=0D
+		goto hwif_ready_err;=0D
+	}=0D
+=0D
+	get_hwif_attr(hwif);=0D
+=0D
+	err =3D wait_until_doorbell_and_outbound_enabled(hwif);=0D
+	if (err !=3D 0) {=0D
+		attr4 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);=0D
+		attr5 =3D hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Hw doorbell/outbound is disabled, attr4 0x%x "=0D
+			    "attr5 0x%x",=0D
+			    attr4, attr5);=0D
+		goto hwif_ready_err;=0D
+	}=0D
+=0D
+	if (!HINIC3_IS_VF(hwdev)) {=0D
+		set_ppf(hwif);=0D
+=0D
+		if (HINIC3_IS_PPF(hwdev))=0D
+			set_mpf(hwif);=0D
+=0D
+		get_mpf(hwif);=0D
+	}=0D
+=0D
+	disable_all_msix(hwdev);=0D
+	/* Disable mgmt cpu reporting any event. */=0D
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "global_func_idx: %d, func_type: %d, host_id: %d, ppf: %d, "=0D
+		    "mpf: %d",=0D
+		    hwif->attr.func_global_idx, hwif->attr.func_type,=0D
+		    hwif->attr.pci_intf_idx, hwif->attr.ppf_idx,=0D
+		    hwif->attr.mpf_idx);=0D
+=0D
+	return 0;=0D
+=0D
+hwif_ready_err:=0D
+	rte_free(hwdev->hwif);=0D
+	hwdev->hwif =3D NULL;=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Free the hw interface.=0D
+ *=0D
+ * @param[in] dev=0D
+ * The pointer to the private hardware device.=0D
+ */=0D
+void=0D
+hinic3_free_hwif(void *dev)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+=0D
+	rte_free(hwdev->hwif);=0D
+}=0D
+=0D
+u16=0D
+hinic3_global_func_id(void *hwdev)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev)=0D
+		return 0;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	return hwif->attr.func_global_idx;=0D
+}=0D
+=0D
+u8=0D
+hinic3_pf_id_of_vf(void *hwdev)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev)=0D
+		return 0;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	return hwif->attr.port_to_port_idx;=0D
+}=0D
+=0D
+u8=0D
+hinic3_pcie_itf_id(void *hwdev)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev)=0D
+		return 0;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	return hwif->attr.pci_intf_idx;=0D
+}=0D
+=0D
+enum func_type=0D
+hinic3_func_type(void *hwdev)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev)=0D
+		return 0;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	return hwif->attr.func_type;=0D
+}=0D
+=0D
+u16=0D
+hinic3_glb_pf_vf_offset(void *hwdev)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D NULL;=0D
+=0D
+	if (!hwdev)=0D
+		return 0;=0D
+=0D
+	hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+=0D
+	return hwif->attr.global_vf_id_of_pf;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwif.h b/drivers/net/hinic3/bas=
e/hinic3_hwif.h=0D
new file mode 100644=0D
index 0000000000..97d2ed99df=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hwif.h=0D
@@ -0,0 +1,142 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_HWIF_H_=0D
+#define _HINIC3_HWIF_H_=0D
+=0D
+#define HINIC3_WAIT_DOORBELL_AND_OUTBOUND_TIMEOUT 60000=0D
+#define HINIC3_PCIE_LINK_DOWN			  0xFFFFFFFF=0D
+=0D
+/* PCIe bar space. */=0D
+#define HINIC3_VF_PCI_CFG_REG_BAR 0=0D
+#define HINIC3_PF_PCI_CFG_REG_BAR 1=0D
+=0D
+#define HINIC3_PCI_INTR_REG_BAR 2=0D
+#define HINIC3_PCI_MGMT_REG_BAR 3 /**< Only PF has mgmt bar. */=0D
+#define HINIC3_PCI_DB_BAR	4=0D
+=0D
+/* Doorbell or direct wqe page size is 4K. */=0D
+#define HINIC3_DB_PAGE_SIZE 0x00001000ULL=0D
+#define HINIC3_DWQE_OFFSET  0x00000800ULL=0D
+=0D
+enum func_type { TYPE_PF, TYPE_VF, TYPE_PPF, TYPE_UNKNOWN };=0D
+#define MSIX_RESEND_TIMER_CLEAR 1=0D
+=0D
+/* Message signaled interrupt status. */=0D
+enum hinic3_msix_state { HINIC3_MSIX_ENABLE, HINIC3_MSIX_DISABLE };=0D
+=0D
+enum hinic3_msix_auto_mask {=0D
+	HINIC3_CLR_MSIX_AUTO_MASK,=0D
+	HINIC3_SET_MSIX_AUTO_MASK,=0D
+};=0D
+=0D
+struct hinic3_func_attr {=0D
+	u16 func_global_idx;=0D
+	u8 port_to_port_idx;=0D
+	u8 pci_intf_idx;=0D
+	u8 vf_in_pf;=0D
+	enum func_type func_type;=0D
+=0D
+	u8 mpf_idx;=0D
+=0D
+	u8 ppf_idx;=0D
+=0D
+	u16 num_irqs; /**< Max: 2 ^ 15. */=0D
+	u8 num_aeqs;  /**< Max: 2 ^ 3. */=0D
+	u8 num_ceqs;  /**< Max: 2 ^ 7. */=0D
+=0D
+	u16 num_queue;	 /**< Max: 2 ^ 8. */=0D
+	u8 num_dma_attr; /**< Max: 2 ^ 6. */=0D
+	u8 msix_flex_en;=0D
+=0D
+	u16 global_vf_id_of_pf;=0D
+};=0D
+=0D
+/* Structure for hardware interface. */=0D
+struct hinic3_hwif {=0D
+	/* Configure virtual address, PF is bar1, VF is bar0/1. */=0D
+	u8 *cfg_regs_base;=0D
+	/* For PF bar3 virtual address, if function is VF should set NULL. */=0D
+	u8 *mgmt_regs_base;=0D
+	u8 *db_base;=0D
+	u64 db_dwqe_len;=0D
+=0D
+	struct hinic3_func_attr attr;=0D
+=0D
+	void *pdev;=0D
+};=0D
+=0D
+enum hinic3_outbound_ctrl { ENABLE_OUTBOUND =3D 0x0, DISABLE_OUTBOUND =3D =
0x1 };=0D
+=0D
+enum hinic3_doorbell_ctrl { ENABLE_DOORBELL =3D 0x0, DISABLE_DOORBELL =3D =
0x1 };=0D
+=0D
+enum hinic3_pf_status {=0D
+	HINIC3_PF_STATUS_INIT =3D 0x0,=0D
+	HINIC3_PF_STATUS_ACTIVE_FLAG =3D 0x11,=0D
+	HINIC3_PF_STATUS_FLR_START_FLAG =3D 0x12,=0D
+	HINIC3_PF_STATUS_FLR_FINISH_FLAG =3D 0x13=0D
+};=0D
+=0D
+/* Type of doorbell. */=0D
+enum hinic3_db_type {=0D
+	HINIC3_DB_TYPE_CMDQ =3D 0x0,=0D
+	HINIC3_DB_TYPE_SQ =3D 0x1,=0D
+	HINIC3_DB_TYPE_RQ =3D 0x2,=0D
+	HINIC3_DB_TYPE_MAX =3D 0x3=0D
+};=0D
+=0D
+/* Get the attributes of the hardware interface. */=0D
+#define HINIC3_HWIF_NUM_AEQS(hwif)	   ((hwif)->attr.num_aeqs)=0D
+#define HINIC3_HWIF_NUM_IRQS(hwif)	   ((hwif)->attr.num_irqs)=0D
+#define HINIC3_HWIF_GLOBAL_IDX(hwif)	   ((hwif)->attr.func_global_idx)=0D
+#define HINIC3_HWIF_GLOBAL_VF_OFFSET(hwif) ((hwif)->attr.global_vf_id_of_p=
f)=0D
+#define HINIC3_HWIF_PPF_IDX(hwif)	   ((hwif)->attr.ppf_idx)=0D
+#define HINIC3_PCI_INTF_IDX(hwif)	   ((hwif)->attr.pci_intf_idx)=0D
+=0D
+/* Func type judgment. */=0D
+#define HINIC3_FUNC_TYPE(dev) ((dev)->hwif->attr.func_type)=0D
+#define HINIC3_IS_PF(dev)     (HINIC3_FUNC_TYPE(dev) =3D=3D TYPE_PF)=0D
+#define HINIC3_IS_VF(dev)     (HINIC3_FUNC_TYPE(dev) =3D=3D TYPE_VF)=0D
+#define HINIC3_IS_PPF(dev)    (HINIC3_FUNC_TYPE(dev) =3D=3D TYPE_PPF)=0D
+=0D
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);=0D
+=0D
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);=0D
+=0D
+void hinic3_set_msix_auto_mask_state(void *hwdev, u16 msix_idx,=0D
+				     enum hinic3_msix_auto_mask flag);=0D
+=0D
+void hinic3_set_msix_state(void *hwdev, u16 msix_idx,=0D
+			   enum hinic3_msix_state flag);=0D
+=0D
+void hinic3_misx_intr_clear_resend_bit(void *hwdev, u16 msix_idx,=0D
+				       u8 clear_resend_en);=0D
+=0D
+u16 hinic3_global_func_id(void *hwdev);=0D
+=0D
+u8 hinic3_pf_id_of_vf(void *hwdev);=0D
+=0D
+u8 hinic3_pcie_itf_id(void *hwdev);=0D
+=0D
+enum func_type hinic3_func_type(void *hwdev);=0D
+=0D
+u16 hinic3_glb_pf_vf_offset(void *hwdev);=0D
+void hinic3_update_msix_info(struct hinic3_hwif *hwif);=0D
+void hinic3_set_pf_status(struct hinic3_hwif *hwif,=0D
+			  enum hinic3_pf_status status);=0D
+=0D
+enum hinic3_pf_status hinic3_get_pf_status(struct hinic3_hwif *hwif);=0D
+=0D
+int hinic3_alloc_db_addr(void *hwdev, void **db_base,=0D
+			 enum hinic3_db_type queue_type);=0D
+=0D
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif);=0D
+=0D
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif);=0D
+=0D
+int hinic3_init_hwif(void *dev);=0D
+=0D
+void hinic3_free_hwif(void *dev);=0D
+=0D
+#endif /**< _HINIC3_HWIF_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

