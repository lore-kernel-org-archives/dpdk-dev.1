Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49961C61DBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 10:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40C534064E;
	Sat, 29 Aug 2026 12:54:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0559B40611
 for <dev@dpdk.org>; Sat, 29 Aug 2026 12:54:26 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67T82rRY3755433; Sat, 29 Aug 2026 03:54:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 mu9WxrNpNv96DEjonsTwTgeqISuCS4UOFg2SpPzSmk=; b=jKsOwm+WkgFdycQKm
 rOstuzNnJZDlDclDmJeKf9YtWmtSxXXaEy5QHftBZDSl6MxZhwJLos7zdU7OD1Dt
 kJCegWRfo3zJC6xco5ziwrhsj5pQRIT1TjEkXK+g0TK3whnB4Hlfzz2pF6trgFIo
 9WBQP7iMsKqetWg+gYUI/359SWgkA14pBu+nZ5yo7yIQjuRo/uOeqsJpj+Ozuxl3
 PlvMZ52MNa/gX3jpKvsUBc2XOZkMYbnodbVm5odiizyY8fZbEkQJMkHFGwyxSVID
 9slqOG32nUARw3HKuK4Gim54PURX/VpR1uWiAAUJ/vul8RzrqHlvkXetaSAzHrLU
 9ON3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbqnd8kcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 03:54:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 29 Aug 2026 03:54:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 29 Aug 2026 03:54:25 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id C25F43F7084;
 Sat, 29 Aug 2026 03:54:22 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v0 2/3] dma/cnxk: add O20 DPI DMA support
Date: Sat, 29 Aug 2026 16:24:08 +0530
Message-ID: <20260829105409.1160766-3-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829105409.1160766-1-vattunuru@marvell.com>
References: <20260829105409.1160766-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfXwk5fNQcxElMr
 cTEPQtZ05b/qJ1hyVdBt7HN9SAzyovOs7WJZDbmqDDElTsk1bZhXsWcmzbZ6t3CbUfCzyJZi4TI
 RwS6OXMQwGJ3exbaLnfoPQWH1nSb9gGsHpCkRrKBBfbZT9/TZ6erNdJtwSV6v27RQ2wF6yXbKqZ
 JnZ5WoPk4FiPyKzchyjQEg304vIs1bMVnleYYh2qNTMQtRwHcNwCAzkpObHiWc1jBoQKpokQZ3O
 xMmov0UdziMDjyT5X2L5yaqjkj0IFvYF+tOD/6neXnavOA5M5eZXr8hw5kfg4gub1Qj//E2Ust1
 M+AASV37U5F08+Vy9VGwBIaVJFieIQljF+rWBvSio//Brj1nxPB2d17CGUsrJFd1C0aaHZpAyxE
 U1D8mVhzC3qnvJT1rLLg/VXGhsstJwMiQfBxMcLjiedFFv/Vk7DLa1KU4b/rJd+wpBepvoYirAa
 gwSEd+UdeJI+vnUK6Zw==
X-Proofpoint-ORIG-GUID: On-Qq0bjT8fMNBFCwy1ktmJmT5eLXYBW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfXwmKuh6v7V1wM
 gLptM8ozOLia8m9jidStOdtBiY7+b/E8xvJgstrHflPAlG5noL/fG3yTFuutmyt2cnKrScqdoYh
 V6vOFhEVWs3vADaW91mRxdq8lI/gV6Y=
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=6a92ba62 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=XftRXrxHMnGVXK4bn6sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: On-Qq0bjT8fMNBFCwy1ktmJmT5eLXYBW
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

Adds DMA driver support for O20 hardware.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c    | 527 +++++++++++++++++++++++++++++-
 drivers/dma/cnxk/cnxk_dmadev.h    |  72 +++-
 drivers/dma/cnxk/cnxk_dmadev_fp.c | 214 ++++++++++++
 3 files changed, 791 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 6ae7fdca3b..3970abe1c3 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -2,6 +2,9 @@
  * Copyright (C) 2021 Marvell International Ltd.
  */
 
+#include <errno.h>
+#include <stdlib.h>
+
 #include <rte_event_dma_adapter.h>
 
 #include <cnxk_dmadev.h>
@@ -9,6 +12,68 @@
 static int cnxk_stats_reset(struct rte_dma_dev *dev, uint16_t vchan);
 static void cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t enable_enq_deq);
 
+static int
+parse_val_u16(const char *key, const char *value, void *extra_args)
+{
+	unsigned long val;
+	char *end;
+
+	RTE_SET_USED(key);
+
+	if (value == NULL || extra_args == NULL)
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoul(value, &end, 0);
+	if (errno != 0 || end == value || *end != '\0' || val > UINT16_MAX)
+		return -EINVAL;
+
+	*(uint16_t *)extra_args = (uint16_t)val;
+
+	return 0;
+}
+
+static int
+cn20k_dmadev_parse_devargs(struct rte_devargs *devargs, struct cnxk_dpi_vf_s *dpivf)
+{
+	uint16_t num_vchans = CN20K_DPI_DEF_VCHANS;
+	uint16_t num_lfs = num_vchans >> 1; /* Each LF has 2 rings */
+	struct rte_kvargs *kvlist = NULL;
+
+	if (devargs == NULL) {
+		dpivf->max_vchans = num_vchans;
+		dpivf->max_lfs = num_lfs;
+		return 0;
+	}
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (kvlist == NULL)
+		goto exit;
+
+	if (rte_kvargs_process(kvlist, CN20K_DPI_NUM_VCHANS, &parse_val_u16, &num_vchans) < 0)
+		goto exit;
+	if (rte_kvargs_process(kvlist, CN20K_DPI_NUM_LFS, &parse_val_u16, &num_lfs) < 0)
+		goto exit;
+
+	if (!num_vchans || !num_lfs || num_vchans > CN20K_DPI_MAX_VCHANS ||
+	    num_lfs > CN20K_DPI_MAX_LFS)
+		goto exit;
+
+	if (!rte_is_power_of_2(num_vchans) || !rte_is_power_of_2(num_lfs)) {
+		plt_err("num_vchans or num_lfs is not a power of 2");
+		goto exit;
+	}
+
+	dpivf->max_vchans = num_vchans;
+	dpivf->max_lfs = num_lfs;
+
+	rte_kvargs_free(kvlist);
+	return 0;
+exit:
+	rte_kvargs_free(kvlist);
+	return -EINVAL;
+}
+
 static int
 cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info, uint32_t size)
 {
@@ -25,9 +90,21 @@ cnxk_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_inf
 		dev_info->dev_capa |= RTE_DMA_CAPA_PRI_POLICY_SP;
 		dev_info->nb_priorities = CN10K_DPI_MAX_PRI;
 	}
-	dev_info->max_desc = CNXK_DPI_MAX_DESC;
-	dev_info->min_desc = CNXK_DPI_MIN_DESC;
-	dev_info->max_sges = CNXK_DPI_MAX_POINTER;
+
+	if (roc_model_is_cn20k()) {
+		const uint16_t vpr = dpivf->vchans_per_ring ? dpivf->vchans_per_ring : 1;
+
+		dev_info->max_desc = CN20K_DPI_MAX_DESC / vpr;
+		dev_info->min_desc = CN20K_DPI_MIN_DESC;
+		dev_info->max_sges = CN20K_DPI_MAX_POINTER;
+		dev_info->max_vchans = dpivf->max_vchans;
+		dev_info->dev_capa |= RTE_DMA_CAPA_OPS_FILL;
+	} else {
+		dev_info->max_desc = CNXK_DPI_MAX_DESC;
+		dev_info->min_desc = CNXK_DPI_MIN_DESC;
+		dev_info->max_sges = CNXK_DPI_MAX_POINTER;
+		dev_info->max_vchans = CNXK_DPI_MAX_VCHANS_PER_QUEUE;
+	}
 
 	return 0;
 }
@@ -52,8 +129,10 @@ cnxk_dmadev_vchan_free(struct cnxk_dpi_vf_s *dpivf, uint16_t vchan)
 
 	for (; i < num_vchans; i++) {
 		dpi_conf = &dpivf->conf[i];
-		rte_free(dpi_conf->c_desc.compl_ptr);
-		dpi_conf->c_desc.compl_ptr = NULL;
+		if (dpi_conf->c_desc.compl_ptr) {
+			rte_free(dpi_conf->c_desc.compl_ptr);
+			dpi_conf->c_desc.compl_ptr = NULL;
+		}
 	}
 
 	return 0;
@@ -99,10 +178,42 @@ cnxk_dmadev_chunk_pool_create(struct rte_dma_dev *dev, uint32_t nb_chunks, uint3
 	return rc;
 }
 
+static int
+cnxk_dmadev_vchan_rsrc_free(struct cnxk_dpi_vf_s *dpivf)
+{
+	struct roc_dpi *rdpi = &dpivf->rdpi;
+	int rc;
+
+	if (dpivf->ring_conf) {
+		rte_free(dpivf->ring_conf);
+		dpivf->ring_conf = NULL;
+	}
+
+	if (rdpi->lfs == NULL)
+		return 0;
+
+	rc = roc_dpi_lf_chan_tbl_free(&(rdpi->lfs[0]));
+	if (rc < 0) {
+		plt_err("Failed to free dpi lf channel table");
+		goto error;
+	}
+
+	rc = roc_dpi_rsrc_fini(rdpi);
+	if (rc < 0)
+		plt_err("Failed to free dpi lfs");
+
+	dpivf->is_ring_conf_done = false;
+error:
+	return rc;
+}
+
 static int
 cnxk_dmadev_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf, uint32_t conf_sz)
 {
 	struct cnxk_dpi_vf_s *dpivf = NULL;
+	struct roc_dpi_lf *lf;
+	uint16_t num_rings;
+	int rc = 0;
 
 	RTE_SET_USED(conf_sz);
 	dpivf = dev->fp_obj->dev_private;
@@ -111,13 +222,78 @@ cnxk_dmadev_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf,
 	 * Free up vchan memory if any, before configuring num_vchans.
 	 */
 	cnxk_dmadev_vchan_free(dpivf, RTE_DMA_ALL_VCHAN);
+
 	dpivf->num_vchans = conf->nb_vchans;
+	if (roc_model_is_cn20k()) {
+		if (!rte_is_power_of_2(dpivf->num_vchans))
+			dpivf->num_vchans = rte_align32pow2(dpivf->num_vchans);
+
+		if (dpivf->num_vchans > dpivf->max_vchans) {
+			plt_info("Limiting vchans from %u to max_vchans %u",
+				 dpivf->num_vchans, dpivf->max_vchans);
+			dpivf->num_vchans = dpivf->max_vchans;
+		}
+	}
 	if (roc_feature_dpi_has_priority())
 		dpivf->rdpi.priority = conf->priority;
 
 	cnxk_set_fp_ops(dev, conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ);
 
-	return 0;
+	if (roc_model_is_cn20k()) {
+		rc = cnxk_dmadev_vchan_rsrc_free(dpivf);
+		if (rc < 0)
+			goto error;
+
+		dpivf->rdpi.nr_lfs = dpivf->max_lfs;
+		num_rings = dpivf->rdpi.nr_lfs << 1;
+
+		if (dpivf->num_vchans > num_rings) {
+			dpivf->vchans_per_ring = dpivf->num_vchans / num_rings;
+		} else {
+			/* Each vchan has got it's own hardware ring */
+			dpivf->vchans_per_ring = 1;
+			dpivf->rdpi.nr_lfs = dpivf->num_vchans >> 1;
+			if (!dpivf->rdpi.nr_lfs)
+				dpivf->rdpi.nr_lfs = 1;
+		}
+
+		if ((CN20K_DPI_MAX_DESC / dpivf->vchans_per_ring) < CN20K_DPI_MIN_DESC) {
+			rc = -EINVAL;
+			plt_err("Very few LFs are requested than required");
+			goto error;
+		}
+
+		num_rings = dpivf->rdpi.nr_lfs << 1;
+		dpivf->ring_conf = rte_zmalloc("dpi_ring_conf", sizeof(struct cn20k_ring_conf) *
+					       num_rings, 0);
+		if (dpivf->ring_conf == NULL) {
+			plt_err("Failed to allocate memory for ring conf");
+			rc = -ENOMEM;
+			goto error;
+		}
+
+		rc = roc_dpi_rsrc_init(&dpivf->rdpi);
+		if (rc < 0) {
+			plt_err("rsrc alloc failed");
+			goto error;
+		}
+
+		lf = &(dpivf->rdpi.lfs[0]);
+		rc = roc_dpi_lf_chan_tbl_alloc(lf, dpivf->num_vchans);
+		if (rc < 0) {
+			plt_err("Failed to allocate chan tbl");
+			goto error;
+		}
+
+		dpivf->chan_tbl = lf->chan_tbl;
+		dpivf->is_ring_conf_done = false;
+	}
+
+error:
+	if (roc_model_is_cn20k() && rc < 0)
+		cnxk_dmadev_vchan_rsrc_free(dpivf);
+
+	return rc;
 }
 
 static int
@@ -232,6 +408,87 @@ cn10k_dmadev_setup_hdr(union cnxk_dpi_instr_cmd *header, const struct rte_dma_vc
 	return 0;
 }
 
+static int
+cn20k_dmadev_setup(struct cnxk_dpi_vf_s *dpivf, uint16_t vchan,
+		    const struct rte_dma_vchan_conf *conf)
+{
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	struct cn20k_ring_conf *rconf = dpivf->ring_conf;
+	uint16_t ridx, max_desc, num_rings;
+	union cnxk_dpi_instr_cmd *header;
+	int rc = 0;
+	int aura;
+
+	header = (union cnxk_dpi_instr_cmd *)&dpi_conf->cmd.u;
+	header->cn20k.ct = DPI_HDR_PT_ZBW_CA;
+	header->cn20k.xt = 0;
+
+	switch (conf->direction) {
+	case RTE_DMA_DIR_DEV_TO_MEM:
+		dpi_conf->cfg.xtype = DPI_XTYPE_INBOUND;
+		dpi_conf->cfg.rport = conf->src_port.pcie.coreid;
+		dpi_conf->cfg.wport = 0;
+		dpi_conf->chan_cfg.pf_func = conf->src_port.pcie.pfid;
+		dpi_conf->chan_cfg.vf_func = conf->src_port.pcie.vfid;
+		dpi_conf->chan_cfg.valid = 1;
+		break;
+	case RTE_DMA_DIR_MEM_TO_DEV:
+		dpi_conf->cfg.xtype = DPI_XTYPE_OUTBOUND;
+		dpi_conf->cfg.rport = 0;
+		dpi_conf->cfg.wport = conf->dst_port.pcie.coreid;
+		dpi_conf->chan_cfg.pf_func = conf->dst_port.pcie.pfid;
+		dpi_conf->chan_cfg.vf_func = conf->dst_port.pcie.vfid;
+		dpi_conf->chan_cfg.valid = 1;
+		aura = dmadev_src_buf_aura_get(conf->auto_free.m2d.pool, "cn20k_mempool_ops");
+		if (aura < 0)
+			return aura;
+		header->cn20k.aura = aura;
+		break;
+	case RTE_DMA_DIR_MEM_TO_MEM:
+		dpi_conf->cfg.xtype = DPI_XTYPE_INTERNAL_ONLY;
+		dpi_conf->cfg.rport = 0;
+		dpi_conf->cfg.wport = 0;
+		break;
+	case RTE_DMA_DIR_DEV_TO_DEV:
+		dpi_conf->cfg.xtype = DPI_XTYPE_EXTERNAL_ONLY;
+		dpi_conf->cfg.rport = conf->src_port.pcie.coreid;
+		dpi_conf->cfg.wport = conf->dst_port.pcie.coreid;
+	};
+
+	max_desc = conf->nb_desc;
+	if (!rte_is_power_of_2(max_desc))
+		max_desc = rte_align32pow2(max_desc);
+
+	num_rings = dpivf->rdpi.nr_lfs << 1;
+
+	for (ridx = 0; ridx < num_rings; ridx++) {
+		if (!rconf[ridx].used) {
+			if (!rconf[ridx].num_vchans) {
+				rconf[ridx].direction = conf->direction;
+				rconf[ridx].num_desc = max_desc;
+			} else if ((rconf[ridx].direction == conf->direction) &&
+				   (rconf[ridx].num_vchans < dpivf->vchans_per_ring)) {
+				rconf[ridx].num_desc += max_desc;
+			} else {
+				continue;
+			}
+
+			rconf[ridx].num_vchans++;
+			dpi_conf->ridx = ridx;
+
+			if (rconf[ridx].num_vchans == dpivf->vchans_per_ring)
+				rconf[ridx].used = true;
+
+			break;
+		}
+	}
+
+	if (ridx == num_rings)
+		rc = -ENODEV;
+
+	return rc;
+}
+
 static int
 cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 			const struct rte_dma_vchan_conf *conf, uint32_t conf_sz)
@@ -245,9 +502,14 @@ cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 
 	RTE_SET_USED(conf_sz);
 
+	if (conf->auto_free.m2d.pool != NULL && conf->direction != RTE_DMA_DIR_MEM_TO_DEV)
+		return -EINVAL;
+
 	header = (union cnxk_dpi_instr_cmd *)&dpi_conf->cmd.u;
 
-	if (dpivf->is_cn10k)
+	if (roc_model_is_cn20k())
+		ret = cn20k_dmadev_setup(dpivf, vchan, conf);
+	else if (roc_model_is_cn10k())
 		ret = cn10k_dmadev_setup_hdr(header, conf);
 	else
 		ret = cn9k_dmadev_setup_hdr(header, conf);
@@ -262,7 +524,7 @@ cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	if (!rte_is_power_of_2(max_desc))
 		max_desc = rte_align32pow2(max_desc);
 
-	if (max_desc > CNXK_DPI_MAX_DESC)
+	if (!roc_model_is_cn20k() && (max_desc > CNXK_DPI_MAX_DESC))
 		max_desc = CNXK_DPI_MAX_DESC;
 
 	size = (max_desc * sizeof(uint8_t) * CNXK_DPI_COMPL_OFFSET);
@@ -285,10 +547,121 @@ cnxk_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 		dpi_conf->c_desc.compl_ptr[i * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
 
 	dpi_conf->c_desc.max_cnt = (max_desc - 1);
+	dpi_conf->cfg_done = true;
 
 	return 0;
 }
 
+static int
+cn20k_dmadev_queue_setup(struct cnxk_dpi_vf_s *dpivf)
+{
+	struct cn20k_ring_conf *rconf = dpivf->ring_conf;
+	struct roc_dpi *rdpi = &dpivf->rdpi;
+	struct cnxk_dpi_conf *dpi_conf;
+	struct roc_dpi_lf_que *que;
+	struct roc_dpi_lf_ring_cfg cfg;
+	struct roc_dpi_lf *lf;
+	uint16_t idx, qidx, ridx, vchan;
+	int rc = 0;
+
+	for (idx = 0; idx < rdpi->nr_lfs; idx++) {
+		lf = &rdpi->lfs[idx];
+		lf->chan_tbl = dpivf->chan_tbl;
+
+		for (qidx = 0; qidx < 2; qidx++) {
+			ridx = (idx << 1) + qidx;
+
+			if (!rconf[ridx].used)
+				continue;
+
+			que = &lf->queue[qidx];
+
+			que->qsize = rconf[ridx].num_desc;
+			que->cmd_len = DPI_CMD_SIZE_128B;
+			que->first_skip = 0;
+			que->later_skip = 0;
+			memset(&cfg, 0, sizeof(cfg));
+			cfg.ring_idx = qidx;
+			cfg.isize = que->cmd_len / DPI_CMD_SIZE_128B;
+			cfg.xtype = DPI_XTYPE_INTERNAL_ONLY;
+			cfg.rport = 0; /* Default is PEM:0 */
+			cfg.wport = 0; /* Default is PEM:0 */
+			cfg.pri = 0;   /* 0 - High Priority */
+			for (vchan = 0; vchan < dpivf->num_vchans; vchan++) {
+				dpi_conf = &dpivf->conf[vchan];
+
+				if (dpi_conf->ridx == ridx)
+					cfg.xtype = dpi_conf->cfg.xtype;
+			}
+
+			rc = roc_dpi_lf_ring_init(que, &cfg);
+			if (rc)
+				return rc;
+
+			for (vchan = 0; vchan < dpivf->num_vchans; vchan++) {
+				dpi_conf = &dpivf->conf[vchan];
+
+				if (dpi_conf->ridx == ridx) {
+					dpi_conf->que = que;
+					dpi_conf->dbell = lf->rbase + DPI_LF_RINGX_WIDX(qidx);
+				}
+			}
+		}
+
+		rc = roc_dpi_lf_chan_tbl_select(lf);
+		if (rc)
+			return rc;
+
+		/* FIX ME */
+		rc = roc_dpi_lf_pffunc_cfg(lf);
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
+
+static int
+cn20k_dmadev_chan_tbl_setup(struct cnxk_dpi_vf_s *dpivf)
+{
+	uint16_t vchan, idx = 0, offset = 0;
+	struct cnxk_dpi_conf *dpi_conf;
+	uint64_t config[64] = {0};
+	struct roc_dpi_lf *lf;
+	int rc = 0;
+
+	lf = &(dpivf->rdpi.lfs[0]);
+
+	for (vchan = 0; vchan < dpivf->num_vchans; vchan++) {
+		dpi_conf = &dpivf->conf[vchan];
+		if (!dpi_conf->cfg_done || (dpi_conf->cfg.xtype == DPI_XTYPE_INTERNAL_ONLY))
+			continue;
+
+		dpi_conf->cmd.cn20k.chan = idx;
+		config[idx++] = dpi_conf->chan_cfg.u;
+
+		if (idx == 64) {
+			rc = roc_dpi_lf_chan_tbl_update(lf, config, offset, idx);
+			if (rc < 0) {
+				plt_err("Failed to update chan tbl = %d", rc);
+				return rc;
+			}
+			offset += idx;
+			idx = 0;
+		}
+	}
+
+	if (idx) {
+		rc = roc_dpi_lf_chan_tbl_update(lf, config, offset, idx);
+		if (rc < 0) {
+			plt_err("Failed to update chan tbl = %d", rc);
+			return rc;
+		}
+	}
+
+	return rc;
+}
+
 static int
 cnxk_dmadev_start(struct rte_dma_dev *dev)
 {
@@ -306,6 +679,10 @@ cnxk_dmadev_start(struct rte_dma_dev *dev)
 		dpi_conf->c_desc.head = 0;
 		dpi_conf->c_desc.tail = 0;
 		dpi_conf->desc_idx = 0;
+
+		if (dpi_conf->c_desc.compl_ptr == NULL)
+			continue;
+
 		for (j = 0; j < dpi_conf->c_desc.max_cnt + 1; j++)
 			dpi_conf->c_desc.compl_ptr[j * CNXK_DPI_COMPL_OFFSET] = CNXK_DPI_REQ_CDATA;
 		nb_desc += dpi_conf->c_desc.max_cnt + 1;
@@ -313,6 +690,27 @@ cnxk_dmadev_start(struct rte_dma_dev *dev)
 		dpi_conf->completed_offset = 0;
 	}
 
+	if (roc_model_is_cn20k()) {
+		for (i = 0; i < (dpivf->rdpi.nr_lfs << 1); i++)
+			dpivf->ring_conf[i].pending = 0;
+		roc_dpi_reset(&dpivf->rdpi);
+
+		if (dpivf->is_ring_conf_done)
+			goto enable_dpi;
+
+		rc = cn20k_dmadev_queue_setup(dpivf);
+		if (rc)
+			goto error;
+
+		rc = cn20k_dmadev_chan_tbl_setup(dpivf);
+		if (rc)
+			goto error;
+
+		dpivf->is_ring_conf_done = true;
+
+		goto enable_dpi;
+	}
+
 	queue_buf_sz = CNXK_DPI_QUEUE_BUF_SIZE_V2;
 	/* Max block size allowed by cnxk mempool driver is (128 * 1024).
 	 * Block size = elt_size + mp->header + mp->trailer.
@@ -349,6 +747,7 @@ cnxk_dmadev_start(struct rte_dma_dev *dev)
 	dpivf->chunk_head = 0;
 	dpivf->chunk_size_m1 = (queue_buf_sz >> 3) - 2;
 
+enable_dpi:
 	roc_dpi_enable(&dpivf->rdpi);
 error:
 	return rc;
@@ -359,14 +758,18 @@ cnxk_dmadev_stop(struct rte_dma_dev *dev)
 {
 	struct cnxk_dpi_vf_s *dpivf = dev->fp_obj->dev_private;
 
-	if (roc_dpi_wait_queue_idle(&dpivf->rdpi))
-		return -EAGAIN;
+	if (!roc_model_is_cn20k()) {
+		if (roc_dpi_wait_queue_idle(&dpivf->rdpi))
+			return -EAGAIN;
+	}
 
 	roc_dpi_disable(&dpivf->rdpi);
-	rte_mempool_free(dpivf->chunk_pool);
-	dpivf->chunk_pool = NULL;
-	dpivf->chunk_base = NULL;
-	dpivf->chunk_size_m1 = 0;
+	if (!roc_model_is_cn20k()) {
+		rte_mempool_free(dpivf->chunk_pool);
+		dpivf->chunk_pool = NULL;
+		dpivf->chunk_base = NULL;
+		dpivf->chunk_size_m1 = 0;
+	}
 
 	return 0;
 }
@@ -378,6 +781,10 @@ cnxk_dmadev_close(struct rte_dma_dev *dev)
 
 	roc_dpi_disable(&dpivf->rdpi);
 	cnxk_dmadev_vchan_free(dpivf, RTE_DMA_ALL_VCHAN);
+
+	if (roc_model_is_cn20k())
+		cnxk_dmadev_vchan_rsrc_free(dpivf);
+
 	roc_dpi_dev_fini(&dpivf->rdpi);
 
 	/* Clear all flags as we close the device. */
@@ -454,11 +861,17 @@ cnxk_damdev_burst_capacity(const void *dev_private, uint16_t vchan)
 {
 	const struct cnxk_dpi_vf_s *dpivf = (const struct cnxk_dpi_vf_s *)dev_private;
 	const struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	struct cn20k_ring_conf *ring_conf;
 	uint16_t burst_cap;
 
 	burst_cap = dpi_conf->c_desc.max_cnt -
 		    (dpi_conf->stats.submitted - dpi_conf->stats.completed) + 1;
 
+	if (roc_model_is_cn20k()) {
+		ring_conf = &dpivf->ring_conf[dpi_conf->ridx];
+		burst_cap -= ring_conf->pending;
+	}
+
 	return burst_cap;
 }
 
@@ -480,6 +893,26 @@ cnxk_dmadev_submit(void *dev_private, uint16_t vchan)
 	return 0;
 }
 
+static int
+cn20k_dmadev_submit(void *dev_private, uint16_t vchan)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	struct cn20k_ring_conf *ring_conf = &dpivf->ring_conf[dpi_conf->ridx];
+	uint16_t num_words = ring_conf->pending;
+
+	if (!num_words)
+		return 0;
+
+	rte_wmb();
+	plt_write64(num_words, dpi_conf->dbell);
+	dpi_conf->stats.submitted += num_words;
+
+	ring_conf->pending = 0;
+
+	return 0;
+}
+
 static int
 cnxk_stats_get(const struct rte_dma_dev *dev, uint16_t vchan, struct rte_dma_stats *rte_stats,
 	       uint32_t size)
@@ -552,11 +985,16 @@ cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t ena_enq_deq)
 	dev->fp_obj->submit = cnxk_dmadev_submit;
 	dev->fp_obj->completed = cnxk_dmadev_completed;
 	dev->fp_obj->completed_status = cnxk_dmadev_completed_status;
-	dev->fp_obj->burst_capacity = cnxk_damdev_burst_capacity;
+		dev->fp_obj->burst_capacity = cnxk_damdev_burst_capacity;
 
 	if (roc_model_is_cn10k()) {
 		dev->fp_obj->copy = cn10k_dmadev_copy;
 		dev->fp_obj->copy_sg = cn10k_dmadev_copy_sg;
+	} else if (roc_model_is_cn20k()) {
+		dev->fp_obj->submit = cn20k_dmadev_submit;
+		dev->fp_obj->copy = cn20k_dmadev_copy;
+		dev->fp_obj->copy_sg = cn20k_dmadev_copy_sg;
+		dev->fp_obj->fill = cn20k_dmadev_fill;
 	}
 
 	if (ena_enq_deq) {
@@ -571,6 +1009,9 @@ cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t ena_enq_deq)
 
 		if (roc_model_is_cn10k())
 			dev->fp_obj->enqueue = cn10k_dma_ops_enqueue;
+
+		if (roc_model_is_cn20k())
+			dev->fp_obj->enqueue = cn20k_dma_ops_enqueue;
 	}
 }
 
@@ -594,8 +1035,10 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_de
 	struct roc_dpi *rdpi = NULL;
 	int rc;
 
-	if (!pci_dev->mem_resource[0].addr)
-		return -ENODEV;
+	if (!roc_model_is_cn20k()) {
+		if (!pci_dev->mem_resource[0].addr)
+			return -ENODEV;
+	}
 
 	rc = roc_plt_init();
 	if (rc) {
@@ -612,19 +1055,65 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_de
 	}
 
 	dpivf = dmadev->data->dev_private;
+	dmadev->device = &pci_dev->device;
+
+	if (roc_model_is_cn20k()) {
+		/* Parse devargs string */
+		rc = cn20k_dmadev_parse_devargs(dmadev->device->devargs, dpivf);
+		if (rc) {
+			plt_err("Failed to parse devargs rc=%d", rc);
+			goto err_out_free;
+		}
+		dpivf->num_vchans = dpivf->max_vchans;
+	}
 
 	dmadev->device = &pci_dev->device;
 	dmadev->fp_obj->dev_private = dpivf;
 	dmadev->dev_ops = &cnxk_dmadev_ops;
 
+	/*
+	 * dev_private (and the roc_dpi it holds) lives in shared memory. Only
+	 * the primary owns the HW and the per-process pci_dev pointer; a
+	 * secondary must not run roc_dpi_dev_init nor overwrite rdpi->pci_dev,
+	 * otherwise the primary later dereferences the secondary's stale
+	 * pointer during rte_eal_cleanup() and crashes.
+	 */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	dpivf->is_cn10k = roc_model_is_cn10k();
+	dmadev->fp_obj->submit = cnxk_dmadev_submit;
+	dmadev->fp_obj->completed = cnxk_dmadev_completed;
+	dmadev->fp_obj->completed_status = cnxk_dmadev_completed_status;
+	dmadev->fp_obj->burst_capacity = cnxk_damdev_burst_capacity;
+
+	if (roc_model_is_cn10k()) {
+		dmadev->fp_obj->copy = cn10k_dmadev_copy;
+		dmadev->fp_obj->copy_sg = cn10k_dmadev_copy_sg;
+		dpivf->num_vchans = CNXK_DPI_MAX_VCHANS_PER_QUEUE;
+	} else if (roc_model_is_cn20k()) {
+		dmadev->fp_obj->submit = cn20k_dmadev_submit;
+		dmadev->fp_obj->copy = cn20k_dmadev_copy;
+		dmadev->fp_obj->copy_sg = cn20k_dmadev_copy_sg;
+		dmadev->fp_obj->fill = cn20k_dmadev_fill;
+	} else {
+		dmadev->fp_obj->copy = cnxk_dmadev_copy;
+		dmadev->fp_obj->copy_sg = cnxk_dmadev_copy_sg;
+		dpivf->num_vchans = CNXK_DPI_MAX_VCHANS_PER_QUEUE;
+	}
+
+	dpivf->conf = rte_zmalloc("dpi_vchan_conf", dpivf->num_vchans *
+				  sizeof(struct cnxk_dpi_conf), 0);
+	if (dpivf->conf == NULL) {
+		plt_err("Failed to allocate memory for vchan conf");
+		rc = -ENOMEM;
+		goto err_out_free;
+	}
+
 	dpivf->mcs_lock = NULL;
 	rdpi = &dpivf->rdpi;
 
 	rdpi->pci_dev = pci_dev;
+
 	rc = roc_dpi_dev_init(rdpi, offsetof(struct rte_dma_op, impl_opaque));
 	if (rc < 0)
 		goto err_out_free;
@@ -653,6 +1142,8 @@ cnxk_dmadev_remove(struct rte_pci_device *pci_dev)
 
 static const struct rte_pci_id cnxk_dma_pci_map[] = {
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CNXK_DPI_VF)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN20K_DPI_PF)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN20K_DPI_VF)},
 	{
 		.vendor_id = 0,
 	},
diff --git a/drivers/dma/cnxk/cnxk_dmadev.h b/drivers/dma/cnxk/cnxk_dmadev.h
index 18039e43fb..3ba404dda8 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.h
+++ b/drivers/dma/cnxk/cnxk_dmadev.h
@@ -9,9 +9,11 @@
 
 #include <bus_pci_driver.h>
 #include <rte_common.h>
+#include <rte_devargs.h>
 #include <rte_dmadev.h>
 #include <rte_dmadev_pmd.h>
 #include <rte_eal.h>
+#include <rte_kvargs.h>
 #include <rte_lcore.h>
 #include <rte_mbuf_pool_ops.h>
 #include <rte_mcslock.h>
@@ -31,15 +33,31 @@
 #define CN10K_DPI_MAX_PRI		    2
 #define CNXK_DPI_MAX_VCHANS_PER_QUEUE	    128
 #define CNXK_DPI_QUEUE_BUF_SIZE		    16256
-#define CNXK_DPI_QUEUE_BUF_SIZE_V2	    130944
+/* Maximum pool size supported by device is 128 * 1024. When RTE_LIBRTE_MEMPOOL_DEBUG is enabled
+ * mempool->trailer size will be increased by 8B. Additionally if the pool is not created with
+ * RTE_MEMPOOL_F_NO_CACHE_ALIGN, trailer will be expanded to cache line size.
+ * To allow future needs, limit the max size to 127KB
+ */
+#define CNXK_DPI_QUEUE_BUF_SIZE_V2	    130048
 #define CNXK_DPI_POOL_MAX_CACHE_SZ	    (16)
 #define CNXK_DPI_DW_PER_SINGLE_CMD	    8
 #define CNXK_DPI_HDR_LEN		    4
 #define CNXK_DPI_CMD_LEN(src, dst)	    (CNXK_DPI_HDR_LEN + ((src) << 1) + ((dst) << 1))
-#define CNXK_DPI_MAX_CMD_SZ		    CNXK_DPI_CMD_LEN(CNXK_DPI_MAX_POINTER,		\
+#define CNXK_DPI_MAX_CMD_SZ		    CNXK_DPI_CMD_LEN(CNXK_DPI_MAX_POINTER,              \
 							     CNXK_DPI_MAX_POINTER)
 #define CNXK_DPI_CHUNKS_FROM_DESC(cz, desc) (((desc) / (((cz) / 8) / CNXK_DPI_MAX_CMD_SZ)) + 1)
 #define CNXK_DPI_COMPL_OFFSET		    ROC_CACHE_LINE_SZ
+
+#define CN20K_DPI_MAX_POINTER		    4
+#define CN20K_DPI_MAX_DESC		    2048
+#define CN20K_DPI_MIN_DESC		    128
+#define CN20K_DPI_MAX_VCHANS		    512
+#define CN20K_DPI_DEF_VCHANS		    8
+#define CN20K_DPI_MAX_LFS		    256
+
+#define CN20K_DPI_NUM_VCHANS	"num_vchans"
+#define CN20K_DPI_NUM_LFS	"num_lfs"
+
 /* Set Completion data to 0xFF when request submitted,
  * upon successful request completion engine reset to completion status
  */
@@ -86,6 +104,32 @@ union cnxk_dpi_instr_cmd {
 		uint64_t reserved_62_63 : 2;
 		/* Word 0 - End */
 	} cn10k;
+
+	struct cn20k_dpi_instr_cmd {
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
+	} cn20k;
+};
+
+struct cn20k_ring_conf {
+	enum rte_dma_direction direction;
+	uint16_t pending;
+	uint16_t num_desc;
+	uint8_t num_vchans;
+	bool used;
 };
 
 struct cnxk_dpi_cdesc_data_s {
@@ -100,9 +144,15 @@ struct cnxk_dpi_conf {
 	union cnxk_dpi_instr_cmd cmd;
 	struct cnxk_dpi_cdesc_data_s c_desc;
 	uint16_t desc_idx;
+	uintptr_t dbell;
 	struct rte_dma_stats stats;
 	uint64_t completed_offset;
+	struct roc_dpi_lf_que *que;
+	union roc_dpi_lf_ccfg chan_cfg;
+	struct roc_dpi_lf_ring_cfg cfg;
+	uint16_t ridx;
 	bool adapter_enabled;
+	bool cfg_done;
 };
 
 struct cnxk_dpi_vf_s {
@@ -111,15 +161,21 @@ struct cnxk_dpi_vf_s {
 	uint16_t chunk_head;
 	uint16_t chunk_size_m1;
 	uint16_t total_pnum_words;
+	uint16_t vchans_per_ring;
 	struct rte_mempool *chunk_pool;
-	struct cnxk_dpi_conf conf[CNXK_DPI_MAX_VCHANS_PER_QUEUE];
+	struct cnxk_dpi_conf *conf;
+	struct cn20k_ring_conf *ring_conf;
 	RTE_ATOMIC(rte_mcslock_t *) mcs_lock;
 	/* Slow path */
 	struct roc_dpi rdpi;
 	uint32_t aura;
+	uint16_t max_lfs;
+	uint16_t max_vchans;
 	uint16_t num_vchans;
+	uint16_t chan_tbl;
 	uint16_t flag;
 	uint8_t is_cn10k;
+	uint8_t is_ring_conf_done;
 } __plt_cache_aligned;
 
 int cnxk_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t dst,
@@ -138,5 +194,13 @@ uint16_t cn10k_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma
 			       uint16_t nb_ops);
 uint16_t cnxk_dma_ops_dequeue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops,
 			      uint16_t nb_ops);
-
+int cn20k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t dst,
+		      uint32_t length, uint64_t flags);
+int cn20k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge *src,
+			 const struct rte_dma_sge *dst, uint16_t nb_src, uint16_t nb_dst,
+			 uint64_t flags);
+int cn20k_dmadev_fill(void *dev_private, uint16_t vchan, uint64_t pattern, rte_iova_t dst,
+		      uint32_t length, uint64_t flags);
+uint16_t cn20k_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops,
+			       uint16_t nb_ops);
 #endif
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index 4435adc38b..29ce13c8e4 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -440,6 +440,163 @@ cn10k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge
 	return dpi_conf->desc_idx++;
 }
 
+int
+cn20k_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t dst,
+		  uint32_t length, uint64_t flags)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	struct roc_dpi_lf_que *queue = dpi_conf->que;
+	struct cn20k_ring_conf *ring_conf;
+	uint8_t *comp_ptr;
+	uint64_t *cmd;
+
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
+		return -ENOSPC;
+
+	if (dpivf->vchans_per_ring == 1) {
+		cmd = queue->cmd_base + ((dpi_conf->c_desc.tail & max_cnt) << 4);
+	} else {
+		cmd = queue->cmd_base + (queue->widx << 4);
+		queue->widx = (queue->widx + 1) & (queue->qsize - 1);
+	}
+
+	ring_conf = &(dpivf->ring_conf[dpi_conf->ridx]);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
+
+	cmd[1] = (uint64_t)comp_ptr;
+	cmd[4] = ((uint64_t)length << 32) | length | ((flags & RTE_DMA_OP_FLAG_AUTO_FREE) << 28);
+	cmd[5] = src;
+	cmd[6] = dst;
+	cmd[0] = DPI_CMD_VLD_BIT | dpi_conf->cmd.u | 0x11U;
+
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
+		rte_wmb();
+		plt_write64(ring_conf->pending + 1, dpi_conf->dbell);
+		dpi_conf->stats.submitted += (ring_conf->pending + 1);
+		ring_conf->pending = 0;
+	} else {
+		ring_conf->pending++;
+	}
+
+	return dpi_conf->desc_idx++;
+}
+
+/* Helper macro to write length and address */
+#define DPI_WRITE_SEGMENT(ptr, seg, i, idx, eidx, tmp)                                             \
+	do {                                                                                       \
+		if ((tmp) % 2 == 0) {                                                              \
+			ptr[eidx] = seg[i].length;                                                 \
+			idx++;                                                                     \
+		} else {                                                                           \
+			ptr[eidx] |= ((uint64_t)seg[i].length << 32);                              \
+			eidx += 3;                                                                 \
+		}                                                                                  \
+		ptr[idx++] = (uint64_t)seg[i].addr;                                                \
+		tmp++;                                                                             \
+	} while (0)
+
+int
+cn20k_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge *src,
+		     const struct rte_dma_sge *dst, uint16_t nb_src, uint16_t nb_dst,
+		     uint64_t flags)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	struct roc_dpi_lf_que *queue = dpi_conf->que;
+	struct cn20k_ring_conf *ring_conf = &dpivf->ring_conf[dpi_conf->ridx];
+	uint16_t idx = 4, eidx = 4, tmp = 0;
+	uint8_t *comp_ptr, i;
+	uint64_t *cmd;
+
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
+		return -ENOSPC;
+
+	if (dpivf->vchans_per_ring == 1) {
+		cmd = queue->cmd_base + ((dpi_conf->c_desc.tail & max_cnt) << 4);
+	} else {
+		cmd = queue->cmd_base + (queue->widx << 4);
+		queue->widx = (queue->widx + 1) & (queue->qsize - 1);
+	}
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
+
+	cmd[1] = (uint64_t)comp_ptr;
+
+	/* Fill source segments */
+	for (i = 0; i < nb_src; i++)
+		DPI_WRITE_SEGMENT(cmd, src, i, idx, eidx, tmp);
+
+	/* Fill destination segments */
+	for (i = 0; i < nb_dst; i++)
+		DPI_WRITE_SEGMENT(cmd, dst, i, idx, eidx, tmp);
+
+	cmd[0] = DPI_CMD_VLD_BIT | dpi_conf->cmd.u | (nb_dst << 4) | nb_src;
+
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
+		rte_wmb();
+		plt_write64(ring_conf->pending + 1, dpi_conf->dbell);
+		dpi_conf->stats.submitted += ring_conf->pending + 1;
+		ring_conf->pending = 0;
+	} else {
+		ring_conf->pending++;
+	}
+
+	return dpi_conf->desc_idx++;
+}
+
+int
+cn20k_dmadev_fill(void *dev_private, uint16_t vchan, uint64_t pattern, rte_iova_t dst,
+		  uint32_t length, uint64_t flags)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	struct roc_dpi_lf_que *queue = dpi_conf->que;
+	struct cn20k_ring_conf *ring_conf;
+	uint8_t *comp_ptr;
+	uint64_t *cmd;
+
+#define DPI_XT_TYPE_FILL BIT_ULL(50)
+
+	if (unlikely(((dpi_conf->c_desc.tail + 1) & max_cnt) == (dpi_conf->c_desc.head & max_cnt)))
+		return -ENOSPC;
+
+	if (dpivf->vchans_per_ring == 1) {
+		cmd = queue->cmd_base + ((dpi_conf->c_desc.tail & max_cnt) << 4);
+	} else {
+		cmd = queue->cmd_base + (queue->widx << 4);
+		queue->widx = (queue->widx + 1) & (queue->qsize - 1);
+	}
+
+	ring_conf = &(dpivf->ring_conf[dpi_conf->ridx]);
+	comp_ptr = &dpi_conf->c_desc
+			    .compl_ptr[(dpi_conf->c_desc.tail & max_cnt) * CNXK_DPI_COMPL_OFFSET];
+	dpi_conf->c_desc.tail++;
+
+	cmd[1] = (uint64_t)comp_ptr;
+	cmd[4] = (uint64_t)length << 32;
+	cmd[5] = pattern;
+	cmd[6] = dst;
+	cmd[0] = DPI_CMD_VLD_BIT | DPI_XT_TYPE_FILL | dpi_conf->cmd.u | 0x10U;
+
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
+		rte_wmb();
+		plt_write64(ring_conf->pending + 1, dpi_conf->dbell);
+		dpi_conf->stats.submitted += (ring_conf->pending + 1);
+		ring_conf->pending = 0;
+	} else {
+		ring_conf->pending++;
+	}
+
+	return dpi_conf->desc_idx++;
+}
+
 static inline uint64_t
 cnxk_dma_adapter_format_event(uint64_t event)
 {
@@ -450,6 +607,63 @@ cnxk_dma_adapter_format_event(uint64_t event)
 	return w0;
 }
 
+uint16_t
+cn20k_dma_ops_enqueue(void *dev_private, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct cnxk_dpi_vf_s *dpivf = dev_private;
+	struct cnxk_dpi_conf *dpi_conf = &dpivf->conf[vchan];
+	const uint16_t max_cnt = dpi_conf->c_desc.max_cnt;
+	struct roc_dpi_lf_que *queue = dpi_conf->que;
+	uint16_t idx, eidx, tmp;
+	struct rte_dma_op *op;
+	uint16_t space, i, j;
+	uint16_t src, dst;
+	uint8_t *comp_ptr;
+	uint64_t *cmd;
+
+	space = (max_cnt + dpi_conf->c_desc.head - dpi_conf->c_desc.tail) & max_cnt;
+	space = RTE_MIN(space, nb_ops);
+
+	for (j = 0; j < space; j++) {
+		op = ops[j];
+		src = op->nb_src;
+		dst = op->nb_dst;
+
+		idx = 4; eidx = 4; tmp = 0;
+
+		if (dpivf->vchans_per_ring == 1) {
+			cmd = queue->cmd_base + ((dpi_conf->c_desc.tail & max_cnt) << 4);
+		} else {
+			cmd = queue->cmd_base + (queue->widx << 4);
+			queue->widx = (queue->widx + 1) & (queue->qsize - 1);
+		}
+		comp_ptr = &dpi_conf->c_desc.compl_ptr[(dpi_conf->c_desc.tail & max_cnt) *
+						       CNXK_DPI_COMPL_OFFSET];
+		dpi_conf->c_desc.ops[dpi_conf->c_desc.tail & max_cnt] = op;
+		dpi_conf->c_desc.tail++;
+
+		cmd[1] = (uint64_t)comp_ptr;
+
+		/* Fill source segments */
+		for (i = 0; i < src; i++)
+			DPI_WRITE_SEGMENT(cmd, op->src_dst_seg, i, idx, eidx, tmp);
+
+		/* Fill destination segments */
+		for (i = 0; i < dst; i++)
+			DPI_WRITE_SEGMENT(cmd, (op->src_dst_seg + src), i, idx, eidx, tmp);
+
+		cmd[0] = DPI_CMD_VLD_BIT | dpi_conf->cmd.u | (dst << 4) | src;
+	}
+
+	if (space) {
+		rte_wmb();
+		plt_write64(space, dpi_conf->dbell);
+		dpi_conf->stats.submitted += space;
+	}
+
+	return j;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(cn10k_dma_adapter_enqueue)
 uint16_t
 cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
-- 
2.34.1

