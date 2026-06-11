Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E397CD98D4
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76ACC42FB5;
	Thu, 11 Jun 2026 11:47:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D8AB142F97
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPqoxHDzK1jZVRnPvl5QwE/sJAvPXdrbnhBMnIvW6Zo=;
 b=hok6TcCYBZ70g3SGo+C6icY/D3nenvag105k2XJtONy5bLwhv88MuwWQVdY49qy77q0Kwd
 /ZzLqW/C1kdHYb8FUFWqbwGbyXsDdc1LC6ogpSbs0kZD3+y+smf5SCUIUmizaDGV9Nhl8O
 ZyMgZzWGrmTMOPCQsLeHfbDzIVC1Ado=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-DL7z3NOmNjGKBxj9jCm_Aw-1; Thu,
 11 Jun 2026 05:47:16 -0400
X-MC-Unique: DL7z3NOmNjGKBxj9jCm_Aw-1
X-Mimecast-MFC-AGG-ID: DL7z3NOmNjGKBxj9jCm_Aw_1781171235
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72B421801323; Thu, 11 Jun 2026 09:47:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DEB81774; Thu, 11 Jun 2026 09:47:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 13/13] bus/vmbus: support unplug
Date: Thu, 11 Jun 2026 11:45:50 +0200
Message-ID: <20260611094551.1514962-14-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s9n0fMkgyhdWwxjSLfp2-9MkB3tHGKVJlhQ_uOaDrB8_1781171235
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
 drivers/bus/vmbus/vmbus_common.c       | 37 ++++++++++----------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 966f6501b4..38e4dd87b3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -118,6 +118,10 @@ New Features
 
   Implemented device unplug operation to allow runtime removal of DPAA devices.
 
+* **bus/vmbus: Added unplug operation support.**
+
+  Implemented device unplug operation to allow runtime removal of VMBUS devices.
+
 * **Added selective Rx in ethdev API.**
 
   Some parts of packets may be discarded in Rx
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 4c4170a4b5..419eb9b895 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -146,34 +146,23 @@ rte_vmbus_probe(void)
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
-
-		rte_vmbus_unmap_device(dev);
-		rte_intr_instance_free(dev->intr_handle);
-
-		dev->device.driver = NULL;
-		rte_bus_remove_device(bus, &dev->device);
-		free(dev);
+			return ret;
 	}
 
-	return error;
+	rte_vmbus_unmap_device(dev);
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
+
+	return 0;
 }
 
 static int
@@ -224,10 +213,12 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 struct rte_bus rte_vmbus_bus = {
 	.scan = rte_vmbus_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = rte_vmbus_cleanup,
+	.free_device = free,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = vmbus_bus_match,
 	.probe_device = vmbus_probe_device,
+	.unplug_device = vmbus_unplug_device,
 	.parse = vmbus_parse,
 	.dev_compare = vmbus_dev_compare,
 };
-- 
2.53.0

