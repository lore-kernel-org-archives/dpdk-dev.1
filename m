Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFC606A334
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gY4t74/q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC534067B;
	Mon, 26 Oct 2026 19:10:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C5A24067B
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/fF4Qb8ePRVaLTeuqUQEBG/QQZYK3gKHJaeMc1NOA4=;
 b=gY4t74/q3mEK4iVE3gt8zD00lwOaWE1Ai4X0tkGyIkMNRSG+ZK1GG+kc+aGrxTKSKXvpnJ
 4DMe1u2ywFcUnbGEOtB9jlt3/OusO1QS5/eZlqyx6E2daMfIeitxuixVFaj+mIOiH7PMqQ
 K8SU0GC+LkMIAKfPQZFsOp0Cbj/m8Ro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-HNZ5tSayOdCBvl2WmyWt3Q-1; Mon,
 26 Oct 2026 14:10:49 -0400
X-MC-Unique: HNZ5tSayOdCBvl2WmyWt3Q-1
X-Mimecast-MFC-AGG-ID: HNZ5tSayOdCBvl2WmyWt3Q_1793038248
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3868A1800D8C; Mon, 26 Oct 2026 18:10:48 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53E561956087; Mon, 26 Oct 2026 18:10:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 04/16] bus/dpaa: support unplug and use generic cleanup
Date: Mon, 26 Oct 2026 19:10:18 +0100
Message-ID: <20261026181031.304100-5-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ODbKbVvStgl912nmQzZ53wuXsNN5BJhvkNIQXOjAhcw_1793038248
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
index be758a0c02..96dc64816d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -82,6 +82,10 @@ New Features
   but objects within each bulk are not ordered as expected by a stack.
   Furthermore, it is not strictly bounded by its size, but might hold more objects.
 
+* **Added unplug operation support to DPAA bus.**
+
+  Implemented device unplug operation to allow runtime removal of DPAA devices.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index f6f24a4def..1ce68bf494 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -788,38 +788,46 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
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
-		rte_intr_fd_close(dev->intr_handle);
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
+		if (ret < 0)
+			return ret;
 	}
+
+	rte_intr_fd_close(dev->intr_handle);
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
@@ -845,14 +853,16 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
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

