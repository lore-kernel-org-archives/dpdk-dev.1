Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF84CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7629A42FBF;
	Thu, 11 Jun 2026 11:47:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50A2E42FBD
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udNpJcs7gR40Z5Jr9vL2nhuxMe/mW2aJ+XOqthKt9Zg=;
 b=VyqIMs5LpkyrBwvr7a+qbxw0mZYe6Gow//nYnj+NXd6uJ65khCwZrzmZOnNUgFrL4FZK6W
 Irv/99n4DDG/iTomBo8/Bp2/sedI5ljhfKEOxPlE8F3fiTiKKLa1SgI+UEchh6bhwThGyP
 wipPygh8ZSMk1GeFvN1AqMo5uKYWZBo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-YIKzMHTuNqWrfHBDaJliuQ-1; Thu,
 11 Jun 2026 05:47:06 -0400
X-MC-Unique: YIKzMHTuNqWrfHBDaJliuQ-1
X-Mimecast-MFC-AGG-ID: YIKzMHTuNqWrfHBDaJliuQ_1781171225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6EE18009DC; Thu, 11 Jun 2026 09:47:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12E3C1954105; Thu, 11 Jun 2026 09:47:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 11/13] bus/dpaa: support unplug
Date: Thu, 11 Jun 2026 11:45:48 +0200
Message-ID: <20260611094551.1514962-12-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2qhP33Z9xBBEusWDlHmL79BxHWP5YQ77y6yZT-tlBI_1781171225
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
 doc/guides/rel_notes/release_26_07.rst |  4 +++
 drivers/bus/dpaa/dpaa_bus.c            | 48 +++++++++++++++-----------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..966f6501b4 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -114,6 +114,10 @@ New Features
 
   Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
 
+* **bus/dpaa: Added unplug operation support.**
+
+  Implemented device unplug operation to allow runtime removal of DPAA devices.
+
 * **Added selective Rx in ethdev API.**
 
   Some parts of packets may be discarded in Rx
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 69f071d007..6d4bec3751 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -785,34 +785,38 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
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
-			continue;
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			continue;
+	if (drv->remove != NULL) {
 		ret = drv->remove(dev);
-		if (ret < 0) {
-			rte_errno = errno;
-			return -1;
-		}
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
-		dev->device.driver = NULL;
+		if (ret < 0)
+			return ret;
 	}
+
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
+
+	return 0;
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
@@ -838,14 +842,16 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 static struct rte_bus rte_dpaa_bus = {
 	.scan = rte_dpaa_bus_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = free,
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
2.53.0

