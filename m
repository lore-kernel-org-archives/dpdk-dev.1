Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AB606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6PdBrvo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18BAB40656;
	Mon, 26 Oct 2026 19:10:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 006D540656
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2mjesgCBby6IdnIwtAv1u+bdvyLT+U97ftmC5m/Oto=;
 b=V6PdBrvoTern6wwACAbF2Y8S24OYyOYA+oMpEEc8KSbqkQx+x3M+kd4JM9B1GKKsemyY0Y
 Owhc/Yh5RgYcVHaljgtSy5n5bFHNl4FSxb5pyTcUsSmmzlylAhYKYKINqekDL5qOECpJnG
 MYen267SNppsjI3dDXs+l0oECxJ+4cU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-kykaR_xWNdiII9aidXPKPg-1; Mon,
 26 Oct 2026 14:10:45 -0400
X-MC-Unique: kykaR_xWNdiII9aidXPKPg-1
X-Mimecast-MFC-AGG-ID: kykaR_xWNdiII9aidXPKPg_1793038244
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5DC718011E4; Mon, 26 Oct 2026 18:10:44 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3BDF1956088; Mon, 26 Oct 2026 18:10:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 03/16] bus/dpaa: allocate interrupt during probing
Date: Mon, 26 Oct 2026 19:10:17 +0100
Message-ID: <20261026181031.304100-4-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lBZnBptjBuKIyMRT3_rPOrxIS49PFf7PuRFW81SwzGA_1793038244
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

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).

Instead, allocate this handle, set eventfds and vfio at the time
probe_device is called.

Adjust the unplug_device path accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- used rte_intr_fd_close,

Changes since RFC v2:
- changed sign of returned error,
- fixed invalid FD in interrupt handle,

Changes since RFC v1:
- restored return code on error in cleanup,

---
 drivers/bus/dpaa/dpaa_bus.c | 76 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5df2dff8f2..f6f24a4def 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -215,16 +215,6 @@ dpaa_create_device_list(void)
 
 		dev->device.numa_node = SOCKET_ID_ANY;
 
-		/* Allocate interrupt handle instance */
-		dev->intr_handle =
-			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-		if (dev->intr_handle == NULL) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
-			ret = -ENOMEM;
-			free(dev);
-			goto cleanup;
-		}
-
 		cfg = &dpaa_netcfg->port_cfg[i];
 		fman_intf = cfg->fman_if;
 
@@ -276,16 +266,6 @@ dpaa_create_device_list(void)
 			goto cleanup;
 		}
 
-		/* Allocate interrupt handle instance */
-		dev->intr_handle =
-			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-		if (dev->intr_handle == NULL) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
-			ret = -ENOMEM;
-			free(dev);
-			goto cleanup;
-		}
-
 		dev->device_type = FSL_DPAA_CRYPTO;
 		dev->id.dev_id = dpaa_bus.device_count + i;
 
@@ -336,7 +316,6 @@ dpaa_create_device_list(void)
 cleanup:
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
 		rte_bus_remove_device(&rte_dpaa_bus, &dev->device);
-		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 	}
 
@@ -637,7 +616,8 @@ rte_dpaa_bus_dev_build(void)
 	return 0;
 }
 
-static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
+static int
+dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 {
 	int fd;
 
@@ -645,12 +625,12 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	if (fd < 0) {
 		DPAA_BUS_ERR("Cannot set up eventfd, error %i (%s)",
 			     errno, strerror(errno));
-		return errno;
+		return -errno;
 	}
 
 	if (rte_intr_fd_set(intr_handle, fd) ||
 			rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_EXT)) {
-		int err = rte_errno;
+		int err = -rte_errno;
 
 		close(fd);
 		rte_intr_fd_set(intr_handle, -1);
@@ -666,7 +646,6 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 static int
 rte_dpaa_bus_scan(void)
 {
-	struct rte_dpaa_device *dev;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
 	static int process_once;
@@ -755,14 +734,6 @@ rte_dpaa_bus_scan(void)
 	 */
 	rte_mbuf_set_platform_mempool_ops(DPAA_MEMPOOL_OPS_NAME);
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
-		if (dev->device_type == FSL_DPAA_ETH) {
-			ret = rte_dpaa_setup_intr(dev->intr_handle);
-			if (ret)
-				DPAA_BUS_ERR("Error setting up interrupt.");
-		}
-	}
-
 	/* And initialize the PA->VA translation table */
 	dpaax_iova_table_populate();
 
@@ -790,10 +761,29 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
 	int ret;
 
+	/* Allocate interrupt handle instance */
+	dpaa_dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (dpaa_dev->intr_handle == NULL) {
+		DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
+	if (dpaa_dev->device_type == FSL_DPAA_ETH) {
+		ret = dpaa_setup_intr(dpaa_dev->intr_handle);
+		if (ret != 0) {
+			DPAA_BUS_ERR("error setting up interrupt: %s", dpaa_dev->name);
+			goto release_intr;
+		}
+	}
+
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
-	if (ret != 0)
+	if (ret != 0) {
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
-
+		rte_intr_fd_close(dpaa_dev->intr_handle);
+release_intr:
+		rte_intr_instance_free(dpaa_dev->intr_handle);
+		dpaa_dev->intr_handle = NULL;
+	}
 	return ret;
 }
 
@@ -801,29 +791,35 @@ static int
 dpaa_bus_cleanup(struct rte_bus *bus)
 {
 	struct rte_dpaa_device *dev;
+	int error = 0;
 
 	BUS_INIT_FUNC_TRACE();
 	RTE_BUS_FOREACH_DEV(dev, bus) {
 		const struct rte_dpaa_driver *drv;
-		int ret = 0;
+		int ret;
 
 		if (!rte_dev_is_probed(&dev->device))
-			continue;
+			goto next;
 		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 		if (drv->remove == NULL)
-			continue;
+			goto next;
 		ret = drv->remove(dev);
 		if (ret < 0) {
 			rte_errno = errno;
-			return -1;
+			error = -1;
+			goto next;
 		}
 		dev->device.driver = NULL;
+next:
+		rte_intr_fd_close(dev->intr_handle);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 	}
 	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
 	dpaa_bus_global_init = 0;
 	DPAA_BUS_DEBUG("Bus cleanup done");
 
-	return 0;
+	return error;
 }
 
 /* Adding destructor for double check in case non-gracefully
-- 
2.54.0

