Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF99CC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB50740689;
	Thu, 23 Jul 2026 15:54:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6215C40B95
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUoZFZycgK5wnF1EoJKZm024IwBk8QXITuFtabIzkrA=;
 b=Rse/A244aHu3m7Ik0eqtGZiDHtTPNw1/cw0zvfOUy29/bNIyQx+SA9/ZhMZAknasnLCNoM
 y3LVmUh7uc30QbTQkRts4rk1AqdnixdS43eXWgVNXRxex/y8Je3Vvc88HIDZ/oAAg4qpU3
 IHPqOiasXr4m4r+HVJ31oyRDQ6QuGss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-9tuFIoQfNwa3f2qWR7odLA-1; Thu,
 23 Jul 2026 09:54:46 -0400
X-MC-Unique: 9tuFIoQfNwa3f2qWR7odLA-1
X-Mimecast-MFC-AGG-ID: 9tuFIoQfNwa3f2qWR7odLA_1784814885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB1C1830317; Thu, 23 Jul 2026 13:54:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 215BD3000225; Thu, 23 Jul 2026 13:54:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 09/11] bus/fslmc: call VFIO setup for some device from bus layer
Date: Thu, 23 Jul 2026 15:53:57 +0200
Message-ID: <20260723135400.3621271-10-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lONrB1rRwqbjWj42ShYN6THRX2KCY3y3LhMi2KoMon4_1784814885
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

Move VFIO device and interrupt setup for ETH, CRYPTO, and QDMA
devices from fslmc_vfio.c to fslmc_bus.c scan layer.

Add fslmc_vfio_dev_setup() (resp. fslmc_vfio_dev_close()) wrapper
that handles VFIO device fd acquisition and interrupt setup
(resp. device removal), hiding VFIO internals from the bus layer.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 13 ++++++
 drivers/bus/fslmc/fslmc_vfio.c | 80 ++++++++++++++++++++++++++++++----
 drivers/bus/fslmc/fslmc_vfio.h |  5 +++
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a03ef6051a..a1bc7d216c 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -488,6 +488,18 @@ rte_fslmc_scan(void)
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 			return 0;
 		}
+
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+			if (dev->dev_type != DPAA2_ETH &&
+			    dev->dev_type != DPAA2_CRYPTO &&
+			    dev->dev_type != DPAA2_QDMA)
+				continue;
+			ret = fslmc_vfio_dev_setup(dev);
+			if (ret) {
+				DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
+				return 0;
+			}
+		}
 	}
 
 	process_once = 1;
@@ -534,6 +546,7 @@ rte_fslmc_close(struct rte_bus *bus)
 			continue;
 		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
 			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
+		fslmc_vfio_dev_close(dev);
 	}
 
 	ret = fslmc_vfio_close_group();
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 5720f366db..9655c27ca8 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1387,6 +1387,15 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
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
@@ -1394,6 +1403,10 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	struct rte_dpaa2_object *object = NULL;
 	int ret;
 
+	RTE_VERIFY(dev->dev_type != DPAA2_CRYPTO);
+	RTE_VERIFY(dev->dev_type != DPAA2_ETH);
+	RTE_VERIFY(dev->dev_type != DPAA2_QDMA);
+
 	switch (dev->dev_type) {
 	case DPAA2_IO:
 	case DPAA2_CON:
@@ -1421,8 +1434,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 }
 
 /*
- * fslmc_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
- * EVENT) devices.
+ * fslmc_process_iodevices for processing only IO devices.
  */
 static int
 fslmc_process_iodevices(struct rte_dpaa2_device *dev)
@@ -1437,12 +1449,6 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
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
@@ -1466,6 +1472,60 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 	return 0;
 }
 
+int
+fslmc_vfio_dev_setup(struct rte_dpaa2_device *dev)
+{
+	int dev_fd = -1;
+	int ret;
+	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
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
@@ -1549,6 +1609,8 @@ fslmc_vfio_close_group(void)
 		case DPAA2_ETH:
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
+			/* ethdev, cryptodev, dmadev are handled at the bus level */
+			break;
 		case DPAA2_IO:
 		case DPAA2_CON:
 		case DPAA2_CI:
@@ -1607,6 +1669,8 @@ fslmc_vfio_process_group(void)
 		case DPAA2_ETH:
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
+			/* ethdev, cryptodev, dmadev are handled at the bus level */
+			break;
 		case DPAA2_CON:
 		case DPAA2_CI:
 		case DPAA2_BPOOL:
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index c995fd67b8..530aaa0a32 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -60,4 +60,9 @@ int fslmc_vfio_close_group(void);
 char *fslmc_get_container(void);
 int fslmc_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
+
+struct rte_dpaa2_device;
+int fslmc_vfio_dev_setup(struct rte_dpaa2_device *dev);
+int fslmc_vfio_dev_close(struct rte_dpaa2_device *dev);
+
 #endif /* _FSLMC_VFIO_H_ */
-- 
2.54.0

