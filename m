Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048CC531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C300640B8C;
	Thu, 23 Jul 2026 15:54:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DEE940B95
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2wHnHgRF3o7ICbNHgcaPLJGB0k+Qol9V/y2mduzGMI=;
 b=G9w5UOR6/1UpmLj6y6vj8IomABPTzpspcN5ZBmfhZ50mEJ4v4jCHgloHldWJ8rGHQ3FNdB
 L7rkQQt4PbVYL3o9PMiPrW086irO51nXv+GpuK+v67ids9ykjh9RdZuUOvjYLnSXly2xAF
 Eh7lT6QjimmPbO/a3WFy1iYiMLOxR+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-V7ZNtYtNPZCN4mw5IFa7tg-1; Thu,
 23 Jul 2026 09:54:38 -0400
X-MC-Unique: V7ZNtYtNPZCN4mw5IFa7tg-1
X-Mimecast-MFC-AGG-ID: V7ZNtYtNPZCN4mw5IFa7tg_1784814877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AC7B180A200; Thu, 23 Jul 2026 13:54:37 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04CA21955BD6; Thu, 23 Jul 2026 13:54:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 07/11] bus/fslmc: refactor device filtering for multiprocess
Date: Thu, 23 Jul 2026 15:53:55 +0200
Message-ID: <20260723135400.3621271-8-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HcndXLWZyaqc3UhO4w95zXYFMADP2VWx97oAgpXnP4k_1784814877
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

Refactor device filtering logic by splitting what was done in
fslmc_vfio_process_group().

During scan, do not add device to the bus list unless needed
(wrt secondary process, blocklist ...). Yet, keep a special
case for MPORTAL/DPIO objects and filter them in a new
fslmc_filter_control_devices() helper.

This helper is also responsible for selecting the right MPORTAL/DPIO
objects depending on primary/secondary considerations.

As a consequence, fslmc_vfio_process_group() only handles IO
device init without having to care about skipping some device.

Finally, remove now dead code in fslmc_vfio_close_group() since
only used devices are left in the bus device list.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 134 ++++++++++++++++++++++++++---
 drivers/bus/fslmc/fslmc_vfio.c | 150 +++++----------------------------
 2 files changed, 139 insertions(+), 145 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4f6e0bf387..4b80948aee 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -135,7 +135,6 @@ scan_one_fslmc_device(char *dev_name)
 		{ "dprc.", DPAA2_DPRC },
 	};
 	char *dev_id = NULL;
-	int ret = -1;
 
 	for (unsigned int i = 0; i < RTE_DIM(dev_types); i++) {
 		if (strncmp(dev_types[i].prefix, dev_name, strlen(dev_types[i].prefix)) != 0)
@@ -145,11 +144,37 @@ scan_one_fslmc_device(char *dev_name)
 		break;
 	}
 
-	/* For all other devices, we allocate rte_dpaa2_device.
-	 * For those devices where there is no driver, probe would release
-	 * the memory associated with the rte_dpaa2_device after necessary
-	 * initialization.
+	if (dev_id == NULL) {
+		DPAA2_BUS_ERR("Skipping invalid device (%s)", dev_name);
+		return 0;
+	}
+
+	/*
+	 * DPAA2_MPORTAL and DPAA2_IO types are handled separately,
+	 * see fslmc_filter_control_devices()
 	 */
+	if (rte_bus_device_is_ignored(&rte_fslmc_bus, dev_name) &&
+			dev_type != DPAA2_MPORTAL && dev_type != DPAA2_IO) {
+		DPAA2_BUS_DEBUG("Skipping blocklisted device (%s)", dev_name);
+		return 0;
+	}
+
+	/* For secondary processes, control objects are not needed */
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		switch (dev_type) {
+		case DPAA2_ETH:
+		case DPAA2_CRYPTO:
+		case DPAA2_QDMA:
+		case DPAA2_IO:
+		case DPAA2_MPORTAL:
+		case DPAA2_DPRC:
+			break;
+		default:
+			DPAA2_BUS_DEBUG("Skipping device in secondary process (%s)", dev_name);
+			return 0;
+		}
+	}
+
 	dev = calloc(1, sizeof(struct rte_dpaa2_device));
 	if (!dev) {
 		DPAA2_BUS_ERR("Unable to allocate device object");
@@ -164,13 +189,6 @@ scan_one_fslmc_device(char *dev_name)
 		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 	if (dev->intr_handle == NULL) {
 		DPAA2_BUS_ERR("Failed to allocate intr handle");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
-	if (dev_id == NULL) {
-		DPAA2_BUS_ERR("Skipping invalid device (%s)", dev_name);
-		ret = 0;
 		goto cleanup;
 	}
 
@@ -178,7 +196,6 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.name = strdup(dev_name);
 	if (!dev->device.name) {
 		DPAA2_BUS_ERR("Unable to clone device name. Out of memory");
-		ret = -ENOMEM;
 		goto cleanup;
 	}
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
@@ -192,7 +209,7 @@ scan_one_fslmc_device(char *dev_name)
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 	}
-	return ret;
+	return -ENOMEM;
 }
 
 static int
@@ -278,6 +295,91 @@ fslmc_dev_compare(const char *name1, const char *name2)
 	return strncmp(devname1, devname2, sizeof(devname1));
 }
 
+static int
+fslmc_filter_control_devices(void)
+{
+	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
+	int dpmcp_count = 0, dpio_count = 0;
+	struct rte_dpaa2_device *dev;
+
+	/* Track MPORTAL/DPIO blocklists */
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->dev_type != DPAA2_MPORTAL && dev->dev_type != DPAA2_IO)
+			continue;
+		if (rte_bus_device_is_ignored(&rte_fslmc_bus, rte_dev_name(&dev->device))) {
+			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping", dev->device.name);
+			if (dev->dev_type == DPAA2_MPORTAL)
+				is_dpmcp_in_blocklist = true;
+			else if (dev->dev_type == DPAA2_IO)
+				is_dpio_in_blocklist = true;
+			fslmc_bus_remove_device(dev);
+			continue;
+		}
+		if (dev->dev_type == DPAA2_MPORTAL)
+			dpmcp_count++;
+		else if (dev->dev_type == DPAA2_IO)
+			dpio_count++;
+	}
+
+	if (dpmcp_count == 0) {
+		DPAA2_BUS_ERR("No MC Portal device found");
+		return -ENODEV;
+	}
+
+	/* Automatic MPORTAL split: primary keeps first, secondary keeps last */
+	if (!is_dpmcp_in_blocklist) {
+		int current_device = 0;
+		int keep_index;
+
+		/* Check MPORTAL availability for secondary */
+		if (rte_eal_process_type() == RTE_PROC_SECONDARY && dpmcp_count < 2) {
+			DPAA2_BUS_ERR("No MC Portal device found for secondary");
+			return -ENODEV;
+		}
+
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+			keep_index = 0;
+		else
+			keep_index = dpmcp_count - 1;
+
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+			if (dev->dev_type != DPAA2_MPORTAL)
+				continue;
+			if (current_device != keep_index)
+				fslmc_bus_remove_device(dev);
+
+			current_device++;
+			if (current_device == dpmcp_count)
+				break;
+		}
+	}
+
+	/* Automatic DPIO split: secondary keeps last only, primary removes last */
+	if (!is_dpio_in_blocklist) {
+		int last_index = dpio_count - 1;
+		int current_device = 0;
+
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+			if (dev->dev_type != DPAA2_IO)
+				continue;
+
+			if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+					current_device != last_index) {
+				fslmc_bus_remove_device(dev);
+			} else if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+					current_device == last_index) {
+				fslmc_bus_remove_device(dev);
+			}
+
+			current_device++;
+			if (current_device == dpio_count)
+				break;
+		}
+	}
+
+	return 0;
+}
+
 static int
 rte_fslmc_scan(void)
 {
@@ -377,6 +479,10 @@ rte_fslmc_scan(void)
 			}
 		}
 
+		ret = fslmc_filter_control_devices();
+		if (ret)
+			return 0;
+
 		ret = fslmc_vfio_process_group();
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 3e45a8ed5c..d67232c31b 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1560,15 +1560,10 @@ fslmc_vfio_close_group(void)
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
 		case DPAA2_IO:
-			fslmc_close_iodevices(dev, vfio_group_fd);
-			break;
 		case DPAA2_CON:
 		case DPAA2_CI:
 		case DPAA2_BPOOL:
 		case DPAA2_MUX:
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-				continue;
-
 			fslmc_close_iodevices(dev, vfio_group_fd);
 			break;
 		case DPAA2_DPRTC:
@@ -1586,154 +1581,48 @@ fslmc_vfio_close_group(void)
 int
 fslmc_vfio_process_group(void)
 {
-	int ret;
-	int found_mportal = 0;
 	struct rte_dpaa2_device *dev;
-	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
-	int dpmcp_count = 0, dpio_count = 0, current_device;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_MPORTAL) {
-			dpmcp_count++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
-				is_dpmcp_in_blocklist = true;
-		}
-		if (dev->dev_type == DPAA2_IO) {
-			dpio_count++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
-				is_dpio_in_blocklist = true;
-		}
-	}
+	int ret;
 
-	/* Search the MCP as that should be initialized first. */
-	current_device = 0;
+	/* Process MPORTAL - should be initialized first */
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_MPORTAL) {
-			current_device++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
-					      dev->device.name);
-				fslmc_bus_remove_device(dev);
-				continue;
-			}
-
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-			    !is_dpmcp_in_blocklist) {
-				if (dpmcp_count == 1 ||
-				    current_device != dpmcp_count) {
-					fslmc_bus_remove_device(dev);
-					continue;
-				}
-			}
-
-			if (!found_mportal) {
-				ret = fslmc_process_mcp(dev);
-				if (ret) {
-					DPAA2_BUS_ERR("Unable to map MC Portal");
-					return ret;
-				}
-				found_mportal = 1;
-			}
-
-			fslmc_bus_remove_device(dev);
-			/* Ideally there is only a single dpmcp, but in case
-			 * multiple exists, looping on remaining devices.
-			 */
+		if (dev->dev_type != DPAA2_MPORTAL)
+			continue;
+		ret = fslmc_process_mcp(dev);
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to map MC Portal");
+			return ret;
 		}
+		fslmc_bus_remove_device(dev);
+		break;
 	}
 
-	/* Cannot continue if there is not even a single mportal */
-	if (!found_mportal) {
-		DPAA2_BUS_ERR("No MC Portal device found. Not continuing");
-		return -EIO;
-	}
-
-	/* Search for DPRC device next as it updates endpoint of
+	/* Process DPRC device next as it updates endpoint of
 	 * other devices.
 	 */
-	current_device = 0;
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_DPRC) {
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Unable to process dprc");
-				return ret;
-			}
-			fslmc_bus_remove_device(dev);
+		if (dev->dev_type != DPAA2_DPRC)
+			continue;
+		ret = fslmc_process_iodevices(dev);
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to process dprc");
+			return ret;
 		}
+		fslmc_bus_remove_device(dev);
 	}
 
-	current_device = 0;
+	/* Process remaining devices */
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_IO)
-			current_device++;
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
-				      dev->device.name);
-			fslmc_bus_remove_device(dev);
-			continue;
-		}
-		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-		    dev->dev_type != DPAA2_ETH &&
-		    dev->dev_type != DPAA2_CRYPTO &&
-		    dev->dev_type != DPAA2_QDMA &&
-		    dev->dev_type != DPAA2_IO) {
-			fslmc_bus_remove_device(dev);
-			continue;
-		}
 		switch (dev->dev_type) {
 		case DPAA2_ETH:
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_DEBUG("Dev (%s) init failed",
-						dev->device.name);
-				return ret;
-			}
-			break;
 		case DPAA2_CON:
 		case DPAA2_CI:
 		case DPAA2_BPOOL:
 		case DPAA2_DPRTC:
 		case DPAA2_MUX:
-			/* IN case of secondary processes, all control objects
-			 * like dpbp, dpcon, dpci are not initialized/required
-			 * - all of these are assumed to be initialized and made
-			 *   available by primary.
-			 */
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-				continue;
-
-			/* Call the object creation routine and remove the
-			 * device entry from device list
-			 */
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_DEBUG("Dev (%s) init failed",
-						dev->device.name);
-				return ret;
-			}
-
-			break;
 		case DPAA2_IO:
-			if (!is_dpio_in_blocklist && dpio_count > 1) {
-				if (rte_eal_process_type() == RTE_PROC_SECONDARY
-				    && current_device != dpio_count) {
-					fslmc_bus_remove_device(dev);
-					break;
-				}
-				if (rte_eal_process_type() == RTE_PROC_PRIMARY
-				    && current_device == dpio_count) {
-					fslmc_bus_remove_device(dev);
-					break;
-				}
-			}
-
 			ret = fslmc_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_DEBUG("Dev (%s) init failed",
@@ -1742,7 +1631,6 @@ fslmc_vfio_process_group(void)
 			}
 
 			break;
-		case DPAA2_UNKNOWN:
 		default:
 			/* Unknown - ignore */
 			DPAA2_BUS_DEBUG("Found unknown device (%s)",
-- 
2.54.0

