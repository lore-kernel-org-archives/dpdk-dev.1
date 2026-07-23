Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A6CC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A76F140689;
	Thu, 23 Jul 2026 15:54:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B2833406B7
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbNUbzpq6i9XQZR+X/PF0M0UAWZO4Ocv1YfWPs0MCvQ=;
 b=M7brzTx2DHqq0+yWGT0aEsgrXZZBBzCaBWqxePsapaMuywKPazx3u8VroMv3Js7G9kELkz
 7wcb4BhdfgL15xmUL2Y/KUXkf7CjHnTxDDiemiszNNpUuw0jTBvXt5Tvge8h3flco32J+9
 IrESTxTGmb4JWhS+VuJGOoqs2cYs3SM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-WHC3Ty46O42u3SXza37qZA-1; Thu,
 23 Jul 2026 09:54:19 -0400
X-MC-Unique: WHC3Ty46O42u3SXza37qZA-1
X-Mimecast-MFC-AGG-ID: WHC3Ty46O42u3SXza37qZA_1784814858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36DF419776B4; Thu, 23 Jul 2026 13:54:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5718196B0A6; Thu, 23 Jul 2026 13:54:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 02/11] bus/dpaa: allocate interrupt during probing
Date: Thu, 23 Jul 2026 15:53:50 +0200
Message-ID: <20260723135400.3621271-3-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZ9f6Nn2rWoXKc9XloY0xptkLhkckrSAKxjYD22M0x4_1784814858
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

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).

Instead, allocate this handle, set eventfds and vfio at the time
probe_device is called.

Adjust the unplug_device path accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 76 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 06962a5b29..b9d7256c29 100644
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
 
@@ -657,13 +637,21 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+static void
+dpaa_close_intr(struct rte_intr_handle *intr_handle)
+{
+	if (rte_intr_fd_get(intr_handle) >= 0) {
+		close(rte_intr_fd_get(intr_handle));
+		rte_intr_fd_set(intr_handle, -1);
+	}
+}
+
 #define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
 #define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
 
 static int
 rte_dpaa_bus_scan(void)
 {
-	struct rte_dpaa_device *dev;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
 	static int process_once;
@@ -752,14 +740,6 @@ rte_dpaa_bus_scan(void)
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
 
@@ -787,10 +767,30 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
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
+			ret = -ret;
+			goto release_intr;
+		}
+	}
+
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
-	if (ret != 0)
+	if (ret != 0) {
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
-
+		dpaa_close_intr(dpaa_dev->intr_handle);
+release_intr:
+		rte_intr_instance_free(dpaa_dev->intr_handle);
+		dpaa_dev->intr_handle = NULL;
+	}
 	return ret;
 }
 
@@ -805,16 +805,20 @@ dpaa_bus_cleanup(struct rte_bus *bus)
 		int ret = 0;
 
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
+			goto next;
 		}
 		dev->device.driver = NULL;
+next:
+		dpaa_close_intr(dev->intr_handle);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 	}
 	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
 	dpaa_bus_global_init = 0;
-- 
2.54.0

