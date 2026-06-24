Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53992CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BA164066F;
	Wed, 24 Jun 2026 12:44:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39CCB40659
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFAU9xKNKmJCzXbBdeHJhVLCOVxrp9+2Nyq3tpvPV1Q=;
 b=C1c7jqtZf+kORjh0QxoYWtnHS04HdmSedTVOWAAOnRqk6Lt8EByPasne6Y8yBgjH3YoAGT
 4+Zap2cU30bhFNh94/gClkGXViNkES2sfvrkfyWQz0Za+i1Y3OeLYh1tqY3W1gboW7KvrS
 MLk5sBof9gSPV8Xc907sBEsqax1ltIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-neQRnoCpPD2F5NmWoHvmSQ-1; Wed,
 24 Jun 2026 06:44:18 -0400
X-MC-Unique: neQRnoCpPD2F5NmWoHvmSQ-1
X-Mimecast-MFC-AGG-ID: neQRnoCpPD2F5NmWoHvmSQ_1782297857
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24B801956047; Wed, 24 Jun 2026 10:44:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7099E1800361; Wed, 24 Jun 2026 10:44:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v4 08/12] bus/ifpga: allocate interrupt during probing
Date: Wed, 24 Jun 2026 12:43:19 +0200
Message-ID: <20260624104324.3576408-9-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tB-ywntW0lP4oEhXlZyvCr2iWSnIo55kbESHNu4qPPo_1782297857
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

