Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F00CC61DBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 10:54:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86C4E40431;
	Sat, 29 Aug 2026 12:54:31 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CD25E4042F
 for <dev@dpdk.org>; Sat, 29 Aug 2026 12:54:29 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TAFKVc3848716; Sat, 29 Aug 2026 03:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 ELT1BSxMLzD8YuWSpF92uoNyPaY8v00mFxGWswx0eQ=; b=QaEKxVYm8MPgKvI/1
 IHuQ5jH3nG0TixCqSDgre6ENWUVBQVvP0DT8zHDGZnuOZLTgxCjc6NCvFQwDmVKy
 iu3yjfKKcLguyU00Us9Hv8WJYq67Qpls3BdWbjtF7za9LLgmjUCitj2UX13WT6oV
 wIGvM+2bbmnMZqj8aKEXbwGqOEifPeAqrAnxTcLAvie32WVSQfXeyE6iOZzqgxi/
 zVdlmvY5MM/717l4Mh76JSSP1MMADMM5YDwRMRezsiucHf7cJcBvKfPcr3thKT7g
 0oabcsJtZY4wDqRfBi8L9FRQYw0xzhgX8jMzD3HDnVdHHJBwP5XoSILjdDqfW/8x
 dpPsg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gbqj88m97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 03:54:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 29 Aug 2026 03:54:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 29 Aug 2026 03:54:27 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id AFA7F3F7084;
 Sat, 29 Aug 2026 03:54:25 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v0 3/3] dma/cnxk: enable inter process domain DMA support
Date: Sat, 29 Aug 2026 16:24:09 +0530
Message-ID: <20260829105409.1160766-4-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829105409.1160766-1-vattunuru@marvell.com>
References: <20260829105409.1160766-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfX7HsFMlHQ3lGD
 Ifi6Jq0rfRnwR1uEPSiIPwxoyqWHj/2Zi8yhsDsld+diwvUc5nhQKsCcINp/xkCbAaBo4HeBt5P
 zkmEja2IkUEm0aTGFBR0Z2yqcF9wuKo=
X-Authority-Analysis: v=2.4 cv=EL82FVZC c=1 sm=1 tr=0 ts=6a92ba64 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=xhJYCCL8WsbtcfxnIMEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: U11G-vQjcIM_up3TxpGvZFd3hV4gN72I
X-Proofpoint-GUID: U11G-vQjcIM_up3TxpGvZFd3hV4gN72I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfX526QR7fKm5As
 TSWXWztwkCuLqSlrRuZSGQFkJLbb4VwNicSUC5rw7XDxKdtSCc5K50/bFZdjsMDariiu87WlYdl
 wrVdbkYF1SMAL2rUSWtzAihoMvSpQKLwulDt0flTG8qbS4O7dIDYEqI0hjvqKRr5HK99+bGjFmE
 ytiRHKvca7vMPxtYKy5rXDqPS3ExILGK/H8YfRRElNsxQGa/dHzIhDEUBFpS65TnMs4szJGhfHA
 GLpZjsGdNXLYgGnZ/tKibZfa4XywidQgTW6/hUMII9/tiwQa4seftj9PNzg9POJGxnC98x19Xrr
 BpgMg74YvjCfxlc2575rjxeSZCyjXgVYEmo8q8AoPdW8nyzGNFnmuhTE4RvRSaosZmGJShgSzCn
 9G313iMLYh4nacRzve2D8qPLYl/iSa4WtW+8IWylbeDw7cmKebPx/Hd/V4cT0Z0NK99HbIKgKkt
 9r/vNftWrMVTxIl+j/Q==
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

Adds support for inter domain DMA operations.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c | 148 ++++++++++++++++++++++++++++++++-
 drivers/dma/cnxk/cnxk_dmadev.h |   1 +
 2 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 3970abe1c3..faa13abc23 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -98,7 +98,7 @@ cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_inf
 		dev_info->min_desc = CN20K_DPI_MIN_DESC;
 		dev_info->max_sges = CN20K_DPI_MAX_POINTER;
 		dev_info->max_vchans = dpivf->max_vchans;
-		dev_info->dev_capa |= RTE_DMA_CAPA_OPS_FILL;
+		dev_info->dev_capa |= (RTE_DMA_CAPA_OPS_FILL | RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
 	} else {
 		dev_info->max_desc = CNXK_DPI_MAX_DESC;
 		dev_info->min_desc = CNXK_DPI_MIN_DESC;
@@ -446,6 +446,13 @@ cn20k_dmadev_setup(struct cnxk_dpi_vf_s *dpivf, uint16_t vchan,
 		break;
 	case RTE_DMA_DIR_MEM_TO_MEM:
 		dpi_conf->cfg.xtype = DPI_XTYPE_INTERNAL_ONLY;
+		if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN) {
+			dpi_conf->chan_cfg.type = RTE_DMA_INTER_PROCESS_DOMAIN;
+			dpi_conf->chan_cfg.src_key = conf->domain.src_handler;
+			dpi_conf->chan_cfg.dst_key = conf->domain.dst_handler;
+			header->cn20k.chan = CNXK_DPI_SRC_DST_KEY(dpi_conf->chan_cfg.src_key,
+								  dpi_conf->chan_cfg.dst_key);
+		}
 		dpi_conf->cfg.rport = 0;
 		dpi_conf->cfg.wport = 0;
 		break;
@@ -1015,6 +1022,140 @@ cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t ena_enq_deq)
 	}
 }
 
+static int
+cnxk_dmadev_access_pair_group_create(const struct rte_dma_dev *dev, rte_uuid_t domain_id,
+				       rte_uuid_t token, int16_t *group_id,
+				       rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
+	struct roc_dpi_lf *lf;
+	int rc;
+
+	RTE_SET_USED(cb);
+
+	if (!roc_model_is_cn20k())
+		return -ENOTSUP;
+
+	if (dpivf->rdpi.lfs == NULL || dpivf->rdpi.nr_lfs == 0) {
+		plt_err("DPI LF resources are not initialized");
+		return -EINVAL;
+	}
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	rc = roc_dpi_access_pair_group_create(lf, domain_id, token, group_id);
+
+	return rc;
+}
+
+static int
+cnxk_dmadev_access_pair_group_destroy(const struct rte_dma_dev *dev, int16_t group_id)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
+	struct roc_dpi_lf *lf;
+	int rc;
+
+	if (!roc_model_is_cn20k())
+		return -ENOTSUP;
+
+	if (dpivf->rdpi.lfs == NULL || dpivf->rdpi.nr_lfs == 0) {
+		plt_err("DPI LF resources are not initialized");
+		return -EINVAL;
+	}
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	if (lf->group_id != group_id) {
+		plt_err("Invalid access pair group is passed");
+		return -EINVAL;
+	}
+
+	rc = roc_dpi_access_pair_group_destroy(lf, group_id);
+
+	return rc;
+}
+
+static int
+cnxk_dmadev_access_pair_group_join(const struct rte_dma_dev *dev, rte_uuid_t domain_id,
+				   rte_uuid_t token, int16_t group_id,
+				   rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
+	struct roc_dpi_lf *lf;
+	int rc;
+
+	RTE_SET_USED(cb);
+
+	if (!roc_model_is_cn20k())
+		return -ENOTSUP;
+
+	if (dpivf->rdpi.lfs == NULL || dpivf->rdpi.nr_lfs == 0) {
+		plt_err("DPI LF resources are not initialized");
+		return -EINVAL;
+	}
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	rc = roc_dpi_access_pair_group_join(lf, domain_id, token, group_id);
+
+	return rc;
+}
+
+static int
+cnxk_dmadev_access_pair_group_leave(const struct rte_dma_dev *dev, int16_t group_id)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
+	struct roc_dpi_lf *lf;
+	int rc;
+
+	if (!roc_model_is_cn20k())
+		return -ENOTSUP;
+
+	if (dpivf->rdpi.lfs == NULL || dpivf->rdpi.nr_lfs == 0) {
+		plt_err("DPI LF resources are not initialized");
+		return -EINVAL;
+	}
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	if (lf->group_id != group_id) {
+		plt_err("Invalid access pair group is passed");
+		return -EINVAL;
+	}
+
+	rc = roc_dpi_access_pair_group_leave(lf, group_id);
+
+	return rc;
+}
+
+static int
+cnxk_dmadev_access_pair_group_handler_get(const struct rte_dma_dev *dev, int16_t group_id,
+					  rte_uuid_t domain_id, uint16_t *handler)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
+	struct roc_dpi_lf *lf;
+	int rc;
+
+	if (!roc_model_is_cn20k())
+		return -ENOTSUP;
+
+	if (dpivf->rdpi.lfs == NULL || dpivf->rdpi.nr_lfs == 0) {
+		plt_err("DPI LF resources are not initialized");
+		return -EINVAL;
+	}
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	if (lf->group_id != group_id) {
+		plt_err("Invalid access pair group is passed");
+		return -EINVAL;
+	}
+
+	rc = roc_dpi_access_pair_group_handler_get(lf, group_id, domain_id, handler);
+
+	return rc;
+}
+
 static const struct rte_dma_dev_ops cnxk_dmadev_ops = {
 	.dev_close = cnxk_dmadev_close,
 	.dev_configure = cnxk_dmadev_configure,
@@ -1024,6 +1165,11 @@ static const struct rte_dma_dev_ops cnxk_dmadev_ops = {
 	.stats_get = cnxk_stats_get,
 	.stats_reset = cnxk_stats_reset,
 	.vchan_setup = cnxk_dmadev_vchan_setup,
+	.access_pair_group_create = cnxk_dmadev_access_pair_group_create,
+	.access_pair_group_destroy = cnxk_dmadev_access_pair_group_destroy,
+	.access_pair_group_join = cnxk_dmadev_access_pair_group_join,
+	.access_pair_group_leave = cnxk_dmadev_access_pair_group_leave,
+	.access_pair_group_handler_get = cnxk_dmadev_access_pair_group_handler_get,
 };
 
 static int
diff --git a/drivers/dma/cnxk/cnxk_dmadev.h b/drivers/dma/cnxk/cnxk_dmadev.h
index 3ba404dda8..043f48cb7e 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.h
+++ b/drivers/dma/cnxk/cnxk_dmadev.h
@@ -47,6 +47,7 @@
 							     CNXK_DPI_MAX_POINTER)
 #define CNXK_DPI_CHUNKS_FROM_DESC(cz, desc) (((desc) / (((cz) / 8) / CNXK_DPI_MAX_CMD_SZ)) + 1)
 #define CNXK_DPI_COMPL_OFFSET		    ROC_CACHE_LINE_SZ
+#define CNXK_DPI_SRC_DST_KEY(src, dst)	    ((0x2040) | ((src & 0x3F) << 7) | (dst & 0x3F))
 
 #define CN20K_DPI_MAX_POINTER		    4
 #define CN20K_DPI_MAX_DESC		    2048
-- 
2.34.1

