Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEEDC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECC3427D0;
	Thu, 17 Sep 2026 09:49:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8C8427E1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJI4PiaCXciu0OjdQYIGnGgxntn3yDSjSLy1bcF0CaM=;
 b=TeSgpL5OTvGU505ePNlOyX5GXFFTC7SaUT+xNS4do57l+9XpgJkVQVkN/rrSZ2M9sLcmeO
 CfVY09REfg7mIFqhJrmDcjPxCeoKmF9vxnHw+CGs0KyE8wM5GZk/iHyNiDsApjZ8UDq7Dt
 3Iy1B/wS1+ltjwAA9ZjWSlsRcFDvdl4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-v3Wypxe0PrS-tRKjYUrWrQ-1; Thu,
 17 Sep 2026 03:49:40 -0400
X-MC-Unique: v3Wypxe0PrS-tRKjYUrWrQ-1
X-Mimecast-MFC-AGG-ID: v3Wypxe0PrS-tRKjYUrWrQ_1789631379
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BF0F195FCDB; Thu, 17 Sep 2026 07:49:39 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39EB61977588; Thu, 17 Sep 2026 07:49:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 04/16] bus/dpaa: support unplug and use generic cleanup
Date: Thu, 17 Sep 2026 09:49:04 +0200
Message-ID: <20260917074917.595603-5-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bAwToaEkhQ90uVplkjzL8ar0xr0FV8Mi5xOLG6Gb3EY_1789631379
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

Add .unplug callback to handle driver removal and interrupt cleanup.
This enables use of the generic bus cleanup helper while preserving
bus-specific cleanup (portal finish, global init reset).

The cleanup function was already performing these operations, so it
seems safe to expose them through the unplug operation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++
 drivers/bus/dpaa/dpaa_bus.c            | 56 +++++++++++++++-----------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..7a5a0c55cb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added unplug operation support to DPAA bus.**
+
+  Implemented device unplug operation to allow runtime removal of DPAA devices.
+
 
 Removed Items
 -------------
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ef904a7192..bb1c379dfd 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -798,38 +798,46 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 }
 
 static int
-dpaa_bus_cleanup(struct rte_bus *bus)
+dpaa_bus_unplug_device(struct rte_device *rte_dev)
 {
-	struct rte_dpaa_device *dev;
-	int error = 0;
+	const struct rte_dpaa_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
+	struct rte_dpaa_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 
-	BUS_INIT_FUNC_TRACE();
-	RTE_BUS_FOREACH_DEV(dev, bus) {
-		const struct rte_dpaa_driver *drv;
+	if (drv->remove != NULL) {
 		int ret;
 
-		if (!rte_dev_is_probed(&dev->device))
-			goto next;
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			goto next;
 		ret = drv->remove(dev);
-		if (ret < 0) {
-			rte_errno = errno;
-			error = -1;
-			goto next;
-		}
-		dev->device.driver = NULL;
-next:
-		dpaa_close_intr(dev->intr_handle);
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
+		if (ret < 0)
+			return ret;
 	}
+
+	dpaa_close_intr(dev->intr_handle);
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
+
+	return 0;
+}
+
+static void
+dpaa_bus_free_device(struct rte_device *dev)
+{
+	free(RTE_BUS_DEVICE(dev, struct rte_dpaa_device));
+}
+
+static int
+dpaa_bus_cleanup(struct rte_bus *bus)
+{
+	int ret;
+
+	BUS_INIT_FUNC_TRACE();
+
+	ret = rte_bus_generic_cleanup(bus);
+
 	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
 	dpaa_bus_global_init = 0;
 	DPAA_BUS_DEBUG("Bus cleanup done");
 
-	return error;
+	return ret;
 }
 
 /* Adding destructor for double check in case non-gracefully
@@ -855,14 +863,16 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 static struct rte_bus rte_dpaa_bus = {
 	.scan = rte_dpaa_bus_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = dpaa_bus_free_device,
+	.cleanup = dpaa_bus_cleanup,
 	.parse = rte_dpaa_bus_parse,
 	.dev_compare = dpaa_bus_dev_compare,
 	.find_device = rte_bus_generic_find_device,
 	.get_iommu_class = rte_dpaa_get_iommu_class,
 	.match = dpaa_bus_match,
 	.probe_device = dpaa_bus_probe_device,
+	.unplug_device = dpaa_bus_unplug_device,
 	.dev_iterate = rte_bus_generic_dev_iterate,
-	.cleanup = dpaa_bus_cleanup,
 };
 
 static struct rte_dpaa_bus_private dpaa_bus = {
-- 
2.54.0

