Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9B606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/mKVBiw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C91E8402E8;
	Mon, 26 Oct 2026 19:10:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id EB6DC402B0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b0v29M6ddV+x0UNt1zfQe4juhmnVrxWMUHBcTaAAcQ=;
 b=F/mKVBiwMyDyANg/wSG0g4foQMci0T0pyxn6jE95WZ3E9IaFgzZXBFrPcwMEog/KekAH0C
 T84pLftCwMIng72BK8sXgN3q3e2GO9BvXCGh5LqM+majnHFgYlm/rh2LxnNZ76zFQuYEtT
 1QRujBtRI/KtC3xKas4Z+coUXDM42qc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-6Op0Nuv-PH-DbFLt8EM8Cg-1; Mon,
 26 Oct 2026 14:10:39 -0400
X-MC-Unique: 6Op0Nuv-PH-DbFLt8EM8Cg-1
X-Mimecast-MFC-AGG-ID: 6Op0Nuv-PH-DbFLt8EM8Cg_1793038238
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B8211800DB5; Mon, 26 Oct 2026 18:10:38 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73A891800257; Mon, 26 Oct 2026 18:10:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 01/16] drivers/bus: cleanup device freeing in NXP bus scan
Date: Mon, 26 Oct 2026 19:10:15 +0100
Message-ID: <20261026181031.304100-2-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uHlgGXPjD02SpqSkhJ_nAz6Ai2KPkSQ3vpNmNh-tJPA_1793038238
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

Following the scan/probe refactoring, in the DPAA bus driver scan method,
the device list is empty at the time the pthread key object is allocated.
This leaves only one location that wants to release the whole device
list, so remove the dpaa_clean_device_list() helper.

Remove the same helper in FSLMC bus for consistency.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 15 ++-------------
 drivers/bus/fslmc/fslmc_bus.c | 22 ++++++----------------
 2 files changed, 8 insertions(+), 29 deletions(-)

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
index 032069ebf3..98bd898acb 100644
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
@@ -314,8 +302,6 @@ rte_fslmc_scan(void)
 	char *group_name;
 
 	if (process_once) {
-		struct rte_dpaa2_device *dev;
-
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
 		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 			dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus,
@@ -383,7 +369,11 @@ rte_fslmc_scan(void)
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

