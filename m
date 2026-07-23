Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C0C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 905CB40A73;
	Thu, 23 Jul 2026 15:54:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C7BD640A71
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81hHokqhuo8gE8W/IHOuCvoouP7F9XSqWN+Az8i8/8w=;
 b=NjduSof7avDQ8WbIYLdf3JDnZ05+gXb7CfNbRj27RN4dYG7+gh/Dpd1papGwfuwZNlWkU1
 BpwMOnju3gW5zGRxx4otZYg8HnbtMjx+j2kHuldk51CGD5nkUKfU+vc9p/+MK7Ehm6pqiw
 AbDLVbeHxoDnyKedvZAFOhm+gaOSiPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-xnpeviS2PDOpSxqDsNd9Eg-1; Thu,
 23 Jul 2026 09:54:26 -0400
X-MC-Unique: xnpeviS2PDOpSxqDsNd9Eg-1
X-Mimecast-MFC-AGG-ID: xnpeviS2PDOpSxqDsNd9Eg_1784814865
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3471D1977531; Thu, 23 Jul 2026 13:54:25 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF0AC18002B5; Thu, 23 Jul 2026 13:54:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 04/11] bus/fslmc: fix memory leaks in scan
Date: Thu, 23 Jul 2026 15:53:52 +0200
Message-ID: <20260723135400.3621271-5-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RiYekBAdG1UBCH_P7oxupn62E1o1G-gGa3tRVxM2VWk_1784814865
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

During the scan phase (more precisely, during device filtering),
device pointers were leaked.

Add a simple helper so a device pointer is fully freed.

As a consequence of the filtering during scan, all blocklisted devices
are freed from the bus list during scan: there is no need for
reevaluating if a device is blocklisted during cleanup.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 15 ++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.c | 33 +++++++++------------------------
 drivers/bus/fslmc/private.h    |  2 ++
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4518f038c6..94685a0f5a 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -85,6 +85,14 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 		rte_bus_add_device(&rte_fslmc_bus, &newdev->device);
 }
 
+void
+fslmc_bus_remove_device(struct rte_dpaa2_device *dev)
+{
+	rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+	rte_intr_instance_free(dev->intr_handle);
+	free(dev);
+}
+
 static void
 dump_device_list(void)
 {
@@ -403,11 +411,8 @@ rte_fslmc_scan(void)
 	closedir(dir);
 
 	/* Remove all devices in the list */
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-		rte_intr_instance_free(dev->intr_handle);
-		free(dev);
-	}
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
+		fslmc_bus_remove_device(dev);
 scan_fail:
 	DPAA2_BUS_DEBUG("FSLMC Bus Not Available. Skipping (%d)", ret);
 	/* Irrespective of failure, scan only return success */
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae..3e45a8ed5c 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1555,13 +1555,6 @@ fslmc_vfio_close_group(void)
 	}
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_LOG(DEBUG, "%s Blacklisted, skipping",
-				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-				continue;
-		}
 		switch (dev->dev_type) {
 		case DPAA2_ETH:
 		case DPAA2_CRYPTO:
@@ -1623,8 +1616,7 @@ fslmc_vfio_process_group(void)
 			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
-				rte_bus_remove_device(&rte_fslmc_bus,
-						&dev->device);
+				fslmc_bus_remove_device(dev);
 				continue;
 			}
 
@@ -1632,8 +1624,7 @@ fslmc_vfio_process_group(void)
 			    !is_dpmcp_in_blocklist) {
 				if (dpmcp_count == 1 ||
 				    current_device != dpmcp_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
+					fslmc_bus_remove_device(dev);
 					continue;
 				}
 			}
@@ -1647,9 +1638,7 @@ fslmc_vfio_process_group(void)
 				found_mportal = 1;
 			}
 
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
+			fslmc_bus_remove_device(dev);
 			/* Ideally there is only a single dpmcp, but in case
 			 * multiple exists, looping on remaining devices.
 			 */
@@ -1673,7 +1662,7 @@ fslmc_vfio_process_group(void)
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
 			}
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 		}
 	}
 
@@ -1685,7 +1674,7 @@ fslmc_vfio_process_group(void)
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
@@ -1693,7 +1682,7 @@ fslmc_vfio_process_group(void)
 		    dev->dev_type != DPAA2_CRYPTO &&
 		    dev->dev_type != DPAA2_QDMA &&
 		    dev->dev_type != DPAA2_IO) {
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		switch (dev->dev_type) {
@@ -1735,14 +1724,12 @@ fslmc_vfio_process_group(void)
 			if (!is_dpio_in_blocklist && dpio_count > 1) {
 				if (rte_eal_process_type() == RTE_PROC_SECONDARY
 				    && current_device != dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
+					fslmc_bus_remove_device(dev);
 					break;
 				}
 				if (rte_eal_process_type() == RTE_PROC_PRIMARY
 				    && current_device == dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
+					fslmc_bus_remove_device(dev);
 					break;
 				}
 			}
@@ -1760,9 +1747,7 @@ fslmc_vfio_process_group(void)
 			/* Unknown - ignore */
 			DPAA2_BUS_DEBUG("Found unknown device (%s)",
 					dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
+			fslmc_bus_remove_device(dev);
 		}
 	}
 
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 20a454c3fc..825a364f1b 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -11,4 +11,6 @@
 
 extern struct rte_bus rte_fslmc_bus;
 
+void fslmc_bus_remove_device(struct rte_dpaa2_device *dev);
+
 #endif /* BUS_FSLMC_PRIVATE_H */
-- 
2.54.0

