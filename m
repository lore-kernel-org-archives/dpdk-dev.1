Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A6C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D7924069D;
	Tue, 30 Jun 2026 16:43:42 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 2A57840691
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:40 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so4077033f8f.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830620; x=1783435420; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OxGxkUhUK6soL8hjFS0Q3fq3C0k8F9ZXoRiLgsxEJ0=;
 b=qDEInHZJxA4OPz5U/DocloKwsOa18eu/J/K2A3PFZK4pl3cIO5UG1Rsrb4I/PkoR49
 ZyYD+ltvEOyydKAFHJwbyAT6xMeITr8SFfiD1lQidvbHhgXQUADkMIGdxuT20FAwSJld
 Tqp/OZKrpzNWPs5qfsfvxO2qRcnFCef8czDQrRB3uYky2fo/zqHL5wYSHc03ANHqI+7D
 Q/h3DEvFS2dKSos/FvthqzWCrDPdu6a90rQhgStvY5ejBbKGPBi+kMRY8J2s06qi3A/y
 gOiAIJW+cj6ZdWEthIPXmwAg14/l7HUGdFleN6mRz5zw82yHiGd+jUeUE/NqIohX+pSY
 rSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830620; x=1783435420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7OxGxkUhUK6soL8hjFS0Q3fq3C0k8F9ZXoRiLgsxEJ0=;
 b=KrIifbE5crXXjjRRP4GWQY7KnG4b7Kq2cD2k/UaBrRBXEz1jK0q9ei9rksICnkbRRT
 VKrOCO52ZXrPrBZzn0Bfe5DfegYd1WcZIPxP+DPwRZ0K+0Jr4m7iiYzsZN2ulXsv8n8N
 sY7oGP+az4hga4emikf2Bsr1GN7ZgnKNbmHid5z8DoXU4aaItCfvDE6NBxEBI3bf2j0g
 J8A0PuSvAyOWD4a7hbjRQlQglQj9L0L+BlKFg4j/qJM9rDylhZ8oiCtI1VWH3YkJhv3S
 85mepIQJ2H7H6tCyb2OADz0xdv/RgtYQWcwEh3wbynnsSBtizgQS+4VX6yPGvb/2tfY5
 uCmQ==
X-Gm-Message-State: AOJu0Yxnt8mDHINeu+hbNfHL+3tbHfMjD+ktC6uabHRuzarAHTWzAYnI
 j8CiWyPAeFXbMnb5Dhrp3SM2CJQqx+DWWtZgY5UESJQ5RMowLqkkURHzcrhViIDY
X-Gm-Gg: AfdE7clyiyljPjgTmr1vzBSzHqOVduOkDJNFs6SdyEi3Iq5wlXBd1k4e7tZj2SW6vY+
 w/4Q21XQHSCXKNEtemM4WrVBlkJdTnJVD7PnMmmsj3RAOrzrxTUlwCX6axa2mDRIE/7On94cdJr
 stzeZX8UQohNo7nkpFpVeqUJDNstM4dHI4jYQW1cYAtlZAdVy7Fba25IxXOTHESAlVsDElGYDxm
 5PXiBOUPD+jEeYYbA4t7emD5MQGjYOSFm7G5ZzikOETz7D7ueHMsB8y3b/Y2girXvHemth5piKJ
 TWD5frwIvBZf6MaSehsk+070liOxvhBzlv+TTAU/LQ9aPk0NC0zPzK1Qzl/CyU2uUcG5zgdU+AH
 HQS8ZWprkrn4GpAdjvD7ibl+uLRpzl3jDOB5kPXO4/c01kkxz4x+B352dnwPIOmuYPcXyk1ojsb
 ldm+il/3w1L9vDpvNy/DWzH5XZHPFx2eOwG6lA5z9o3Vgb
X-Received: by 2002:a05:600c:83ce:b0:493:aa0a:4a00 with SMTP id
 5b1f17b1804b1-493b82ae831mr56304185e9.17.1782830619658; 
 Tue, 30 Jun 2026 07:43:39 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756778fac3sm7742880f8f.32.2026.06.30.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:39 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 2/6] bus/fslmc: move DPCON management from event driver to
 bus
Date: Tue, 30 Jun 2026 16:43:25 +0200
Message-ID: <20260630144329.457643-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
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
index f65a63a786..6bcd6b9e6d 100644
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

