Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FCCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCACE4065D;
	Tue, 23 Jun 2026 12:55:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 76A6E40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF6g+ayAZDaO9lf2ExgnEM0tiLED59LPNXLvWv0u0xI=;
 b=dhOF1y0sNF0PRfGgIW7jyPW6aJkSxhhrcp05NsOOIbV3LAhdoBXVA0vGrAejMhoPRuFoJi
 VhFirZuqMMlAe3VuNZ0ToCnFY9iYnEDyszqey2cNj4C/EOhMTGvVkVk+wn/y4zTutDlC2K
 yLJfB9tsuYHomEo+AAlvKB2MKI44OcM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-nmD4ZndyNtCfmFdBHzDiBw-1; Tue,
 23 Jun 2026 06:55:51 -0400
X-MC-Unique: nmD4ZndyNtCfmFdBHzDiBw-1
X-Mimecast-MFC-AGG-ID: nmD4ZndyNtCfmFdBHzDiBw_1782212150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8661C1956044; Tue, 23 Jun 2026 10:55:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1840B1800348; Tue, 23 Jun 2026 10:55:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 11/11] bus/vmbus: support unplug
Date: Tue, 23 Jun 2026 12:54:38 +0200
Message-ID: <20260623105439.2144694-12-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tcf-naSTJV_cBsTBbLJ2nSDLg0ThkVHjMPb3DYaxfsk_1782212150
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

Add .unplug callback to handle driver removal, device unmapping, and
interrupt cleanup. This enables use of the generic bus cleanup helper.

The cleanup function was already performing these operations, so it
seems safe to expose them through the unplug operation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_07.rst |  4 +++
 drivers/bus/vmbus/vmbus_common.c       | 41 ++++++++++++--------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..55d3b44527 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -114,6 +114,10 @@ New Features
 
   Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
 
+* **Added unplug operation support to VMBUS bus.**
+
+  Implemented device unplug operation to allow runtime removal of VMBUS devices.
+
 * **Added selective Rx in ethdev API.**
 
   Some parts of packets may be discarded in Rx
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a6e3a24a7c..cd6e851e4c 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -144,34 +144,29 @@ rte_vmbus_probe(void)
 }
 
 static int
-rte_vmbus_cleanup(struct rte_bus *bus)
+vmbus_unplug_device(struct rte_device *rte_dev)
 {
-	struct rte_vmbus_device *dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, bus) {
-		const struct rte_vmbus_driver *drv;
-		int ret;
-
-		if (!rte_dev_is_probed(&dev->device))
-			continue;
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			continue;
+	const struct rte_vmbus_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
+	struct rte_vmbus_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
+	int ret = 0;
 
+	if (drv->remove != NULL) {
 		ret = drv->remove(dev);
 		if (ret < 0)
-			error = -1;
+			return ret;
+	}
 
-		rte_vmbus_unmap_device(dev);
-		rte_intr_instance_free(dev->intr_handle);
+	rte_vmbus_unmap_device(dev);
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
 
-		dev->device.driver = NULL;
-		rte_bus_remove_device(bus, &dev->device);
-		free(dev);
-	}
+	return 0;
+}
 
-	return error;
+static void
+vmbus_free_device(struct rte_device *dev)
+{
+	free(RTE_BUS_DEVICE(dev, struct rte_vmbus_device));
 }
 
 static int
@@ -222,10 +217,12 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 struct rte_bus rte_vmbus_bus = {
 	.scan = rte_vmbus_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = rte_vmbus_cleanup,
+	.free_device = vmbus_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = vmbus_bus_match,
 	.probe_device = vmbus_probe_device,
+	.unplug_device = vmbus_unplug_device,
 	.parse = vmbus_parse,
 	.dev_compare = vmbus_dev_compare,
 };
-- 
2.54.0

