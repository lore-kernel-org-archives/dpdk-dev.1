Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BF606A78E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ra4EW4uV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8662542E4C;
	Tue,  3 Nov 2026 16:07:34 +0100 (CET)
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
 by mails.dpdk.org (Postfix) with ESMTPS id 78D7942E02
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:32 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=noIu0YgXHu9puoBpwCdYaljxVIZl8R7J7z6TLkHX6oE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718452; v=1; x=1794323252;
 b=Ra4EW4uVVzFVIrSyEO1rGeAezk+YheNF4Zz9JjHOI6XHOXobzVIVjvpnehUl6eYht6IOQWrA
 QN2KUijfOWsFyzDRra/F6JQarPSG3RZ6bXs7N1dtX36zpQ57jykrla0cRlGBaG63+d7qYJJLjAw
 xitC2efAxpSkrBses8yD6OuY=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 690efeb262b72dc5;
 Tue, 03 Nov 2026 15:07:32 +0000
X-Mizu-Trace-ID: 690efeb262b72dc5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 087/227] dma/imx_edma5: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:45 +0800
Message-ID: <20261103145306.487255-88-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.c b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
index 778644fa82..33f751465f 100644
--- a/drivers/dma/imx_edma5/imx_edma5_dmadev.c
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
@@ -100,7 +100,7 @@ imx_edma5_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf, ui
 	RTE_SET_USED(conf_sz);
 
 	if (ed->vchans == NULL) {
-		ed->vchans = rte_zmalloc_socket("imx_edma5_vchans",
+		ed->vchans = rte_zmalloc_numa("imx_edma5_vchans",
 			ed->max_vchans * sizeof(struct imx_edma5_vchan), RTE_CACHE_LINE_SIZE,
 			dev->data->numa_node);
 		if (ed->vchans == NULL) {
@@ -202,7 +202,7 @@ imx_edma5_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	vc->desc_mask = conf->nb_desc - 1;
 	vc->iova_is_va = (rte_eal_iova_mode() == RTE_IOVA_VA);
 
-	vc->jobs = rte_zmalloc_socket("imx_edma5_jobs", vc->nb_desc * sizeof(struct imx_edma5_job),
+	vc->jobs = rte_zmalloc_numa("imx_edma5_jobs", vc->nb_desc * sizeof(struct imx_edma5_job),
 		RTE_CACHE_LINE_SIZE, dev->data->numa_node);
 	if (vc->jobs == NULL) {
 		IMX_EDMA5_LOG(ERR, "Failed to alloc job ring for vchan %u", vchan);
@@ -210,7 +210,7 @@ imx_edma5_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	}
 
 	/* One IMX_EDMA5_SG_TCD_PER_JOB descriptor slice per job ring slot. */
-	vc->sg_tcd_pool = rte_zmalloc_socket("imx_edma5_sgtcd",
+	vc->sg_tcd_pool = rte_zmalloc_numa("imx_edma5_sgtcd",
 		(size_t)vc->nb_desc * IMX_EDMA5_SG_TCD_PER_JOB * sizeof(struct imx_edma5_hw_tcd64),
 		RTE_CACHE_LINE_SIZE, dev->data->numa_node);
 	if (vc->sg_tcd_pool == NULL) {
@@ -1037,7 +1037,7 @@ imx_edma5_probe(struct rte_platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dev = rte_dma_pmd_allocate(name, rte_socket_id(), sizeof(struct imx_edma5_dev));
+	dev = rte_dma_pmd_allocate(name, rte_numa_id(), sizeof(struct imx_edma5_dev));
 	if (dev == NULL) {
 		IMX_EDMA5_LOG(ERR, "Failed to allocate dmadev for %s", name);
 		return -ENOMEM;
-- 
2.55.0

