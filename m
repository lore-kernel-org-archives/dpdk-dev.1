Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695BBC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2674E406A2;
	Tue, 11 Feb 2025 18:05:43 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DDA9A4066F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:05:41 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BFVaV1011849
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:05:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=7HA7txZWBp1lVuC9rA4pqER
 jh2DVPF5OzY1VsxFYohs=; b=Ivj6Li23hhLfEjNf8VkhHEe13Z1W8/Hh+Ey8VyN
 7pLVSd4W34k7lpV3DsKzbcf0DM6TCVFJDf4piks2IMKNz9KJzW/yw2UwXfStbLBL
 3u3CzdnctC/JUy6UexDsz2Ia1U2XlENaE/b1chl/IUvKS7a0hMj8ZSUEdVpvl6oH
 AgYtYGZ812gv/WwPNxSpB1drU+dakA0TFAfzjyXiLYbUCsDuhSh9ECSZzh9HY8JN
 oeGoBV3RRcPe1I8vnYfZFr1CGmxeiOql6acgQLh/4fRk1qMLJt2NVYh7MAHwu3eY
 iW+k7+r45/56WSrKJeTb1hnyvR20ve0moAtgpx+pylTAE5w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44r990r80c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:05:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Feb 2025 09:05:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Feb 2025 09:05:39 -0800
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 85E5B3F7085;
 Tue, 11 Feb 2025 09:05:38 -0800 (PST)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v0 1/1] dma/cnxk: support pending count per HW DMA channel
Date: Tue, 11 Feb 2025 22:35:32 +0530
Message-ID: <20250211170532.1650221-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H1V7TltFORPc1GesWIC3hlnvMYSMAkff
X-Proofpoint-GUID: H1V7TltFORPc1GesWIC3hlnvMYSMAkff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
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

Adds code changes to maintain pending count per hw dma channel
instead of per vchan. This enables ringing dbell for exact number
of dma commands present in the DPI queue.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c    | 17 +++----
 drivers/dma/cnxk/cnxk_dmadev.h    |  3 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c | 74 +++++++++++++------------------
 3 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index e7be3767b2..90bb69011f 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -288,12 +288,12 @@ cnxk_dmadev_start(struct rte_dma_dev *dev)
 	int i, j, rc = 0;
 	void *chunk;
 
+	dpivf->total_pnum_words = 0;
+
 	for (i = 0; i < dpivf->num_vchans; i++) {
 		dpi_conf = &dpivf->conf[i];
 		dpi_conf->c_desc.head = 0;
 		dpi_conf->c_desc.tail = 0;
-		dpi_conf->pnum_words = 0;
-		dpi_conf->pending = 0;
 		dpi_conf->desc_idx = 0;
 		for (j = 0; j < dpi_conf->c_desc.max_cnt + 1; j++)
 			dpi_conf->c_desc.compl_ptr[j * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
@@ -442,8 +442,7 @@ cnxk_damdev_burst_capacity(const void *dev_private, uint16_t vchan)
 	uint16_t burst_cap;
 
 	burst_cap = dpi_conf->c_desc.max_cnt -
-		    ((dpi_conf->stats.submitted - dpi_conf->stats.completed) + dpi_conf->pending) +
-		    1;
+		    (dpi_conf->stats.submitted - dpi_conf->stats.completed) + 1;
 
 	return burst_cap;
 }
@@ -452,18 +451,16 @@ static int
 cnxk_dmadev_submit(void *dev_private, uint16_t vchan)
 {
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
-	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
-	uint32_t num_words = dpi_conf->pnum_words;
+	uint32_t num_words = dpivf->total_pnum_words;
+	RTE_SET_USED(vchan);
 
-	if (!dpi_conf->pnum_words)
+	if (!num_words)
 		return 0;
 
 	rte_wmb();
 	plt_write64(num_words, dpivf->rdpi.rbase + DPI_VDMA_DBELL);
 
-	dpi_conf->stats.submitted += dpi_conf->pending;
-	dpi_conf->pnum_words = 0;
-	dpi_conf->pending = 0;
+	dpivf->total_pnum_words = 0;
 
 	return 0;
 }
diff --git a/drivers/dma/cnxk/cnxk_dmadev.h b/drivers/dma/cnxk/cnxk_dmadev.h
index a95ce13f62..9a232a5464 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.h
+++ b/drivers/dma/cnxk/cnxk_dmadev.h
@@ -98,8 +98,6 @@ struct cnxk_dpi_cdesc_data_s {
 struct cnxk_dpi_conf {
 	union cnxk_dpi_instr_cmd cmd;
 	struct cnxk_dpi_cdesc_data_s c_desc;
-	uint16_t pnum_words;
-	uint16_t pending;
 	uint16_t desc_idx;
 	struct rte_dma_stats stats;
 	uint64_t completed_offset;
@@ -111,6 +109,7 @@ struct cnxk_dpi_vf_s {
 	uint64_t *chunk_base;
 	uint16_t chunk_head;
 	uint16_t chunk_size_m1;
+	uint16_t total_pnum_words;
 	struct rte_mempool *chunk_pool;
 	struct cnxk_dpi_conf conf[CNXK_DPI_MAX_VCHANS_PER_QUEUE];
 	RTE_ATOMIC(rte_mcslock_t *) mcs_lock;
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index 26591235c6..36fc40c7e0 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -281,16 +281,15 @@ cnxk_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t d
 
 	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
 		rte_wmb();
-		plt_write64(dpi_conf->pnum_words + CNXK_DPI_DW_PER_SINGLE_CMD,
+		plt_write64(dpivf->total_pnum_words + CNXK_DPI_DW_PER_SINGLE_CMD,
 			    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-		dpi_conf->stats.submitted += dpi_conf->pending + 1;
-		dpi_conf->pnum_words = 0;
-		dpi_conf->pending = 0;
+		dpivf->total_pnum_words = 0;
 	} else {
-		dpi_conf->pnum_words += CNXK_DPI_DW_PER_SINGLE_CMD;
-		dpi_conf->pending++;
+		dpivf->total_pnum_words += CNXK_DPI_DW_PER_SINGLE_CMD;
 	}
 
+	dpi_conf->stats.submitted += 1;
+
 	return dpi_conf->desc_idx++;
 }
 
@@ -337,16 +336,15 @@ cnxk_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 
 	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
 		rte_wmb();
-		plt_write64(dpi_conf->pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
+		plt_write64(dpivf->total_pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
 			    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-		dpi_conf->stats.submitted += dpi_conf->pending + 1;
-		dpi_conf->pnum_words = 0;
-		dpi_conf->pending = 0;
+		dpivf->total_pnum_words = 0;
 	} else {
-		dpi_conf->pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
-		dpi_conf->pending++;
+		dpivf->total_pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
 	}
 
+	dpi_conf->stats.submitted += 1;
+
 	return dpi_conf->desc_idx++;
 }
 
@@ -383,16 +381,15 @@ cn10k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t
 
 	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
 		rte_wmb();
-		plt_write64(dpi_conf->pnum_words + CNXK_DPI_DW_PER_SINGLE_CMD,
+		plt_write64(dpivf->total_pnum_words + CNXK_DPI_DW_PER_SINGLE_CMD,
 			    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-		dpi_conf->stats.submitted += dpi_conf->pending + 1;
-		dpi_conf->pnum_words = 0;
-		dpi_conf->pending = 0;
+		dpivf->total_pnum_words = 0;
 	} else {
-		dpi_conf->pnum_words += 8;
-		dpi_conf->pending++;
+		dpivf->total_pnum_words += CNXK_DPI_DW_PER_SINGLE_CMD;
 	}
 
+	dpi_conf->stats.submitted += 1;
+
 	return dpi_conf->desc_idx++;
 }
 
@@ -426,16 +423,15 @@ cn10k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 
 	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
 		rte_wmb();
-		plt_write64(dpi_conf->pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
+		plt_write64(dpivf->total_pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
 			    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-		dpi_conf->stats.submitted += dpi_conf->pending + 1;
-		dpi_conf->pnum_words = 0;
-		dpi_conf->pending = 0;
+		dpivf->total_pnum_words = 0;
 	} else {
-		dpi_conf->pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
-		dpi_conf->pending++;
+		dpivf->total_pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
 	}
 
+	dpi_conf->stats.submitted += 1;
+
 	return dpi_conf->desc_idx++;
 }
 
@@ -495,15 +491,13 @@ cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 
 		if (op->flags & RTE_DMA_OP_FLAG_SUBMIT) {
 			rte_wmb();
-			plt_write64(dpi_conf->pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
+			plt_write64(dpivf->total_pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
 				    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-			dpi_conf->stats.submitted += dpi_conf->pending + 1;
-			dpi_conf->pnum_words = 0;
-			dpi_conf->pending = 0;
+			dpivf->total_pnum_words = 0;
 		} else {
-			dpi_conf->pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
-			dpi_conf->pending++;
+			dpivf->total_pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
 		}
+		dpi_conf->stats.submitted += 1;
 		rte_mcslock_unlock(&dpivf->mcs_lock, &mcs_lock_me);
 	}
 
@@ -567,15 +561,13 @@ cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_event
 
 		if (op->flags & RTE_DMA_OP_FLAG_SUBMIT) {
 			rte_wmb();
-			plt_write64(dpi_conf->pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
+			plt_write64(dpivf->total_pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
 				    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-			dpi_conf->stats.submitted += dpi_conf->pending + 1;
-			dpi_conf->pnum_words = 0;
-			dpi_conf->pending = 0;
+			dpivf->total_pnum_words = 0;
 		} else {
-			dpi_conf->pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
-			dpi_conf->pending++;
+			dpivf->total_pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
 		}
+		dpi_conf->stats.submitted += 1;
 		rte_mcslock_unlock(&dpivf->mcs_lock, &mcs_lock_me);
 	}
 
@@ -636,15 +628,13 @@ cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 
 		if (op->flags & RTE_DMA_OP_FLAG_SUBMIT) {
 			rte_wmb();
-			plt_write64(dpi_conf->pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
+			plt_write64(dpivf->total_pnum_words + CNXK_DPI_CMD_LEN(nb_src, nb_dst),
 				    dpivf->rdpi.rbase + DPI_VDMA_DBELL);
-			dpi_conf->stats.submitted += dpi_conf->pending + 1;
-			dpi_conf->pnum_words = 0;
-			dpi_conf->pending = 0;
+			dpivf->total_pnum_words = 0;
 		} else {
-			dpi_conf->pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
-			dpi_conf->pending++;
+			dpivf->total_pnum_words += CNXK_DPI_CMD_LEN(nb_src, nb_dst);
 		}
+		dpi_conf->stats.submitted += 1;
 		rte_mcslock_unlock(&dpivf->mcs_lock, &mcs_lock_me);
 	}
 
-- 
2.34.1

