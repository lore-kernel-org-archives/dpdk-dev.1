Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107B606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Muksv1xL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CD97402A3;
	Mon, 26 Oct 2026 19:11:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 7898C402A3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G07uum+0qbLJ4kF7L4MPeGk/hsOiY1rspm7cORIU3q0=;
 b=Muksv1xLjxlM2HTD7k5B64UmB5E1qSwjJ4Dkm3fv96Lh4poiQg2ZAsyqCDhmN0x0jcGlm+
 /o9SZLJO7krB6kaxdG4/1le2G2Mj3jaTp57sOCSb+yp9FDmTPViC+nMGDgW2S0mWjyJaqd
 x+eJhZIMwQE+QOgLnSCCnubiC1+652k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-iHO_wL-pP5qMxYdT0MltSg-1; Mon,
 26 Oct 2026 14:10:55 -0400
X-MC-Unique: iHO_wL-pP5qMxYdT0MltSg-1
X-Mimecast-MFC-AGG-ID: iHO_wL-pP5qMxYdT0MltSg_1793038255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED2EC1955EA9; Mon, 26 Oct 2026 18:10:54 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 235001800480; Mon, 26 Oct 2026 18:10:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 06/16] bus/fslmc: fix memory leaks in scan
Date: Mon, 26 Oct 2026 19:10:20 +0100
Message-ID: <20261026181031.304100-7-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ycjhTIPp7lUjIGjL2C9qOtaWQNRWdePJ1ac9vfQDVQ_1793038255
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
index 632142d128..38dd8afe34 100644
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
@@ -369,11 +385,8 @@ rte_fslmc_scan(void)
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
index c8b5518956..2a3d022d2e 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1568,13 +1568,6 @@ fslmc_vfio_close_group(void)
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
@@ -1636,8 +1629,7 @@ fslmc_vfio_process_group(void)
 			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
-				rte_bus_remove_device(&rte_fslmc_bus,
-						&dev->device);
+				fslmc_bus_remove_device(dev);
 				continue;
 			}
 
@@ -1645,8 +1637,7 @@ fslmc_vfio_process_group(void)
 			    !is_dpmcp_in_blocklist) {
 				if (dpmcp_count == 1 ||
 				    current_device != dpmcp_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
+					fslmc_bus_remove_device(dev);
 					continue;
 				}
 			}
@@ -1660,9 +1651,7 @@ fslmc_vfio_process_group(void)
 				found_mportal = 1;
 			}
 
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
+			fslmc_bus_remove_device(dev);
 			/* Ideally there is only a single dpmcp, but in case
 			 * multiple exists, looping on remaining devices.
 			 */
@@ -1686,7 +1675,7 @@ fslmc_vfio_process_group(void)
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
 			}
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 		}
 	}
 
@@ -1698,7 +1687,7 @@ fslmc_vfio_process_group(void)
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
@@ -1706,7 +1695,7 @@ fslmc_vfio_process_group(void)
 		    dev->dev_type != DPAA2_CRYPTO &&
 		    dev->dev_type != DPAA2_QDMA &&
 		    dev->dev_type != DPAA2_IO) {
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			fslmc_bus_remove_device(dev);
 			continue;
 		}
 		switch (dev->dev_type) {
@@ -1748,14 +1737,12 @@ fslmc_vfio_process_group(void)
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
@@ -1773,9 +1760,7 @@ fslmc_vfio_process_group(void)
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

