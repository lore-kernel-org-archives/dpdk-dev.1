Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206B2C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15637409FA;
	Mon,  6 Jul 2026 17:06:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 88E2E40A6E
 for <dev@dpdk.org>; Mon,  6 Jul 2026 17:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783350403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XvXYXuvlZbdxwLfXNlKiZNFQJfxBZXcvKTMhfhVhNBw=;
 b=eJX6Rnh6ZS7Krv6LxmyOqdyXZabtyECDmSj90CRDtdOEHMMyFzALmZQvTbdG/EjBf1gnqy
 i1F4P3eUh744JOk98nflIr6C4d4eqdDvpCkUSbAWsA9joVDNuZIldAkzu2Yco3D0B8EDsR
 fif6Qlumh4CPu7uhx//UjPxFrlUMQpw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-MZRxNFxlP9KX1bWC9wVlew-1; Mon,
 06 Jul 2026 11:06:41 -0400
X-MC-Unique: MZRxNFxlP9KX1bWC9wVlew-1
X-Mimecast-MFC-AGG-ID: MZRxNFxlP9KX1bWC9wVlew_1783350401
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA51E1955D9F
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:06:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2556D18005B8
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:06:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH] dev: hide internal type for device comparison
Date: Mon,  6 Jul 2026 17:06:36 +0200
Message-ID: <20260706150636.839560-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i2fWWLaKBSY5a8MFzwdf2TP7VyoKe2xNDiQ8_ZzmKos_1783350401
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

rte_dev_cmp_t is a type used only in bus operations.
Since no public API references it, remove it from exported types.
Thanks to this, we can remove the dependency of bus_driver.h to
rte_dev.h.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_vdev.c         |  1 +
 lib/eal/include/bus_driver.h | 24 +++++++++++++++++++++++-
 lib/eal/include/rte_dev.h    | 21 ---------------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index c82d996404..c300976ace 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -7,6 +7,7 @@
 #include <string.h>
 
 #include <rte_common.h>
+#include <rte_dev.h>
 #include <rte_kvargs.h>
 #include <bus_driver.h>
 #include <rte_bus_vdev.h>
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 4f6521c87f..fa4d711a90 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -7,7 +7,6 @@
 
 #include <rte_bus.h>
 #include <rte_compat.h>
-#include <rte_dev.h>
 #include <rte_eal.h>
 #include <rte_tailq.h>
 
@@ -15,8 +14,10 @@
 extern "C" {
 #endif
 
+struct rte_dev_iterator;
 struct rte_devargs;
 struct rte_device;
+struct rte_driver;
 
 /** Double linked list of buses */
 RTE_TAILQ_HEAD(rte_bus_list, rte_bus);
@@ -49,6 +50,27 @@ typedef int (*rte_bus_scan_t)(void);
  */
 typedef int (*rte_bus_probe_t)(struct rte_bus *bus);
 
+/**
+ * Device comparison function.
+ *
+ * This type of function is used to compare an rte_device with arbitrary
+ * data.
+ *
+ * @param dev
+ *   Device handle.
+ *
+ * @param data
+ *   Data to compare against. The type of this parameter is determined by
+ *   the kind of comparison performed by the function.
+ *
+ * @return
+ *   0 if the device matches the data.
+ *   !0 if the device does not match.
+ *   <0 if ordering is possible and the device is lower than the data.
+ *   >0 if ordering is possible and the device is greater than the data.
+ */
+typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
+
 /**
  * Device iterator to find a device on a bus.
  *
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 7eca5e8cf2..12e205efa7 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -211,27 +211,6 @@ int rte_eal_hotplug_remove(const char *busname, const char *devname);
  */
 int rte_dev_remove(struct rte_device *dev);
 
-/**
- * Device comparison function.
- *
- * This type of function is used to compare an rte_device with arbitrary
- * data.
- *
- * @param dev
- *   Device handle.
- *
- * @param data
- *   Data to compare against. The type of this parameter is determined by
- *   the kind of comparison performed by the function.
- *
- * @return
- *   0 if the device matches the data.
- *   !0 if the device does not match.
- *   <0 if ordering is possible and the device is lower than the data.
- *   >0 if ordering is possible and the device is greater than the data.
- */
-typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
-
 /**
  * Iteration context.
  *
-- 
2.54.0

