Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8BCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9D64331C;
	Thu, 11 Jun 2026 17:50:18 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8228B43310
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:17 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so45617455e9.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193017; x=1781797817; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt+0G3S7691SOW1IOG+68MMP3GrvCSsAinzdE0NCNlI=;
 b=LQN/SsYUuOE3UFLLydZmtInr+LOma+aOUR3ID58MDU3EhnFnaa6WggdUdgNWywkkAh
 8urGzdQv1OQkMi3SuuKdqmD7/kkzhrR+gKGRSrBEzZaR+LHFE4ud9B8eYRt2nbiBGT3l
 GFQL0+8zrPbnKkJZVEevvLhpjHagXsAKfwYcqjqaJQykkkNLsfHuH2DSNO0r3koo7qWH
 UGU+v2eiYZN/c+elowSJTEG06s+HPWPH1M0cokzDj5U8xq7G8VatSrZIKQVx3pj3vInO
 pzAi3rrgzWW3yUg6bPoFIkMg2/2AjfewihCCfksIa2Q0LomHX4ZOLO/mP5I7gBWIQqtd
 xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193017; x=1781797817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zt+0G3S7691SOW1IOG+68MMP3GrvCSsAinzdE0NCNlI=;
 b=DXxHuO9j2bwCGpM4ZEIY/fg3vBbWFMaxjd3dtCj9VeoXj9v1fh/uyEKq6lgoE3h8wB
 BIqz99hynmmBL9Ml3Dp8F/0srbcXVv0aK3JN6dLAPAQ70Xr5abyhugpNSpCdcD926jbk
 Ou9fYCE6u8elOM4WruBcchDD3zAxjXQqK64HdBB1ZXq/WWVChIrtwTU1ELQv6w3fjd2A
 X4tSVWqSoTlq4xhvCmgwsGtOlz5Owr1JouEdltt4ArC32ZI4TaFbuY105w3Ip2Wnj7lI
 hNyy5KWXwhI0EUBK+o4MSmN47dsnrJp5YTJwwKiKhe/JRHv6gPRG17kOZYP+Gv1RjDqf
 6xSQ==
X-Gm-Message-State: AOJu0YzVzvBEVvIgYJG1u98VsdM4cu4NZookujUUq2GoiC3bX07idIOS
 VapFINJHLI3Z9zyUkfM8sFY4rUahclvZyCSJx1liI3CAFr4XrGGHS7tH2zQ/DA==
X-Gm-Gg: Acq92OGh29TEmOakbailA0QlBzTijVn7eB2ZwMUU9fTQr4ObcTTSOf6JfIjzHqR65Rg
 VS2p0GInFoejs6qVEDWJ3VZ1bkdtWsN8LYhag0O6aQ4NVk9wIDytk+wsEZOLanmhH7jK5HF984q
 Y7JseKW8wMI9gbpKVkjRUrs4fqxV93fgHHVZeJmV6vreh3T3HoCVCYsl29YvyW/+BuMpDsWMGhf
 6d8cZv6IjhyXu8vXNhJLckm0ZvXWcG3dDqipBUyevbkwDk9vCETjB6NvYKhab1Q/c58RL7fJUsB
 cu5A7vm4kx2mAs0vVlirhO42l88A0Egfqs3MzqhIKo9crO6/NunMpYyL7kTPkVPvnZyGh1ZdqW0
 Nhr9N32L/dG1PAM5aeWnhYhj81WhPQgol8oiAAt6vmFsqyXfJu8tM2XFBqfkc3YE5451qk6nm4F
 DGkMAquLzA8onJATsZma/y20aURidUeQa2DN369zPxVqNEtRjW26opitk+Iht7zQc=
X-Received: by 2002:a05:600c:c093:b0:490:b724:507d with SMTP id
 5b1f17b1804b1-490e55e2208mr46654575e9.11.1781193016787; 
 Thu, 11 Jun 2026 08:50:16 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52a553csm64402205e9.2.2026.06.11.08.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:16 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 3/9] bus/fslmc: move DPCON management from event driver to bus
Date: Thu, 11 Jun 2026 17:49:18 +0200
Message-ID: <20260611154926.392670-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

