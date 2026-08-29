Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F5C61DCB
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 10:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0702402E3;
	Sat, 29 Aug 2026 12:54:25 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CEED5402B6
 for <dev@dpdk.org>; Sat, 29 Aug 2026 12:54:24 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67T8DB9C3637760; Sat, 29 Aug 2026 03:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 2XJnitaYz17DepFNgmW0q96d5wuqv78Q6TYe4TWFWs=; b=AyDYyycQ0/LXqr5Ur
 MQnv17vcGY4zf/w7GeriLktvekesjXRbkBjPGIq9agk3WGd1hHV49SL9z8CCG4bL
 nAfnlxKeF9zYNmn5ild+9UazfAtajiv5+MluS9kGdxf8tXB5NhUztOvFRLeDGEmm
 8V57mZZqVsJR48HF92l/4lpRNsyxpVuCoEPaJfYpcBlmU4GlUq2Jn/IGO352TLbi
 vGmN4i9ZRQyEJMp8bkKLhNIXFliIGV6qZIt34QRnYzjKT5wd66Mi4CkC36EBpOV0
 IrRbx1s15ywSccApkgxUaBq8TdPuMQxPU41ObN5kiKfCAI+X23pD67Ls/qSMRdj7
 6xDDw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gbqj88m8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 03:54:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 29 Aug 2026 03:54:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 29 Aug 2026 03:54:22 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 4938A3F7084;
 Sat, 29 Aug 2026 03:54:20 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v0 1/3] common/cnxk: add O20 DPI DMA support
Date: Sat, 29 Aug 2026 16:24:07 +0530
Message-ID: <20260829105409.1160766-2-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829105409.1160766-1-vattunuru@marvell.com>
References: <20260829105409.1160766-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfX58nfCsXdN3Ob
 AnlrYN6bZ0NBqunnsZ8O6GbrK5pbtQaSA1pVnyuGjACFmc9Md0FPnP4lvLq/U6cHYKEqK6lvdOq
 ajBqOFoWDa0K9cgqdO0C37mpt+e9H3w=
X-Authority-Analysis: v=2.4 cv=EL82FVZC c=1 sm=1 tr=0 ts=6a92ba5f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=89g8sRju4ZhpO8gqZycA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: P1GHLT3eFeb6v7cxB1cz4X2aQ0ExAmzW
X-Proofpoint-GUID: P1GHLT3eFeb6v7cxB1cz4X2aQ0ExAmzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfX90EMRbkFnX0S
 PTmcS/pZyv8nqVchewKoQeloo3M4DFvn9FtaOkIzBClHT1tK4ZE46dyDP0kcI+FgBjNHoT8buBh
 HICcRWsYuqHOu4ENTN4p9FqpwwDvvWtO2gvxLeKizX/JT+Bb1asFRcSon18FuP/OlI9ghKWW+lD
 QE7LBu9R+B7/a17jiu1KRbEcjOks2BO3ayAv0qtDwr8JuZPc0oYZoXPYEG02dSBQq4A/3A9ELQv
 12Yi7onTi2ugGPUbxenk3QW6WjdZk4u5vuFwY3cNavEn1v6ZmqNvoQXtzYfsmEpvwA7AQRIwNZw
 lbEQnbBWUtS/ovXjGQEElPNBuXmNyKpILjrg4WdGNtm/OsyuQYKrh/pJRvo/9/sgtto57NBlhBs
 j7hj8oWdb1/lTOyDOVcTXP+FqFKz3WPwKS6AYpaIz769pmiSWFe6PlFqZHnGQB4PbDiADZrgD6g
 EOYmSUydwfbLUdzboCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Adds ROC support for O20 DPI DMA hardware.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/common/cnxk/hw/dpi.h                  |  72 +-
 drivers/common/cnxk/hw/rvu.h                  |   2 +
 drivers/common/cnxk/roc_constants.h           |   2 +
 drivers/common/cnxk/roc_dev.c                 |   1 +
 drivers/common/cnxk/roc_dpi.c                 | 683 +++++++++++++++++-
 drivers/common/cnxk/roc_dpi.h                 |  85 +++
 drivers/common/cnxk/roc_dpi_priv.h            |  34 +
 drivers/common/cnxk/roc_mbox.h                | 174 ++++-
 drivers/common/cnxk/roc_platform.h            |   8 +
 .../common/cnxk/roc_platform_base_symbols.c   |  18 +
 10 files changed, 1065 insertions(+), 14 deletions(-)

diff --git a/drivers/common/cnxk/hw/dpi.h b/drivers/common/cnxk/hw/dpi.h
index a34713dde6..8d5a5bd0e1 100644
--- a/drivers/common/cnxk/hw/dpi.h
+++ b/drivers/common/cnxk/hw/dpi.h
@@ -23,6 +23,27 @@
 #define DPI_VF_INT_ENA_W1C (0x110)
 #define DPI_VF_INT_ENA_W1S (0x118)
 
+/* DPI CN20K LF register offsets from VF_BAR2 */
+#define DPI_LF_CTL		    (0ull)
+#define DPI_LF_RINGX_CFG(x)	    ((0x20ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_BASE(x)	    ((0x30ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_RIDX(x)	    ((0x40ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_WIDX(x)	    ((0x50ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_RST(x)	    ((0x70ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_ISTAT(x)	    ((0x80ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_CMPL(x)	    ((0x90ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_INT	    (0x100ull)
+#define DPI_LF_RINGX_INT_W1S	    (0x108ull)
+#define DPI_LF_RINGX_INT_ENA_W1C    (0x110ull)
+#define DPI_LF_RINGX_INT_ENA_W1S    (0x118ull)
+#define DPI_LF_RINGX_ERR_STAT(x)    ((0x120ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_ERR	    (0x200ull)
+#define DPI_LF_RINGX_ERR_W1S	    (0x208ull)
+#define DPI_LF_RINGX_ERR_ENA_W1C    (0x210ull)
+#define DPI_LF_RINGX_ERR_ENA_W1S    (0x218ull)
+#define DPI_LF_RINGX_DMA_CNT(x)	    ((0x220ull | (uint64_t)(x) << 3))
+#define DPI_LF_RINGX_DMA_BCNT(x)    ((0x230ull | (uint64_t)(x) << 3))
+
 /**
  * Enumeration dpi_hdr_xtype_e
  *
@@ -54,6 +75,26 @@
 #define DPI_MIN_CMD_SIZE 8
 #define DPI_MAX_CMD_SIZE 64
 
+#define DPI_CMD_SIZE_64B  64
+#define DPI_CMD_SIZE_128B 128
+
+#define DPI_CMD_VLD_BIT BIT_ULL(63)
+
+#define DPI_LF_QCFG_QEN	  BIT_ULL(63)
+#define DPI_LF_QCFG_ISIZE BIT(11)
+#define DPI_LF_QUEUE_RST  BIT(0)
+
+#define DPI_LF_QIDX_WRAP_MASK 0x8000
+#define DPI_LF_QSIZE_MASK     0xFF
+#define DPI_LF_QIDX_MASK      0xFFF
+#define DPI_LF_QSIZE_SHIFT    56
+
+#define DPI_Q_RIDX(x) ((x)&0xFFF)
+#define DPI_Q_WIDX(x) ((x)&0xFFF)
+
+#define DPI_Q_RIDX_WRAP(x) (((x) >> 15) & 0x1)
+#define DPI_Q_WIDX_WRAP(x) (((x) >> 15) & 0x1)
+
 /**
  * Structure dpi_instr_hdr_s for CN9K
  *
@@ -61,7 +102,7 @@
  */
 union dpi_instr_hdr_s {
 	uint64_t u[4];
-	struct dpi_cn9k_instr_hdr_s_s {
+	struct dpi_cn9k_instr_hdr_s {
 		uint64_t tag : 32;
 		uint64_t tt : 2;
 		uint64_t grp : 10;
@@ -95,7 +136,7 @@ union dpi_instr_hdr_s {
 		/* Word 3 - End */
 	} cn9k;
 
-	struct dpi_cn10k_instr_hdr_s_s {
+	struct dpi_cn10k_instr_hdr_s {
 		uint64_t nfst : 4;
 		uint64_t reserved_4_5 : 2;
 		uint64_t nlst : 4;
@@ -128,6 +169,33 @@ union dpi_instr_hdr_s {
 		uint64_t reserved_192_255 : 64;
 		/* Word 3 - End */
 	} cn10k;
+
+	struct dpi_cn20k_instr_hdr_s {
+		uint64_t nfst : 3;
+		uint64_t reserved_3 : 1;
+		uint64_t nlst : 3;
+		uint64_t reserved_7 : 1;
+		uint64_t msix_int : 1;
+		uint64_t ct : 3;
+		uint64_t chan : 14;
+		uint64_t reserved_26_29 : 4;
+		uint64_t aura : 20;
+		uint64_t xt : 2;
+		uint64_t ivec : 9;
+		uint64_t fe : 1;
+		uint64_t reserved_62 : 1;
+		uint64_t vld : 1;
+		/* Word 0 - End */
+		uint64_t ptr : 64;
+		/* Word 1 - End */
+		uint64_t tag : 32;
+		uint64_t tt : 2;
+		uint64_t grp : 10;
+		uint64_t reserved_107_127 : 20;
+		/* Word 2 - End */
+		uint64_t reserved_128_191 : 64;
+		/* Word 3 - End */
+	} cn20k;
 };
 
 #endif /*__DEV_DPI_HW_H__*/
diff --git a/drivers/common/cnxk/hw/rvu.h b/drivers/common/cnxk/hw/rvu.h
index 6f02d1e3d2..01f19b0a16 100644
--- a/drivers/common/cnxk/hw/rvu.h
+++ b/drivers/common/cnxk/hw/rvu.h
@@ -169,6 +169,8 @@
 #define RVU_BLOCK_ADDR_R_START (0x14ull)
 #define RVU_BLOCK_ADDR_REE0    (0x14ull)
 #define RVU_BLOCK_ADDR_REE1    (0x15ull)
+#define RVU_BLOCK_ADDR_DPI0    (0x18ULL)
+#define RVU_BLOCK_ADDR_DPI1    (0x19ULL)
 #define RVU_BLOCK_ADDR_MBOX    (0x1bULL)
 
 #define RVU_VF_INT_VEC_MBOX (0x0ull)
diff --git a/drivers/common/cnxk/roc_constants.h b/drivers/common/cnxk/roc_constants.h
index 795869c9df..3218e641f0 100644
--- a/drivers/common/cnxk/roc_constants.h
+++ b/drivers/common/cnxk/roc_constants.h
@@ -47,6 +47,8 @@
 #define PCI_DEVID_CNXK_RVU_ESWITCH_VF 0xA0E1
 #define PCI_DEVID_CNXK_RVU_BPHY_PF    0xA0E4
 #define PCI_DEVID_CNXK_RVU_BPHY_VF    0xA0E5
+#define PCI_DEVID_CN20K_DPI_PF        0xA0E8
+#define PCI_DEVID_CN20K_DPI_VF        0xA0E9
 
 #define PCI_DEVID_CN9K_CGX  0xA059
 #define PCI_DEVID_CN10K_RPM 0xA060
diff --git a/drivers/common/cnxk/roc_dev.c b/drivers/common/cnxk/roc_dev.c
index 61aa4b3075..e2b717a214 100644
--- a/drivers/common/cnxk/roc_dev.c
+++ b/drivers/common/cnxk/roc_dev.c
@@ -1401,6 +1401,7 @@ dev_vf_hwcap_update(struct plt_pci_device *pci_dev, struct dev *dev)
 	case PCI_DEVID_CNXK_RVU_NIX_INL_VF:
 	case PCI_DEVID_CNXK_RVU_BPHY_VF:
 	case PCI_DEVID_CNXK_RVU_ESWITCH_VF:
+	case PCI_DEVID_CN20K_DPI_VF:
 		dev->hwcap |= DEV_HWCAP_F_VF;
 		break;
 	}
diff --git a/drivers/common/cnxk/roc_dpi.c b/drivers/common/cnxk/roc_dpi.c
index 71edfcbf9b..39d20accb0 100644
--- a/drivers/common/cnxk/roc_dpi.c
+++ b/drivers/common/cnxk/roc_dpi.c
@@ -6,10 +6,14 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <stdarg.h>
 
 #include "roc_api.h"
 #include "roc_priv.h"
 
+#define ROC_DPI_DEV_NAME     "roc_dpi_dev_"
+#define ROC_DPI_DEV_NAME_LEN (sizeof(ROC_DPI_DEV_NAME) + PCI_PRI_STR_SIZE)
+
 #define DPI_PF_MBOX_SYSFS_ENTRY "dpi_device_config"
 
 static inline int
@@ -56,17 +60,225 @@ roc_dpi_wait_queue_idle(struct roc_dpi *roc_dpi)
 	return 0;
 }
 
+void
+dpi_lf_ena_dis(struct roc_dpi_lf *lf, uint8_t enb)
+{
+	uint64_t reg;
+	int ring_idx;
+
+	for (ring_idx = 0; ring_idx < ROC_DPI_LF_RINGS; ring_idx++) {
+		reg = plt_read64(lf->rbase + DPI_LF_RINGX_CFG(ring_idx));
+
+		if (enb)
+			reg |= DPI_LF_QCFG_QEN;
+		else
+			reg &= ~DPI_LF_QCFG_QEN;
+
+		plt_write64(reg, lf->rbase + DPI_LF_RINGX_CFG(ring_idx));
+	}
+}
+
+int
+dpi_lf_reset(struct roc_dpi_lf *lf)
+{
+	uint64_t start_cycle;
+	uint64_t wait_cycles;
+	uintptr_t reg_addr;
+	int ring_idx;
+
+	wait_cycles = (DPI_LF_RESET_TMO_US * plt_tsc_hz()) / 1000000;
+
+	for (ring_idx = 0; ring_idx < ROC_DPI_LF_RINGS; ring_idx++) {
+		reg_addr = lf->rbase + DPI_LF_RINGX_RST(ring_idx);
+		plt_write64(DPI_LF_QUEUE_RST, reg_addr);
+
+		start_cycle = plt_tsc_cycles();
+		while (plt_read64(reg_addr) & DPI_LF_QUEUE_RST) {
+			if (plt_tsc_cycles() - start_cycle >= wait_cycles) {
+				plt_err("DPI LF[%u]: ring[%u] reset timed out", lf->slot, ring_idx);
+				return -ETIMEDOUT;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int
+roc_dpi_access_pair_group_create(struct roc_dpi_lf *lf, rte_uuid_t domain_id, rte_uuid_t token,
+				 int16_t *group_id)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_access_group_alloc_req *req;
+	struct dpi_lf_access_group_alloc_rsp *rsp;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_access_group_alloc(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_blkaddr = lf->blk_addr;
+	mbox_memcpy(req->lf_handle, domain_id, sizeof(rte_uuid_t));
+	mbox_memcpy(req->access_key, token, sizeof(rte_uuid_t));
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc)
+		goto exit;
+
+	*group_id = rsp->group_id;
+	lf->group_id = rsp->group_id;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_access_pair_group_destroy(struct roc_dpi_lf *lf, int16_t group_id)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_access_group_free_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_access_group_free(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_blkaddr = lf->blk_addr;
+	req->group_id = group_id;
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_access_pair_group_join(struct roc_dpi_lf *lf, rte_uuid_t domain_id, rte_uuid_t token,
+			       int16_t group_id)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_access_group_join_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_access_group_join(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	mbox_memcpy(req->lf_handle, domain_id, sizeof(rte_uuid_t));
+	mbox_memcpy(req->access_key, token, sizeof(rte_uuid_t));
+	req->dpi_blkaddr = lf->blk_addr;
+	req->group_id = group_id;
+
+	rc = mbox_process(mbox);
+	if (rc)
+		goto exit;
+
+	lf->group_id = group_id;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_access_pair_group_leave(struct roc_dpi_lf *lf, int16_t group_id)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_access_group_leave_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_access_group_leave(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_blkaddr = lf->blk_addr;
+	req->group_id = group_id;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_access_pair_group_handler_get(struct roc_dpi_lf *lf, int16_t group_id, rte_uuid_t domain_id,
+				      uint16_t *handler)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_access_group_handle_get_req *req;
+	struct dpi_lf_access_group_handle_get_rsp *rsp;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_access_group_handle_get(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	mbox_memcpy(req->lf_handle, domain_id, sizeof(rte_uuid_t));
+	req->dpi_blkaddr = lf->blk_addr;
+	req->group_id = group_id;
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc)
+		goto exit;
+
+	*handler = rsp->handle;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
-roc_dpi_enable(struct roc_dpi *dpi)
+roc_dpi_reset(struct roc_dpi *dpi)
 {
-	plt_write64(0x1, dpi->rbase + DPI_VDMA_EN);
+	uint16_t i;
+	int rc = 0;
+
+	if (roc_model_is_cn20k()) {
+		for (i = 0; i < dpi->nr_lfs; i++) {
+			rc |= dpi_lf_reset(&dpi->lfs[i]);
+			if (rc)
+				plt_err("Reset failed for DPI LF - %u", i);
+		}
+	}
+
+	return rc;
+}
+
+int
+roc_dpi_enable(struct roc_dpi *roc_dpi)
+{
+	uint16_t i;
+
+	if (roc_model_is_cn20k()) {
+		for (i = 0; i < roc_dpi->nr_lfs; i++)
+			dpi_lf_ena_dis(&roc_dpi->lfs[i], true);
+	} else {
+		plt_write64(0x1, roc_dpi->rbase + DPI_VDMA_EN);
+	}
+
 	return 0;
 }
 
 int
-roc_dpi_disable(struct roc_dpi *dpi)
+roc_dpi_disable(struct roc_dpi *roc_dpi)
 {
-	plt_write64(0x0, dpi->rbase + DPI_VDMA_EN);
+	uint16_t i;
+
+	if (roc_model_is_cn20k()) {
+		for (i = 0; i < roc_dpi->nr_lfs; i++)
+			dpi_lf_ena_dis(&roc_dpi->lfs[i], false);
+	} else {
+		plt_write64(0x0, roc_dpi->rbase + DPI_VDMA_EN);
+	}
+
 	return 0;
 }
 
@@ -154,28 +366,481 @@ roc_dpi_configure_v2(struct roc_dpi *roc_dpi, uint32_t chunk_sz, uint64_t aura,
 	return rc;
 }
 
+int
+dpi_lf_attach(struct dev *dev, uint8_t blk_addr, bool modify, uint16_t nb_lf)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct dpi_rsrc_attach_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_attach_resources(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_lfs = nb_lf;
+	req->dpilfs = 1;
+	req->modify = modify;
+	req->dpi_blkaddr = blk_addr;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+dpi_lf_detach(struct dev *dev)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	uint8_t blk_addr = RVU_BLOCK_ADDR_DPI0;
+	struct dpi_rsrc_detach *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_detach_resources(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_blkaddr = blk_addr;
+	req->dpilfs = 1;
+	req->partial = 1;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+dpi_chan_tbl_alloc(struct dev *dev, uint8_t blk_addr, uint16_t tbl_sz)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct dpi_lf_chan_tbl_alloc_req *req;
+	struct dpi_lf_chan_tbl_alloc_rsp *rsp;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_alloc(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->tbl_size = tbl_sz;
+	req->dpi_blkaddr = blk_addr;
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc)
+		goto exit;
+	rc = rsp->tbl_num;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+dpi_chan_tbl_free(struct dev *dev, uint8_t blk_addr, uint16_t tbl_num)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct dpi_lf_chan_tbl_free_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_free(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->tbl_num = tbl_num;
+	req->dpi_blkaddr = blk_addr;
+
+	rc = mbox_process(mbox);
+
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_lf_chan_tbl_select(struct roc_dpi_lf *lf)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_chan_tbl_select_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_select(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->lf_slot = lf->slot;
+	req->chan_tbl = lf->chan_tbl;
+	req->dpi_blkaddr = lf->blk_addr;
+	req->ena = true;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_lf_chan_tbl_ena_dis(struct roc_dpi_lf *lf, bool ena)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_chan_tbl_ena_dis_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_ena_dis(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->lf_slot = lf->slot;
+	req->dpi_blkaddr = lf->blk_addr;
+	req->ena_dis = ena;
+
+	rc = mbox_process(mbox);
+
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+dpi_chan_tbl_update(struct dev *dev, uint8_t blk_addr, uint16_t chan_tbl, uint64_t *tbl,
+		    uint16_t off, uint16_t nb_entries)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct dpi_lf_chan_tbl_update_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_update(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	mbox_memcpy(req->config, tbl, nb_entries * sizeof(uint64_t));
+
+	req->chan_tbl = chan_tbl;
+	req->num_entries = nb_entries;
+	req->idx_offset = off;
+	req->dpi_blkaddr = blk_addr;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_lf_chan_tbl_update(struct roc_dpi_lf *lf, uint64_t *config, uint16_t offset,
+			   uint16_t entries)
+{
+	if (entries > DPI_LF_CHAN_TBL_UPDATE_SIZE)
+		return -EINVAL;
+
+	return dpi_chan_tbl_update(lf->dev, lf->blk_addr, lf->chan_tbl, config, offset, entries);
+}
+
+int
+dpi_chan_tbl_ena_dis(struct dev *dev, uint32_t blkaddr, uint16_t lfid, uint16_t chan_tbl,
+		     bool enable)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct dpi_lf_chan_tbl_select_req *req;
+	int rc;
+
+	req = mbox_alloc_msg_dpi_lf_chan_tbl_select(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->chan_tbl = chan_tbl;
+	req->lf_slot = lfid;
+	req->ena = enable;
+	req->dpi_blkaddr = blkaddr;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_dpi_lf_chan_tbl_alloc(struct roc_dpi_lf *lf, uint16_t tbl_sz)
+{
+	int rc;
+
+	rc = dpi_chan_tbl_alloc(lf->dev, lf->blk_addr, tbl_sz);
+	if (rc < 0)
+		return rc;
+
+	lf->chan_tbl_sz = tbl_sz;
+	lf->chan_tbl = rc;
+	return 0;
+}
+
+int
+roc_dpi_lf_chan_tbl_free(struct roc_dpi_lf *lf)
+{
+	return dpi_chan_tbl_free(lf->dev, lf->blk_addr, lf->chan_tbl);
+}
+
+int
+roc_dpi_lf_pffunc_cfg(struct roc_dpi_lf *lf)
+{
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_pf_func_cfg_req *req;
+	int rc = -ENOSPC;
+
+	req = mbox_alloc_msg_dpi_lf_pf_func_cfg(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->dpi_blkaddr = lf->blk_addr;
+	req->sso_pf_func = idev_sso_pffunc_get();
+	req->npa_pf_func = idev_npa_pffunc_get();
+	req->lf_slot = lf->slot;
+
+	rc = mbox_process(mbox);
+
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+dpi_lf_queue_configure(struct roc_dpi_lf_que *que, struct roc_dpi_lf_ring_cfg *rcfg)
+{
+	char nm[ROC_DPI_DEV_NAME_LEN] = {'\0'};
+	struct roc_dpi_lf *lf = que->lf;
+	const struct plt_memzone *mz;
+	uint64_t reg;
+
+	snprintf(nm, sizeof(nm), "%s_%u_%u_%x", "dpi_lf_q", lf->slot, rcfg->ring_idx,
+		 lf->dev->pf_func);
+	mz = plt_memzone_reserve_aligned(nm, que->qsize * que->cmd_len, 0, 128);
+	if (!mz) {
+		plt_err("Cannot alloc buffer for DPI LF ring command buffer: %s", nm);
+		return -ENOMEM;
+	}
+
+	que->mz = mz;
+	que->cmd_base = (uint64_t *)mz->addr;
+
+	reg = plt_read64(lf->rbase + DPI_LF_RINGX_CFG(rcfg->ring_idx));
+
+	if (rcfg->isize)
+		reg |= DPI_LF_QCFG_ISIZE;
+	else
+		reg &= ~DPI_LF_QCFG_ISIZE;
+
+	reg |= (((uint64_t)que->first_skip << 20) | ((uint64_t)que->later_skip << 28));
+	reg |= BIT_ULL(7);
+
+	plt_write64(reg, lf->rbase + DPI_LF_RINGX_CFG(rcfg->ring_idx));
+
+	reg = plt_read64(lf->rbase + DPI_LF_RINGX_BASE(rcfg->ring_idx));
+	reg = (uint64_t)que->cmd_base;
+	reg |= ((((que->mz->len >> 10) - 1) & DPI_LF_QSIZE_MASK) << DPI_LF_QSIZE_SHIFT);
+	plt_write64(reg, lf->rbase + DPI_LF_RINGX_BASE(rcfg->ring_idx));
+
+	return 0;
+}
+
+int
+roc_dpi_lf_ring_init(struct roc_dpi_lf_que *que, struct roc_dpi_lf_ring_cfg *rcfg)
+{
+	struct roc_dpi_lf *lf = que->lf;
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_ring_cfg_req *req;
+	int rc = -ENOSPC;
+
+	req = mbox_alloc_msg_dpi_lf_ring_cfg(mbox);
+	if (req == NULL)
+		goto fail;
+
+	req->dpi_blkaddr = lf->blk_addr;
+	req->lf_slot = lf->slot;
+	req->xtype = rcfg->xtype;
+	req->rport = rcfg->rport;
+	req->wport = rcfg->wport;
+	req->ring_idx = rcfg->ring_idx;
+	req->pri = rcfg->pri;
+
+	rc = mbox_process(mbox);
+	if (rc)
+		goto fail;
+
+	rc = dpi_lf_queue_configure(que, rcfg);
+
+fail:
+	mbox_put(mbox);
+	return rc;
+}
+
+void
+roc_dpi_lf_ring_fini(struct roc_dpi_lf_que *que)
+{
+	if (que->mz) {
+		plt_memzone_free(que->mz);
+		que->mz = NULL;
+	}
+}
+
+int
+roc_dpi_lf_ring_chan_cfg(struct roc_dpi_lf_que *que, union roc_dpi_lf_ccfg *ccfg)
+{
+	struct roc_dpi_lf *lf = que->lf;
+	struct mbox *mbox = mbox_get(lf->dev->mbox);
+	struct dpi_lf_chan_cfg_req *req;
+	int rc = -ENOSPC;
+
+	req = mbox_alloc_msg_dpi_lf_chan_cfg(mbox);
+	if (req == NULL)
+		goto fail;
+
+	req->dpi_blkaddr = lf->blk_addr;
+	req->def_config = ccfg->u;
+	req->lf_slot = lf->slot;
+	req->ring_idx = que == lf->queue ? 0 : 1;
+
+	rc = mbox_process(mbox);
+
+fail:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+dpi_lf_init(struct roc_dpi_lf *lf, struct dev *dev, uint8_t slot)
+{
+	uint8_t blk_addr = RVU_BLOCK_ADDR_DPI0;
+
+	lf->dev = dev;
+	lf->slot = slot;
+	lf->rbase = dev->bar2 + (RVU_BLOCK_ADDR_DPI0 << 20 | slot << 12);
+	lf->queue[0].lf = lf;
+	lf->queue[1].lf = lf;
+	lf->blk_addr = blk_addr;
+	return 0;
+}
+
+int
+roc_dpi_rsrc_init(struct roc_dpi *roc_dpi)
+{
+	struct plt_pci_device *pci_dev = roc_dpi->pci_dev;
+	struct dpi *dpi = roc_dpi_to_dpi_priv(roc_dpi);
+	uint8_t blk_addr = RVU_BLOCK_ADDR_DPI0;
+	char name[ROC_DPI_DEV_NAME_LEN];
+	const struct plt_memzone *mz;
+	struct dev *dev = &dpi->dev;
+	uint16_t slot;
+	int rc;
+
+	mz = plt_memzone_reserve_cache_align(plt_pci_dev_name(name, ROC_DPI_DEV_NAME, pci_dev),
+					     roc_dpi->nr_lfs * sizeof(struct roc_dpi_lf));
+	if (!mz)
+		return -ENOMEM;
+
+	roc_dpi->mz = mz;
+	roc_dpi->lfs = mz->addr;
+
+	rc = dpi_lf_attach(dev, blk_addr, true, roc_dpi->nr_lfs);
+	if (rc) {
+		plt_err("Could not attach LFs");
+		plt_memzone_free(mz);
+		roc_dpi->mz = NULL;
+		roc_dpi->lfs = NULL;
+		return rc;
+	}
+
+	for (slot = 0; slot < roc_dpi->nr_lfs; slot++)
+		dpi_lf_init(&(roc_dpi->lfs[slot]), dev, slot);
+
+	return rc;
+}
+
+int
+roc_dpi_rsrc_fini(struct roc_dpi *roc_dpi)
+{
+	struct dpi *dpi = roc_dpi_to_dpi_priv(roc_dpi);
+	struct dev *dev = &dpi->dev;
+	struct roc_dpi_lf_que *que;
+	struct roc_dpi_lf *lf;
+	uint16_t slot, qid;
+	int rc;
+
+	roc_dpi_disable(roc_dpi);
+
+	for (slot = 0; slot < roc_dpi->nr_lfs; slot++) {
+		lf = &roc_dpi->lfs[slot];
+
+		for (qid = 0; qid < ROC_DPI_LF_RINGS; qid++) {
+			que = &lf->queue[qid];
+			if (que->mz) {
+				plt_memzone_free(que->mz);
+				que->mz = NULL;
+			}
+		}
+	}
+
+	rc = dpi_lf_detach(dev);
+	plt_memzone_free(roc_dpi->mz);
+	roc_dpi->mz = NULL;
+	roc_dpi->lfs = NULL;
+
+	return rc;
+}
+
 int
 roc_dpi_dev_init(struct roc_dpi *roc_dpi, uint8_t offset)
 {
 	struct plt_pci_device *pci_dev = roc_dpi->pci_dev;
+	struct dpi *dpi = roc_dpi_to_dpi_priv(roc_dpi);
+	struct dev *dev = &dpi->dev;
 	uint16_t vfid;
+	int rc = 0;
 
 	roc_dpi->rbase = pci_dev->mem_resource[0].addr;
-	vfid = ((pci_dev->addr.devid & 0x1F) << 3) | (pci_dev->addr.function & 0x7);
-	vfid -= 1;
-	roc_dpi->vfid = vfid;
-	idev_dma_cs_offset_set(offset);
 
-	return 0;
+	if (roc_model_is_cn20k()) {
+		rc = dev_init(dev, pci_dev);
+		if (rc)
+			plt_err("Failed to init dpi roc device");
+	} else {
+		vfid = ((pci_dev->addr.devid & 0x1F) << 3) | (pci_dev->addr.function & 0x7);
+		vfid -= 1;
+		roc_dpi->vfid = vfid;
+		idev_dma_cs_offset_set(offset);
+	}
+
+	return rc;
 }
 
 int
 roc_dpi_dev_fini(struct roc_dpi *roc_dpi)
 {
 	struct plt_pci_device *pci_dev = roc_dpi->pci_dev;
+	struct dpi *dpi = roc_dpi_to_dpi_priv(roc_dpi);
+	struct dev *dev = &dpi->dev;
 	dpi_mbox_msg_t mbox_msg;
 	int rc;
 
+	if (roc_model_is_cn20k()) {
+		rc = dev_fini(dev, pci_dev);
+		return rc;
+	}
+
 	rc = roc_dpi_wait_queue_idle(roc_dpi);
 	if (rc)
 		return rc;
diff --git a/drivers/common/cnxk/roc_dpi.h b/drivers/common/cnxk/roc_dpi.h
index 3a11559df9..6f12ad2c4b 100644
--- a/drivers/common/cnxk/roc_dpi.h
+++ b/drivers/common/cnxk/roc_dpi.h
@@ -5,16 +5,80 @@
 #ifndef _ROC_DPI_H_
 #define _ROC_DPI_H_
 
+#define ROC_DPI_LF_RINGS       2
+#define ROC_DPI_MAX_LFS	       256
+#define ROC_DPI_LF_CHAN_TBL_SZ 4096
+
+struct roc_dpi_lf_ring_cfg {
+	uint8_t ring_idx;
+	uint8_t xtype;
+	uint8_t rport;
+	uint8_t wport;
+	uint8_t pri;
+	uint8_t isize;
+};
+
+union roc_dpi_lf_ccfg {
+	uint64_t u;
+	struct {
+		uint64_t vf_func : 12;
+		uint64_t pf_func : 4;
+		uint64_t st : 8;
+		uint64_t rsvd_24_31 : 8;
+		uint64_t pasid : 20;
+		uint64_t pasid_ctrl : 2;
+		uint64_t th : 1;
+		uint64_t ph : 2;
+		uint64_t rsvd_57_62 : 6;
+		uint64_t valid : 1;
+	};
+	struct {
+		uint32_t type;
+		uint16_t src_key;
+		uint16_t dst_key;
+	};
+};
+
+struct roc_dpi_lf_que {
+	const struct plt_memzone *mz;
+	uint64_t *cmd_base;
+	struct roc_dpi_lf *lf;
+	uint16_t qsize;
+	uint16_t widx;
+	uint8_t cmd_len;
+	uint8_t first_skip;
+	uint8_t later_skip;
+} __plt_cache_aligned;
+
+struct roc_dpi_lf {
+	struct roc_dpi_lf_que queue[ROC_DPI_LF_RINGS];
+	uintptr_t rbase;
+	struct dev *dev;
+	uint16_t chan_tbl;
+	uint16_t chan_tbl_sz;
+	uint16_t slot;
+	uint16_t blk_addr;
+	int group_id;
+};
+
 struct roc_dpi {
 	struct plt_pci_device *pci_dev;
+	const struct plt_memzone *mz;
+	struct roc_dpi_lf *lfs;
 	uint8_t *rbase;
 	uint16_t vfid;
 	uint8_t priority;
+	uint16_t nr_lfs;
+
+#define ROC_DPI_MEM_SZ (4 * 1024)
+	uint8_t reserved[ROC_DPI_MEM_SZ] __plt_cache_aligned;
 } __plt_cache_aligned;
 
 int __roc_api roc_dpi_dev_init(struct roc_dpi *roc_dpi, uint8_t offset);
 int __roc_api roc_dpi_dev_fini(struct roc_dpi *roc_dpi);
 
+int __roc_api roc_dpi_rsrc_init(struct roc_dpi *roc_dpi);
+int __roc_api roc_dpi_rsrc_fini(struct roc_dpi *roc_dpi);
 int __roc_api roc_dpi_configure(struct roc_dpi *dpi, uint32_t chunk_sz, uint64_t aura,
 				uint64_t chunk_base);
 int __roc_api roc_dpi_configure_v2(struct roc_dpi *roc_dpi, uint32_t chunk_sz, uint64_t aura,
@@ -22,5 +86,26 @@ int __roc_api roc_dpi_configure_v2(struct roc_dpi *roc_dpi, uint32_t chunk_sz, u
 int __roc_api roc_dpi_enable(struct roc_dpi *dpi);
 int __roc_api roc_dpi_wait_queue_idle(struct roc_dpi *dpi);
 int __roc_api roc_dpi_disable(struct roc_dpi *dpi);
+int __roc_api roc_dpi_reset(struct roc_dpi *dpi);
+
+int __roc_api roc_dpi_lf_ring_init(struct roc_dpi_lf_que *que, struct roc_dpi_lf_ring_cfg *rcfg);
+void __roc_api roc_dpi_lf_ring_fini(struct roc_dpi_lf_que *que);
+int __roc_api roc_dpi_lf_pffunc_cfg(struct roc_dpi_lf *lf);
+int __roc_api roc_dpi_lf_ring_chan_cfg(struct roc_dpi_lf_que *que, union roc_dpi_lf_ccfg *cfg);
+int __roc_api roc_dpi_lf_chan_tbl_alloc(struct roc_dpi_lf *lf, uint16_t tbl_sz);
+int __roc_api roc_dpi_lf_chan_tbl_free(struct roc_dpi_lf *lf);
+int __roc_api roc_dpi_lf_chan_tbl_select(struct roc_dpi_lf *lf);
+int __roc_api roc_dpi_lf_chan_tbl_ena_dis(struct roc_dpi_lf *lf, bool ena);
+int __roc_api roc_dpi_lf_chan_tbl_update(struct roc_dpi_lf *lf, uint64_t *config, uint16_t offset,
+					 uint16_t entries);
+int __roc_api roc_dpi_lf_dump(struct roc_dpi_lf *lf, FILE *file);
 
+int __roc_api roc_dpi_access_pair_group_create(struct roc_dpi_lf *lf, rte_uuid_t domain_id,
+					       rte_uuid_t token, int16_t *group_id);
+int __roc_api roc_dpi_access_pair_group_destroy(struct roc_dpi_lf *lf, int16_t group_id);
+int __roc_api roc_dpi_access_pair_group_join(struct roc_dpi_lf *lf, rte_uuid_t domain_id,
+					     rte_uuid_t token, int16_t group_id);
+int __roc_api roc_dpi_access_pair_group_leave(struct roc_dpi_lf *lf, int16_t group_id);
+int __roc_api roc_dpi_access_pair_group_handler_get(struct roc_dpi_lf *lf, int16_t group_id,
+						    rte_uuid_t domain_id, uint16_t *handler);
 #endif
diff --git a/drivers/common/cnxk/roc_dpi_priv.h b/drivers/common/cnxk/roc_dpi_priv.h
index 05b6751ca6..3051abc979 100644
--- a/drivers/common/cnxk/roc_dpi_priv.h
+++ b/drivers/common/cnxk/roc_dpi_priv.h
@@ -18,6 +18,7 @@
 #define DPI_QUEUE_OPEN_V2 0x5
 
 #define DPI_QUEUE_IDLE_TMO_MS 1E3
+#define DPI_LF_RESET_TMO_US   10000
 
 typedef union dpi_mbox_msg_t {
 	uint64_t u[2];
@@ -43,4 +44,37 @@ typedef union dpi_mbox_msg_t {
 	} s;
 } dpi_mbox_msg_t;
 
+struct dpi {
+	struct plt_pci_device *pci_dev;
+	struct dev dev;
+	uint16_t lf_msix_off[ROC_DPI_MAX_LFS];
+	uint8_t lf_blkaddr[ROC_DPI_MAX_LFS];
+};
+
+static inline struct dpi *
+roc_dpi_to_dpi_priv(struct roc_dpi *roc_dpi)
+{
+	return (struct dpi *)&roc_dpi->reserved[0];
+}
+
+static inline struct roc_dpi *
+dpi_priv_to_roc_dpi(struct dpi *dpi)
+{
+	return (struct roc_dpi *)((char *)dpi - offsetof(struct roc_dpi, reserved));
+}
+
+int dpi_lf_reset(struct roc_dpi_lf *lf);
+void dpi_lf_ena_dis(struct roc_dpi_lf *lf, uint8_t enb);
+int dpi_lfs_attach(struct dev *dev, uint8_t blkaddr, bool modify, uint16_t nb_lf);
+int dpi_lfs_detach(struct dev *dev);
+int dpi_lf_attach(struct dev *dev, uint8_t blkaddr, bool modify, uint16_t nb_lf);
+int dpi_lf_detach(struct dev *dev);
+int dpi_lf_init(struct roc_dpi_lf *lf, struct dev *dev, uint8_t slot);
+int dpi_chan_tbl_alloc(struct dev *dev, uint8_t blk_addr, uint16_t tbl_sz);
+int dpi_chan_tbl_free(struct dev *dev, uint8_t blk_addr, uint16_t tbl_num);
+int dpi_chan_tbl_ena_dis(struct dev *dev, uint32_t dpi_blkaddr, uint16_t lfid, uint16_t chan_tbl,
+			 bool enable);
+int dpi_chan_tbl_update(struct dev *dev, uint8_t blk_addr, uint16_t chan_tbl, uint64_t *tbl,
+			uint16_t off, uint16_t nb_entries);
+
 #endif
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 52ecde6563..48d0b6f895 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -198,7 +198,7 @@ struct mbox_msghdr {
 	M(CPT_GET_CAPS, 0xBFD, cpt_caps_get, msg_req, cpt_caps_rsp_msg)        \
 	M(CPT_GET_ENG_GRP, 0xBFF, cpt_eng_grp_get, cpt_eng_grp_req,            \
 	  cpt_eng_grp_rsp)                                                     \
-	M(CPT_SET_QUEUE_PRI, 0xBFB, cpt_set_que_pri, cpt_queue_pri_req_msg,	\
+	M(CPT_SET_QUEUE_PRI, 0xBFB, cpt_set_que_pri, cpt_queue_pri_req_msg,     \
 			       msg_rsp)					\
 	/* REE mbox IDs (range 0xE00 - 0xFFF) */                               \
 	M(REE_CONFIG_LF, 0xE01, ree_config_lf, ree_lf_req_msg, msg_rsp)        \
@@ -401,7 +401,34 @@ struct mbox_msghdr {
 	M(MCS_FIPS_KEY_SET, 0xa045, mcs_fips_key_set, mcs_fips_key_req, msg_rsp)                   \
 	M(MCS_FIPS_BLOCK_SET, 0xa046, mcs_fips_block_set, mcs_fips_block_req, msg_rsp)             \
 	M(MCS_FIPS_START, 0xa047, mcs_fips_start, mcs_fips_req, msg_rsp)                           \
-	M(MCS_FIPS_RESULT_GET, 0xa048, mcs_fips_result_get, mcs_fips_req, mcs_fips_result_rsp)
+	M(MCS_FIPS_RESULT_GET, 0xa048, mcs_fips_result_get, mcs_fips_req, mcs_fips_result_rsp)     \
+	/* DPI mbox IDs (range 0xc000 - 0xcfff) */                                                 \
+	M(DPI_ATTACH_RESOURCES, 0xc000, dpi_attach_resources, dpi_rsrc_attach_req, msg_rsp)        \
+	M(DPI_DETACH_RESOURCES, 0xc001, dpi_detach_resources, dpi_rsrc_detach, msg_rsp)            \
+	M(DPI_LF_RING_CFG, 0xc002, dpi_lf_ring_cfg, dpi_lf_ring_cfg_req, msg_rsp)                  \
+	M(DPI_LF_PF_FUNC_CFG, 0xc003, dpi_lf_pf_func_cfg, dpi_lf_pf_func_cfg_req, msg_rsp)         \
+	M(DPI_LF_FREE, 0xc004, dpi_lf_free, msg_req, msg_rsp)                                      \
+	M(DPI_FREE_RSRC_CNT, 0xc005, dpi_free_rsrc_cnt, msg_req, dpi_free_rsrcs_rsp)               \
+	M(DPI_LF_CHAN_CFG, 0xc006, dpi_lf_chan_cfg, dpi_lf_chan_cfg_req, msg_rsp)                  \
+	M(DPI_LF_CHAN_TBL_ALLOC, 0xc007, dpi_lf_chan_tbl_alloc, dpi_lf_chan_tbl_alloc_req,         \
+	  dpi_lf_chan_tbl_alloc_rsp)                                                               \
+	M(DPI_LF_CHAN_TBL_FREE, 0xc008, dpi_lf_chan_tbl_free, dpi_lf_chan_tbl_free_req, msg_rsp)   \
+	M(DPI_LF_CHAN_TBL_SELECT, 0xc009, dpi_lf_chan_tbl_select, dpi_lf_chan_tbl_select_req,      \
+	  msg_rsp)                                                                                 \
+	M(DPI_LF_CHAN_TBL_ENA_DIS, 0xc00a, dpi_lf_chan_tbl_ena_dis, dpi_lf_chan_tbl_ena_dis_req,   \
+	  msg_rsp)                                                                                 \
+	M(DPI_LF_CHAN_TBL_UPDATE, 0xc00b, dpi_lf_chan_tbl_update, dpi_lf_chan_tbl_update_req,      \
+	  msg_rsp)                                                                                 \
+	M(DPI_LF_ACCESS_GROUP_ALLOC, 0xc00d, dpi_lf_access_group_alloc,                            \
+	  dpi_lf_access_group_alloc_req,  dpi_lf_access_group_alloc_rsp)                           \
+	M(DPI_LF_ACCESS_GROUP_JOIN, 0xc00e, dpi_lf_access_group_join, dpi_lf_access_group_join_req,\
+	  msg_rsp)                                                                                 \
+	M(DPI_LF_ACCESS_GROUP_LEAVE, 0xc00f, dpi_lf_access_group_leave,                            \
+	  dpi_lf_access_group_leave_req, msg_rsp)                                                  \
+	M(DPI_LF_ACCESS_GROUP_HANDLE_GET, 0xc010, dpi_lf_access_group_handle_get,                  \
+	  dpi_lf_access_group_handle_get_req, dpi_lf_access_group_handle_get_rsp)                  \
+	M(DPI_LF_ACCESS_GROUP_FREE, 0xc011, dpi_lf_access_group_free, dpi_lf_access_group_free_req,\
+	  msg_rsp)
 
 /* Messages initiated by AF (range 0xC00 - 0xDFF) */
 #define MBOX_UP_CGX_MESSAGES                                                   \
@@ -1318,7 +1345,6 @@ struct mcs_fips_result_rsp {
 	uint64_t __io icv_bits63_0;
 	uint8_t __io result_pass;
 };
-
 /* NPA mbox message formats */
 
 /* NPA mailbox error codes
@@ -3318,4 +3344,146 @@ struct rep_event {
 	struct rep_evt_data evt_data;
 };
 
+/* DPI mbox message formats */
+
+struct dpi_lf_chan_tbl_alloc_req {
+	struct mbox_msghdr hdr;
+
+	uint32_t __io dpi_blkaddr;
+	uint32_t __io tbl_size; /* No of table entries */
+};
+
+struct dpi_lf_chan_tbl_alloc_rsp {
+	struct mbox_msghdr hdr;
+
+	uint16_t __io tbl_num; /* Allocated channel table num */
+};
+
+struct dpi_lf_chan_tbl_free_req {
+	struct mbox_msghdr hdr;
+
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io tbl_num;
+};
+
+struct dpi_lf_ring_cfg_req {
+	struct mbox_msghdr hdr;
+
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io lf_slot;
+	uint8_t __io xtype; /* Transfer type */
+	uint8_t __io pri;   /* Queue priority */
+	uint8_t __io ring_idx;
+	uint8_t __io err_rsp_en;
+	uint8_t __io wport; /* Write port */
+	uint8_t __io rport; /* Read port */
+};
+
+struct dpi_rsrc_attach_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint8_t __io modify : 1;
+	uint8_t __io dpilfs : 1;
+	uint16_t __io dpi_lfs;
+};
+
+struct dpi_rsrc_detach {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint8_t __io partial : 1;
+	uint8_t __io dpilfs : 1;
+	uint8_t __io dpi1_lfs : 1;
+};
+
+struct dpi_free_rsrcs_rsp {
+	struct mbox_msghdr hdr;
+	uint8_t __io dpi;
+	uint8_t __io dpi1;
+};
+
+struct dpi_lf_pf_func_cfg_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io npa_pf_func;
+	uint16_t __io sso_pf_func;
+	uint16_t __io lf_slot;
+};
+
+struct dpi_lf_chan_cfg_req {
+	struct mbox_msghdr hdr;
+	uint64_t __io def_config; /* DPI_CHANNEL_TABLE_S value */
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io lf_slot;
+	uint16_t __io ring_idx;
+};
+
+struct dpi_lf_chan_tbl_select_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io lf_slot;
+	uint16_t __io chan_tbl; /* Channel table  */
+	uint8_t __io ena;
+};
+
+struct dpi_lf_chan_tbl_ena_dis_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io lf_slot;
+	uint8_t __io ena_dis;
+};
+
+struct dpi_lf_chan_tbl_update_req {
+	struct mbox_msghdr hdr;
+#define DPI_LF_CHAN_TBL_UPDATE_SIZE 64
+	uint64_t __io config[DPI_LF_CHAN_TBL_UPDATE_SIZE]; /* DPI_CHANNEL_TABLE_S value */
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io idx_offset;  /* Offset within the channel table */
+	uint16_t __io num_entries; /* Num of entries to be updated from idx_offset */
+	uint16_t __io chan_tbl;
+};
+
+struct dpi_lf_access_group_alloc_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint8_t __io lf_handle[16];
+	uint8_t __io access_key[16];
+};
+
+struct dpi_lf_access_group_alloc_rsp {
+	struct mbox_msghdr hdr;
+	uint16_t __io group_id;
+};
+
+struct dpi_lf_access_group_join_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint8_t __io lf_handle[16];
+	uint8_t __io access_key[16];
+	uint16_t __io group_id;
+};
+
+struct dpi_lf_access_group_leave_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io group_id;
+};
+
+struct dpi_lf_access_group_handle_get_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint8_t __io lf_handle[16];
+	uint16_t __io group_id;
+};
+
+struct dpi_lf_access_group_handle_get_rsp {
+	struct mbox_msghdr hdr;
+	uint16_t __io handle;
+};
+
+struct dpi_lf_access_group_free_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io dpi_blkaddr;
+	uint16_t __io group_id;
+};
+
 #endif /* __ROC_MBOX_H__ */
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index ac4f76473f..082397ed4e 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -347,6 +347,14 @@ extern int cnxk_logtype_esw;
 	RTE_LOG_DP_LINE_PREFIX(DEBUG, CNXK, "%s():%u ", __func__ RTE_LOG_COMMA __LINE__, \
 		__VA_ARGS__)
 
+/* append dbdf to name */
+#define plt_pci_dev_name(devname, name, dev)                                                       \
+	({                                                                                         \
+		snprintf((devname), sizeof(devname), "%s" PCI_PRI_FMT, (name), (dev)->addr.domain, \
+			 (dev)->addr.bus, (dev)->addr.devid, (dev)->addr.function);                \
+		devname;                                                                           \
+	})
+
 #ifdef __cplusplus
 #define CNXK_PCI_ID(subsystem_dev, dev)                                        \
 {                                                                      \
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 063cb21aae..232129d903 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -70,6 +70,24 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure_v2)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_init)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_ring_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_ring_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_pffunc_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_ring_chan_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_select)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_access_pair_group_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_access_pair_group_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_access_pair_group_join)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_access_pair_group_leave)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_access_pair_group_handler_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_rsrc_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_rsrc_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_lf_chan_tbl_update)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_tx_rule)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_delete_rule)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_rx_rule)
-- 
2.34.1

