Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6380C982E1
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 14:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE9940A80;
	Sun, 20 Sep 2026 16:42:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C7505402C3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 16:41:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KE37Qm2647558; Sun, 20 Sep 2026 07:41:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 PmAJ7kgUdSIF6am+kC6kYvR9yYwBAgiZ1RXQwFeNHk=; b=CVGgnyZ6D8tPUJ09v
 kHE8lN9r7EJbGlhsEgEug0LUi8+RXCcapVlqLo9Ul9nZX2BZFogcsqDXpDeHJXws
 IGEPEa9Qz00PTU1zuL+3Ue5GRBkNjNnHAXkbEkl8xnc7JdoVOlGTKrk3LBfkOIp5
 b/0v/YxpQNIW5XRPKnBbe+6HeQ/MaGpvGQZk1vYj7LAUkI8+fPs+fUu11Pp6wngT
 SAGM7DBnBHvG7GT66zs+b2wptiviJTuJs6Y2vupslwYRbMUicmYE+Emgfok64Tff
 B0ELVkM/Sd/qUsu6I9uhBwgxOZm+KjwdD7cv9HJCUdwUBD8JvqoxVUFoe4RNYIbT
 D3Abg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gtb588kv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Sep 2026 07:41:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 20 Sep 2026 07:41:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 20 Sep 2026 07:41:53 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id BAF433F7040;
 Sun, 20 Sep 2026 07:41:51 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v2 3/4] dma/cnxk: enable inter process domain DMA support
Date: Sun, 20 Sep 2026 20:11:31 +0530
Message-ID: <20260920144132.762575-4-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920144132.762575-1-vattunuru@marvell.com>
References: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
 <20260920144132.762575-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX5XTj76xFh6xm
 8OH9hfa7UYMUHJbIq0koHehnP1XKkZ2wooBow0JkOJXpdKhqtJOor8sFbp7ryRROgqLmstqXcrk
 /eafYq1HGp6vMqDgf2kkOyVxEt/w20M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX7ggfUJ4LxAxi
 JNMGc7vTo1JwX4cjAx0shUXOh8uZHIWJFPIlhi52ThQbr21KBrRedXX8XiUvY01Xw8tU+0kcDbN
 /Jytf3jaYwkV9vK7j16OzmZfmoOV0vs35InAZg83ctnJczrA7OHnbsY7Xuwg9hmEj4kESP5TFlY
 JT371JuNR5bqhUaYN6PkYUyjO86nxW6mams6mxVRqvWkdQEHGMRbZkd82TrEVP2h3fpCK50zx//
 ZIRlPguuwtHfejbG0gAXGsJeqhmNUs3xf8x0mhDD9wd61d/kh14GGVTGi4RvvfC0mHE+19gjIaW
 gn2+RG840dzk74He4Vi5zo2E0eStS0V4U4eybXgEnaGiH16wm7oFr0Al/3UC2A3+Zk+K8+NmveS
 l517epe4xv77v7POtlJS1oDEKjGLKHHH9HuITU1y3Jfpsn/ytY0KXq8KJqxuFcCTwpMGOG0g0Ci
 lM87DIe0NZbV9HcSfvA==
X-Proofpoint-ORIG-GUID: Noy0UbD-5h6XeCUEKn9G5epUDzP975B1
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6aaff0b2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=6uvpq5QzBp1FEMkKkWAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Noy0UbD-5h6XeCUEKn9G5epUDzP975B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
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
 doc/guides/dmadevs/cnxk.rst    |  73 ++++++++++++++++
 drivers/dma/cnxk/cnxk_dmadev.c | 148 ++++++++++++++++++++++++++++++++-
 drivers/dma/cnxk/cnxk_dmadev.h |   1 +
 3 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/doc/guides/dmadevs/cnxk.rst b/doc/guides/dmadevs/cnxk.rst
index 2794f393a7..9021a0f126 100644
--- a/doc/guides/dmadevs/cnxk.rst
+++ b/doc/guides/dmadevs/cnxk.rst
@@ -110,6 +110,79 @@ Refer to the :ref:`dmadev_enqueue_dequeue` section
 of the dmadev library documentation
 for details on operation enqueue and submission API usage.
 
+CN20K inter-process domain DMA transfers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+CN20K DPI devices advertise the ``RTE_DMA_CAPA_INTER_PROCESS_DOMAIN`` capability.
+This enables DMA transfers between memory owned by different DPDK processes
+running on the same CN20K SoC.
+
+Each participating process must bind its own CN20K DPI PF or VF device to
+``vfio-pci`` and probe it through the ``cnxk`` dmadev PMD.
+Inter-process domain transfers are supported only with
+``RTE_DMA_DIR_MEM_TO_MEM`` direction.
+
+Access pair group setup
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Before configuring a virtual channel for inter-process DMA, each process must
+join a common access pair group using the dmadev access pair group API.
+The general setup flow is described in
+:doc:`/prog_guide/dmadev` under *Inter-domain DMA Transfers*.
+
+At a high level:
+
+#. Each process generates a unique ``domain_id`` (``rte_uuid_t``) to identify
+   its process domain.
+#. Process#1 generates a ``token`` and calls ``rte_dma_access_pair_group_create()``.
+#. Process#1 shares the ``group_id``, ``token`` and its ``domain_id`` with
+   Process#2 through an out-of-band channel.
+#. Process#2 calls ``rte_dma_access_pair_group_join()`` with the shared
+   ``group_id``, ``token`` and its own ``domain_id``.
+#. Each process retrieves source and destination handler values using
+   ``rte_dma_access_pair_group_handler_get()``.
+#. Each process configures its virtual channel and performs DMA transfers.
+#. Process#2 calls ``rte_dma_access_pair_group_leave()`` when finished.
+#. Process#1 calls ``rte_dma_access_pair_group_destroy()`` to tear down the group.
+
+Virtual channel configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+After the access pair group is established and handler values are exchanged,
+configure the virtual channel with ``RTE_DMA_INTER_PROCESS_DOMAIN`` domain type.
+For example::
+
+     struct rte_dma_vchan_conf vchan_conf = {0};
+
+     vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+     vchan_conf.nb_desc = 128;
+     vchan_conf.domain.type = RTE_DMA_INTER_PROCESS_DOMAIN;
+     vchan_conf.domain.src_handler = local_src_handler;
+     vchan_conf.domain.dst_handler = peer_dst_handler;
+
+     rte_dma_vchan_setup(dma_dev_id, vchan, &vchan_conf);
+
+``src_handler``
+
+  Handler for the local process domain, obtained from
+  ``rte_dma_access_pair_group_handler_get()`` using the local domain_id.
+
+``dst_handler``
+
+  Handler for the peer process domain, obtained from
+  ``rte_dma_access_pair_group_handler_get()`` using the peer domain_id.
+
+Once the virtual channel is configured, start the device and issue copy or
+copy-SG operations as for a regular memory-to-memory transfer.
+
+.. note::
+
+   Inter-process domain DMA is supported on CN20K only.
+   CN9K/CN10K DPI devices do not advertise
+   ``RTE_DMA_CAPA_INTER_PROCESS_DOMAIN``.
+
+   The access pair group APIs are experimental and may change in future releases.
+
 Performance Tuning Parameters
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 602241d755..db177afd6f 100644
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
@@ -443,6 +443,13 @@ cn20k_dmadev_setup(struct cnxk_dpi_vf_s *dpivf, uint16_t vchan,
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
@@ -1016,6 +1023,140 @@ cnxk_set_fp_ops(struct rte_dma_dev *dev, uint8_t ena_enq_deq)
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
@@ -1025,6 +1166,11 @@ static const struct rte_dma_dev_ops cnxk_dmadev_ops = {
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

