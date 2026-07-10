Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F06BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A65A740B97;
	Fri, 10 Jul 2026 23:09:30 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 22D5840B97
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:30 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so9828065e9.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717770; x=1784322570; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FYRooVxBVy6WTVhK5P/aCIHS0ycOpmFlBm783Q4QfDw=;
 b=IjZt0SWX350pA39j1NVlt8758LLblLzN1EGgTFYXdi3AIM28X9xgnDkzeK739u7gYY
 HXyCSiHdIQ83D249VNdKJlNc3sV4PrUu/Mn3nvoyhjzeaP0i0OKK7C3iEmG2iLrCcRns
 HK4l8JCzhiI7LrsyUiAbKnxZWX3euM4Zo5r5DKVUvR8iZ2wT33FAolAqsZqCl5+JkR5o
 yXXPWGeuJJgjjRyFeI7h2Bq0eLNfJSEypBi6GYmV0FU9N2Kw2EP4fTVkAkbYYzDOZ10d
 8+1xNX1axdZkXm/FsS12xqO+S5XBAocT3qvkf3esDeRM+RsoYUiIAIwtB0rm1dMRCKK1
 3h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717770; x=1784322570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FYRooVxBVy6WTVhK5P/aCIHS0ycOpmFlBm783Q4QfDw=;
 b=BjtV2f6r0TIf5lA8BIyVWKj36za/aO5yXj+qD5JECko4dlcgt3354y2D+ChwTgYohL
 aMSELW8RVe4bmEWnOAXK1F8yQ3Mf5R2O8IetBCLFp+LL1TJb+2hpzBTOv7CqybDn6YeU
 yQqVNCM0lhJsEkBZkcFBjbpNxTt2E6X1NoynxzNhNg8/hdLtdECU79qweGNfhdD+wqu3
 /EjV2ZVhPpqYTW30knDJOL5qwP1XsAjluZ5MtDva0uVCchDyr/FOCvXs2WiyGedP1jfa
 a+krDv2Ms6lG7I4lul6WZkx0Xr7LzPN44kVpHvOQldl41DYro9oZi4OTrgzaKVwMsanm
 rkYg==
X-Gm-Message-State: AOJu0YzU5HI/seZnJjlWAgBlE80i8IeHyVZRt7lCmJhZPtOsYRjPjh+3
 AisOfhukNzRg58QDLleXbqyNc1aW8/PMPa6Ds2NH7NbML7W8ql7ygXmZ6B7q3wT7
X-Gm-Gg: AfdE7cm2wA+4sKocyMGRJp5rYQtimGIl+ks2fjbPz/29NPWGVrVvYO7+6hW/IHGEg8h
 lpP97sxyi8vY1hIOYGxs+24b3LTtbc0lw31nWUfz8jhRvXVvId/e+m6NZa1aAq2OZe5ws6e/zff
 0s2QJfot/bdkXZ5+jdASOvP2xSCQw4rTTnKIDBw7ppYfaKjsJ5bayeVUtMs0dnuMxHGdIsk4pOL
 YwGLmnirF1tPGcFcIvnlg/BTD8ab3H7M3TK9pQiPo1U003vA6hcXuJgIr5omm2PGjCeZ/RbEw1P
 8dCAKCCAQqyhkUwJOdEaTDSnwGqwTzyeTI9v2HRvjF6FCmZ43ArUadw8bh+D3niW/AC56Se3cym
 PXw3rIAnoWsOTpRz+O9sct26qk6DoYEe/q57Osl2bqaPYvUgjujrY7WtnnV6qjR4cxNrKbIfUEK
 OBlHwAbQ==
X-Received: by 2002:a05:600d:6454:10b0:493:f2b3:9cf9 with SMTP id
 5b1f17b1804b1-493f8833b5fmr2683595e9.36.1783717769607; 
 Fri, 10 Jul 2026 14:09:29 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47df6a31dd5sm17507106f8f.16.2026.07.10.14.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:28 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 2/6] bus/fslmc: move DPCON management from event driver to
 bus
Date: Fri, 10 Jul 2026 23:09:16 +0200
Message-ID: <20260710210920.2402309-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710210920.2402309-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
 <20260710210920.2402309-1-maxime@leroys.fr>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/meson.build                    |  1 +
 .../dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c  | 16 +++++++---------
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h          |  6 ++++++
 drivers/event/dpaa2/dpaa2_eventdev.h             |  3 ---
 drivers/event/dpaa2/meson.build                  |  1 -
 5 files changed, 14 insertions(+), 13 deletions(-)
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
index e625a5c035..2a6d970101 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -274,6 +274,12 @@ struct dpaa2_dpcon_dev {
 	uint8_t channel_index;
 };
 
+/* DPCON channel pool, shared by the net rx-interrupt path and the event PMD */
+__rte_internal
+struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
+__rte_internal
+void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon);
+
 /* Refer to Table 7-3 in SEC BG */
 #define QBMAN_FLE_WORD4_FMT_SBF 0x0    /* Single buffer frame */
 #define QBMAN_FLE_WORD4_FMT_SGE 0x2 /* Scatter gather frame */
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index bb87bdbab2..3883a26c91 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -85,9 +85,6 @@ struct dpaa2_eventdev {
 	uint32_t event_dev_cfg;
 };
 
-struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
-void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon);
-
 int test_eventdev_dpaa2(void);
 
 #endif /* __DPAA2_EVENTDEV_H__ */
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

