Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13993606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4Hr6giq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C95C540B8C;
	Mon, 26 Oct 2026 19:11:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 761FC4067C
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBZqj0mm8obIqE7KBY+kafa9ZKTZionJoBpAAFi+Qsk=;
 b=Q4Hr6giqCN9sOP8fhPk15+SBkATQwTb5Mk9/v5f1E54Sd/vHjQtjjS7GHe9TZyaxygg8OT
 rh4G89pEjN70vl52fXxcarCMMgJWUvYz20CUesstJvLwdGPdPJK0mKRlV4PyKyeiulPIwf
 +F8BCx3TnAzQ+oFnnu+6/JCJrojMRgw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-05Ol2wVrOg6sngtF_lrrFg-1; Mon,
 26 Oct 2026 14:11:25 -0400
X-MC-Unique: 05Ol2wVrOg6sngtF_lrrFg-1
X-Mimecast-MFC-AGG-ID: 05Ol2wVrOg6sngtF_lrrFg_1793038284
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F9AC18007F8; Mon, 26 Oct 2026 18:11:24 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 451A61956087; Mon, 26 Oct 2026 18:11:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 15/16] bus/fslmc: allocate interrupt during probing
Date: Mon, 26 Oct 2026 19:10:29 +0100
Message-ID: <20261026181031.304100-16-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GyB3xRVRQC--1oxmpxl-QpqtKB4kEzybMLFOB5Riagc_1793038284
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).

Instead, allocate this handle, set eventfds and vfio at the time
probe_device is called.

Adjust the unplug_device path accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 58 +++++++++++++++--------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 7863bb233e..cf3cec246b 100644
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
 
@@ -573,7 +559,6 @@ rte_fslmc_scan(void)
 static int
 rte_fslmc_probe(struct rte_bus *bus)
 {
-	struct rte_dpaa2_device *dev;
 	static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
 		.name = DPAA2_SEQN_DYNFIELD_NAME,
 		.size = sizeof(dpaa2_seqn_t),
@@ -621,19 +606,8 @@ rte_fslmc_probe(struct rte_bus *bus)
 		goto vfio_dma_unmap;
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		ret = fslmc_vfio_dev_setup(dev);
-		if (ret) {
-			DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
-			goto vfio_dev_close;
-		}
-	}
-
 	return rte_bus_generic_probe(bus);
 
-vfio_dev_close:
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
-		fslmc_vfio_dev_close(dev);
 vfio_dma_unmap:
 	fslmc_vfio_dmaunmap();
 vfio_close_group:
@@ -665,7 +639,6 @@ rte_fslmc_close(struct rte_bus *bus)
 	RTE_BUS_FOREACH_DEV(dev, bus) {
 		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
 			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
-		fslmc_vfio_dev_close(dev);
 	}
 
 	ret = fslmc_vfio_close_group();
@@ -742,10 +715,27 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
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
@@ -763,12 +753,14 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 		int ret = drv->remove(dev);
 		if (ret != 0)
 			return ret;
-		/* FIXME: unplug_device should free intr_handle */
-		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
-		return 0;
 	}
 
-	return -ENODEV;
+	fslmc_vfio_dev_close(dev);
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
+	DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
+
+	return 0;
 }
 
 struct rte_bus rte_fslmc_bus = {
-- 
2.54.0

