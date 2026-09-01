Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859BC61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D491C40615;
	Tue,  1 Sep 2026 22:33:24 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 341F540ECF
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:23 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8558c0b26a8so229222b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294802;
 x=1788899602; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r8j9VbmEG2m8nAOljbN9eEEoVMtO7ZbNrcLBrmU0sfc=;
 b=yzj5NPzIuvYQmDR9MZZqG33/q43P7ep8FikBtPrDT0r1Mc/2OKQN+5Pr/JXrBudo7V
 317qm+JsUZ/PF2LvUJtSXpPfQpz8k742oF3t53jm8EDONeff1M8f19in1/lrNQXlFYA4
 Ml9ymdv7hODGdyI4iONgwvn8BreugjFFV0GkHYmUSIRCuOQC46qoWBul9kD0byIJBsmO
 QyW4SJntPOQdzxdtx3pYiWQ+bZW/YpV5Uy8TmbX+AqUNv16RhAZGmhfECULuh74XN62V
 QBEt2keY4bzns6EkmlN1d+Xryi2dhDlcL/YICXd8tptrTNpWGpBKIlLQgDBWiea1gU8Y
 v64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294802; x=1788899602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r8j9VbmEG2m8nAOljbN9eEEoVMtO7ZbNrcLBrmU0sfc=;
 b=rC5AZdCMwWJKI+Lpvn0cKSoITJcYg1pGbxmGlwfTXfyZLAidt3ux8KKiehZSpemb0z
 4xIah4NSG4WAlCDsy3G3yog+BxgOgKdqwSBaDSkf2nopqxP61qvOz0VsZAfQ+aES89Fa
 L4un0uFfDoxw74IZyQMussb+ObsdJupUY2y/CDD3GI8xbRgIg6LyAWitiVGMqX31lsHC
 29YYnaVTZ87iAvMSntOsSMy8r6vMdCh97Gl9wiTm3e3a7+3LBAhgH5rl2sxXjq7LNrP7
 9lGBgiBMoy3R3dnCM1f/7uXG9fQsIYqjhu4ua7L0TRQ+pdq1jptp2sIiHXtS1LWGDX4m
 lRZw==
X-Gm-Message-State: AFuF++lOMQL8kKY6f/WpvL3qSjREQ0V5/HczAr1T0jN3HcGt86bxMvBd
 lKmkj4IPLDPXLqIgLjMMS3Zvj0hOkomW2vc0JqtvojSnweQO+cp4RneMk04uMQIwhLI3KvzofKZ
 wyZTZ
X-Gm-Gg: AR+sD10aF/lDjUG5TqqQ64c2Rr7r8lZ0jrJgU1dISk8Bk77AcA3K6bGCf5BohEmOEQn
 yzSeSgO2L8Kjn3BRxRoIIk8zpVzFGwnPci6+8MsR5/3G5SmJGCCs3DahSUR2vhtjv6MtoBXP0qo
 b1/pNZ8IcLdNGHBpxwOBWBUNrataXdr2nwA5sD0HeGER5JxduH9b2BZEz6l+LX72HZk6Kstu/V3
 d6a6JWDSTA32s4pP2eP25fkz8273FfMt29Brd3NlSmZ6IAHLw+vYUzl7QayI9VfOno8MqPnsxvh
 iFknT1eanSQ7CSWh9sU0YnRCl7sCKPa6ujX1SPCtqFXQndy6+SCxut+gyri4BUIy/tHi9BjgVBm
 NWgrbO1+TW3AE7hS4iPepfW9k+nVFFT39iR4xwi5B98DkCXBm0vrxepBwmfzdVhlY6y/MFL4NyC
 Nu/3gOc9BXK/alzAnmZh+rpdtWoIlK1jWdvF5fW9LGRLvLg91zBNc4CQmJsDOzWgAyGAT7QjBfW
 UwhtuC0awZIoGijwROLzXBW06E=
X-Received: by 2002:a05:6a00:8005:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-85ed23e979emr739545b3a.9.1788294802167; 
 Tue, 01 Sep 2026 13:33:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 14/22] ethdev: promote congestion management API to stable
Date: Tue,  1 Sep 2026 13:23:13 -0700
Message-ID: <20260901203217.1485915-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

The congestion management interface was added in v22.11 and its four
functions have not changed since. With this rte_ethdev_cman.c has no
experimental symbol left.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/ethdev/rte_ethdev.h                | 22 ----------------------
 lib/ethdev/rte_ethdev_cman.c           |  8 ++++----
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6649a847ff..477139a2a1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -127,6 +127,9 @@ API Changes
   * remaining flow helpers: ``rte_flow_actions_update``, ``rte_flow_restore_info_dynflag``,
     ``rte_flow_calc_table_hash``, ``rte_flow_group_set_miss_actions``,
     and ``rte_flow_calc_encap_hash``
+  * congestion management:
+    ``rte_eth_cman_config_init``, ``rte_eth_cman_config_set``,
+    ``rte_eth_cman_config_get`` and ``rte_eth_cman_info_get``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 2a694130ea..2b40340004 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6040,9 +6040,6 @@ enum rte_eth_cman_obj {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
- *
  * A structure used to retrieve information of ethdev congestion management.
  */
 struct rte_eth_cman_info {
@@ -6064,9 +6061,6 @@ struct rte_eth_cman_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
- *
  * A structure used to configure the ethdev congestion management.
  */
 struct rte_eth_cman_config {
@@ -6108,9 +6102,6 @@ struct rte_eth_cman_config {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve the information for ethdev congestion management
  *
  * @param port_id
@@ -6124,13 +6115,9 @@ struct rte_eth_cman_config {
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Initialize the ethdev congestion management configuration structure with default values.
  *
  * @param port_id
@@ -6144,13 +6131,9 @@ int rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info);
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Configure ethdev congestion management
  *
  * @param port_id
@@ -6163,13 +6146,9 @@ int rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *confi
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve the applied ethdev congestion management parameters for the given port.
  *
  * @param port_id
@@ -6186,7 +6165,6 @@ int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config);
 
 #ifdef __cplusplus
diff --git a/lib/ethdev/rte_ethdev_cman.c b/lib/ethdev/rte_ethdev_cman.c
index a8460e6977..3a62432bf0 100644
--- a/lib/ethdev/rte_ethdev_cman.c
+++ b/lib/ethdev/rte_ethdev_cman.c
@@ -12,7 +12,7 @@
 #include "ethdev_trace.h"
 
 /* Get congestion management information for a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_info_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_info_get)
 int
 rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 {
@@ -41,7 +41,7 @@ rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 }
 
 /* Initialize congestion management structure with default values */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_init, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_init)
 int
 rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 {
@@ -70,7 +70,7 @@ rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 }
 
 /* Configure congestion management on a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_set, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_set)
 int
 rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config)
 {
@@ -98,7 +98,7 @@ rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *conf
 }
 
 /* Retrieve congestion management configuration of a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_get)
 int
 rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config)
 {
-- 
2.53.0

