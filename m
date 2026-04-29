Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E5FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBE7240A71;
	Wed, 29 Apr 2026 13:47:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0C1B940679
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PgmFHO1viAEVBH3lGc68bSKNQbuw+JFFXBMJBY6JBo=;
 b=asIusLUQyENZS+JJPAbjQ5lFPLPcHdZu1iSYTB57XUlHIW/FxozZt6DoDN492MLTgr3JC5
 Cy+LrE34pZ6VvSlQ1S1QRPQ9SJYOCG2nD8IDYOBboFWjEDi9jKSg+EQRDy8oxMAVFhHXZ4
 X9kkof9uSKuFOTyKtV+zEvU1wMBG084=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-xD_Dq20QMCGftyO-MG1k4g-1; Wed,
 29 Apr 2026 07:47:45 -0400
X-MC-Unique: xD_Dq20QMCGftyO-MG1k4g-1
X-Mimecast-MFC-AGG-ID: xD_Dq20QMCGftyO-MG1k4g_1777463264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D734C1800576; Wed, 29 Apr 2026 11:47:43 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C11EB19560AB; Wed, 29 Apr 2026 11:47:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 20/23] drivers/bus: separate specific bus metadata for NXP
 drivers
Date: Wed, 29 Apr 2026 13:44:53 +0200
Message-ID: <20260429114503.932575-21-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QE9VEGhUEf5ydrbGbbnMk8IqZRYSLaIZMEvcV9Y7alI_1777463264
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

As a preparation for the next commit, split the specific bus types and
move specific fields to a private structure/singleton variable.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 55 ++++++++++++++++++++---------------
 drivers/bus/fslmc/fslmc_bus.c |  6 ++--
 drivers/bus/fslmc/private.h   |  2 --
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ade093cd13..08c1607647 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -59,6 +59,9 @@
 
 struct rte_dpaa_bus {
 	struct rte_bus bus;
+};
+
+struct rte_dpaa_bus_private {
 	int device_count;
 	int detected;
 	uint32_t svr_ver;
@@ -67,6 +70,7 @@ struct rte_dpaa_bus {
 };
 
 static struct rte_dpaa_bus rte_dpaa_bus;
+static struct rte_dpaa_bus_private dpaa_bus;
 static struct netcfg_info *dpaa_netcfg;
 
 /* define a variable to hold the portal_key, once created.*/
@@ -87,7 +91,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_eth_port_cfg)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_soc_ver)
 uint32_t dpaa_soc_ver(void)
 {
-	return rte_dpaa_bus.svr_ver;
+	return dpaa_bus.svr_ver;
 }
 
 struct fm_eth_port_cfg *
@@ -103,11 +107,11 @@ dpaa_push_queue_num_update(void)
 	int ret = false;
 	uint16_t current, new_val;
 
-	current = rte_atomic_load_explicit(&rte_dpaa_bus.push_rxq_num,
+	current = rte_atomic_load_explicit(&dpaa_bus.push_rxq_num,
 					   rte_memory_order_acquire);
-	if (current < rte_dpaa_bus.max_push_rxq_num) {
+	if (current < dpaa_bus.max_push_rxq_num) {
 		new_val = current + 1;
-		if (rte_atomic_compare_exchange_strong_explicit(&rte_dpaa_bus.push_rxq_num,
+		if (rte_atomic_compare_exchange_strong_explicit(&dpaa_bus.push_rxq_num,
 				&current, new_val,
 				rte_memory_order_release,
 				rte_memory_order_acquire))
@@ -121,7 +125,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa_push_queue_max_num)
 uint16_t
 dpaa_push_queue_max_num(void)
 {
-	return rte_dpaa_bus.max_push_rxq_num;
+	return dpaa_bus.max_push_rxq_num;
 }
 
 static int
@@ -204,7 +208,7 @@ dpaa_create_device_list(void)
 	struct fm_eth_port_cfg *cfg;
 	struct fman_if *fman_intf;
 
-	rte_dpaa_bus.device_count = 0;
+	dpaa_bus.device_count = 0;
 
 	/* Creating Ethernet Devices */
 	for (i = 0; dpaa_netcfg && (i < dpaa_netcfg->num_ethports); i++) {
@@ -256,7 +260,7 @@ dpaa_create_device_list(void)
 		dpaa_add_to_device_list(dev);
 	}
 
-	rte_dpaa_bus.device_count += i;
+	dpaa_bus.device_count += i;
 
 	/* Unlike case of ETH, RTE_LIBRTE_DPAA_MAX_CRYPTODEV SEC devices are
 	 * constantly created only if "sec" property is found in the device
@@ -289,7 +293,7 @@ dpaa_create_device_list(void)
 		}
 
 		dev->device_type = FSL_DPAA_CRYPTO;
-		dev->id.dev_id = rte_dpaa_bus.device_count + i;
+		dev->id.dev_id = dpaa_bus.device_count + i;
 
 		/* Even though RTE_CRYPTODEV_NAME_MAX_LEN is valid length of
 		 * crypto PMD, using RTE_ETH_NAME_MAX_LEN as that is the size
@@ -306,7 +310,7 @@ dpaa_create_device_list(void)
 		dpaa_add_to_device_list(dev);
 	}
 
-	rte_dpaa_bus.device_count += i;
+	dpaa_bus.device_count += i;
 
 qdma_dpaa:
 	/* Creating QDMA Device */
@@ -319,7 +323,7 @@ dpaa_create_device_list(void)
 		}
 
 		dev->device_type = FSL_DPAA_QDMA;
-		dev->id.dev_id = rte_dpaa_bus.device_count + i;
+		dev->id.dev_id = dpaa_bus.device_count + i;
 
 		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
 		sprintf(dev->name, "dpaa_qdma-%d", i+1);
@@ -331,7 +335,7 @@ dpaa_create_device_list(void)
 
 		dpaa_add_to_device_list(dev);
 	}
-	rte_dpaa_bus.device_count += i;
+	dpaa_bus.device_count += i;
 
 	return 0;
 
@@ -688,10 +692,10 @@ rte_dpaa_bus_scan(void)
 		return 0;
 	}
 
-	if (rte_dpaa_bus.detected)
+	if (dpaa_bus.detected)
 		return 0;
 
-	rte_dpaa_bus.detected = 1;
+	dpaa_bus.detected = 1;
 
 	/* create the key, supplying a function that'll be invoked
 	 * when a portal affined thread will be deleted.
@@ -707,34 +711,34 @@ rte_dpaa_bus_scan(void)
 	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
 	if (svr_file) {
 		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
-			rte_dpaa_bus.svr_ver = svr_ver & DPAA_SVR_MASK;
+			dpaa_bus.svr_ver = svr_ver & DPAA_SVR_MASK;
 		else
-			rte_dpaa_bus.svr_ver = 0;
+			dpaa_bus.svr_ver = 0;
 		fclose(svr_file);
 	} else {
-		rte_dpaa_bus.svr_ver = 0;
+		dpaa_bus.svr_ver = 0;
 	}
-	if (rte_dpaa_bus.svr_ver == SVR_LS1046A_FAMILY) {
+	if (dpaa_bus.svr_ver == SVR_LS1046A_FAMILY) {
 		DPAA_BUS_LOG(INFO, "This is LS1046A family SoC.");
-	} else if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+	} else if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
 		DPAA_BUS_LOG(INFO, "This is LS1043A family SoC.");
 	} else {
 		DPAA_BUS_LOG(WARNING,
 			"This is Unknown(%08x) DPAA1 family SoC.",
-			rte_dpaa_bus.svr_ver);
+			dpaa_bus.svr_ver);
 	}
 
 	/* Disabling the default push mode for LS1043A */
-	if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
-		rte_dpaa_bus.max_push_rxq_num = 0;
+	if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+		dpaa_bus.max_push_rxq_num = 0;
 		return 0;
 	}
 
 	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
 	if (penv)
-		rte_dpaa_bus.max_push_rxq_num = atoi(penv);
-	if (rte_dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
-		rte_dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
+		dpaa_bus.max_push_rxq_num = atoi(penv);
+	if (dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
+		dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
 
 	/* Device list creation is only done once */
 	if (!process_once) {
@@ -868,6 +872,9 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.dev_iterate = rte_bus_generic_dev_iterate,
 		.cleanup = dpaa_bus_cleanup,
 	},
+};
+
+static struct rte_dpaa_bus_private dpaa_bus = {
 	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
 	.device_count = 0,
 };
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d855d6b36b..821fe63955 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -28,6 +28,7 @@
 #define VFIO_IOMMU_GROUP_PATH "/sys/kernel/iommu_groups"
 
 struct rte_fslmc_bus rte_fslmc_bus;
+static int fslmc_bus_device_count[DPAA2_DEVTYPE_MAX];
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
@@ -39,7 +40,7 @@ rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type)
 {
 	if (device_type >= DPAA2_DEVTYPE_MAX)
 		return 0;
-	return rte_fslmc_bus.device_count[device_type];
+	return fslmc_bus_device_count[device_type];
 }
 
 static void
@@ -200,7 +201,7 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus.bus, dev_name);
 
 	/* Update the device found into the device_count table */
-	rte_fslmc_bus.device_count[dev->dev_type]++;
+	fslmc_bus_device_count[dev->dev_type]++;
 
 	/* Add device in the fslmc device list */
 	insert_in_device_list(dev);
@@ -559,7 +560,6 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.unplug = fslmc_bus_unplug,
 		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
-	.device_count = {0},
 };
 
 RTE_REGISTER_BUS(fslmc, rte_fslmc_bus.bus);
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 2fe592f24d..a0dda4f9d6 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -14,8 +14,6 @@
  */
 struct rte_fslmc_bus {
 	struct rte_bus bus;     /**< Generic Bus object */
-	int device_count[DPAA2_DEVTYPE_MAX];
-				/**< Count of all devices scanned */
 };
 
 extern struct rte_fslmc_bus rte_fslmc_bus;
-- 
2.53.0

