Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F9FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED0CE40A4B;
	Wed, 29 Apr 2026 13:47:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 83FC840664
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXCqSiaBnN0jOyTWox9QjYsQ/4ImLkJ1iqRYmkj1Z7c=;
 b=OuWinSj4g9WqakZ77LI9NUIMM74976uzbU0lXsYQri6dDzRA57JLW9zAbQ30VWccGGGvgO
 A+fVAz2hwD4qUxlulcGLb1s4P2cKyTm0D1pjyIPHtOv2+sOLhsoEV08ecq2rSbQZMwY8io
 HeIl8HbJVlBT5ymUemn4ciHqoqbnwC8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-xfF_HN0OP4uIhW98pZOShQ-1; Wed,
 29 Apr 2026 07:47:02 -0400
X-MC-Unique: xfF_HN0OP4uIhW98pZOShQ-1
X-Mimecast-MFC-AGG-ID: xfF_HN0OP4uIhW98pZOShQ_1777463221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56F841800350; Wed, 29 Apr 2026 11:47:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0D25195608E; Wed, 29 Apr 2026 11:46:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 14/23] drivers/bus: initialize NXP bus specifics in scan
Date: Wed, 29 Apr 2026 13:44:47 +0200
Message-ID: <20260429114503.932575-15-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yf9hMjpw4LNeJ8QtmzMkW3XmCuXSKOAoNhzCp00FZ2c_1777463221
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

Move bus-specific initialization code from probe() to scan() operations
for DPAA and FSLMC buses. This separates device discovery and bus setup
(scan) from driver matching and probing (probe), preparing for a future
generic probe() implementation in EAL.

Both buses now have a clean separation:
- scan(): discover devices + initialize bus
- probe(): match drivers + call probe_device()

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 76 +++++++++++++++---------------
 drivers/bus/fslmc/fslmc_bus.c | 88 +++++++++++++++++------------------
 2 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index b0ed61ba39..43d71cefa4 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -569,40 +569,6 @@ dpaa_bus_dev_compare(const char *name1, const char *name2)
 	return strncmp(devname1, devname2, sizeof(devname1));
 }
 
-#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
-#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
-
-static int
-rte_dpaa_bus_scan(void)
-{
-	int ret;
-
-	BUS_INIT_FUNC_TRACE();
-
-	if ((access(DPAA_DEV_PATH1, F_OK) != 0) &&
-	    (access(DPAA_DEV_PATH2, F_OK) != 0)) {
-		DPAA_BUS_LOG(DEBUG, "DPAA Bus not present. Skipping.");
-		return 0;
-	}
-
-	if (rte_dpaa_bus.detected)
-		return 0;
-
-	rte_dpaa_bus.detected = 1;
-
-	/* create the key, supplying a function that'll be invoked
-	 * when a portal affined thread will be deleted.
-	 */
-	ret = pthread_key_create(&dpaa_portal_key, dpaa_portal_finish);
-	if (ret) {
-		DPAA_BUS_LOG(DEBUG, "Unable to create pthread key. (%d)", ret);
-		dpaa_clean_device_list();
-		return ret;
-	}
-
-	return 0;
-}
-
 /* register a dpaa bus based dpaa driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_register)
 void
@@ -701,20 +667,43 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
+#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
+
 static int
-rte_dpaa_bus_probe(void)
+rte_dpaa_bus_scan(void)
 {
-	int ret = -1;
 	struct rte_dpaa_device *dev;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
 	static int process_once;
 	char *penv;
+	int ret;
+
+	BUS_INIT_FUNC_TRACE();
+
+	if ((access(DPAA_DEV_PATH1, F_OK) != 0) &&
+	    (access(DPAA_DEV_PATH2, F_OK) != 0)) {
+		DPAA_BUS_LOG(DEBUG, "DPAA Bus not present. Skipping.");
+		return 0;
+	}
 
-	/* If DPAA bus is not present nothing needs to be done */
-	if (!rte_dpaa_bus.detected)
+	if (rte_dpaa_bus.detected)
 		return 0;
 
+	rte_dpaa_bus.detected = 1;
+
+	/* create the key, supplying a function that'll be invoked
+	 * when a portal affined thread will be deleted.
+	 */
+	ret = pthread_key_create(&dpaa_portal_key, dpaa_portal_finish);
+	if (ret) {
+		DPAA_BUS_LOG(DEBUG, "Unable to create pthread key. (%d)", ret);
+		dpaa_clean_device_list();
+		return ret;
+	}
+
+	/* SoC version detection and configuration */
 	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
 	if (svr_file) {
 		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
@@ -786,9 +775,19 @@ rte_dpaa_bus_probe(void)
 	/* And initialize the PA->VA translation table */
 	dpaax_iova_table_populate();
 
+	dpaa_bus_global_init = 1;
+	return 0;
+}
+
+static int
+rte_dpaa_bus_probe(void)
+{
+	struct rte_dpaa_device *dev;
+
 	/* For each registered driver, and device, call the driver->probe */
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		struct rte_driver *driver = NULL;
+		int ret;
 
 next_driver:
 		driver = rte_bus_find_driver(&rte_dpaa_bus.bus, driver, &dev->device);
@@ -801,7 +800,6 @@ rte_dpaa_bus_probe(void)
 		else if (ret > 0)
 			goto next_driver;
 	}
-	dpaa_bus_global_init = 1;
 
 	return 0;
 }
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index e6db8f5100..156f4e295f 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -322,7 +322,6 @@ rte_fslmc_scan(void)
 		}
 		return 0;
 	}
-	process_once = 1;
 
 	/* Now we only support single group per process.*/
 	group_name = getenv("DPRC");
@@ -368,6 +367,48 @@ rte_fslmc_scan(void)
 	/* If debugging is enabled, device list is dumped to log output */
 	dump_device_list();
 
+	/* Bus initialization - only if devices were found */
+	if (!TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list)) {
+		static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
+			.name = DPAA2_SEQN_DYNFIELD_NAME,
+			.size = sizeof(dpaa2_seqn_t),
+			.align = alignof(dpaa2_seqn_t),
+		};
+
+		dpaa2_seqn_dynfield_offset =
+			rte_mbuf_dynfield_register(&dpaa2_seqn_dynfield_desc);
+		if (dpaa2_seqn_dynfield_offset < 0) {
+			DPAA2_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
+			return 0;
+		}
+
+		ret = fslmc_vfio_setup_group();
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to setup VFIO %d", ret);
+			return 0;
+		}
+
+		/* Map existing segments as well as, in case of hotpluggable memory,
+		 * install callback handler.
+		 */
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			ret = fslmc_vfio_dmamap();
+			if (ret) {
+				DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)", ret);
+				DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
+				return 0;
+			}
+		}
+
+		ret = fslmc_vfio_process_group();
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
+			return 0;
+		}
+	}
+
+	process_once = 1;
+
 	return 0;
 
 scan_fail_cleanup:
@@ -408,51 +449,8 @@ rte_fslmc_close(void)
 static int
 rte_fslmc_probe(void)
 {
-	int ret = 0;
-
 	struct rte_dpaa2_device *dev;
-
-	static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
-		.name = DPAA2_SEQN_DYNFIELD_NAME,
-		.size = sizeof(dpaa2_seqn_t),
-		.align = alignof(dpaa2_seqn_t),
-	};
-
-	if (TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list))
-		return 0;
-
-	dpaa2_seqn_dynfield_offset =
-		rte_mbuf_dynfield_register(&dpaa2_seqn_dynfield_desc);
-	if (dpaa2_seqn_dynfield_offset < 0) {
-		DPAA2_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
-		return 0;
-	}
-
-	ret = fslmc_vfio_setup_group();
-	if (ret) {
-		DPAA2_BUS_ERR("Unable to setup VFIO %d", ret);
-		return 0;
-	}
-
-	/* Map existing segments as well as, in case of hotpluggable memory,
-	 * install callback handler.
-	 */
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		ret = fslmc_vfio_dmamap();
-		if (ret) {
-			DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)",
-				      ret);
-			/* Not continuing ahead */
-			DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
-			return 0;
-		}
-	}
-
-	ret = fslmc_vfio_process_group();
-	if (ret) {
-		DPAA2_BUS_ERR("Unable to setup devices %d", ret);
-		return 0;
-	}
+	int ret;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		struct rte_driver *driver = NULL;
-- 
2.53.0

