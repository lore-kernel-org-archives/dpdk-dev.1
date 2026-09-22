Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B8C982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB12C427B3;
	Tue, 22 Sep 2026 11:40:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 020F5427B6
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FdCWMSU2jT5IzKE2ng5yCvKUS/PQ8B73mvZA5c4ZXg=;
 b=VfHxFuJXb1ZRHOObbeMxziWRbOM0DlMhxyvEGI431AfoekG5pI1Kbi5Unk9uEARazFdUnM
 6mFD9ipI1LyOionh6Hjk8Ns4g4ABltEAF05h+jE+9MOU4iuFI7uI50jn7FsI3pBNirkM4C
 O4OVnZgCT4ayBUHswXA6AFdocGvv5wg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-gg-2C_loN2ushml5dJwazA-1; Tue,
 22 Sep 2026 05:40:53 -0400
X-MC-Unique: gg-2C_loN2ushml5dJwazA-1
X-Mimecast-MFC-AGG-ID: gg-2C_loN2ushml5dJwazA_1790070052
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A5B81805A02; Tue, 22 Sep 2026 09:40:52 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 479F51800473; Tue, 22 Sep 2026 09:40:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 6/9] test/vdev: find device with public API
Date: Tue, 22 Sep 2026 11:40:22 +0200
Message-ID: <20260922094026.2636265-7-david.marchand@redhat.com>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QNndlo_crLE5jTfXimnE8EHs4PMoAMYOXl04uIyOpz4_1790070052
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

Checking internal API has little sense as users are not supposed to call
those.
Use public API to achieve similar coverage.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_vdev.c | 85 ++++++++------------------------------------
 1 file changed, 15 insertions(+), 70 deletions(-)

diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index c300976ace..6951ef7cc3 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -2,69 +2,26 @@
  * Copyright 2021 6WIND S.A.
  */
 
-#include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 
-#include <rte_common.h>
 #include <rte_dev.h>
-#include <rte_kvargs.h>
-#include <bus_driver.h>
+#include <rte_bus.h>
 #include <rte_bus_vdev.h>
 
 #include "test.h"
 
-#define TEST_VDEV_KEY_NAME "name"
-
-static const char * const valid_keys[] = {
-	TEST_VDEV_KEY_NAME,
-	NULL,
-};
-
-static int
-cmp_dev_name(const struct rte_device *dev, const void *name)
-{
-	return strcmp(rte_dev_name(dev), name);
-}
-
-static int
-cmp_dev_match(const struct rte_device *dev, const void *_kvlist)
-{
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *key = TEST_VDEV_KEY_NAME;
-	const char *name;
-
-	/* no kvlist arg, all devices match */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, rte_dev_name(dev)) != 0)
-		return -1;
-
-	return 0;
-}
-
 static struct rte_device *
-get_matching_vdev(const char *match_str)
+find_vdev_by_name(const char *name)
 {
-	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
-	struct rte_kvargs *kvargs = NULL;
+	struct rte_dev_iterator it = { 0 };
 	struct rte_device *dev;
 
-	if (match_str != NULL) {
-		kvargs = rte_kvargs_parse(match_str, valid_keys);
-		if (kvargs == NULL) {
-			printf("Failed to parse match string\n");
-			return NULL;
-		}
+	RTE_DEV_FOREACH(dev, "bus=vdev", &it) {
+		if (strcmp(rte_dev_name(dev), name) == 0)
+			return dev;
 	}
-
-	dev = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-
-	return dev;
+	return NULL;
 }
 
 static int
@@ -83,7 +40,7 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test0\n");
 		goto fail;
 	}
-	dev0 = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_name, "net_null_test0");
+	dev0 = find_vdev_by_name("net_null_test0");
 	if (dev0 == NULL) {
 		printf("Cannot find net_null_test0 vdev\n");
 		goto fail;
@@ -94,44 +51,32 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test1\n");
 		goto fail;
 	}
-	dev1 = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_name, "net_null_test1");
+	dev1 = find_vdev_by_name("net_null_test1");
 	if (dev1 == NULL) {
 		printf("Cannot find net_null_test1 vdev\n");
 		goto fail;
 	}
 
-	/* try to match vdevs */
-	dev = get_matching_vdev("name=net_null_test0");
+	/* try to find vdevs */
+	dev = find_vdev_by_name("net_null_test0");
 	if (dev != dev0) {
 		printf("Cannot match net_null_test0 vdev\n");
 		goto fail;
 	}
 
-	dev = get_matching_vdev("name=net_null_test1");
+	dev = find_vdev_by_name("net_null_test1");
 	if (dev != dev1) {
 		printf("Cannot match net_null_test1 vdev\n");
 		goto fail;
 	}
 
-	dev = get_matching_vdev("name=unexistant");
+	dev = find_vdev_by_name("nonexistent");
 	if (dev != NULL) {
-		printf("Unexistant vdev should not match\n");
-		goto fail;
-	}
-
-	dev = get_matching_vdev("");
-	if (dev == NULL || dev == dev1) {
-		printf("Cannot match any vdev with empty match string\n");
-		goto fail;
-	}
-
-	dev = get_matching_vdev(NULL);
-	if (dev == NULL || dev == dev1) {
-		printf("Cannot match any vdev with NULL match string\n");
+		printf("Nonexistent vdev should not match\n");
 		goto fail;
 	}
 
-	/* iterate all vdevs, and ensure we find vdev0 and vdev1 */
+	/* iterate all vdevs, and ensure we find dev0 and dev1 */
 	RTE_DEV_FOREACH(dev, "bus=vdev", &dev_iter) {
 		if (dev == dev0)
 			dev0 = NULL;
-- 
2.54.0

