Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD7C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA06406BA;
	Thu, 23 Jul 2026 15:54:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3C9F040A4B
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJG5bdJu6teQevu4g4sROeiKozAzhQXXF4Nn1aFNKeg=;
 b=JgFv4+9WfSo3KKyQR5RYGH5RUqrCHGCA9644hrTI576W01RcOsE7S5l3IL1Ze6798nc4+s
 UDZyDvv6gQK+xcasR8DoLQTyLVAN6OE7Xmuwe/GKw9pLXQUFayq9dJJccKLU9XYblpV7a+
 6Qf+QQV2SbW9oyhfq+iOyojEAh04NKc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-v-_b4IrYOqaINAIT00tiYQ-1; Thu,
 23 Jul 2026 09:54:22 -0400
X-MC-Unique: v-_b4IrYOqaINAIT00tiYQ-1
X-Mimecast-MFC-AGG-ID: v-_b4IrYOqaINAIT00tiYQ_1784814861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AA20180A200; Thu, 23 Jul 2026 13:54:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E17B81956053; Thu, 23 Jul 2026 13:54:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 03/11] bus/dpaa: support unplug and use generic cleanup
Date: Thu, 23 Jul 2026 15:53:51 +0200
Message-ID: <20260723135400.3621271-4-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xcfQxYlNFC0Opi8QLGCfeG3B_W90-G_IY7L_0bygsec_1784814861
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
 drivers/bus/dpaa/dpaa_bus.c            | 57 +++++++++++++++-----------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..ceb3bf0616 100644
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
index b9d7256c29..3dd372e600 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -795,36 +795,45 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 }
 
 static int
-dpaa_bus_cleanup(struct rte_bus *bus)
+dpaa_bus_unplug_device(struct rte_device *rte_dev)
 {
-	struct rte_dpaa_device *dev;
+	const struct rte_dpaa_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
+	struct rte_dpaa_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
+	int ret = 0;
 
-	BUS_INIT_FUNC_TRACE();
-	RTE_BUS_FOREACH_DEV(dev, bus) {
-		const struct rte_dpaa_driver *drv;
-		int ret = 0;
-
-		if (!rte_dev_is_probed(&dev->device))
-			goto next;
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			goto next;
+	if (drv->remove != NULL) {
 		ret = drv->remove(dev);
-		if (ret < 0) {
-			rte_errno = errno;
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
 
-	return 0;
+	return ret;
 }
 
 /* Adding destructor for double check in case non-gracefully
@@ -850,14 +859,16 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
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

