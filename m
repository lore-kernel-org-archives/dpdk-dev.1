Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEAC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C00142E5E;
	Thu, 17 Sep 2026 09:50:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B05742E7B
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYNhFfKawR2mHuVEd+y6gcxn3MHP29+uMvtsLvbS4zQ=;
 b=DlFafF2XBuAHg276J8T1dhKaCKoZbSbD1G8ER5Ib5PzIhNR8dkJRsxz1sFW5y7bJyoSSVG
 F7izJew+4BneP2c5iWIxj21blXnEQxD+2sx29CkvXf731ag1X/i1RvnZSokLqm15eFtM1W
 kxcuwe+Fmqc87nzzbqbB/b/810OKlAo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-yZfoFr1YPWO1Osv1KuszOQ-1; Thu,
 17 Sep 2026 03:50:16 -0400
X-MC-Unique: yZfoFr1YPWO1Osv1KuszOQ-1
X-Mimecast-MFC-AGG-ID: yZfoFr1YPWO1Osv1KuszOQ_1789631415
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D3CC1955F1A; Thu, 17 Sep 2026 07:50:15 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 719441956087; Thu, 17 Sep 2026 07:50:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 14/16] bus/fslmc: call VFIO setup for some device from bus
 layer
Date: Thu, 17 Sep 2026 09:49:14 +0200
Message-ID: <20260917074917.595603-15-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fM7MRtNVWJlvRaWoudHkx0MCFHwgKAIO2mm-ghSDQII_1789631415
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

Move VFIO setup for ETH, CRYPTO and QDMA devices from fslmc_vfio.c
to fslmc_bus.c scan layer.
Also move interrupt setup for ETH devices.

Add fslmc_vfio_dev_setup() (resp. fslmc_vfio_dev_close()) wrapper
that handles VFIO device fd acquisition and interrupt setup
(resp. device removal), hiding VFIO internals from the bus layer.

Note: before this change, CRYPTO and QDMA devices were getting a
VFIO device FD even though nothing seems to be done with it.
This is kept as is, the device FD is closed on call to
fslmc_vfio_dev_close().

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- added cleanup on failure,

---
 drivers/bus/fslmc/fslmc_bus.c  | 12 +++++
 drivers/bus/fslmc/fslmc_vfio.c | 83 ++++++++++++++++++++++++++--------
 drivers/bus/fslmc/fslmc_vfio.h |  5 ++
 3 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 3b22d3367d..4f4abd19ce 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -579,12 +579,23 @@ rte_fslmc_scan(void)
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 			goto vfio_dma_unmap;
 		}
+
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+			ret = fslmc_vfio_dev_setup(dev);
+			if (ret) {
+				DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
+				goto vfio_dev_close;
+			}
+		}
 	}
 
 	process_once = 1;
 
 	return 0;
 
+vfio_dev_close:
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
+		fslmc_vfio_dev_close(dev);
 vfio_dma_unmap:
 	fslmc_vfio_dmaunmap();
 vfio_close_group:
@@ -631,6 +642,7 @@ rte_fslmc_close(struct rte_bus *bus)
 	RTE_BUS_FOREACH_DEV(dev, bus) {
 		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
 			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
+		fslmc_vfio_dev_close(dev);
 	}
 
 	ret = fslmc_vfio_close_group();
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 857f22f204..04582e38c6 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1444,6 +1444,15 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
 	return -EIO;
 }
 
+static void
+dpaa2_close_intr(struct rte_intr_handle *intr_handle)
+{
+	if (rte_intr_fd_get(intr_handle) >= 0) {
+		close(rte_intr_fd_get(intr_handle));
+		rte_intr_fd_set(intr_handle, -1);
+	}
+}
+
 static void
 fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	int vfio_fd)
@@ -1478,8 +1487,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 }
 
 /*
- * fslmc_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
- * EVENT) devices.
+ * fslmc_process_iodevices for processing only IO devices.
  */
 static int
 fslmc_process_iodevices(struct rte_dpaa2_device *dev)
@@ -1494,12 +1502,6 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 		return ret;
 
 	switch (dev->dev_type) {
-	case DPAA2_ETH:
-		ret = rte_dpaa2_vfio_setup_intr(dev->intr_handle, dev_fd,
-				device_info.num_irqs);
-		if (ret)
-			return ret;
-		break;
 	case DPAA2_CON:
 	case DPAA2_IO:
 	case DPAA2_CI:
@@ -1523,6 +1525,61 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 	return 0;
 }
 
+int
+fslmc_vfio_dev_setup(struct rte_dpaa2_device *dev)
+{
+	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
+	int dev_fd;
+	int ret;
+
+	ret = fslmc_vfio_setup_device(dev->device.name, &dev_fd, &device_info);
+	if (ret) {
+		DPAA2_BUS_ERR("VFIO setup failed for %s: %d",
+			      dev->device.name, ret);
+		return ret;
+	}
+
+	if (dev->dev_type == DPAA2_ETH) {
+		ret = rte_dpaa2_vfio_setup_intr(dev->intr_handle, dev_fd,
+						device_info.num_irqs);
+		if (ret) {
+			DPAA2_BUS_ERR("Interrupt setup failed for %s: %d",
+				      dev->device.name, ret);
+			fslmc_vfio_dev_close(dev);
+			return ret;
+		}
+	}
+
+	DPAA2_BUS_DEBUG("Device (%s) VFIO setup completed", dev->device.name);
+	return 0;
+}
+
+int
+fslmc_vfio_dev_close(struct rte_dpaa2_device *dev)
+{
+	int vfio_group_fd;
+	int ret;
+	const char *group_name = fslmc_vfio_get_group_name();
+
+	vfio_group_fd = fslmc_vfio_group_fd_by_name(group_name);
+	if (vfio_group_fd <= 0) {
+		DPAA2_BUS_ERR("Get fd by name(%s) failed(%d)",
+			      group_name, vfio_group_fd);
+		if (vfio_group_fd < 0)
+			return vfio_group_fd;
+		return -EIO;
+	}
+
+	dpaa2_close_intr(dev->intr_handle);
+
+	ret = fslmc_vfio_group_remove_dev(vfio_group_fd, dev->device.name);
+	if (ret)
+		DPAA2_BUS_ERR("Failed to remove %s from vfio", dev->device.name);
+
+	DPAA2_BUS_DEBUG("Device (%s) closed", dev->device.name);
+	return ret;
+}
+
 static int
 fslmc_process_mcp(struct rte_dpaa2_device *dev)
 {
@@ -1682,16 +1739,6 @@ fslmc_vfio_process_group(void)
 		}
 	}
 
-	/* Process regular devices */
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		ret = fslmc_process_iodevices(dev);
-		if (ret) {
-			DPAA2_BUS_DEBUG("Dev (%s) init failed",
-					dev->device.name);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index 57fe7038de..0973ddbe37 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -61,4 +61,9 @@ char *fslmc_get_container(void);
 int fslmc_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
 int fslmc_vfio_dmaunmap(void);
+
+struct rte_dpaa2_device;
+int fslmc_vfio_dev_setup(struct rte_dpaa2_device *dev);
+int fslmc_vfio_dev_close(struct rte_dpaa2_device *dev);
+
 #endif /* _FSLMC_VFIO_H_ */
-- 
2.54.0

