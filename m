Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C35CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3637D40685;
	Wed, 12 Nov 2025 10:11:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A550140670
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZ0ztXc/vfQdScaJDPP9+GfLKm9GRK0RKYtgSRv0CRA=;
 b=Dc5X3L435h7lUtNsGmhugKSmCdShbAkx2vEt6CFIimkDOStL6koI7Zf7FvbfDNbYNO0IAH
 PSHb7tn/BF2tMKQurvMc1+xo3C9uYcPYk68K+k5qgIksFsqhNYNY5E2fxU/LTHwgFL3hZA
 xKlIEECmGQL02RlLGeRMy6sY80BmEzQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-UOwIHXjWNXiQY88D5VGGZw-1; Wed,
 12 Nov 2025 04:11:15 -0500
X-MC-Unique: UOwIHXjWNXiQY88D5VGGZw-1
X-Mimecast-MFC-AGG-ID: UOwIHXjWNXiQY88D5VGGZw_1762938673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0ACD195605A; Wed, 12 Nov 2025 09:11:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA432180035F; Wed, 12 Nov 2025 09:11:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 2/5] dma/dpaa2: remove DMA device in bus device
Date: Wed, 12 Nov 2025 10:10:45 +0100
Message-ID: <20251112091049.2669481-3-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kPzU7HPAN52Y2Bm4pc55eLuZ1A3dP5m2PKX3iLBwU-0_1762938673
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

This leaves no user of the dmadev field in the fslmc device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
 drivers/dma/dpaa2/dpaa2_qdma.c       | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 45c7a519f9..efa88754a7 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -99,7 +99,6 @@ struct rte_dpaa2_device {
 	struct rte_device device;           /**< Inherit core device */
 	union {
 		struct rte_eth_dev *eth_dev;        /**< ethernet device */
-		struct rte_dma_dev *dmadev;          /**< DMA Device */
 		struct rte_rawdev *rawdev;          /**< Raw Device */
 	};
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 4be43d6bd9..beca464c72 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1455,6 +1455,9 @@ dpaa2_qdma_stop(struct rte_dma_dev *dev)
 	return 0;
 }
 
+static int
+dpaa2_dpdmai_dev_uninit(struct rte_dma_dev *dev);
+
 static int
 dpaa2_qdma_close(struct rte_dma_dev *dev)
 {
@@ -1505,6 +1508,8 @@ dpaa2_qdma_close(struct rte_dma_dev *dev)
 	/* Reset QDMA device structure */
 	qdma_dev->num_vqs = 0;
 
+	dpaa2_dpdmai_dev_uninit(dev);
+
 	return 0;
 }
 
@@ -1703,7 +1708,6 @@ dpaa2_qdma_probe(struct rte_dpaa2_driver *dpaa2_drv,
 		return -EINVAL;
 	}
 
-	dpaa2_dev->dmadev = dmadev;
 	dmadev->dev_ops = &dpaa2_qdma_ops;
 	dmadev->device = &dpaa2_dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
@@ -1727,13 +1731,10 @@ dpaa2_qdma_probe(struct rte_dpaa2_driver *dpaa2_drv,
 static int
 dpaa2_qdma_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
-	struct rte_dma_dev *dmadev = dpaa2_dev->dmadev;
 	int ret;
 
 	DPAA2_QDMA_FUNC_TRACE();
 
-	dpaa2_dpdmai_dev_uninit(dmadev);
-
 	ret = rte_dma_pmd_release(dpaa2_dev->device.name);
 	if (ret)
 		DPAA2_QDMA_ERR("Device cleanup failed");
-- 
2.51.0

