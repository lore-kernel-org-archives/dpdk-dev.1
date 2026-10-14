Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F04CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DDA640698;
	Wed, 14 Oct 2026 19:40:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA2F6406BB
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTOBC/VV1w4sV4vYXTaq0imCW1vV7Y18oTxYQ8w05e4=;
 b=CD+kzVD5JHB3SX1ZyqsODqYNLBk5+nR1A3LMw3053q2ZbO3PfbCm0Fmf9gBAQjcoJ3vCIx
 xfWabJPx5mHp3Dj2T9/EoIGMaPybR8zsLomedmWP0kAlCWXtFgX1y4WcNp0ByrUdGumuDh
 rTmrls5WpMGw0s0EuGLS6VlaQAJeCQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-W0KHnRsAOMCrkx1REXBkaw-1; Wed,
 14 Oct 2026 17:40:20 +0000
X-MC-Unique: W0KHnRsAOMCrkx1REXBkaw-1
X-Mimecast-MFC-AGG-ID: W0KHnRsAOMCrkx1REXBkaw_1791999620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D562C1955DC7; Wed, 14 Oct 2026 17:40:19 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2D8930000E3; Wed, 14 Oct 2026 17:40:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 04/16] bus/dpaa: support unplug and use generic cleanup
Date: Wed, 14 Oct 2026 19:39:47 +0200
Message-ID: <20261014174001.1830726-5-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hZrwI2iUCmDmsezOg7JXzTNNKQaa9tuyAh9VAlADrUI_1791999620
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
index 03b4feae0f..2b994b7a5f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -73,6 +73,10 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added unplug operation support to DPAA bus.**
+
+  Implemented device unplug operation to allow runtime removal of DPAA devices.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 928c8c1280..2a45876de4 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -799,38 +799,46 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
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
@@ -856,14 +864,16 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
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

