Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7BCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D0E40684;
	Sat, 30 Aug 2025 14:40:59 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 87E5040651
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Pq691T0i6U3rF8+75HnYcxkDbY5JxyeUxZUU2Z9l/D8=;
 b=IJmWWCUVoVqZsbdDu4kK4fGowSflSZz54IYgNdoPmMAo+6waIwK+0w5+rcp2VO
 p4w0DLQPRZIHYinSQrDIFM/JmowPaBsXv45Xrm9l6tmUCIQdP4xXWhnm305PaAMj
 MhQkvEUoyGW36rsS8kfkG5m0SaU08SzL1zK0tG3U283Vk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S10;
 Sat, 30 Aug 2025 20:40:52 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 06/18] net/hinic3: add eq mechanism function code
Date: Sat, 30 Aug 2025 20:39:18 +0800
Message-ID: <20250830123942.5037-7-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S10
X-Coremail-Antispam: 1Uf129KBjvAXoWfXF4xZr1UAF17AF1xZF4xJFb_yoW8Kr1kCo
 W3GF43tw4rtr1xA3Wvvrs2yFyqyFn09rn8Jay3Gas7Za9Fqr15Ga17GF4Sqw1fXryjyFy8
 CFWftwnayw4UZwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7tkuDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHwu5Cmiy3h4h2AAAsE
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

Eqs include aeq and ceq. Aeq is a kind of queue for mgmt=0D
asynchronous message and mgmt command response message.=0D
This patch introduces data structures, initialization,=0D
and related interfaces about aeq.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_eqs.c | 721 +++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_eqs.h |  98 ++++=0D
 2 files changed, 819 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_eqs.c b/drivers/net/hinic3/base=
/hinic3_eqs.c=0D
new file mode 100644=0D
index 0000000000..745b1fbad5=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_eqs.c=0D
@@ -0,0 +1,721 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+#include <rte_memory.h>=0D
+#include <rte_memzone.h>=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_csr.h"=0D
+#include "hinic3_eqs.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_nic_event.h"=0D
+=0D
+/* Indicate AEQ_CTRL_0 shift. */=0D
+#define AEQ_CTRL_0_INTR_IDX_SHIFT     0=0D
+#define AEQ_CTRL_0_DMA_ATTR_SHIFT     12=0D
+#define AEQ_CTRL_0_PCI_INTF_IDX_SHIFT 20=0D
+#define AEQ_CTRL_0_INTR_MODE_SHIFT    31=0D
+=0D
+/* Indicate AEQ_CTRL_0 mask. */=0D
+#define AEQ_CTRL_0_INTR_IDX_MASK     0x3FFU=0D
+#define AEQ_CTRL_0_DMA_ATTR_MASK     0x3FU=0D
+#define AEQ_CTRL_0_PCI_INTF_IDX_MASK 0x7U=0D
+#define AEQ_CTRL_0_INTR_MODE_MASK    0x1U=0D
+=0D
+/* Set and clear the AEQ_CTRL_0 bit fields. */=0D
+#define AEQ_CTRL_0_SET(val, member) \=0D
+	(((val) & AEQ_CTRL_0_##member##_MASK) << AEQ_CTRL_0_##member##_SHIFT)=0D
+#define AEQ_CTRL_0_CLEAR(val, member) \=0D
+	((val) & (~(AEQ_CTRL_0_##member##_MASK << AEQ_CTRL_0_##member##_SHIFT)))=
=0D
+=0D
+/* Indicate AEQ_CTRL_1 shift. */=0D
+#define AEQ_CTRL_1_LEN_SHIFT	   0=0D
+#define AEQ_CTRL_1_ELEM_SIZE_SHIFT 24=0D
+#define AEQ_CTRL_1_PAGE_SIZE_SHIFT 28=0D
+=0D
+/* Indicate AEQ_CTRL_1 mask. */=0D
+#define AEQ_CTRL_1_LEN_MASK	  0x1FFFFFU=0D
+#define AEQ_CTRL_1_ELEM_SIZE_MASK 0x3U=0D
+#define AEQ_CTRL_1_PAGE_SIZE_MASK 0xFU=0D
+=0D
+/* Set and clear the AEQ_CTRL_1 bit fields. */=0D
+#define AEQ_CTRL_1_SET(val, member) \=0D
+	(((val) & AEQ_CTRL_1_##member##_MASK) << AEQ_CTRL_1_##member##_SHIFT)=0D
+#define AEQ_CTRL_1_CLEAR(val, member) \=0D
+	((val) & (~(AEQ_CTRL_1_##member##_MASK << AEQ_CTRL_1_##member##_SHIFT)))=
=0D
+=0D
+#define HINIC3_EQ_PROD_IDX_MASK	      0xFFFFF=0D
+#define HINIC3_TASK_PROCESS_EQE_LIMIT 1024=0D
+#define HINIC3_EQ_UPDATE_CI_STEP      64=0D
+=0D
+/* Indicate EQ_ELEM_DESC shift. */=0D
+#define EQ_ELEM_DESC_TYPE_SHIFT	   0=0D
+#define EQ_ELEM_DESC_SRC_SHIFT	   7=0D
+#define EQ_ELEM_DESC_SIZE_SHIFT	   8=0D
+#define EQ_ELEM_DESC_WRAPPED_SHIFT 31=0D
+=0D
+/* Indicate EQ_ELEM_DESC mask. */=0D
+#define EQ_ELEM_DESC_TYPE_MASK	  0x7FU=0D
+#define EQ_ELEM_DESC_SRC_MASK	  0x1U=0D
+#define EQ_ELEM_DESC_SIZE_MASK	  0xFFU=0D
+#define EQ_ELEM_DESC_WRAPPED_MASK 0x1U=0D
+=0D
+/* Get the AEQ_CTRL_1 bit fields. */=0D
+#define EQ_ELEM_DESC_GET(val, member)               \=0D
+	(((val) >> EQ_ELEM_DESC_##member##_SHIFT) & \=0D
+	 EQ_ELEM_DESC_##member##_MASK)=0D
+=0D
+/* Indicate EQ_CI_SIMPLE_INDIR shift. */=0D
+#define EQ_CI_SIMPLE_INDIR_CI_SHIFT	 0=0D
+#define EQ_CI_SIMPLE_INDIR_ARMED_SHIFT	 21=0D
+#define EQ_CI_SIMPLE_INDIR_AEQ_IDX_SHIFT 30=0D
+=0D
+/* Indicate EQ_CI_SIMPLE_INDIR mask. */=0D
+#define EQ_CI_SIMPLE_INDIR_CI_MASK	0x1FFFFFU=0D
+#define EQ_CI_SIMPLE_INDIR_ARMED_MASK	0x1U=0D
+#define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK 0x3U=0D
+=0D
+/* Set and clear the EQ_CI_SIMPLE_INDIR bit fields. */=0D
+#define EQ_CI_SIMPLE_INDIR_SET(val, member)           \=0D
+	(((val) & EQ_CI_SIMPLE_INDIR_##member##_MASK) \=0D
+	 << EQ_CI_SIMPLE_INDIR_##member##_SHIFT)=0D
+#define EQ_CI_SIMPLE_INDIR_CLEAR(val, member)          \=0D
+	((val) & (~(EQ_CI_SIMPLE_INDIR_##member##_MASK \=0D
+		    << EQ_CI_SIMPLE_INDIR_##member##_SHIFT)))=0D
+=0D
+#define EQ_WRAPPED(eq) ((u32)(eq)->wrapped << EQ_VALID_SHIFT)=0D
+=0D
+#define EQ_CONS_IDX(eq)                                                   =
 \=0D
+	({                                                                 \=0D
+		typeof(eq) __eq =3D (eq);                                    \=0D
+		__eq->cons_idx | ((u32)__eq->wrapped << EQ_WRAPPED_SHIFT); \=0D
+	})=0D
+#define GET_EQ_NUM_PAGES(eq, size)                                     \=0D
+	({                                                             \=0D
+		typeof(eq) __eq =3D (eq);                                \=0D
+		typeof(size) __size =3D (size);                          \=0D
+		(u16)(RTE_ALIGN((u32)(__eq->eq_len * __eq->elem_size), \=0D
+				__size) /                              \=0D
+		      __size);                                         \=0D
+	})=0D
+=0D
+#define GET_EQ_NUM_ELEMS(eq, pg_size) ((pg_size) / (u32)(eq)->elem_size)=0D
+=0D
+#define GET_EQ_ELEMENT(eq, idx)                                         \=
=0D
+	({                                                              \=0D
+		typeof(eq) __eq =3D (eq);                                 \=0D
+		typeof(idx) __idx =3D (idx);                              \=0D
+		((u8 *)__eq->virt_addr[__idx / __eq->num_elem_in_pg]) + \=0D
+			(u32)((__idx & (__eq->num_elem_in_pg - 1)) *    \=0D
+			      __eq->elem_size);                         \=0D
+	})=0D
+=0D
+#define GET_AEQ_ELEM(eq, idx) \=0D
+	((struct hinic3_aeq_elem *)GET_EQ_ELEMENT((eq), (idx)))=0D
+=0D
+#define PAGE_IN_4K(page_size)	    ((page_size) >> 12)=0D
+#define EQ_SET_HW_PAGE_SIZE_VAL(eq) ((u32)ilog2(PAGE_IN_4K((eq)->page_size=
)))=0D
+=0D
+#define ELEMENT_SIZE_IN_32B(eq)	    (((eq)->elem_size) >> 5)=0D
+#define EQ_SET_HW_ELEM_SIZE_VAL(eq) ((u32)ilog2(ELEMENT_SIZE_IN_32B(eq)))=
=0D
+=0D
+#define AEQ_DMA_ATTR_DEFAULT 0=0D
+=0D
+#define EQ_WRAPPED_SHIFT 20=0D
+=0D
+#define EQ_VALID_SHIFT 31=0D
+=0D
+#define aeq_to_aeqs(eq)                                                   =
   \=0D
+	({                                                                   \=0D
+		typeof(eq) __eq =3D (eq);                                      \=0D
+		container_of(__eq - __eq->q_id, struct hinic3_aeqs, aeq[0]); \=0D
+	})=0D
+=0D
+#define AEQ_MSIX_ENTRY_IDX_0 0=0D
+=0D
+/**=0D
+ * Write the consumer idx to hw.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue to update the cons idx.=0D
+ * @param[in] arm_state=0D
+ * Indicate whether report interrupts when generate eq element.=0D
+ */=0D
+static void=0D
+set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)=0D
+{=0D
+	u32 eq_wrap_ci =3D 0;=0D
+	u32 val =3D 0;=0D
+	u32 addr =3D HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR;=0D
+=0D
+	eq_wrap_ci =3D EQ_CONS_IDX(eq);=0D
+=0D
+	/* Dpdk pmd driver only aeq0 use int_arm mode. */=0D
+	if (eq->q_id !=3D 0)=0D
+		val =3D EQ_CI_SIMPLE_INDIR_SET(HINIC3_EQ_NOT_ARMED, ARMED);=0D
+	else=0D
+		val =3D EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);=0D
+=0D
+	val =3D val | EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |=0D
+	      EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);=0D
+=0D
+	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);=0D
+}=0D
+=0D
+/**=0D
+ * Set aeq's ctrls registers.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue for setting.=0D
+ */=0D
+static void=0D
+set_aeq_ctrls(struct hinic3_eq *eq)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D eq->hwdev->hwif;=0D
+	struct irq_info *eq_irq =3D &eq->eq_irq;=0D
+	u32 addr, val, ctrl0, ctrl1, page_size_val, elem_size;=0D
+	u32 pci_intf_idx =3D HINIC3_PCI_INTF_IDX(hwif);=0D
+=0D
+	/* Set AEQ ctrl0. */=0D
+	addr =3D HINIC3_CSR_AEQ_CTRL_0_ADDR;=0D
+=0D
+	val =3D hinic3_hwif_read_reg(hwif, addr);=0D
+=0D
+	val =3D AEQ_CTRL_0_CLEAR(val, INTR_IDX) &=0D
+	      AEQ_CTRL_0_CLEAR(val, DMA_ATTR) &=0D
+	      AEQ_CTRL_0_CLEAR(val, PCI_INTF_IDX) &=0D
+	      AEQ_CTRL_0_CLEAR(val, INTR_MODE);=0D
+=0D
+	ctrl0 =3D AEQ_CTRL_0_SET(eq_irq->msix_entry_idx, INTR_IDX) |=0D
+		AEQ_CTRL_0_SET(AEQ_DMA_ATTR_DEFAULT, DMA_ATTR) |=0D
+		AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |=0D
+		AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);=0D
+=0D
+	val |=3D ctrl0;=0D
+=0D
+	hinic3_hwif_write_reg(hwif, addr, val);=0D
+=0D
+	/* Set AEQ ctrl1. */=0D
+	addr =3D HINIC3_CSR_AEQ_CTRL_1_ADDR;=0D
+=0D
+	page_size_val =3D EQ_SET_HW_PAGE_SIZE_VAL(eq);=0D
+	elem_size =3D EQ_SET_HW_ELEM_SIZE_VAL(eq);=0D
+=0D
+	ctrl1 =3D AEQ_CTRL_1_SET(eq->eq_len, LEN) |=0D
+		AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |=0D
+		AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);=0D
+=0D
+	hinic3_hwif_write_reg(hwif, addr, ctrl1);=0D
+}=0D
+=0D
+/**=0D
+ * Initialize all the elements in the aeq.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ * @param[in] init_val=0D
+ * Value to init.=0D
+ */=0D
+static void=0D
+aeq_elements_init(struct hinic3_eq *eq, u32 init_val)=0D
+{=0D
+	struct hinic3_aeq_elem *aeqe =3D NULL;=0D
+	u32 i;=0D
+=0D
+	for (i =3D 0; i < eq->eq_len; i++) {=0D
+		aeqe =3D GET_AEQ_ELEM(eq, i);=0D
+		aeqe->desc =3D cpu_to_be32(init_val);=0D
+	}=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Write the init va=
lues. */=0D
+}=0D
+=0D
+/**=0D
+ * Set the pages for the event queue.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+set_eq_pages(struct hinic3_eq *eq)=0D
+{=0D
+	struct hinic3_hwif *hwif =3D eq->hwdev->hwif;=0D
+	u32 reg, init_val;=0D
+	u16 pg_num, i;=0D
+	int err;=0D
+=0D
+	for (pg_num =3D 0; pg_num < eq->num_pages; pg_num++) {=0D
+		/* Allocate memory for each page. */=0D
+		eq->eq_mz[pg_num] =3D hinic3_dma_zone_reserve(eq->hwdev->eth_dev,=0D
+			"eq_mz", eq->q_id, eq->page_size,=0D
+			eq->page_size, SOCKET_ID_ANY);=0D
+		if (!eq->eq_mz[pg_num]) {=0D
+			err =3D -ENOMEM;=0D
+			goto dma_alloc_err;=0D
+		}=0D
+=0D
+		/* Write physical memory address and virtual memory address. */=0D
+		eq->dma_addr[pg_num] =3D eq->eq_mz[pg_num]->iova;=0D
+		eq->virt_addr[pg_num] =3D eq->eq_mz[pg_num]->addr;=0D
+=0D
+		reg =3D HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num);=0D
+		hinic3_hwif_write_reg(hwif, reg,=0D
+				      upper_32_bits(eq->dma_addr[pg_num]));=0D
+=0D
+		reg =3D HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num);=0D
+		hinic3_hwif_write_reg(hwif, reg,=0D
+				      lower_32_bits(eq->dma_addr[pg_num]));=0D
+	}=0D
+	/* Calculate the number of elements that can be accommodated. */=0D
+	eq->num_elem_in_pg =3D GET_EQ_NUM_ELEMS(eq, eq->page_size);=0D
+	if (eq->num_elem_in_pg & (eq->num_elem_in_pg - 1)) {=0D
+		PMD_DRV_LOG(ERR, "Number element in eq page !=3D power of 2");=0D
+		err =3D -EINVAL;=0D
+		goto dma_alloc_err;=0D
+	}=0D
+	init_val =3D EQ_WRAPPED(eq);=0D
+=0D
+	/* Initialize elements in the queue. */=0D
+	aeq_elements_init(eq, init_val);=0D
+=0D
+	return 0;=0D
+=0D
+dma_alloc_err:=0D
+	for (i =3D 0; i < pg_num; i++)=0D
+		hinic3_memzone_free(eq->eq_mz[i]);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Allocate the pages for the event queue.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+alloc_eq_pages(struct hinic3_eq *eq)=0D
+{=0D
+	u64 dma_addr_size, virt_addr_size, eq_mz_size;=0D
+	int err;=0D
+=0D
+	/* Calculate the size of the memory to be allocated. */=0D
+	dma_addr_size =3D eq->num_pages * sizeof(*eq->dma_addr);=0D
+	virt_addr_size =3D eq->num_pages * sizeof(*eq->virt_addr);=0D
+	eq_mz_size =3D eq->num_pages * sizeof(*eq->eq_mz);=0D
+=0D
+	eq->dma_addr =3D rte_zmalloc("eq_dma", dma_addr_size,=0D
+				   HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!eq->dma_addr)=0D
+		return -ENOMEM;=0D
+=0D
+	eq->virt_addr =3D rte_zmalloc("eq_va", virt_addr_size,=0D
+				    HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!eq->virt_addr) {=0D
+		err =3D -ENOMEM;=0D
+		goto virt_addr_alloc_err;=0D
+	}=0D
+=0D
+	eq->eq_mz =3D=0D
+		rte_zmalloc("eq_mz", eq_mz_size, HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!eq->eq_mz) {=0D
+		err =3D -ENOMEM;=0D
+		goto eq_mz_alloc_err;=0D
+	}=0D
+	err =3D set_eq_pages(eq);=0D
+	if (err !=3D 0)=0D
+		goto eq_pages_err;=0D
+=0D
+	return 0;=0D
+=0D
+eq_pages_err:=0D
+	rte_free(eq->eq_mz);=0D
+=0D
+eq_mz_alloc_err:=0D
+	rte_free(eq->virt_addr);=0D
+=0D
+virt_addr_alloc_err:=0D
+	rte_free(eq->dma_addr);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Free the pages of the event queue.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ */=0D
+static void=0D
+free_eq_pages(struct hinic3_eq *eq)=0D
+{=0D
+	u16 pg_num;=0D
+=0D
+	for (pg_num =3D 0; pg_num < eq->num_pages; pg_num++)=0D
+		hinic3_memzone_free(eq->eq_mz[pg_num]);=0D
+=0D
+	rte_free(eq->eq_mz);=0D
+	rte_free(eq->virt_addr);=0D
+	rte_free(eq->dma_addr);=0D
+}=0D
+=0D
+static u32=0D
+get_page_size(struct hinic3_eq *eq)=0D
+{=0D
+	u32 total_size;=0D
+	u16 count, n =3D 0;=0D
+=0D
+	/* Total memory size. */=0D
+	total_size =3D RTE_ALIGN((eq->eq_len * eq->elem_size),=0D
+			       HINIC3_MIN_EQ_PAGE_SIZE);=0D
+	if (total_size <=3D (HINIC3_EQ_MAX_PAGES * HINIC3_MIN_EQ_PAGE_SIZE))=0D
+		return HINIC3_MIN_EQ_PAGE_SIZE;=0D
+	/* Total number of pages. */=0D
+	count =3D (u16)(RTE_ALIGN((total_size / HINIC3_EQ_MAX_PAGES),=0D
+				HINIC3_MIN_EQ_PAGE_SIZE) /=0D
+		      HINIC3_MIN_EQ_PAGE_SIZE);=0D
+=0D
+	/* Whether count is a power of 2. */=0D
+	if (!(count & (count - 1)))=0D
+		return HINIC3_MIN_EQ_PAGE_SIZE * count;=0D
+=0D
+	while (count) {=0D
+		count >>=3D 1;=0D
+		n++;=0D
+	}=0D
+=0D
+	return ((u32)HINIC3_MIN_EQ_PAGE_SIZE) << n;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize AEQ.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ * @param[in] q_id=0D
+ * Queue id number.=0D
+ * @param[in] q_len=0D
+ * The number of EQ elements.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+init_aeq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id, u32 q=
_len)=0D
+{=0D
+	int err =3D 0;=0D
+=0D
+	eq->hwdev =3D hwdev;=0D
+	eq->q_id =3D q_id;=0D
+	eq->eq_len =3D q_len;=0D
+=0D
+	/* Indirect access should set q_id first. */=0D
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_AEQ_INDIR_IDX_ADDR, eq->q_id);=
=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< write index befor=
e config. */=0D
+=0D
+	/* Clear eq_len to force eqe drop in hardware. */=0D
+	hinic3_hwif_write_reg(eq->hwdev->hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);=0D
+	rte_atomic_thread_fence(rte_memory_order_release);=0D
+	/* Init aeq pi to 0 before allocating aeq pages. */=0D
+	hinic3_hwif_write_reg(eq->hwdev->hwif, HINIC3_CSR_AEQ_PROD_IDX_ADDR, 0);=
=0D
+=0D
+	eq->cons_idx =3D 0;=0D
+	eq->wrapped =3D 0;=0D
+=0D
+	eq->elem_size =3D HINIC3_AEQE_SIZE;=0D
+	eq->page_size =3D get_page_size(eq);=0D
+	eq->orig_page_size =3D eq->page_size;=0D
+	eq->num_pages =3D GET_EQ_NUM_PAGES(eq, eq->page_size);=0D
+	if (eq->num_pages > HINIC3_EQ_MAX_PAGES) {=0D
+		PMD_DRV_LOG(ERR, "Too many pages: %d for aeq", eq->num_pages);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D alloc_eq_pages(eq);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Allocate pages for eq failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Pmd driver uses AEQ_MSIX_ENTRY_IDX_0. */=0D
+	eq->eq_irq.msix_entry_idx =3D AEQ_MSIX_ENTRY_IDX_0;=0D
+	set_aeq_ctrls(eq);=0D
+=0D
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);=0D
+=0D
+	if (eq->q_id =3D=3D 0)=0D
+		hinic3_set_msix_state(hwdev, 0, HINIC3_MSIX_ENABLE);=0D
+=0D
+	eq->poll_retry_nr =3D HINIC3_RETRY_NUM;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Remove AEQ.=0D
+ *=0D
+ * @param[in] eq=0D
+ * The event queue.=0D
+ */=0D
+static void=0D
+remove_aeq(struct hinic3_eq *eq)=0D
+{=0D
+	struct irq_info *entry =3D &eq->eq_irq;=0D
+=0D
+	if (eq->q_id =3D=3D 0)=0D
+		hinic3_set_msix_state(eq->hwdev, entry->msix_entry_idx,=0D
+				      HINIC3_MSIX_DISABLE);=0D
+=0D
+	/* Indirect access should set q_id first. */=0D
+	hinic3_hwif_write_reg(eq->hwdev->hwif, HINIC3_AEQ_INDIR_IDX_ADDR,=0D
+			      eq->q_id);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Write index befor=
e config. */=0D
+=0D
+	/* Clear eq_len to avoid hw access host memory. */=0D
+	hinic3_hwif_write_reg(eq->hwdev->hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);=0D
+=0D
+	/* Update cons_idx to avoid invalid interrupt. */=0D
+	eq->cons_idx =3D hinic3_hwif_read_reg(eq->hwdev->hwif,=0D
+					    HINIC3_CSR_AEQ_PROD_IDX_ADDR);=0D
+	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);=0D
+=0D
+	free_eq_pages(eq);=0D
+}=0D
+=0D
+/**=0D
+ * Init all AEQs.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device object=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_aeqs_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_aeqs *aeqs =3D NULL;=0D
+	u16 num_aeqs;=0D
+	int err;=0D
+	u16 i, q_id;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	num_aeqs =3D HINIC3_HWIF_NUM_AEQS(hwdev->hwif);=0D
+	if (num_aeqs > HINIC3_MAX_AEQS) {=0D
+		PMD_DRV_LOG(INFO, "Adjust aeq num to %d", HINIC3_MAX_AEQS);=0D
+		num_aeqs =3D HINIC3_MAX_AEQS;=0D
+	} else if (num_aeqs < HINIC3_MIN_AEQS) {=0D
+		PMD_DRV_LOG(ERR, "PMD needs %d AEQs, Chip has %d",=0D
+			    HINIC3_MIN_AEQS, num_aeqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	aeqs =3D rte_zmalloc("hinic3_aeqs", sizeof(*aeqs),=0D
+			   HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!aeqs)=0D
+		return -ENOMEM;=0D
+=0D
+	hwdev->aeqs =3D aeqs;=0D
+	aeqs->hwdev =3D hwdev;=0D
+	aeqs->num_aeqs =3D num_aeqs;=0D
+=0D
+	for (q_id =3D 0; q_id < num_aeqs; q_id++) {=0D
+		err =3D init_aeq(&aeqs->aeq[q_id], hwdev, q_id,=0D
+			       HINIC3_DEFAULT_AEQ_LEN);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Init aeq %d failed", q_id);=0D
+			goto init_aeq_err;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+init_aeq_err:=0D
+	for (i =3D 0; i < q_id; i++)=0D
+		remove_aeq(&aeqs->aeq[i]);=0D
+=0D
+	rte_free(aeqs);=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Free all AEQs.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ */=0D
+void=0D
+hinic3_aeqs_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_aeqs *aeqs =3D hwdev->aeqs;=0D
+	u16 q_id;=0D
+=0D
+	for (q_id =3D 0; q_id < aeqs->num_aeqs; q_id++)=0D
+		remove_aeq(&aeqs->aeq[q_id]);=0D
+=0D
+	rte_free(aeqs);=0D
+}=0D
+=0D
+void=0D
+hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_aeq_elem *aeqe_pos =3D NULL;=0D
+	struct hinic3_eq *eq =3D NULL;=0D
+	u32 addr, ci, pi, ctrl0, idx;=0D
+	int q_id;=0D
+=0D
+	for (q_id =3D 0; q_id < hwdev->aeqs->num_aeqs; q_id++) {=0D
+		eq =3D &hwdev->aeqs->aeq[q_id];=0D
+		/* Indirect access should set q_id first. */=0D
+		hinic3_hwif_write_reg(eq->hwdev->hwif,=0D
+				      HINIC3_AEQ_INDIR_IDX_ADDR, eq->q_id);=0D
+		/* Write index before config. */=0D
+		rte_atomic_thread_fence(rte_memory_order_release);=0D
+=0D
+		addr =3D HINIC3_CSR_AEQ_CTRL_0_ADDR;=0D
+=0D
+		ctrl0 =3D hinic3_hwif_read_reg(hwdev->hwif, addr);=0D
+=0D
+		idx =3D hinic3_hwif_read_reg(hwdev->hwif,=0D
+					   HINIC3_AEQ_INDIR_IDX_ADDR);=0D
+=0D
+		addr =3D HINIC3_CSR_AEQ_CONS_IDX_ADDR;=0D
+		ci =3D hinic3_hwif_read_reg(hwdev->hwif, addr);=0D
+		addr =3D HINIC3_CSR_AEQ_PROD_IDX_ADDR;=0D
+		pi =3D hinic3_hwif_read_reg(hwdev->hwif, addr);=0D
+		aeqe_pos =3D GET_AEQ_ELEM(eq, eq->cons_idx);=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Aeq id: %d, idx: %u, ctrl0: 0x%08x, wrap: %d,"=0D
+			    " pi: 0x%x, ci: 0x%08x,  desc: 0x%x",=0D
+			    q_id, idx, ctrl0, eq->wrapped, pi, ci,=0D
+			    be32_to_cpu(aeqe_pos->desc));=0D
+	}=0D
+}=0D
+=0D
+static int=0D
+aeq_elem_handler(struct hinic3_eq *eq, u32 aeqe_desc,=0D
+		 struct hinic3_aeq_elem *aeqe_pos, void *param)=0D
+{=0D
+	enum hinic3_aeq_type event;=0D
+	u8 data[HINIC3_AEQE_DATA_SIZE];=0D
+	u8 size;=0D
+=0D
+	event =3D EQ_ELEM_DESC_GET(aeqe_desc, TYPE);=0D
+	if (EQ_ELEM_DESC_GET(aeqe_desc, SRC)) {=0D
+		/* SW event uses only the first 8B. */=0D
+		memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);=0D
+		hinic3_be32_to_cpu(data, HINIC3_AEQE_DATA_SIZE);=0D
+		/* Just support HINIC3_STATELESS_EVENT. */=0D
+		return hinic3_nic_sw_aeqe_handler(eq->hwdev, event, data);=0D
+	}=0D
+=0D
+	memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);=0D
+	hinic3_be32_to_cpu(data, HINIC3_AEQE_DATA_SIZE);=0D
+	size =3D EQ_ELEM_DESC_GET(aeqe_desc, SIZE);=0D
+=0D
+	if (event =3D=3D HINIC3_MSG_FROM_MGMT_CPU) {=0D
+		return hinic3_mgmt_msg_aeqe_handler(eq->hwdev, data, size,=0D
+						    param);=0D
+	} else if (event =3D=3D HINIC3_MBX_FROM_FUNC) {=0D
+		return hinic3_mbox_func_aeqe_handler(eq->hwdev, data, size,=0D
+						     param);=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "AEQ hw event not support %d", event);=0D
+		return -EINVAL;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Poll one or continue aeqe, and call dedicated process.=0D
+ *=0D
+ * @param[in] eq=0D
+ * Pointer to the event queue.=0D
+ * @param[in] timeout=0D
+ * equal to 0 - Poll all aeqe in eq, used in interrupt mode.=0D
+ * Greater than 0 - Poll aeq until get aeqe with 'last' field set to 1, us=
ed in=0D
+ * polling mode.=0D
+ * @param[in] param=0D
+ * Customized parameter.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_aeq_poll_msg(struct hinic3_eq *eq, u32 timeout, void *param)=0D
+{=0D
+	struct hinic3_aeq_elem *aeqe_pos =3D NULL;=0D
+	u32 aeqe_desc =3D 0;=0D
+	u32 eqe_cnt =3D 0;=0D
+	int err =3D -EFAULT;=0D
+	int done =3D HINIC3_MSG_HANDLER_RES;=0D
+	unsigned long end;=0D
+	u16 i;=0D
+=0D
+	for (i =3D 0; ((timeout =3D=3D 0) && (i < eq->eq_len)) ||=0D
+		    ((timeout > 0) && (done !=3D 0) && (i < eq->eq_len));=0D
+	     i++) {=0D
+		err =3D -EIO;=0D
+		end =3D jiffies + msecs_to_jiffies(timeout);=0D
+		do {=0D
+			aeqe_pos =3D GET_AEQ_ELEM(eq, eq->cons_idx);=0D
+=0D
+			/* Data in HW is in Big endian format. */=0D
+			aeqe_desc =3D be32_to_cpu(aeqe_pos->desc);=0D
+=0D
+			/*=0D
+			 * HW updates wrapped bit, when it adds eq element=0D
+			 * event.=0D
+			 */=0D
+			if (EQ_ELEM_DESC_GET(aeqe_desc, WRAPPED) !=3D=0D
+			    eq->wrapped) {=0D
+				err =3D 0;=0D
+				rte_atomic_thread_fence(rte_memory_order_acquire);=0D
+				break;=0D
+			}=0D
+=0D
+			if (timeout !=3D 0)=0D
+				usleep(HINIC3_AEQE_DESC_SIZE);=0D
+		} while (time_before(jiffies, end));=0D
+=0D
+		if (err !=3D 0) /**< Poll time out. */=0D
+			break;=0D
+		/* Handle the middle element of the event queue. */=0D
+		done =3D aeq_elem_handler(eq, aeqe_desc, aeqe_pos, param);=0D
+=0D
+		eq->cons_idx++;=0D
+		if (eq->cons_idx =3D=3D eq->eq_len) {=0D
+			eq->cons_idx =3D 0;=0D
+			eq->wrapped =3D !eq->wrapped;=0D
+		}=0D
+=0D
+		if (++eqe_cnt >=3D HINIC3_EQ_UPDATE_CI_STEP) {=0D
+			eqe_cnt =3D 0;=0D
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);=0D
+		}=0D
+	}=0D
+	/* Set the consumer index of the event queue. */=0D
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_dev_handle_aeq_event(struct hinic3_hwdev *hwdev, void *param)=0D
+{=0D
+	struct hinic3_eq *aeq =3D &hwdev->aeqs->aeq[0];=0D
+=0D
+	/* Clear resend timer cnt register. */=0D
+	hinic3_misx_intr_clear_resend_bit(hwdev, aeq->eq_irq.msix_entry_idx,=0D
+					  MSIX_RESEND_TIMER_CLEAR);=0D
+	hinic3_aeq_poll_msg(aeq, 0, param);=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_eqs.h b/drivers/net/hinic3/base=
/hinic3_eqs.h=0D
new file mode 100644=0D
index 0000000000..7617ed9589=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_eqs.h=0D
@@ -0,0 +1,98 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_EQS_H_=0D
+#define _HINIC3_EQS_H_=0D
+=0D
+#define HINIC3_MAX_AEQS	    4=0D
+#define HINIC3_MIN_AEQS	    2=0D
+#define HINIC3_EQ_MAX_PAGES 4=0D
+=0D
+#define HINIC3_AEQE_SIZE 64=0D
+=0D
+#define HINIC3_AEQE_DESC_SIZE 4=0D
+#define HINIC3_AEQE_DATA_SIZE (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)=0D
+=0D
+/* Linux is 1K, dpdk is 64. */=0D
+#define HINIC3_DEFAULT_AEQ_LEN 64=0D
+=0D
+#define HINIC3_MIN_EQ_PAGE_SIZE 0x1000	 /**< Min eq page size 1K Bytes. */=
=0D
+#define HINIC3_MAX_EQ_PAGE_SIZE 0x400000 /**< Max eq page size 4M Bytes */=
=0D
+=0D
+#define HINIC3_MIN_AEQ_LEN 64=0D
+#define HINIC3_MAX_AEQ_LEN \=0D
+	((HINIC3_MAX_EQ_PAGE_SIZE / HINIC3_AEQE_SIZE) * HINIC3_EQ_MAX_PAGES)=0D
+=0D
+#define EQ_IRQ_NAME_LEN 64=0D
+=0D
+enum hinic3_eq_intr_mode { HINIC3_INTR_MODE_ARMED, HINIC3_INTR_MODE_ALWAYS=
 };=0D
+=0D
+enum hinic3_eq_ci_arm_state { HINIC3_EQ_NOT_ARMED, HINIC3_EQ_ARMED };=0D
+=0D
+/* Structure for interrupt request information. */=0D
+struct irq_info {=0D
+	u16 msix_entry_idx; /**< IRQ corresponding index number. */=0D
+	u32 irq_id;	    /**< The IRQ number from OS. */=0D
+};=0D
+=0D
+#define HINIC3_RETRY_NUM 10=0D
+=0D
+enum hinic3_aeq_type {=0D
+	HINIC3_HW_INTER_INT =3D 0,=0D
+	HINIC3_MBX_FROM_FUNC =3D 1,=0D
+	HINIC3_MSG_FROM_MGMT_CPU =3D 2,=0D
+	HINIC3_API_RSP =3D 3,=0D
+	HINIC3_API_CHAIN_STS =3D 4,=0D
+	HINIC3_MBX_SEND_RSLT =3D 5,=0D
+	HINIC3_MAX_AEQ_EVENTS=0D
+};=0D
+=0D
+/* Structure for EQ(Event Queue) information. */=0D
+struct hinic3_eq {=0D
+	struct hinic3_hwdev *hwdev;=0D
+	u16 q_id;=0D
+	u32 page_size;=0D
+	u32 orig_page_size;=0D
+	u32 eq_len;=0D
+=0D
+	u32 cons_idx;=0D
+	u16 wrapped;=0D
+=0D
+	u16 elem_size;=0D
+	u16 num_pages;=0D
+	u32 num_elem_in_pg;=0D
+=0D
+	struct irq_info eq_irq;=0D
+=0D
+	const struct rte_memzone **eq_mz;=0D
+	rte_iova_t *dma_addr;=0D
+	u8 **virt_addr;=0D
+=0D
+	u16 poll_retry_nr;=0D
+};=0D
+=0D
+struct hinic3_aeq_elem {=0D
+	u8 aeqe_data[HINIC3_AEQE_DATA_SIZE];=0D
+	u32 desc;=0D
+};=0D
+=0D
+/* Structure for AEQs(Asynchronous Event Queues) information. */=0D
+struct hinic3_aeqs {=0D
+	struct hinic3_hwdev *hwdev;=0D
+=0D
+	struct hinic3_eq aeq[HINIC3_MAX_AEQS];=0D
+	u16 num_aeqs;=0D
+};=0D
+=0D
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);=0D
+=0D
+int hinic3_aeq_poll_msg(struct hinic3_eq *eq, u32 timeout, void *param);=0D
+=0D
+void hinic3_dev_handle_aeq_event(struct hinic3_hwdev *hwdev, void *param);=
=0D
+=0D
+#endif /**< _HINIC3_EQS_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

