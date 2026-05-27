Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF5CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 07:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543C44067C;
	Wed, 27 May 2026 09:59:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB66940695
 for <dev@dpdk.org>; Wed, 27 May 2026 09:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779868741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xD4FIW3KA1cBx6sm7N5T08hQ6TebdicCliUVnII9H+w=;
 b=f7YDReFhBWD8S2QN7fDHzOtwP/Z3Kz3ZIxp+p1g6F8os3ZJQJJSbfUSAfhZfjwbU2mU/PB
 xgsBatU7uFKcj3WnRASVSewXWk3mAYmWOZxGyBgUcwrwhX3tCtPCBxtJecnWmN8IKim9mw
 JoQY8Js7b3rT3xpWm+Gwq0m9qIc/irs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-Uj9IMc98Mg2wOfAxHT1AnQ-1; Wed,
 27 May 2026 03:58:57 -0400
X-MC-Unique: Uj9IMc98Mg2wOfAxHT1AnQ-1
X-Mimecast-MFC-AGG-ID: Uj9IMc98Mg2wOfAxHT1AnQ_1779868736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8259B195609F; Wed, 27 May 2026 07:58:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49C22404; Wed, 27 May 2026 07:58:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 16/25] drivers/bus: initialize NXP bus specifics in scan
Date: Wed, 27 May 2026 09:56:40 +0200
Message-ID: <20260527075654.3780732-17-david.marchand@redhat.com>
In-Reply-To: <20260527075654.3780732-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nEIc3jfB3S1BGe_pINlz2Pg_bTTAhtjFE1iPyplTRzU_1779868736
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

