Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D6CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1288040648;
	Tue, 23 Jun 2026 12:55:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C654B40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEml60900TxUNoNMoI790sxzfYNHqC0jk/PI5kdm7bY=;
 b=Wqoersvl4I9rbaDP0IqCERQPDyZHnQ6xi2Jq7L+aqJSueU0fmoml1MQ3ybQHhk+llV33MJ
 DGmP5S7BPYVZj8fVtsPvUN7JCYuzzYiZUPIzc61+MtQcAfRb1XU8knDda1rtkmDNC7IMyG
 /TvuCtNudSP3pQUpdcy3px+Oexe3iA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-NYQM3o11PQmFlV0qziU-VQ-1; Tue,
 23 Jun 2026 06:55:27 -0400
X-MC-Unique: NYQM3o11PQmFlV0qziU-VQ-1
X-Mimecast-MFC-AGG-ID: NYQM3o11PQmFlV0qziU-VQ_1782212125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A29A180034C; Tue, 23 Jun 2026 10:55:25 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEF0D1800348; Tue, 23 Jun 2026 10:55:22 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v3 07/11] bus/ifpga: allocate interrupt during probing
Date: Tue, 23 Jun 2026 12:54:34 +0200
Message-ID: <20260623105439.2144694-8-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J8xYDWxLzM0JcK5wRwJ5ou9Kybo8FKU3pJGIpr6WTqM_1782212125
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

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).
Instead, allocate this handle at the time probe_device is called.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/ifpga/ifpga_bus.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 2c22329f65..af77d69ef6 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -144,14 +144,6 @@ ifpga_scan_one(struct rte_rawdev *rawdev,
 	afu_dev->id.uuid.uuid_high = 0;
 	afu_dev->id.port      = afu_pr_conf.afu_id.port;
 
-	/* Allocate interrupt instance */
-	afu_dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (afu_dev->intr_handle == NULL) {
-		IFPGA_BUS_ERR("Failed to allocate intr handle");
-		goto end;
-	}
-
 	if (rawdev->dev_ops && rawdev->dev_ops->dev_info_get)
 		rawdev->dev_ops->dev_info_get(rawdev, afu_dev, sizeof(*afu_dev));
 
@@ -177,10 +169,7 @@ ifpga_scan_one(struct rte_rawdev *rawdev,
 end:
 	rte_kvargs_free(kvlist);
 	free(path);
-	if (afu_dev) {
-		rte_intr_instance_free(afu_dev->intr_handle);
-		free(afu_dev);
-	}
+	free(afu_dev);
 
 	return NULL;
 }
@@ -272,8 +261,22 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
 	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
 	struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(drv, *afu_drv);
+	int ret;
+
+	afu_dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (afu_dev->intr_handle == NULL) {
+		IFPGA_BUS_ERR("Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
+	ret = afu_drv->probe(afu_dev);
+	if (ret != 0) {
+		rte_intr_instance_free(afu_dev->intr_handle);
+		afu_dev->intr_handle = NULL;
+	}
 
-	return afu_drv->probe(afu_dev);
+	return ret;
 }
 
 /*
-- 
2.54.0

