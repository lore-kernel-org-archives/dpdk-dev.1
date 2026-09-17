Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EAC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FED942E5D;
	Thu, 17 Sep 2026 09:50:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 888AA42E7D
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7GKw2M4EU6UFUyd+6oMDViE5uRvAt6rjiN4t3dI0zg=;
 b=b1GpupgSRjYcKa7RQzul9TO9+0cXvlhgKwkJB8w6gnHhnULLUhEOF06tGRmhaYV+AW0FJU
 kVaU9wipjehDtboz1/T+9CFdEPWGgTdQOBgv9pnQWfU8+C6qAapgqXhcQV9PX6gN0BSQOQ
 /Oqjfs64EC1VPLzqmfQMdAlDl7ye/pM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-gwgVqDWUMeyDpU_bY7rNeA-1; Thu,
 17 Sep 2026 03:50:19 -0400
X-MC-Unique: gwgVqDWUMeyDpU_bY7rNeA-1
X-Mimecast-MFC-AGG-ID: gwgVqDWUMeyDpU_bY7rNeA_1789631418
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3CDD195F148; Thu, 17 Sep 2026 07:50:18 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6E1D30001BE; Thu, 17 Sep 2026 07:50:17 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 15/16] bus/fslmc: allocate interrupt during probing
Date: Thu, 17 Sep 2026 09:49:15 +0200
Message-ID: <20260917074917.595603-16-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W8ixPNoXohNIBBM9Nt-Wh86To7RnSudVZJr4jsxNJdA_1789631418
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

Instead, allocate this handle, set eventfds and vfio at the time
probe_device is called.

Adjust the unplug_device path accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 51 +++++++++++++++--------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4f4abd19ce..909edb9124 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -104,7 +104,6 @@ fslmc_free_device(struct rte_device *rte_dev)
 
 	if (dev->dev_type < DPAA2_DEVTYPE_MAX)
 		fslmc_bus_device_count[dev->dev_type]--;
-	rte_intr_instance_free(dev->intr_handle);
 	free(dev);
 }
 
@@ -144,7 +143,6 @@ fslmc_remove_control_device(struct rte_dpaa2_device *dev)
 		fslmc_bus_device_count[dev->dev_type]--;
 
 	TAILQ_REMOVE(&fslmc_control_devices, &dev->device, next);
-	rte_intr_instance_free(dev->intr_handle);
 	free(dev);
 }
 
@@ -256,15 +254,6 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.numa_node = SOCKET_ID_ANY;
 	dev->dev_type = dev_type;
 
-	/* Allocate interrupt instance */
-	dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL) {
-		DPAA2_BUS_ERR("Failed to allocate intr handle");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
 	if (sscanf(dev_id, "%hu", &dev->object_id) != 1) {
 		DPAA2_BUS_ERR("Failed to parse object ID");
 		ret = -EINVAL;
@@ -292,10 +281,7 @@ scan_one_fslmc_device(char *dev_name)
 
 	return 0;
 cleanup:
-	if (dev) {
-		rte_intr_instance_free(dev->intr_handle);
-		free(dev);
-	}
+	free(dev);
 	return ret;
 }
 
@@ -579,23 +565,12 @@ rte_fslmc_scan(void)
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 			goto vfio_dma_unmap;
 		}
-
-		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-			ret = fslmc_vfio_dev_setup(dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
-				goto vfio_dev_close;
-			}
-		}
 	}
 
 	process_once = 1;
 
 	return 0;
 
-vfio_dev_close:
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
-		fslmc_vfio_dev_close(dev);
 vfio_dma_unmap:
 	fslmc_vfio_dmaunmap();
 vfio_close_group:
@@ -642,7 +617,6 @@ rte_fslmc_close(struct rte_bus *bus)
 	RTE_BUS_FOREACH_DEV(dev, bus) {
 		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
 			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
-		fslmc_vfio_dev_close(dev);
 	}
 
 	ret = fslmc_vfio_close_group();
@@ -718,10 +692,27 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(driver, *drv);
 	int ret = 0;
 
-	/* FIXME: probe_device should allocate intr_handle */
+	/* Allocate interrupt instance */
+	dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (dev->intr_handle == NULL) {
+		DPAA2_BUS_ERR("Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
+	ret = fslmc_vfio_dev_setup(dev);
+	if (ret) {
+		DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
+		goto release_intr;
+	}
+
 	ret = drv->probe(drv, dev);
 	if (ret != 0) {
 		DPAA2_BUS_ERR("Unable to probe");
+		fslmc_vfio_dev_close(dev);
+release_intr:
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 	} else {
 		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
@@ -739,7 +730,9 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 		int ret = drv->remove(dev);
 		if (ret != 0)
 			return ret;
-		/* FIXME: unplug_device should free intr_handle */
+		fslmc_vfio_dev_close(dev);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
 		return 0;
 	}
-- 
2.54.0

