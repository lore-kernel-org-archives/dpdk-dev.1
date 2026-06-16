Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA369CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 487CE406BC;
	Tue, 16 Jun 2026 12:27:42 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 1ACB14067D
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:41 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so31234725e9.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605661; x=1782210461; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt+0G3S7691SOW1IOG+68MMP3GrvCSsAinzdE0NCNlI=;
 b=Jw/X+fmiSblKTpgxSUxy6E50sNm+hz3iWnJprL9KyU6/M/nwYyIo3days82HJW4DWQ
 gmsF/lwi9BGY4VMQI1MaWRsVXeW9ujslvk2Oh2Er2AGTEMJWu4SXgGCnoaMJfMTtKdVK
 uWGPtTBpcacJsrIA2gsrJMMCKiBJk1wx23GD5Cn/77x5KOQOPRiqjJ6DDk4ElCrUgPw/
 ne1NgR4RgQSE4ONHqXVoErPgteZYxtHX+RxDkMGbaqNvv3r5FB0C6Xvk7oCh1XGcHBEc
 YCbAb0onkLsugIPL+knyTPdYX2gnr1RAQZfnjyC7zCNdlZLfJhKMGPTDZh1dW4ShrteN
 3IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605661; x=1782210461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zt+0G3S7691SOW1IOG+68MMP3GrvCSsAinzdE0NCNlI=;
 b=Ng89GkGKYsRcBzuv8reT2opYcytXT2Ye/Cca17vRMUeOzacuYv9tkqqi7Qs5wzoofr
 /U9b56Oypaa5OH/9aejAyF1/cDAOwuYltvhpaTRRJQezl9Zwdvhs93ztD5M58/mf2O0y
 GsBAfjIuDu0Pwj7y82rHhDX8ym6wo7Q8+hhP0dxIYEZqd7U2OrP9+LKziA+FOqOb+lAn
 DFBOiUdUY7QETddWDjIQYX9c53URep23aledXsLBBra4aBEIr2gTPQNxpE4dR0aRo8GC
 Pu+B+TaxcfTsV7xQIsMy4D35fGDa0cbxUdiQ47roW6iZAVIM93GKFyQMt+oVfzvMLCLB
 2a1w==
X-Gm-Message-State: AOJu0YzgSZOIwMNygdQDaX5/rqjzz1QMD+IK2P3Z3QUffWkICPx/lPoB
 oHwT8/QbTC/DGgI7qMcfwOXVBytVR2iEEp0Jw0/GOk6C/jRiQUvChwpmEUD/3Ohz
X-Gm-Gg: Acq92OEu2G/3Eb0iIRTanu+O1rxfoXvIz3MGTNAOTWqIGrD2QIfxW8whcROvNX+Ccfj
 GFWmtQdHkLTDRkiAqrHMKhe88sCiALQVfdBiUH9+m+xulVvzjbIfP2NdlVs6GaOk+u6U1YO1aSV
 HCCtTmhzH7Fcf1ZrevcAOg7fJroZb4jdTDC2zKDdLuL7cnYoJmeaJDLvhFBip2cd9AlRxHQbbaI
 xNIPGapq0ElNw4zMvsHBI6pCgwaSX/dFSKoDKNhZxQIIrtonseKozUg4n0lhx8jMRlTzR6jS/4s
 zRjqJLVjMNxwjNVW8dBmTKkFXW/mNix7GyTd/889BuyflQs0v5d7pcpA/D/GSOvLXK890i2PKkl
 /sO1N0LWB7qVEbjyQwb3i93zBnW54kb5q14GzXPFhDMCDEumNqF2nFpOf2Nk/mj493WSUVXqB3L
 PEJzziRMpwcGtSk6Y2BgNRp5uB3vXQsxJRPym1SwCv6/gSvzLQlDVR
X-Received: by 2002:a05:600c:821a:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-4922faf12edmr42616615e9.13.1781605660503; 
 Tue, 16 Jun 2026 03:27:40 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm258572145e9.0.2026.06.16.03.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:40 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 1/6] bus/fslmc: move DPCON management from event driver to
 bus
Date: Tue, 16 Jun 2026 12:27:21 +0200
Message-ID: <20260616102727.708948-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DPCON allocation helpers (rte_dpaa2_alloc_dpcon_dev /
rte_dpaa2_free_dpcon_dev) lived in the event driver, but a notification
channel is a generic QBMan resource. Move dpaa2_hw_dpcon.c to the fslmc
bus and export the helpers as internal symbols so both the event PMD and
the net driver's rx-queue interrupt path can draw channels from the same
pool. No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/meson.build                    |  1 +
 .../dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c  | 16 +++++++---------
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h          |  8 ++++++++
 drivers/event/dpaa2/dpaa2_eventdev.h             |  5 +++--
 drivers/event/dpaa2/meson.build                  |  1 -
 5 files changed, 19 insertions(+), 12 deletions(-)
 rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (90%)

diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index ceae1c6c11..50d9e91a37 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -22,6 +22,7 @@ sources = files(
         'mc/mc_sys.c',
         'portal/dpaa2_hw_dpbp.c',
         'portal/dpaa2_hw_dpci.c',
+        'portal/dpaa2_hw_dpcon.c',
         'portal/dpaa2_hw_dpio.c',
         'portal/dpaa2_hw_dprc.c',
         'qbman/qbman_portal.c',
diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
similarity index 90%
rename from drivers/event/dpaa2/dpaa2_hw_dpcon.c
rename to drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
index ea5b0d4b85..6fd96ec0b9 100644
--- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
@@ -18,13 +18,12 @@
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
 #include <dev_driver.h>
-#include <ethdev_driver.h>
+#include <eal_export.h>
 
 #include <bus_fslmc_driver.h>
 #include <mc/fsl_dpcon.h>
 #include <portal/dpaa2_hw_pvt.h>
-#include "dpaa2_eventdev.h"
-#include "dpaa2_eventdev_logs.h"
+#include <fslmc_logs.h>
 
 TAILQ_HEAD(dpcon_dev_list, dpaa2_dpcon_dev);
 static struct dpcon_dev_list dpcon_dev_list
@@ -55,8 +54,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	/* Allocate DPAA2 dpcon handle */
 	dpcon_node = rte_malloc(NULL, sizeof(struct dpaa2_dpcon_dev), 0);
 	if (!dpcon_node) {
-		DPAA2_EVENTDEV_ERR(
-				"Memory allocation failed for dpcon device");
+		DPAA2_BUS_ERR("Memory allocation failed for dpcon device");
 		return -1;
 	}
 
@@ -65,8 +63,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	ret = dpcon_open(&dpcon_node->dpcon,
 			 CMD_PRI_LOW, dpcon_id, &dpcon_node->token);
 	if (ret) {
-		DPAA2_EVENTDEV_ERR("Unable to open dpcon device: err(%d)",
-				   ret);
+		DPAA2_BUS_ERR("Unable to open dpcon device: err(%d)", ret);
 		rte_free(dpcon_node);
 		return -1;
 	}
@@ -75,8 +72,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	ret = dpcon_get_attributes(&dpcon_node->dpcon,
 				   CMD_PRI_LOW, dpcon_node->token, &attr);
 	if (ret != 0) {
-		DPAA2_EVENTDEV_ERR("dpcon attribute fetch failed: err(%d)",
-				   ret);
+		DPAA2_BUS_ERR("dpcon attribute fetch failed: err(%d)", ret);
 		rte_free(dpcon_node);
 		return -1;
 	}
@@ -92,6 +88,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpcon_dev)
 struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void)
 {
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
@@ -105,6 +102,7 @@ struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void)
 	return dpcon_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dpcon_dev)
 void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon)
 {
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index e625a5c035..79a2ec41e3 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -274,6 +274,14 @@ struct dpaa2_dpcon_dev {
 	uint8_t channel_index;
 };
 
+/* DPCON channel allocation -- managed by the fslmc bus so both the net
+ * NAPI/DQRR rx path and the event PMD can grab channels.
+ */
+__rte_internal
+struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
+__rte_internal
+void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon);
+
 /* Refer to Table 7-3 in SEC BG */
 #define QBMAN_FLE_WORD4_FMT_SBF 0x0    /* Single buffer frame */
 #define QBMAN_FLE_WORD4_FMT_SGE 0x2 /* Scatter gather frame */
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index bb87bdbab2..f53efce61c 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -85,8 +85,9 @@ struct dpaa2_eventdev {
 	uint32_t event_dev_cfg;
 };
 
-struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
-void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon);
+/* rte_dpaa2_alloc_dpcon_dev()/rte_dpaa2_free_dpcon_dev() now live in the fslmc
+ * bus (portal/dpaa2_hw_pvt.h), which this header's includers already pull in.
+ */
 
 int test_eventdev_dpaa2(void);
 
diff --git a/drivers/event/dpaa2/meson.build b/drivers/event/dpaa2/meson.build
index dd5063af43..62b8507652 100644
--- a/drivers/event/dpaa2/meson.build
+++ b/drivers/event/dpaa2/meson.build
@@ -7,7 +7,6 @@ if not is_linux
 endif
 deps += ['bus_vdev', 'net_dpaa2', 'crypto_dpaa2_sec']
 sources = files(
-        'dpaa2_hw_dpcon.c',
         'dpaa2_eventdev.c',
         'dpaa2_eventdev_selftest.c',
 )
-- 
2.43.0

