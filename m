Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A19C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF35942E61;
	Thu, 17 Sep 2026 09:50:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D97A542E4D
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ago90h5gC+MZoCO6FpVroZK5qDAM0X6JdJL9zKSxnds=;
 b=Tdj0fpxFK9S34mcfWmiZTfWzWoCN6EjmvvGd2AG4Zgq49wSOZAT5tnB4VsKnexY5QBuDRd
 XjLXqXsv0B8IP15YHbXVyKXhjxuOTkT5Y+05TH+WiJGShqZsJQYkxI7AofaldTievm8vG4
 ehqq1X5n3aG/QuhICnrDs1y/huqWneo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-zbZ0p0ndOMqA9Bmu79oxyg-1; Thu,
 17 Sep 2026 03:50:10 -0400
X-MC-Unique: zbZ0p0ndOMqA9Bmu79oxyg-1
X-Mimecast-MFC-AGG-ID: zbZ0p0ndOMqA9Bmu79oxyg_1789631409
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 979E11944A8C; Thu, 17 Sep 2026 07:50:08 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AC5F76D; Thu, 17 Sep 2026 07:50:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC v2 12/16] bus/fslmc: refactor device filtering for multiprocess
Date: Thu, 17 Sep 2026 09:49:12 +0200
Message-ID: <20260917074917.595603-13-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RqDGHHZQYo40inY0QbzBQBtj2e0AjkvYf2exuzgopr0_1789631409
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

Separate control devices from other bus devices.

During scan, do not add device to the control list unless needed
(wrt secondary process, blocklist ...). Yet, keep a special
case for MPORTAL/DPIO objects and filter them in a new
fslmc_filter_control_devices() helper.

This helper is also responsible for selecting the right MPORTAL/DPIO
objects depending on primary/secondary considerations.

As a consequence, fslmc_vfio_process_group() only handles IO
device init without having to care about skipping some device.

Finally, remove now dead code in fslmc_vfio_close_group() since
only used devices are left in the control and bus device lists.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- split DPAA2 devices in two lists, one for EAL and one for the internal
  devices initialisation. This new list is kept ordered,
- fixed regressions raised by Stephen AI review:
  - allowlist issue: internal devices must be exempted from allowlist
    in some cases, so I simply reproduced the existing custom logic,
  - device pruning with only one DPIO device,
  - (unused) MPORTAL objects kept in device list,

---
 drivers/bus/fslmc/fslmc_bus.c  | 202 ++++++++++++++++++++++++++++++--
 drivers/bus/fslmc/fslmc_vfio.c | 205 ++++++++-------------------------
 drivers/bus/fslmc/private.h    |   4 +
 3 files changed, 250 insertions(+), 161 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 802617c5fe..4789ab0cf3 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -30,6 +30,15 @@
 struct rte_bus rte_fslmc_bus;
 static int fslmc_bus_device_count[DPAA2_DEVTYPE_MAX];
 
+/*
+ * Control devices (MPORTAL, IO, CON, CI, BPOOL, MUX, DPRC) are bus infrastructure,
+ * not regular devices. They are initialized during scan/setup and don't participate
+ * in normal probe/unplug. Keep them in a separate list to avoid interference with
+ * generic bus operations.
+ */
+struct fslmc_control_device_list fslmc_control_devices =
+	TAILQ_HEAD_INITIALIZER(fslmc_control_devices);
+
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
 int dpaa2_seqn_dynfield_offset = -1;
@@ -106,10 +115,44 @@ fslmc_bus_remove_device(struct rte_dpaa2_device *dev)
 	fslmc_free_device(&dev->device);
 }
 
+static void
+insert_in_control_device_list(struct rte_dpaa2_device *dev)
+{
+	struct rte_device *rte_dev;
+	struct rte_device *prev;
+
+	prev = NULL;
+	TAILQ_FOREACH(rte_dev, &fslmc_control_devices, next) {
+		if (compare_dpaa2_devname(dev, RTE_BUS_DEVICE(rte_dev, *dev)) < 0)
+			break;
+		prev = rte_dev;
+	}
+
+	if (prev != NULL)
+		TAILQ_INSERT_AFTER(&fslmc_control_devices, prev, &dev->device, next);
+	else
+		TAILQ_INSERT_HEAD(&fslmc_control_devices, &dev->device, next);
+
+	if (dev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[dev->dev_type]++;
+}
+
+void
+fslmc_remove_control_device(struct rte_dpaa2_device *dev)
+{
+	if (dev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[dev->dev_type]--;
+
+	TAILQ_REMOVE(&fslmc_control_devices, &dev->device, next);
+	rte_intr_instance_free(dev->intr_handle);
+	free(dev);
+}
+
 static void
 dump_device_list(void)
 {
 	struct rte_dpaa2_device *dev;
+	struct rte_device *rte_dev;
 
 	/* Only if the log level has been set to Debugging, print list */
 	if (rte_log_can_log(dpaa2_logtype_bus, RTE_LOG_DEBUG)) {
@@ -117,6 +160,11 @@ dump_device_list(void)
 		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 			DPAA2_BUS_LOG(DEBUG, "\t\t%s", dev->device.name);
 		}
+		DPAA2_BUS_LOG(DEBUG, "List of control devices:");
+		TAILQ_FOREACH(rte_dev, &fslmc_control_devices, next) {
+			dev = RTE_BUS_DEVICE(rte_dev, struct rte_dpaa2_device);
+			DPAA2_BUS_LOG(DEBUG, "\t\t%s", dev->device.name);
+		}
 	}
 }
 
@@ -166,11 +214,39 @@ scan_one_fslmc_device(char *dev_name)
 		dev_id = ptr + 1;
 	}
 
-	/* For all other devices, we allocate rte_dpaa2_device.
-	 * For those devices where there is no driver, probe would release
-	 * the memory associated with the rte_dpaa2_device after necessary
-	 * initialization.
+	/*
+	 * DPAA2_MPORTAL and DPAA2_IO types are handled separately,
+	 * see fslmc_filter_control_devices()
+	 *
+	 * Note: Only check for explicit blocklist (RTE_DEV_BLOCKED).
+	 * Control objects (dpbp, dpcon, etc.) are required even in allowlist
+	 * mode as they are initialized by fslmc_vfio_process_group(), not probed.
 	 */
+	if (dev_type != DPAA2_MPORTAL && dev_type != DPAA2_IO) {
+		struct rte_devargs *devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
+
+		if (devargs && devargs->policy == RTE_DEV_BLOCKED) {
+			DPAA2_BUS_DEBUG("Skipping blocklisted device (%s)", dev_name);
+			return 0;
+		}
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
@@ -203,8 +279,16 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.name = dev->name;
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
-	/* Add device in the fslmc device list */
-	insert_in_device_list(dev);
+	switch (dev_type) {
+	case DPAA2_ETH:
+	case DPAA2_CRYPTO:
+	case DPAA2_QDMA:
+		insert_in_device_list(dev);
+		break;
+	default:
+		insert_in_control_device_list(dev);
+		break;
+	}
 
 	return 0;
 cleanup:
@@ -298,6 +382,97 @@ fslmc_dev_compare(const char *name1, const char *name2)
 	return strncmp(devname1, devname2, sizeof(devname1));
 }
 
+static int
+fslmc_filter_control_devices(void)
+{
+	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
+	int dpmcp_count = 0, dpio_count = 0;
+	struct rte_dpaa2_device *dev;
+	struct rte_device *rte_dev;
+	struct rte_device *tmp_dev;
+
+	/* Track MPORTAL/DPIO blocklists */
+	RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		if (dev->dev_type != DPAA2_MPORTAL && dev->dev_type != DPAA2_IO)
+			continue;
+		/* Only check for explicit blocklist, not allowlist */
+		if (dev->device.devargs && dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping", dev->device.name);
+			if (dev->dev_type == DPAA2_MPORTAL)
+				is_dpmcp_in_blocklist = true;
+			else if (dev->dev_type == DPAA2_IO)
+				is_dpio_in_blocklist = true;
+			fslmc_remove_control_device(dev);
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
+		RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+			dev = RTE_BUS_DEVICE(rte_dev, *dev);
+			if (dev->dev_type != DPAA2_MPORTAL)
+				continue;
+			if (current_device != keep_index)
+				fslmc_remove_control_device(dev);
+
+			current_device++;
+			if (current_device == dpmcp_count)
+				break;
+		}
+	}
+
+	/* Automatic DPIO split: secondary keeps last only, primary removes last */
+	if (!is_dpio_in_blocklist && dpio_count > 1) {
+		int last_index = dpio_count - 1;
+		int current_device = 0;
+
+		RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+			dev = RTE_BUS_DEVICE(rte_dev, *dev);
+			if (dev->dev_type != DPAA2_IO)
+				continue;
+
+			if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+					current_device != last_index) {
+				fslmc_remove_control_device(dev);
+			} else if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+					current_device == last_index) {
+				fslmc_remove_control_device(dev);
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
@@ -361,7 +536,7 @@ rte_fslmc_scan(void)
 	dump_device_list();
 
 	/* Bus initialization - only if devices were found */
-	if (!TAILQ_EMPTY(&rte_fslmc_bus.device_list)) {
+	if (!TAILQ_EMPTY(&rte_fslmc_bus.device_list) || !TAILQ_EMPTY(&fslmc_control_devices)) {
 		static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
 			.name = DPAA2_SEQN_DYNFIELD_NAME,
 			.size = sizeof(dpaa2_seqn_t),
@@ -393,6 +568,12 @@ rte_fslmc_scan(void)
 			}
 		}
 
+		ret = fslmc_filter_control_devices();
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to filter control devices %d", ret);
+			goto vfio_dma_unmap;
+		}
+
 		ret = fslmc_vfio_process_group();
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
@@ -410,6 +591,13 @@ rte_fslmc_scan(void)
 	fslmc_vfio_close_group();
 
 scan_fail:
+	while (!TAILQ_EMPTY(&fslmc_control_devices)) {
+		struct rte_device *rte_dev = TAILQ_FIRST(&fslmc_control_devices);
+
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		fslmc_remove_control_device(dev);
+	}
+
 	/* Remove all devices in the list */
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
 		fslmc_bus_remove_device(dev);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 03cac79c50..954167f452 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1599,6 +1599,7 @@ int
 fslmc_vfio_close_group(void)
 {
 	struct rte_dpaa2_device *dev;
+	struct rte_device *rte_dev;
 	int vfio_group_fd;
 	const char *group_name = fslmc_vfio_get_group_name();
 
@@ -1611,30 +1612,14 @@ fslmc_vfio_close_group(void)
 		return -EIO;
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		switch (dev->dev_type) {
-		case DPAA2_ETH:
-		case DPAA2_CRYPTO:
-		case DPAA2_QDMA:
-		case DPAA2_IO:
-			fslmc_close_iodevices(dev, vfio_group_fd);
-			break;
-		case DPAA2_CON:
-		case DPAA2_CI:
-		case DPAA2_BPOOL:
-		case DPAA2_MUX:
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-				continue;
-
-			fslmc_close_iodevices(dev, vfio_group_fd);
-			break;
-		case DPAA2_DPRTC:
-		default:
-			DPAA2_BUS_DEBUG("Device cannot be closed: Not supported (%s)",
-					dev->device.name);
-		}
+	TAILQ_FOREACH(rte_dev, &fslmc_control_devices, next) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		fslmc_close_iodevices(dev, vfio_group_fd);
 	}
 
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
+		fslmc_close_iodevices(dev, vfio_group_fd);
+
 	fslmc_vfio_clear_group(vfio_group_fd);
 
 	return 0;
@@ -1643,168 +1628,80 @@ fslmc_vfio_close_group(void)
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
-
-	/* Search the MCP as that should be initialized first. */
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
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
+	struct rte_device *rte_dev;
+	struct rte_device *tmp_dev;
+	int ret;
 
-			fslmc_bus_remove_device(dev);
-			/* Ideally there is only a single dpmcp, but in case
-			 * multiple exists, looping on remaining devices.
-			 */
+	/* Process MPORTAL - should be initialized first */
+	RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		if (dev->dev_type != DPAA2_MPORTAL)
+			continue;
+		ret = fslmc_process_mcp(dev);
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to map MC Portal");
+			return ret;
 		}
+		fslmc_remove_control_device(dev);
+		break;
 	}
 
-	/* Cannot continue if there is not even a single mportal */
-	if (!found_mportal) {
-		DPAA2_BUS_ERR("No MC Portal device found. Not continuing");
-		return -EIO;
+	/* Remove any remaining MPORTAL devices */
+	RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		if (dev->dev_type == DPAA2_MPORTAL)
+			fslmc_remove_control_device(dev);
 	}
 
-	/* Search for DPRC device next as it updates endpoint of
+	/* Process DPRC device next as it updates endpoint of
 	 * other devices.
 	 */
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_DPRC) {
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Unable to process dprc");
-				return ret;
-			}
-			fslmc_bus_remove_device(dev);
+	RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
+		if (dev->dev_type != DPAA2_DPRC)
+			continue;
+		ret = fslmc_process_iodevices(dev);
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to process dprc");
+			return ret;
 		}
+		fslmc_remove_control_device(dev);
 	}
 
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
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
+	/* Process remaining control devices */
+	RTE_TAILQ_FOREACH_SAFE(rte_dev, &fslmc_control_devices, next, tmp_dev) {
+		dev = RTE_BUS_DEVICE(rte_dev, *dev);
 		switch (dev->dev_type) {
-		case DPAA2_ETH:
-		case DPAA2_CRYPTO:
-		case DPAA2_QDMA:
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
 						dev->device.name);
 				return ret;
 			}
-
 			break;
-		case DPAA2_UNKNOWN:
 		default:
 			/* Unknown - ignore */
 			DPAA2_BUS_DEBUG("Found unknown device (%s)",
 					dev->device.name);
-			fslmc_bus_remove_device(dev);
+			fslmc_remove_control_device(dev);
+			break;
+		}
+	}
+
+	/* Process regular devices */
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		ret = fslmc_process_iodevices(dev);
+		if (ret) {
+			DPAA2_BUS_DEBUG("Dev (%s) init failed",
+					dev->device.name);
+			return ret;
 		}
 	}
 
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 825a364f1b..064ffa9536 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -11,6 +11,10 @@
 
 extern struct rte_bus rte_fslmc_bus;
 
+RTE_TAILQ_HEAD(fslmc_control_device_list, rte_device);
+extern struct fslmc_control_device_list fslmc_control_devices;
+
 void fslmc_bus_remove_device(struct rte_dpaa2_device *dev);
+void fslmc_remove_control_device(struct rte_dpaa2_device *dev);
 
 #endif /* BUS_FSLMC_PRIVATE_H */
-- 
2.54.0

