Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415FCC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D3442E12;
	Thu, 17 Sep 2026 09:50:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AFCC0427D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEH9LANGqpQr6O88Tbc4zod3FAHqkM4WNC6bQ22zZHA=;
 b=GC8butqiLmbSsE6aLWn3sxccrHlBPQU6JdsZwQCRDYMjLPwh+XCi3IwMu+B80gkDWyPJ78
 gb6a5IK5HsIXR17uCeKnN9exkh5E+ldu1khaol7tNm5MD2VJn3gCZi5orqcZIO2oI4/PLX
 QWy+DeJExVEq2zqiW0+P48GWJcRZLTs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-RJi2DIdePqKPMDLSzbBEUg-1; Thu,
 17 Sep 2026 03:50:05 -0400
X-MC-Unique: RJi2DIdePqKPMDLSzbBEUg-1
X-Mimecast-MFC-AGG-ID: RJi2DIdePqKPMDLSzbBEUg_1789631404
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE82E1802158; Thu, 17 Sep 2026 07:50:04 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D240B19373D8; Thu, 17 Sep 2026 07:50:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 11/16] bus/fslmc: release resources on scan failure
Date: Thu, 17 Sep 2026 09:49:11 +0200
Message-ID: <20260917074917.595603-12-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wCa93fO_XT0V9Ka6AtV6w31lpWnRQxy6j9h0qnQnN-E_1789631404
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

In case of a single failure, all mapped memory, VFIO resources and
device pointers were left untouched.
When reaching one init failure during scan, unwind what had been done so
far.

Note: the mapping helper was ignoring the memory callback registration
failure, so it is kept as is.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 38 +++++++++++------------
 drivers/bus/fslmc/fslmc_vfio.c | 56 +++++++++++++++++++++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.h |  1 +
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 2f66484ad2..802617c5fe 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -341,23 +341,20 @@ rte_fslmc_scan(void)
 
 	/* Scan the DPRC container object */
 	ret = scan_one_fslmc_device(group_name);
-	if (ret != 0) {
-		/* Error in parsing directory - exit gracefully */
-		goto scan_fail_cleanup;
-	}
-
-	while ((entry = readdir(dir)) != NULL) {
-		if (entry->d_name[0] == '.' || entry->d_type != DT_DIR)
-			continue;
+	if (ret == 0) {
+		while ((entry = readdir(dir)) != NULL) {
+			if (entry->d_name[0] == '.' || entry->d_type != DT_DIR)
+				continue;
 
-		ret = scan_one_fslmc_device(entry->d_name);
-		if (ret != 0) {
-			/* Error in parsing directory - exit gracefully */
-			goto scan_fail_cleanup;
+			ret = scan_one_fslmc_device(entry->d_name);
+			if (ret != 0)
+				break;
 		}
 	}
 
 	closedir(dir);
+	if (ret != 0)
+		goto scan_fail;
 
 	DPAA2_BUS_INFO("FSLMC Bus scan completed");
 	/* If debugging is enabled, device list is dumped to log output */
@@ -375,13 +372,13 @@ rte_fslmc_scan(void)
 			rte_mbuf_dynfield_register(&dpaa2_seqn_dynfield_desc);
 		if (dpaa2_seqn_dynfield_offset < 0) {
 			DPAA2_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
-			return 0;
+			goto scan_fail;
 		}
 
 		ret = fslmc_vfio_setup_group();
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to setup VFIO %d", ret);
-			return 0;
+			goto scan_fail;
 		}
 
 		/* Map existing segments as well as, in case of hotpluggable memory,
@@ -392,14 +389,14 @@ rte_fslmc_scan(void)
 			if (ret) {
 				DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)", ret);
 				DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
-				return 0;
+				goto vfio_close_group;
 			}
 		}
 
 		ret = fslmc_vfio_process_group();
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
-			return 0;
+			goto vfio_dma_unmap;
 		}
 	}
 
@@ -407,13 +404,16 @@ rte_fslmc_scan(void)
 
 	return 0;
 
-scan_fail_cleanup:
-	closedir(dir);
+vfio_dma_unmap:
+	fslmc_vfio_dmaunmap();
+vfio_close_group:
+	fslmc_vfio_close_group();
 
+scan_fail:
 	/* Remove all devices in the list */
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
 		fslmc_bus_remove_device(dev);
-scan_fail:
+
 	DPAA2_BUS_DEBUG("FSLMC Bus Not Available. Skipping (%d)", ret);
 	/* Irrespective of failure, scan only return success */
 	return 0;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 705f5aeffc..03cac79c50 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1157,6 +1157,27 @@ fslmc_dmamap_seg(const struct rte_memseg_list *msl __rte_unused,
 	return ret;
 }
 
+static int
+fslmc_dmaunmap_seg(const struct rte_memseg_list *msl __rte_unused,
+		const struct rte_memseg *ms, void *arg)
+{
+	int *n_segs = arg;
+	int ret;
+
+	/* if IOVA address is invalid, skip */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	ret = fslmc_unmap_dma(ms->addr_64, ms->iova, ms->len);
+	if (ret)
+		DPAA2_BUS_ERR("Unable to VFIO unmap (addr=%p, len=%zu)",
+				ms->addr, ms->len);
+	else
+		(*n_segs)++;
+
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_fslmc_vfio_mem_dmamap)
 int
 rte_fslmc_vfio_mem_dmamap(uint64_t vaddr, uint64_t iova, uint64_t size)
@@ -1180,10 +1201,8 @@ fslmc_vfio_dmamap(void)
 	rte_mcfg_mem_read_lock();
 
 	ret = rte_memseg_walk(fslmc_dmamap_seg, &i);
-	if (ret) {
-		rte_mcfg_mem_read_unlock();
-		return ret;
-	}
+	if (ret != 0)
+		goto unmap;
 
 	ret = rte_mem_event_callback_register("fslmc_memevent_clb",
 			fslmc_memevent_cb, NULL);
@@ -1196,12 +1215,33 @@ fslmc_vfio_dmamap(void)
 
 	DPAA2_BUS_DEBUG("Total %d segments found.", i);
 
-	/* Existing segments have been mapped and memory callback for hotplug
-	 * has been installed.
-	 */
+	/* Ignore callback handler registration failure */
+	ret = 0;
+
+unmap:
+	if (ret != 0) {
+		i = 0;
+		rte_memseg_walk(fslmc_dmaunmap_seg, &i);
+	}
+
 	rte_mcfg_mem_read_unlock();
 
-	return 0;
+	return ret;
+}
+
+int
+fslmc_vfio_dmaunmap(void)
+{
+	int i = 0, ret;
+
+	rte_mcfg_mem_read_lock();
+
+	rte_mem_event_callback_unregister("fslmc_memevent_clb", NULL);
+	ret = rte_memseg_walk(fslmc_dmaunmap_seg, &i);
+
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
 }
 
 static int
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index c995fd67b8..57fe7038de 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -60,4 +60,5 @@ int fslmc_vfio_close_group(void);
 char *fslmc_get_container(void);
 int fslmc_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
+int fslmc_vfio_dmaunmap(void);
 #endif /* _FSLMC_VFIO_H_ */
-- 
2.54.0

