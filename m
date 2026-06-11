Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A11CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A65A142F87;
	Thu, 11 Jun 2026 11:46:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B19D42F87
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG/36gOokS9myj61IreFx/E7Y0Ihrb0WGra0KXLZqL4=;
 b=SHD44xh7JqscpI/wW+4RdMVEVhYg7OLxvHEE4/C82Gy8NndEoKJ7dAodAQjb39ajGfcP3c
 kyx962SBJNhnoB9lmqmrec6QdQR4UBg8uWOHr0sL6kp56OyffIRUkCYWlHGfUzfRo0CMG1
 Z5/5Ahnr5R/sIciw5cMeyARTzAAH5OI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-3DqIoWBoO4-5MqrICoS0Yw-1; Thu,
 11 Jun 2026 05:46:25 -0400
X-MC-Unique: 3DqIoWBoO4-5MqrICoS0Yw-1
X-Mimecast-MFC-AGG-ID: 3DqIoWBoO4-5MqrICoS0Yw_1781171184
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5F3918DA5F5; Thu, 11 Jun 2026 09:46:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 938CE30A8; Thu, 11 Jun 2026 09:46:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 04/13] drivers/bus: cleanup device freeing in NXP bus
Date: Thu, 11 Jun 2026 11:45:41 +0200
Message-ID: <20260611094551.1514962-5-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RyzB3aiUL89bNDn-rjjEBMVKFvf6qlFXSzMfi19PHfc_1781171184
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

Following the scan/probe refactoring, in the DPAA bus driver scan method,
the device list is empty at the time the pthread key object is allocated.
This leaves only one location that wants to release the whole device
list, so remove the dpaa_clean_device_list() helper.

Remove the same helper in FSLMC bus for consistency.

Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 15 ++-------------
 drivers/bus/fslmc/fslmc_bus.c | 21 ++++++---------------
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ee467b94d5..a439c22071 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -193,8 +193,6 @@ dpaa_sec_available(void)
 	return -1;
 }
 
-static void dpaa_clean_device_list(void);
-
 static int
 dpaa_create_device_list(void)
 {
@@ -336,21 +334,13 @@ dpaa_create_device_list(void)
 	return 0;
 
 cleanup:
-	dpaa_clean_device_list();
-	return ret;
-}
-
-static void
-dpaa_clean_device_list(void)
-{
-	struct rte_dpaa_device *dev = NULL;
-
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
 		rte_bus_remove_device(&rte_dpaa_bus, &dev->device);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
-		dev = NULL;
 	}
+
+	return ret;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_init)
@@ -699,7 +689,6 @@ rte_dpaa_bus_scan(void)
 	ret = pthread_key_create(&dpaa_portal_key, dpaa_portal_finish);
 	if (ret) {
 		DPAA_BUS_LOG(DEBUG, "Unable to create pthread key. (%d)", ret);
-		dpaa_clean_device_list();
 		return ret;
 	}
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 88511d4dc7..5870863189 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -43,19 +43,6 @@ rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type)
 	return fslmc_bus_device_count[device_type];
 }
 
-static void
-cleanup_fslmc_device_list(void)
-{
-	struct rte_dpaa2_device *dev;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-		rte_intr_instance_free(dev->intr_handle);
-		free(dev);
-		dev = NULL;
-	}
-}
-
 static int
 compare_dpaa2_devname(struct rte_dpaa2_device *dev1,
 		      struct rte_dpaa2_device *dev2)
@@ -305,6 +292,7 @@ fslmc_dev_compare(const char *name1, const char *name2)
 static int
 rte_fslmc_scan(void)
 {
+	struct rte_dpaa2_device *dev;
 	int ret;
 	char fslmc_dirpath[PATH_MAX];
 	DIR *dir;
@@ -314,7 +302,6 @@ rte_fslmc_scan(void)
 	char *group_name;
 
 	if (process_once) {
-		struct rte_dpaa2_device *dev;
 
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
 		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
@@ -416,7 +403,11 @@ rte_fslmc_scan(void)
 	closedir(dir);
 
 	/* Remove all devices in the list */
-	cleanup_fslmc_device_list();
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+		rte_intr_instance_free(dev->intr_handle);
+		free(dev);
+	}
 scan_fail:
 	DPAA2_BUS_DEBUG("FSLMC Bus Not Available. Skipping (%d)", ret);
 	/* Irrespective of failure, scan only return success */
-- 
2.53.0

