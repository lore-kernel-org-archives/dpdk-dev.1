Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02658CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF9C242FAD;
	Thu, 11 Jun 2026 11:46:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F29F242F7A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A20S55o/gCCg0gKIEDt3jZtGsFIL4Kc6nR8IFlJ8QIo=;
 b=IGUjXxqgvgkhylt9q+onPPIwO1vtUeY/3d/X8PPdBg4xt+AiMpp4uUjoxd1LyCDvKs3ybW
 Uaj/vWWPsPA7723JqDvW6tEqn1q01O4W+WNtKlLdNoqqECOvfXtPcEAY6QgP315LHWKZFq
 37nWXx8zW6ZjumuDuzO4y4127GQpJiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-MqcPe-iSPRaueXzBidQQPA-1; Thu,
 11 Jun 2026 05:46:30 -0400
X-MC-Unique: MqcPe-iSPRaueXzBidQQPA-1
X-Mimecast-MFC-AGG-ID: MqcPe-iSPRaueXzBidQQPA_1781171189
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12BAF195E92B; Thu, 11 Jun 2026 09:46:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADC7736917; Thu, 11 Jun 2026 09:46:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 05/13] drivers/bus: allocate interrupt during probing in NXP
 bus
Date: Thu, 11 Jun 2026 11:45:42 +0200
Message-ID: <20260611094551.1514962-6-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: obwDOTU0SSfzxo-sTzYoPfaqDtMvt-iH_CzSqU23H6c_1781171189
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
Instead, allocate this handle at the time probe_device is called.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 35 +++++++++++++----------------------
 drivers/bus/fslmc/fslmc_bus.c | 27 +++++++++++++--------------
 2 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index a439c22071..3915e0a8b7 100644
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
 
@@ -788,9 +767,19 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
 	int ret;
 
+	/* Allocate interrupt handle instance */
+	dpaa_dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (dpaa_dev->intr_handle == NULL) {
+		DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
-	if (ret != 0)
+	if (ret != 0) {
+		rte_intr_instance_free(dpaa_dev->intr_handle);
+		dpaa_dev->intr_handle = NULL;
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
+	}
 
 	return ret;
 }
@@ -815,6 +804,8 @@ dpaa_bus_cleanup(void)
 			rte_errno = errno;
 			return -1;
 		}
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 		dev->device.driver = NULL;
 	}
 	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 5870863189..fdc8bcb276 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -130,15 +130,6 @@ scan_one_fslmc_device(char *dev_name)
 
 	dev->device.numa_node = SOCKET_ID_ANY;
 
-	/* Allocate interrupt instance */
-	dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL) {
-		DPAA2_BUS_ERR("Failed to allocate intr handle");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
 	/* Parse the device name and ID */
 	t_ptr = strtok(dup_dev_name, ".");
 	if (!t_ptr) {
@@ -199,10 +190,7 @@ scan_one_fslmc_device(char *dev_name)
 	return 0;
 cleanup:
 	free(dup_dev_name);
-	if (dev) {
-		rte_intr_instance_free(dev->intr_handle);
-		free(dev);
-	}
+	free(dev);
 	return ret;
 }
 
@@ -405,7 +393,6 @@ rte_fslmc_scan(void)
 	/* Remove all devices in the list */
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 	}
 scan_fail:
@@ -511,9 +498,19 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 		return 0;
 	}
 
+	/* Allocate interrupt instance */
+	dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (dev->intr_handle == NULL) {
+		DPAA2_BUS_ERR("Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
 	ret = drv->probe(drv, dev);
 	if (ret != 0) {
 		DPAA2_BUS_ERR("Unable to probe");
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 	} else {
 		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
@@ -529,6 +526,8 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 
 	if (drv->remove != NULL) {
 		drv->remove(dev);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 		dev->device.driver = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
 		return 0;
-- 
2.53.0

