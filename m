Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17270C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 18:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC7240676;
	Mon, 19 May 2025 20:56:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5A640676
 for <dev@dpdk.org>; Mon, 19 May 2025 20:56:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JHr1CM014038;
 Mon, 19 May 2025 11:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 3KXSvyk+KriLRh/KVv7BecYZ3BFEihAPNDP+AUadwI=; b=eOi+S1wxGtM97NMZY
 q5eUDz7WUYWIY0LFZt0CRRFPSigqSluatN4+mqi0Wo5819ML5Ic5LEen/cKxB80a
 LCjOsiKJm1sHoguSe1lzO4BQpMovsqrpsVeaF4L/oLWlInno6NJmu1CFeBvUo+Rq
 9mv51EtJH/JO4dWt9o6mQULEEH2HutDrqJmQmJvQkNblZnMXv74vya4xxdwPf97k
 THsLsUQ6FZcIN7x8BkuOCfTmJNVPoZuG8cJgMUsRHjx/5HCqLGpitxcslihp3Pvm
 V10ANmr1Mq2odYrU0CcIogy+2w9LrFONvgj52IT6aiArIpeoW+gaZ/R4hT+4TeT9
 p0bNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46qb79ashx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 11:56:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 11:56:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 11:56:37 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 8711E3F7080;
 Mon, 19 May 2025 11:56:32 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>
CC: <g.singh@nxp.com>, <sachin.saxena@nxp.com>, <hemant.agrawal@nxp.com>,
 <fengchengwen@huawei.com>, <bruce.richardson@intel.com>,
 <kevin.laatz@intel.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v2 4/5] dma/cnxk: implement enqueue dequeue ops
Date: Tue, 20 May 2025 00:26:03 +0530
Message-ID: <20250519185604.5584-5-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519185604.5584-1-pbhagavatula@marvell.com>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
 <20250519185604.5584-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z2KGM9oY8KM3zqF2qtH1GtkLL_dQTPgl
X-Proofpoint-ORIG-GUID: Z2KGM9oY8KM3zqF2qtH1GtkLL_dQTPgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3NiBTYWx0ZWRfXxe/Em5swypCX
 Nm3LrvJaqkmDaP7bjdLQO49hcmFLYvbdaexr+SgyMbLHhEZmJx+Py/OGvKAzlmmobwVaBcoUTrH
 QWcdgMcmKZ6PP5102KpztOry8H0ql0Nag13ylz/aO13DPbJ53Ii0Pylgn39v7QGjS8efofJ+NqH
 bust6yWCKAzUB7Vbx7ROnHmedbXtREWr37YtMyI0/13myCavmjU946sSavhEPG+9uPGNWEoTh6S
 3YUYG8TfCxewSeeH4da7PViYtg72Bxz/LZc+yFcKEbSi1C/ZVxCySyy2PF3PYX9EpdlgfUsXxUZ
 AKp6IMTB7RJit1mYRTbFUXakFw9CzZ+NjnP7qoEpBo7f/ZLlU1b9Eld4CnJU4hjM0nb/8S5n95D
 ois+lx9TCc/nmE93LLnv+URVL6FGgYanV+ykW+3+eAOy0gNYpkVzrDIV/pnqSYw1uwYDza98
X-Authority-Analysis: v=2.4 cv=YvQPR5YX c=1 sm=1 tr=0 ts=682b7ee6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=xKmJUHBexbacZ4eocFsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
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
 drivers/dma/cnxk/cnxk_dmadev.c    |  78 ++++++++----
 drivers/dma/cnxk/cnxk_dmadev.h    |   7 ++
 drivers/dma/cnxk/cnxk_dmadev_fp.c | 189 ++++++++++++++++++++++++++----
 3 files changed, 232 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 90bb69011f..f12a15aef7 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -7,6 +7,7 @@
 #include <cnxk_dmadev.h>
 
 static int cnxk_stats_reset(struct rte_dma_dev *dev, uint16_t vchan);
+static void cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t enable_enq_deq);
 
 static int
 cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info, uint32_t size)
@@ -19,7 +20,7 @@ cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_inf
 	dev_info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_MEM_TO_DEV |
 			     RTE_DMA_CAPA_DEV_TO_MEM | RTE_DMA_CAPA_DEV_TO_DEV |
 			     RTE_DMA_CAPA_OPS_COPY | RTE_DMA_CAPA_OPS_COPY_SG |
-			     RTE_DMA_CAPA_M2D_AUTO_FREE;
+			     RTE_DMA_CAPA_M2D_AUTO_FREE | RTE_DMA_CAPA_OPS_ENQ_DEQ;
 	if (roc_feature_dpi_has_priority()) {
 		dev_info->dev_capa |= RTE_DMA_CAPA_PRI_POLICY_SP;
 		dev_info->nb_priorities = CN10K_DPI_MAX_PRI;
@@ -114,6 +115,8 @@ cnxk_dmadev_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf,
 	if (roc_feature_dpi_has_priority())
 		dpivf->rdpi.priority = conf->priority;
 
+	cnxk_set_fp_ops(dev, conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ);
+
 	return 0;
 }
 
@@ -270,6 +273,14 @@ cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
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
 
@@ -382,23 +393,25 @@ cnxk_dmadev_completed(void *dev_private, uint16_t vchan, const uint16_t nb_cpls,
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
 	struct cnxk_dpi_cdesc_data_s *c_desc = &dpi_conf->c_desc;
+	const uint16_t max_cnt = c_desc->max_cnt;
 	uint8_t status;
 	int cnt;
 
 	for (cnt = 0; cnt < nb_cpls; cnt++) {
-		status = c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET];
+		status = c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET];
 		if (status) {
 			if (status == CNXK_DPI_REQ_CDATA)
 				break;
 			*has_error = 1;
 			dpi_conf->stats.errors++;
-			c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET] =
+			c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET] =
 				CNXK_DPI_REQ_CDATA;
-			CNXK_DPI_STRM_INC(*c_desc, head);
+			c_desc->head++;
 			break;
 		}
-		c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
-		CNXK_DPI_STRM_INC(*c_desc, head);
+		c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET] =
+			CNXK_DPI_REQ_CDATA;
+		c_desc->head++;
 	}
 
 	dpi_conf->stats.completed += cnt;
@@ -414,18 +427,20 @@ cnxk_dmadev_completed_status(void *dev_private, uint16_t vchan, const uint16_t n
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
 	struct cnxk_dpi_cdesc_data_s *c_desc = &dpi_conf->c_desc;
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
 	int cnt;
 
 	for (cnt = 0; cnt < nb_cpls; cnt++) {
-		status[cnt] = c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET];
+		status[cnt] = c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET];
 		if (status[cnt]) {
 			if (status[cnt] == CNXK_DPI_REQ_CDATA)
 				break;
 
 			dpi_conf->stats.errors++;
 		}
-		c_desc->compl_ptr[c_desc->head * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
-		CNXK_DPI_STRM_INC(*c_desc, head);
+		c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET] =
+			CNXK_DPI_REQ_CDATA;
+		c_desc->head++;
 	}
 
 	dpi_conf->stats.completed += cnt;
@@ -528,6 +543,37 @@ cnxk_stats_reset(struct rte_dma_dev *dev, uint16_t vchan)
 	return 0;
 }
 
+static void
+cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t ena_enq_deq)
+{
+
+	dev->fp_obj->copy = cnxk_dmadev_copy;
+	dev->fp_obj->copy_sg = cnxk_dmadev_copy_sg;
+	dev->fp_obj->submit = cnxk_dmadev_submit;
+	dev->fp_obj->completed = cnxk_dmadev_completed;
+	dev->fp_obj->completed_status = cnxk_dmadev_completed_status;
+	dev->fp_obj->burst_capacity = cnxk_damdev_burst_capacity;
+
+	if (roc_model_is_cn10k()) {
+		dev->fp_obj->copy = cn10k_dmadev_copy;
+		dev->fp_obj->copy_sg = cn10k_dmadev_copy_sg;
+	}
+
+	if (ena_enq_deq) {
+		dev->fp_obj->copy = NULL;
+		dev->fp_obj->copy_sg = NULL;
+		dev->fp_obj->submit = NULL;
+		dev->fp_obj->completed = NULL;
+		dev->fp_obj->completed_status = NULL;
+
+		dev->fp_obj->enqueue = cnxk_dma_ops_enqueue;
+		dev->fp_obj->dequeue = cnxk_dma_ops_dequeue;
+
+		if (roc_model_is_cn10k())
+			dev->fp_obj->enqueue = cn10k_dma_ops_enqueue;
+	}
+}
+
 static const struct rte_dma_dev_ops cnxk_dmadev_ops = {
 	.dev_close = cnxk_dmadev_close,
 	.dev_configure = cnxk_dmadev_configure,
@@ -571,19 +617,7 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_de
 	dmadev->fp_obj->dev_private = dpivf;
 	dmadev->dev_ops = &cnxk_dmadev_ops;
 
-	dmadev->fp_obj->copy = cnxk_dmadev_copy;
-	dmadev->fp_obj->copy_sg = cnxk_dmadev_copy_sg;
-	dmadev->fp_obj->submit = cnxk_dmadev_submit;
-	dmadev->fp_obj->completed = cnxk_dmadev_completed;
-	dmadev->fp_obj->completed_status = cnxk_dmadev_completed_status;
-	dmadev->fp_obj->burst_capacity = cnxk_damdev_burst_capacity;
-
-	if (roc_model_is_cn10k()) {
-		dpivf->is_cn10k = true;
-		dmadev->fp_obj->copy = cn10k_dmadev_copy;
-		dmadev->fp_obj->copy_sg = cn10k_dmadev_copy_sg;
-	}
-
+	dpivf->is_cn10k = roc_model_is_cn10k();
 	dpivf->mcs_lock = NULL;
 	rdpi = &dpivf->rdpi;
 
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
index dea73c5b41..579aafa894 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -246,15 +246,16 @@ cnxk_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t d
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
 	uint64_t cmd[CNXK_DPI_DW_PER_SINGLE_CMD];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
 	uint8_t *comp_ptr;
 	int rc;
 
-	if (unlikely(((dpi_conf->c_desc.tail + 1) & dpi_conf->c_desc.max_cnt) ==
-		     dpi_conf->c_desc.head))
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
 		return -ENOSPC;
 
-	comp_ptr = &dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
-	CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
 
 	cmd[0] = (1UL << 54) | (1UL << 48);
 	cmd[1] = dpi_conf->cmd.u | ((flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 37);
@@ -276,7 +277,7 @@ cnxk_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t d
 
 	rc = __dpi_queue_write_single(dpivf, cmd);
 	if (unlikely(rc)) {
-		CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+		dpi_conf->c_desc.tail--;
 		return rc;
 	}
 
@@ -300,17 +301,18 @@ cnxk_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 {
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
 	const struct rte_dma_sge *fptr, *lptr;
 	uint8_t *comp_ptr;
 	uint64_t hdr[4];
 	int rc;
 
-	if (unlikely(((dpi_conf->c_desc.tail + 1) & dpi_conf->c_desc.max_cnt) ==
-		     dpi_conf->c_desc.head))
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
 		return -ENOSPC;
 
-	comp_ptr = &dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
-	CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
 
 	hdr[1] = dpi_conf->cmd.u | ((flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 37);
 	hdr[2] = (uint64_t)comp_ptr;
@@ -331,7 +333,7 @@ cnxk_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 
 	rc = __dpi_queue_write_sg(dpivf, hdr, fptr, lptr, nb_src, nb_dst);
 	if (unlikely(rc)) {
-		CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+		dpi_conf->c_desc.tail--;
 		return rc;
 	}
 
@@ -355,16 +357,17 @@ cn10k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t
 {
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
 	uint64_t cmd[CNXK_DPI_DW_PER_SINGLE_CMD];
 	uint8_t *comp_ptr;
 	int rc;
 
-	if (unlikely(((dpi_conf->c_desc.tail + 1) & dpi_conf->c_desc.max_cnt) ==
-		     dpi_conf->c_desc.head))
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
 		return -ENOSPC;
 
-	comp_ptr = &dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
-	CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
 
 	cmd[0] = dpi_conf->cmd.u | (1U << 6) | 1U;
 	cmd[1] = (uint64_t)comp_ptr;
@@ -376,7 +379,7 @@ cn10k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t
 
 	rc = __dpi_queue_write_single(dpivf, cmd);
 	if (unlikely(rc)) {
-		CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+		dpi_conf->c_desc.tail--;
 		return rc;
 	}
 
@@ -401,16 +404,17 @@ cn10k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 {
 	struct cnxk_dpi_vf_s *dpivf = dev_private;
 	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
 	uint8_t *comp_ptr;
 	uint64_t hdr[4];
 	int rc;
 
-	if (unlikely(((dpi_conf->c_desc.tail + 1) & dpi_conf->c_desc.max_cnt) ==
-		     dpi_conf->c_desc.head))
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
 		return -ENOSPC;
 
-	comp_ptr = &dpi_conf->c_desc.compl_ptr[dpi_conf->c_desc.tail * CNXK_DPI_COMPL_OFFSET];
-	CNXK_DPI_STRM_INC(dpi_conf->c_desc, tail);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
 
 	hdr[0] = dpi_conf->cmd.u | (nb_dst << 6) | nb_src;
 	hdr[1] = (uint64_t)comp_ptr;
@@ -418,7 +422,7 @@ cn10k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 
 	rc = __dpi_queue_write_sg(dpivf, hdr, src, dst, nb_src, nb_dst);
 	if (unlikely(rc)) {
-		CNXK_DPI_STRM_DEC(dpi_conf->c_desc, tail);
+		dpi_conf->c_desc.tail--;
 		return rc;
 	}
 
@@ -670,3 +674,148 @@ cnxk_dma_adapter_dequeue(uintptr_t get_work1)
 
 	return (uintptr_t)op;
 }
+
+uint16_t
+cnxk_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	const struct rte_dma_sge *fptr, *lptr;
+	uint16_t src, dst, nwords = 0;
+	struct rte_dma_op *op;
+	uint16_t space, i;
+	uint8_t *comp_ptr;
+	uint64_t hdr[4];
+	int rc;
+
+	space = ((dpi_conf->c_desc.max_cnt + dpi_conf->c_desc.head - dpi_conf->c_desc.tail) &
+		 max_cnt);
+	space = RTE_MIN(space, nb_ops);
+
+	for (i = 0; i < space; i++) {
+		op = ops[i];
+		comp_ptr = &dpi_conf->c_desc.compl_ptr[(dpi_conf->c_desc.tail & max_cnt) *
+						       CNXK_DPI_COMPL_OFFSET];
+		dpi_conf->c_desc.ops[dpi_conf->c_desc.tail & max_cnt] = op;
+		dpi_conf->c_desc.tail++;
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
+			dpi_conf->c_desc.tail--;
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
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	uint16_t space, i, nwords = 0;
+	struct rte_dma_op *op;
+	uint16_t src, dst;
+	uint8_t *comp_ptr;
+	uint64_t hdr[4];
+	int rc;
+
+	space = (max_cnt + dpi_conf->c_desc.head - dpi_conf->c_desc.tail) & max_cnt;
+	space = RTE_MIN(space, nb_ops);
+
+	for (i = 0; i < space; i++) {
+		op = ops[i];
+		src = op->nb_src;
+		dst = op->nb_dst;
+
+		comp_ptr = &dpi_conf->c_desc.compl_ptr[(dpi_conf->c_desc.tail & max_cnt) *
+						       CNXK_DPI_COMPL_OFFSET];
+		dpi_conf->c_desc.ops[dpi_conf->c_desc.tail & max_cnt] = op;
+		dpi_conf->c_desc.tail++;
+
+		hdr[0] = dpi_conf->cmd.u | (dst << 6) | src;
+		hdr[1] = (uint64_t)comp_ptr;
+		hdr[2] = (1UL << 47) | ((op->flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 43);
+
+		rc = __dpi_queue_write_sg(dpivf, hdr, &op->src_dst_seg[0], &op->src_dst_seg[src],
+					  src, dst);
+		if (rc) {
+			dpi_conf->c_desc.tail--;
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
+	const uint16_t max_cnt = c_desc->max_cnt;
+	struct rte_dma_op *op;
+	uint16_t space, cnt;
+	uint8_t status;
+
+	space = (c_desc->tail - c_desc->head) & max_cnt;
+	space = RTE_MIN(nb_ops, space);
+
+	for (cnt = 0; cnt < space; cnt++) {
+		status = c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+		op = c_desc->ops[c_desc->head & max_cnt];
+		if (status) {
+			if (status == CNXK_DPI_REQ_CDATA)
+				break;
+			dpi_conf->stats.errors++;
+		}
+		op->status = status;
+		ops[cnt] = op;
+		c_desc->compl_ptr[(c_desc->head & max_cnt) * CNXK_DPI_COMPL_OFFSET] =
+			CNXK_DPI_REQ_CDATA;
+		c_desc->head++;
+	}
+
+	dpi_conf->stats.completed += cnt;
+
+	return cnt;
+}
-- 
2.43.0

