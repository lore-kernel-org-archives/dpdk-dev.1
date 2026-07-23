Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BFC531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49DBF4068E;
	Thu, 23 Jul 2026 15:54:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4021C40663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsCBbhkzUoo3JYG0ado0vEwyLqw+RYVlwXgXyXRLO+o=;
 b=A04VGOPBGbruZxMtAMK1uaU1kFu+MViOLmVka//BxqXtB8ksRhsXZ9ZO7R2sQpq4IrcaNT
 MH0gEmTSW7jO+g5WOrYGnCXGy8XCM4ytzFZME9pZ/dAEZD29rwvcrywaF/lagUtKEzY1ye
 8EHtbaK42r9g60MS5Tkp2uz6WZfLTb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-wRMZs1xLNUObcYNrz751kQ-1; Thu,
 23 Jul 2026 09:54:14 -0400
X-MC-Unique: wRMZs1xLNUObcYNrz751kQ-1
X-Mimecast-MFC-AGG-ID: wRMZs1xLNUObcYNrz751kQ_1784814853
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5AA1845548; Thu, 23 Jul 2026 13:54:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6D0118005B8; Thu, 23 Jul 2026 13:54:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 01/11] drivers/bus: cleanup device freeing in NXP bus scan
Date: Thu, 23 Jul 2026 15:53:49 +0200
Message-ID: <20260723135400.3621271-2-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IelneyO-iCiNbK4YsKVUlfLwvmk5RqnCAGJD3S-6pJI_1784814853
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

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 15 ++-------------
 drivers/bus/fslmc/fslmc_bus.c | 21 ++++++---------------
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 368c8eeb98..06962a5b29 100644
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
index 3626b12316..4518f038c6 100644
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
2.54.0

