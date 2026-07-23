Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E83C531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC11B40A73;
	Thu, 23 Jul 2026 15:54:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1508B4067D
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9cWRMfQ6/MuTJd3aEsCpJr6LDu7HBqE3aaMN6bmuas=;
 b=Lkntse+mRI9TxJ2jpNDfKXW+pm7MTPsYnU1w0KrVnlwlyL7MAMUZwzEYgwQQvBUNtUO+r1
 AN66q1TlymFi0U/zcfDfJAOZg2nPAWhXLwSsBqqFBH+bLCLRJOyIfUxUxz5W6JvPvG4j/G
 LDp8oWI7uv2Z/+01ZzFw+GFqOoKe9dg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-dNbxtA0qNbm-g6JqVpv5FQ-1; Thu,
 23 Jul 2026 09:54:50 -0400
X-MC-Unique: dNbxtA0qNbm-g6JqVpv5FQ-1
X-Mimecast-MFC-AGG-ID: dNbxtA0qNbm-g6JqVpv5FQ_1784814889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64BCC180074E; Thu, 23 Jul 2026 13:54:49 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 112131956053; Thu, 23 Jul 2026 13:54:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 10/11] bus/fslmc: allocate interrupt during probing
Date: Thu, 23 Jul 2026 15:53:58 +0200
Message-ID: <20260723135400.3621271-11-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AYTwzJpDC1zgwhXtwPFxUYSXLzIC7o1RC1rVD8WxzcQ_1784814889
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
 drivers/bus/fslmc/fslmc_bus.c            | 54 ++++++++++--------------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  1 +
 2 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a1bc7d216c..39afdee9ee 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -95,7 +95,6 @@ fslmc_bus_remove_device(struct rte_dpaa2_device *dev)
 		fslmc_bus_device_count[dev->dev_type]--;
 
 	rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-	rte_intr_instance_free(dev->intr_handle);
 	free(dev);
 }
 
@@ -184,19 +183,12 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.numa_node = SOCKET_ID_ANY;
 	dev->dev_type = dev_type;
 
-	/* Allocate interrupt instance */
-	dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL) {
-		DPAA2_BUS_ERR("Failed to allocate intr handle");
-		goto cleanup;
-	}
-
 	sscanf(dev_id, "%hu", &dev->object_id);
 	dev->device.name = strdup(dev_name);
 	if (!dev->device.name) {
 		DPAA2_BUS_ERR("Unable to clone device name. Out of memory");
-		goto cleanup;
+		free(dev);
+		return -ENOMEM;
 	}
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
@@ -204,12 +196,6 @@ scan_one_fslmc_device(char *dev_name)
 	insert_in_device_list(dev);
 
 	return 0;
-cleanup:
-	if (dev) {
-		rte_intr_instance_free(dev->intr_handle);
-		free(dev);
-	}
-	return -ENOMEM;
 }
 
 static int
@@ -488,18 +474,6 @@ rte_fslmc_scan(void)
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 			return 0;
 		}
-
-		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-			if (dev->dev_type != DPAA2_ETH &&
-			    dev->dev_type != DPAA2_CRYPTO &&
-			    dev->dev_type != DPAA2_QDMA)
-				continue;
-			ret = fslmc_vfio_dev_setup(dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
-				return 0;
-			}
-		}
 	}
 
 	process_once = 1;
@@ -546,7 +520,6 @@ rte_fslmc_close(struct rte_bus *bus)
 			continue;
 		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
 			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
-		fslmc_vfio_dev_close(dev);
 	}
 
 	ret = fslmc_vfio_close_group();
@@ -622,10 +595,27 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(driver, *drv);
 	int ret = 0;
 
-	/* FIXME: probe_device should allocate intr_handle */
+	/* Allocate interrupt instance */
+	dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (dev->intr_handle == NULL) {
+		DPAA2_BUS_ERR("Failed to allocate intr handle");
+		return -ENOMEM;
+	}
+
+	ret = fslmc_vfio_dev_setup(dev);
+	if (ret) {
+		DPAA2_BUS_ERR("Dev (%s) VFIO setup failed", dev->device.name);
+		goto release_intr;
+	}
+
 	ret = drv->probe(drv, dev);
 	if (ret != 0) {
 		DPAA2_BUS_ERR("Unable to probe");
+		fslmc_vfio_dev_close(dev);
+release_intr:
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 	} else {
 		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
@@ -643,7 +633,9 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 		int ret = drv->remove(dev);
 		if (ret != 0)
 			return ret;
-		/* FIXME: unplug_device should free intr_handle */
+		fslmc_vfio_dev_close(dev);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
 		return 0;
 	}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e17050b625..71996b2b38 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -470,6 +470,7 @@ dpaa2_close_dpio_device(int object_id)
 			rte_free(dpio_dev->dpio);
 		}
 		TAILQ_REMOVE(&dpio_dev_list, dpio_dev, next);
+		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
 }
-- 
2.54.0

