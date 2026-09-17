Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C1C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68BB942DF1;
	Thu, 17 Sep 2026 09:49:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3048D42DA1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mO18YDalq4W68ycF90WpTCzIVOOarrm5rx1hf6biMB0=;
 b=fIi/SivSWv2F0vutTqaq1StWFy8X/1b/UvJ9wnkmH9aZtYYMwqd8JN9KfILUScrttlbniJ
 46ilzW9lZWXkuytmAPfCB8PW1fiFB3AS/b8JTQHaRCTeU357IWfqbxSkTMYOZGzNGbi6td
 uQylKgzGUi4BcSs4HCJjbjJw3lXJTWE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-2JbgEMAWN5StXVAwJUpKkQ-1; Thu,
 17 Sep 2026 03:49:48 -0400
X-MC-Unique: 2JbgEMAWN5StXVAwJUpKkQ-1
X-Mimecast-MFC-AGG-ID: 2JbgEMAWN5StXVAwJUpKkQ_1789631387
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C36D1802176; Thu, 17 Sep 2026 07:49:47 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E84C30001A2; Thu, 17 Sep 2026 07:49:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 06/16] bus/fslmc: fix memory leaks in scan
Date: Thu, 17 Sep 2026 09:49:06 +0200
Message-ID: <20260917074917.595603-7-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zwG5xnwtZTiLI-IiN_CQqwR_H9oDm_oKT6dKopO_M9Y_1789631387
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
Changes since RFC v1:
- fixed interrupt handle leak by adding fslmc_free_device helper
  sooner in the series,

---
 drivers/bus/fslmc/fslmc_bus.c  | 23 ++++++++++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.c | 33 +++++++++------------------------
 drivers/bus/fslmc/private.h    |  2 ++
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4b0896e42e..322b023652 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -85,6 +85,22 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 		rte_bus_add_device(&rte_fslmc_bus, &newdev->device);
 }
 
+static void
+fslmc_free_device(struct rte_device *rte_dev)
+{
+	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
+
+	rte_intr_instance_free(dev->intr_handle);
+	free(dev);
+}
+
+void
+fslmc_bus_remove_device(struct rte_dpaa2_device *dev)
+{
+	rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+	fslmc_free_device(&dev->device);
+}
+
 static void
 dump_device_list(void)
 {
@@ -402,11 +418,8 @@ rte_fslmc_scan(void)
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
index 165e9444f5..6e0b35f391 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1557,13 +1557,6 @@ fslmc_vfio_close_group(void)
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
@@ -1625,8 +1618,7 @@ fslmc_vfio_process_group(void)
 			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
-				rte_bus_remove_device(&rte_fslmc_bus,
-						&dev->device);
+				fslmc_bus_remove_device(dev);
 				continue;
 			}
 
@@ -1634,8 +1626,7 @@ fslmc_vfio_process_group(void)
 			    !is_dpmcp_in_blocklist) {
 				if (dpmcp_count == 1 ||
 				    current_device != dpmcp_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
+					fslmc_bus_remove_device(dev);
 					continue;
 				}
 			}
@@ -1649,9 +1640,7 @@ fslmc_vfio_process_group(void)
 				found_mportal = 1;
 			}
 
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
+			fslmc_bus_remove_device(dev);
 			/* Ideally there is only a single dpmcp, but in case
 			 * multiple exists, looping on remaining devices.
 			 */
@@ -1675,7 +1664,7 @@ fslmc_vfio_process_group(void)
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
 			}
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 		}
 	}
 
@@ -1687,7 +1676,7 @@ fslmc_vfio_process_group(void)
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
@@ -1695,7 +1684,7 @@ fslmc_vfio_process_group(void)
 		    dev->dev_type != DPAA2_CRYPTO &&
 		    dev->dev_type != DPAA2_QDMA &&
 		    dev->dev_type != DPAA2_IO) {
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		switch (dev->dev_type) {
@@ -1737,14 +1726,12 @@ fslmc_vfio_process_group(void)
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
@@ -1762,9 +1749,7 @@ fslmc_vfio_process_group(void)
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

