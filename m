Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B15C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:37:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB76A40667;
	Wed, 26 Mar 2025 20:37:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 13F8540661
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:36:57 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QIUUtW006660
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 3aSfAalnB9SUl+8MGQ5BpnN9Vt/6hDv6A9J3ZJzrKw=; b=SweXPbeUv8MYYzjBQ
 obEBBI0B/AuUti849DwlorH7aDCn9osUWIkzeOONhJkLQVlJac9qAPYxRjhaIGLT
 6/B6eu6yNy6TDapBfLydZTp52KAAJl1fkXG4Iu9UTPtW2IlmMiv/MqcxCd2FMH/y
 t/cOSmlqVz+UoaOnZjDmypRJjhsS5xYCG892m5vI/+cRbosD1YGxtKUKtfj6YFFt
 e+NXiCvuRZrjM/VyED7tb2Uuu8WVHRyLyMguWt74shH7QSbCq9sdnGvt/9RCZ3Jq
 nGwZRd/joxewokiuns8tZ3r9gig1oWPq3/F4jHkg4PsQswCqix57Vaen16X+cjQl
 xr33w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45meyk1d8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 12:36:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 12:36:52 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 21FCE5C68F3;
 Wed, 26 Mar 2025 12:36:50 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC v2 2/3] dma/cnxk: implement enqueue dequeue ops
Date: Thu, 27 Mar 2025 01:06:35 +0530
Message-ID: <20250326193637.12557-3-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326193637.12557-1-pbhagavatula@marvell.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250326193637.12557-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G+wcE8k5 c=1 sm=1 tr=0 ts=67e45759 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=KWS-mKsX8iLGy-ohL_cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: J0DRBdzPvIxK5hw7EkdzBN4YMEmzq1FY
X-Proofpoint-GUID: J0DRBdzPvIxK5hw7EkdzBN4YMEmzq1FY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Implement DMA enqueue/dequeue operations when
application enables it via configuration.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c    |  25 +++++-
 drivers/dma/cnxk/cnxk_dmadev.h    |   7 ++
 drivers/dma/cnxk/cnxk_dmadev_fp.c | 140 ++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 90bb69011f..1ce3563250 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -19,7 +19,7 @@ cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_inf
 	dev_info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_MEM_TO_DEV |
 			     RTE_DMA_CAPA_DEV_TO_MEM | RTE_DMA_CAPA_DEV_TO_DEV |
 			     RTE_DMA_CAPA_OPS_COPY | RTE_DMA_CAPA_OPS_COPY_SG |
-			     RTE_DMA_CAPA_M2D_AUTO_FREE;
+			     RTE_DMA_CAPA_M2D_AUTO_FREE | RTE_DMA_CAPA_OPS_ENQ_DEQ;
 	if (roc_feature_dpi_has_priority()) {
 		dev_info->dev_capa |= RTE_DMA_CAPA_PRI_POLICY_SP;
 		dev_info->nb_priorities = CN10K_DPI_MAX_PRI;
@@ -114,6 +114,21 @@ cnxk_dmadev_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf,
 	if (roc_feature_dpi_has_priority())
 		dpivf->rdpi.priority = conf->priority;
 
+	if (conf->enable_enq_deq) {
+		dev->fp_obj->copy = NULL;
+		dev->fp_obj->fill = NULL;
+		dev->fp_obj->submit = NULL;
+		dev->fp_obj->copy_sg = NULL;
+		dev->fp_obj->completed = NULL;
+		dev->fp_obj->completed_status = NULL;
+
+		dev->fp_obj->enqueue = cnxk_dma_ops_enqueue;
+		dev->fp_obj->dequeue = cnxk_dma_ops_dequeue;
+
+		if (roc_model_is_cn10k())
+			dev->fp_obj->enqueue = cn10k_dma_ops_enqueue;
+	}
+
 	return 0;
 }
 
@@ -270,6 +285,14 @@ cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 		return -ENOMEM;
 	}
 
+	size = (max_desc * sizeof(struct rte_dma_op *));
+	dpi_conf->c_desc.ops = rte_zmalloc(NULL, size, RTE_CACHE_LINE_SIZE);
+	if (dpi_conf->c_desc.ops == NULL) {
+		plt_err("Failed to allocate for ops array");
+		rte_free(dpi_conf->c_desc.compl_ptr);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < max_desc; i++)
 		dpi_conf->c_desc.compl_ptr[i * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
 
diff --git a/drivers/dma/cnxk/cnxk_dmadev.h b/drivers/dma/cnxk/cnxk_dmadev.h
index 9a232a5464..18039e43fb 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.h
+++ b/drivers/dma/cnxk/cnxk_dmadev.h
@@ -93,6 +93,7 @@ struct cnxk_dpi_cdesc_data_s {
 	uint16_t head;
 	uint16_t tail;
 	uint8_t *compl_ptr;
+	struct rte_dma_op **ops;
 };
 
 struct cnxk_dpi_conf {
@@ -131,5 +132,11 @@ int cn10k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iov
 int cn10k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge *src,
 			 const struct rte_dma_sge *dst, uint16_t nb_src, uint16_t nb_dst,
 			 uint64_t flags);
+uint16_t cnxk_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops,
+			      uint16_t nb_ops);
+uint16_t cn10k_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops,
+			       uint16_t nb_ops);
+uint16_t cnxk_dma_ops_dequeue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops,
+			      uint16_t nb_ops);
 
 #endif
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index 36fc40c7e0..419425c386 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -665,3 +665,143 @@ cnxk_dma_adapter_dequeue(uintptr_t get_work1)
 
 	return (uintptr_t)op;
 }
+
+uint16_t
+cnxk_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const struct rte_dma_sge *fptr, *lptr;
+	uint16_t src, dst, nwords = 0;
+	struct rte_dma_op *op;
+	uint16_t space, i;
+	uint8_t *comp_ptr;
+	uint64_t hdr[4];
+	int rc;
+
+	space = (dpi_conf->c_desc.max_cnt + 1) -
+		((dpi_conf->c_desc.tail - dpi_conf->c_desc.head) & dpi_conf->c_desc.max_cnt);
+	space = RTE_MIN(space, nb_ops);
+
+	for (i = 0; i < space; i++) {
+		op = ops[i];
+		comp_ptr =
+			&dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
+		dpi_conf->c_desc.ops[dpi_conf->c_desc.tail] = op;
+		CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+
+		hdr[1] = dpi_conf->cmd.u | ((op->flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 37);
+		hdr[2] = (uint64_t)comp_ptr;
+
+		src = op->nb_src;
+		dst = op->nb_dst;
+		/*
+		 * For inbound case, src pointers are last pointers.
+		 * For all other cases, src pointers are first pointers.
+		 */
+		if (((dpi_conf->cmd.u >> 48) & DPI_HDR_XTYPE_MASK) == DPI_XTYPE_INBOUND) {
+			fptr = &op->src_dst_seg[src];
+			lptr = &op->src_dst_seg[0];
+			RTE_SWAP(src, dst);
+		} else {
+			fptr = &op->src_dst_seg[0];
+			lptr = &op->src_dst_seg[src];
+		}
+		hdr[0] = ((uint64_t)dst << 54) | (uint64_t)src << 48;
+
+		rc = __dpi_queue_write_sg(dpivf, hdr, fptr, lptr, src, dst);
+		if (rc) {
+			CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+			goto done;
+		}
+		nwords += CNXK_DPI_CMD_LEN(src, dst);
+	}
+
+done:
+	if (nwords) {
+		rte_wmb();
+		plt_write64(nwords, dpivf->rdpi.rbase + DPI_VDMA_DBELL);
+		dpi_conf->stats.submitted += i;
+	}
+
+	return i;
+}
+
+uint16_t
+cn10k_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	uint16_t space, i, nwords = 0;
+	struct rte_dma_op *op;
+	uint16_t src, dst;
+	uint8_t *comp_ptr;
+	uint64_t hdr[4];
+	int rc;
+
+	space = (dpi_conf->c_desc.max_cnt + 1) -
+		((dpi_conf->c_desc.tail - dpi_conf->c_desc.head) & dpi_conf->c_desc.max_cnt);
+	space = RTE_MIN(space, nb_ops);
+
+	for (i = 0; i < space; i++) {
+		op = ops[i];
+		src = op->nb_src;
+		dst = op->nb_dst;
+		comp_ptr =
+			&dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
+		dpi_conf->c_desc.ops[dpi_conf->c_desc.tail] = op;
+		CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+
+		hdr[0] = dpi_conf->cmd.u | (dst << 6) | src;
+		hdr[1] = (uint64_t)comp_ptr;
+		hdr[2] = (1UL << 47) | ((op->flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 43);
+
+		rc = __dpi_queue_write_sg(dpivf, hdr, &op->src_dst_seg[0], &op->src_dst_seg[src],
+					  src, dst);
+		if (rc) {
+			CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+			goto done;
+		}
+		nwords += CNXK_DPI_CMD_LEN(src, dst);
+	}
+
+done:
+	if (nwords) {
+		rte_wmb();
+		plt_write64(nwords, dpivf->rdpi.rbase + DPI_VDMA_DBELL);
+		dpi_conf->stats.submitted += i;
+	}
+
+	return i;
+}
+
+uint16_t
+cnxk_dma_ops_dequeue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	struct cnxk_dpi_cdesc_data_s *c_desc = &dpi_conf->c_desc;
+	struct rte_dma_op *op;
+	uint16_t space, cnt;
+	uint8_t status;
+
+	space = (c_desc->tail - c_desc->head) & c_desc->max_cnt;
+	space = RTE_MIN(nb_ops, space);
+	for (cnt = 0; cnt < space; cnt++) {
+		status = c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET];
+		op = c_desc->ops[c_desc->head];
+		op->status = status;
+		ops[cnt] = op;
+		if (status) {
+			if (status == CNXK_DPI_REQ_CDATA)
+				break;
+			dpi_conf->stats.errors++;
+		}
+		c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
+		CNXK_DPI_STRM_INC(*c_desc, head);
+	}
+
+	dpi_conf->stats.completed += cnt;
+
+	return cnt;
+}
-- 
2.43.0

