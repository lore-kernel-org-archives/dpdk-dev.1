Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD4CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B7D042F71;
	Thu, 11 Jun 2026 15:08:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9969E42EDC
 for <dev@dpdk.org>; Thu, 11 Jun 2026 15:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781183292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndOe21mZ0yYAR2RDZMVO7tLvBHu7rEALx+ewaV9Wmdo=;
 b=XjUymI2oGbAg/w0T8PfxcYrrTfiGt6JcTILYAEPYZzRN1W95J8ocLtR3yQIeqWqgYTKDGP
 YPxZtJ++g5Wd9U3iSsScnLc2/AvKokUhAPc0vyzMFLDlAu3XpBOTfHJ2ULFQcuvic+uMVl
 gf1Y9Vm2AJEbm8p9sj3aCCKQy1e3qj4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-3eZrxJxoMxSeuMeL6awidQ-1; Thu,
 11 Jun 2026 09:08:10 -0400
X-MC-Unique: 3eZrxJxoMxSeuMeL6awidQ-1
X-Mimecast-MFC-AGG-ID: 3eZrxJxoMxSeuMeL6awidQ_1781183289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 806421953963; Thu, 11 Jun 2026 13:08:09 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE4201800351; Thu, 11 Jun 2026 13:08:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, Sachin Saxena <sachin.saxena@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 2/3] dma/dpaa: remove dmadev pointer from bus device
Date: Thu, 11 Jun 2026 15:07:36 +0200
Message-ID: <20260611130738.1720628-3-david.marchand@redhat.com>
In-Reply-To: <20260611130738.1720628-1-david.marchand@redhat.com>
References: <20260611130738.1720628-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: owvbAz6UZDJ1YxmeXuGVh50lewhg7teHSldlG0ZsDSI_1781183289
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

A driver .dev_close op is automatically called when releasing a dma
device.
Move device specific unitialisation in this driver .dev_close op.

This leaves no user of the dmadev field in the dpaa device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/bus_dpaa_driver.h |  1 -
 drivers/dma/dpaa/dpaa_qdma.c       | 39 +++++++++++++++---------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 6759792eea..0642aee14a 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -82,7 +82,6 @@ struct rte_dpaa_device {
 	struct rte_device device;
 	union {
 		struct rte_eth_dev *eth_dev;
-		struct rte_dma_dev *dmadev;
 	};
 	struct dpaa_device_id id;
 	struct rte_intr_handle *intr_handle;
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 74e23d2ee5..a695f58bc5 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -965,8 +965,24 @@ dpaa_qdma_start(__rte_unused struct rte_dma_dev *dev)
 }
 
 static int
-dpaa_qdma_close(__rte_unused struct rte_dma_dev *dev)
+dpaa_qdma_close(struct rte_dma_dev *dmadev)
 {
+	struct fsl_qdma_engine *fsl_qdma = dmadev->data->dev_private;
+	uint32_t i, j, regs_size;
+
+	regs_size = fsl_qdma->block_offset * fsl_qdma->num_blocks;
+	regs_size += (QDMA_CTRL_REGION_SIZE + QDMA_STATUS_REGION_SIZE);
+
+	for (i = 0; i < QDMA_BLOCKS; i++)
+		fsl_qdma_free_stq_res(&fsl_qdma->stat_queues[i]);
+
+	for (i = 0; i < QDMA_BLOCKS; i++) {
+		for (j = 0; j < QDMA_QUEUES; j++)
+			fsl_qdma_free_cmdq_res(&fsl_qdma->cmd_queues[i][j]);
+	}
+
+	munmap(fsl_qdma->ctrl_base, regs_size);
+
 	return 0;
 }
 
@@ -1420,7 +1436,6 @@ dpaa_qdma_probe(__rte_unused struct rte_dpaa_driver *dpaa_drv,
 		return -EINVAL;
 	}
 
-	dpaa_dev->dmadev = dmadev;
 	dmadev->dev_ops = &dpaa_qdma_ops;
 	dmadev->device = &dpaa_dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
@@ -1445,24 +1460,8 @@ dpaa_qdma_probe(__rte_unused struct rte_dpaa_driver *dpaa_drv,
 static int
 dpaa_qdma_remove(struct rte_dpaa_device *dpaa_dev)
 {
-	struct rte_dma_dev *dmadev = dpaa_dev->dmadev;
-	struct fsl_qdma_engine *fsl_qdma = dmadev->data->dev_private;
-	uint32_t i, j, regs_size;
-
-	regs_size = fsl_qdma->block_offset * fsl_qdma->num_blocks;
-	regs_size += (QDMA_CTRL_REGION_SIZE + QDMA_STATUS_REGION_SIZE);
-
-	for (i = 0; i < QDMA_BLOCKS; i++)
-		fsl_qdma_free_stq_res(&fsl_qdma->stat_queues[i]);
-
-	for (i = 0; i < QDMA_BLOCKS; i++) {
-		for (j = 0; j < QDMA_QUEUES; j++)
-			fsl_qdma_free_cmdq_res(&fsl_qdma->cmd_queues[i][j]);
-	}
-
-	munmap(fsl_qdma->ctrl_base, regs_size);
-
-	(void)rte_dma_pmd_release(dpaa_dev->device.name);
+	if (rte_dma_pmd_release(dpaa_dev->device.name))
+		DPAA_QDMA_ERR("Device cleanup failed");
 
 	return 0;
 }
-- 
2.53.0

