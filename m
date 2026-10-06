Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A4CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 23:32:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B64740268;
	Wed,  7 Oct 2026 01:32:52 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id B32B440151
 for <dev@dpdk.org>; Wed,  7 Oct 2026 01:32:50 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e30b9f1441so34223935ad.3
 for <dev@dpdk.org>; Tue, 06 Oct 2026 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791329569;
 x=1791934369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=17fPay2LuGx62aIgtu6BVR8Kpj32927dIlU05YRnFTY=;
 b=r3uZaM1AOLujobu+pLQ7pQSIN8fqZwjnd+eFbYSQZZ+WXeBR1JJjG47cTt2dWI6Thc
 a9M6UWG8Snw1qcVpnRmsxVncXUbezdpctYJ5HGPYQn0OqXdbIDW659Ak1LbyFURS+ENt
 pvB0AJ9TeWzRQ4Pad0oq4PZIFPkI3mTBDHVA5Si/uM8/fYwuVAzQgfV9VyyPX5l3vUMP
 /JEE4sUN2O1DLYG65fDPikNLyrVsGGtM5ghorOmRhxkzzeHx4+sCx847JjH4ExHzm0ES
 zh3XE913ml8msz5qcKupSzl0QYmEisfyanfy8fk9rh+wWGYSyY8Aq3PuOsYBqNa2IQC3
 2YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791329569; x=1791934369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=17fPay2LuGx62aIgtu6BVR8Kpj32927dIlU05YRnFTY=;
 b=WFdp3S0VuproHjTrz7aojpqL2Qtf5cFBtE5IWbib9R0cdvBCSbL1k085CZcml7gpL2
 k1VGVpQVbzcIB7mJSb5dlAJXU65Ra/MfVLC1JRXy4szhUYvYdJY3XAKLQBX9dH1caW+J
 9ymQn9OpdPCXlbzUmgTZ81Gu9H4JU/k+aaKhqnI4vtEYQzz1e07cdVunGvxQ6SRWYjo+
 b7e4dwJuFdOi/MUvyeTMI1AzVgAi6X/eQ2Q27LScKps0n0S6N5MVjIIOgDN+4Px4vq0a
 xlNKRodn0OPXwu4SvXv9I89yvwca2/iwVicjmD8omrlM7+ysMP5S50nYN5ai3Tn71fVu
 PLtw==
X-Gm-Message-State: AFq9FYKO/5yzyKbRX4jw9/CRUsfNk+T6dUkblyYmRiZrt08zZtm1UmA8
 eNj184Tpq0b2kZI9rCtp75sOspZgb2Tuwnm8Hm5y0NbLV1itQHh25Xeto8fIpgYX/AQO+BhrdRx
 /X9Ulmm4=
X-Gm-Gg: AYBFou0Txy2dNpG9H2ptMqYsJn6aj2YwGD8jwhEIkcFJfj5NfxzF4wDwy/2swflUNA1
 oS6+O7dysL2k9hMbJL8VtsokuATbw6BonndSaCYr9E0tBqYQ8j121No48RjY/YY1IqrNKGWq+7g
 Ijldm1u9SMJdVBBYTnQA62Yk3n2WBd2Jt0OSv0FXVmaA6FipFyNoJcCgRnVh1RYQefIMM2GMn6g
 WQVLa7boCXEqhQGtsDbs8wcsrNdMr7wzAiIZaaPX2QFTLEWCjy8bsNPSrtjZYC5PyL8XT36/c+o
 04LuwD+ovA5dkrq2wETCPz3xw83VWSKeDkHrYWPwJujvSa2dm5xyo1bAWipkKG6mDxxct5aMf8j
 bzkkz3U53Ohn+WII3rT5G/Rw1Mu97RcBAJti2jHxT3fE8OpczeGy+ciCX2G4Za4FKtL71oWv/MX
 vH9Vu+scgAaK9pv+HXYvTS84dnPuSLsaW/s+dxLB8BU2KQcUYchKHwqnNVFGeGiA8qXk2MX7s7Q
 intuwDo2IvSs51jjoqGgD7aXricAaJMzpp2WQ==
X-Received: by 2002:a17:903:906:b0:2df:a314:1beb with SMTP id
 d9443c01a7336-2e5ffa13f7amr7127205ad.1.1791329569346; 
 Tue, 06 Oct 2026 16:32:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e604b63d9bsm2087155ad.84.2026.10.06.16.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 16:32:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] metrics: remove experimental telemetry helper API
Date: Tue,  6 Oct 2026 16:31:44 -0700
Message-ID: <20261006233144.644562-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

While investigating experimental functions leftover in DPDK.

The rte_metrics_tel_* functions are dead code. Nothing in the tree
calls them from outside the metrics library itself; they were left
exported by the telemetry library rewrite in 20.05.

Stop exporting them. Delete the header, move the types into the C file
and make the helpers static. The file now only builds when jansson is
present, so the stub branch goes away too.

The legacy commands ports_all_stat_values, global_stat_values and
ports_stats_values_by_name are unchanged.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   9 +++
 lib/metrics/meson.build                |   6 +-
 lib/metrics/rte_metrics_telemetry.c    | 106 ++++++-------------------
 lib/metrics/rte_metrics_telemetry.h    |  71 -----------------
 4 files changed, 39 insertions(+), 153 deletions(-)
 delete mode 100644 lib/metrics/rte_metrics_telemetry.h

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 934efaaf93..254e9ada64 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -195,6 +195,15 @@ Removed Items
   which were based on the legacy pipeline library API.
   The ``pipeline`` example application covers the SWX pipeline API.
 
+* metrics: Removed the experimental telemetry helper API
+  and the ``rte_metrics_telemetry.h`` header:
+  ``rte_metrics_tel_reg_all_ethdev``, ``rte_metrics_tel_encode_json_format``,
+  ``rte_metrics_tel_get_global_stats``, ``rte_metrics_tel_get_port_stats_ids``,
+  ``rte_metrics_tel_get_ports_stats_json`` and ``rte_metrics_tel_extract_data``.
+  These had no users and exposed jansson types in the public header.
+  The legacy telemetry commands ``ports_all_stat_values``,
+  ``global_stat_values`` and ``ports_stats_values_by_name`` are unchanged.
+
 * net/iavf: Removed the ``auto_reconfig`` devarg.
 
   The restoration of the promiscuous and all-multicast settings after a VF reset
diff --git a/lib/metrics/meson.build b/lib/metrics/meson.build
index 6722f666d2..0e32a08dc3 100644
--- a/lib/metrics/meson.build
+++ b/lib/metrics/meson.build
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('rte_metrics.c', 'rte_metrics_telemetry.c')
-headers = files('rte_metrics.h', 'rte_metrics_telemetry.h')
+sources = files('rte_metrics.c')
+headers = files('rte_metrics.h')
 
+# Legacy JSON telemetry commands are only available with jansson.
 if dpdk_conf.has('RTE_HAS_JANSSON')
+    sources += files('rte_metrics_telemetry.c')
     ext_deps += jansson_dep
 endif
 
diff --git a/lib/metrics/rte_metrics_telemetry.c b/lib/metrics/rte_metrics_telemetry.c
index f9ec556595..2350ef5041 100644
--- a/lib/metrics/rte_metrics_telemetry.c
+++ b/lib/metrics/rte_metrics_telemetry.c
@@ -2,19 +2,35 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
+#include <jansson.h>
+
 #include <ethdev_driver.h>
-#include <eal_export.h>
 #include <rte_string_fns.h>
 #ifdef RTE_LIB_TELEMETRY
 #include <telemetry_internal.h>
 #endif
 
 #include "rte_metrics.h"
-#include "rte_metrics_telemetry.h"
-
-#ifdef RTE_HAS_JANSSON
 
-struct telemetry_metrics_data tel_met_data;
+enum rte_telemetry_stats_type {
+	PORT_STATS = 0,
+	GLOBAL_STATS = 1
+};
+
+struct telemetry_encode_param {
+	enum rte_telemetry_stats_type type;
+	struct port_param {
+		int num_metric_ids;
+		uint32_t metric_ids[RTE_METRICS_MAX_METRICS];
+		int num_port_ids;
+		uint32_t port_ids[RTE_MAX_ETHPORTS];
+	} pp;
+};
+
+static struct telemetry_metrics_data {
+	int reg_index[RTE_MAX_ETHPORTS];
+	int metrics_register_done;
+} tel_met_data;
 
 int metrics_log_level;
 #define RTE_LOGTYPE_METRICS metrics_log_level
@@ -72,8 +88,7 @@ rte_metrics_tel_reg_port_ethdev_to_metrics(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
-int32_t
+static int32_t
 rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 {
 	struct driver_index {
@@ -227,8 +242,7 @@ rte_metrics_tel_format_port(uint32_t pid, json_t *ports,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
-int32_t
+static int32_t
 rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 		char **json_buffer)
 {
@@ -281,8 +295,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
-int32_t
+static int32_t
 rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 		int *reg_index, char **json_buffer)
 {
@@ -312,8 +325,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
-int32_t
+static int32_t
 rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 {
 	int p, num_port_ids = 0;
@@ -379,8 +391,7 @@ rte_metrics_tel_stat_names_to_ids(const char * const *stat_names,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
-int32_t
+static int32_t
 rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 {
 	int ret;
@@ -547,68 +558,3 @@ RTE_INIT(metrics_ctor)
 			handle_ports_stats_values_by_name);
 #endif
 }
-
-#else /* !RTE_HAS_JANSSON */
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
-int32_t
-rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
-{
-	RTE_SET_USED(metrics_register_done);
-	RTE_SET_USED(reg_index_list);
-
-	return -ENOTSUP;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
-int32_t
-rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
-	char **json_buffer)
-{
-	RTE_SET_USED(ep);
-	RTE_SET_USED(json_buffer);
-
-	return -ENOTSUP;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
-int32_t
-rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
-	int *reg_index, char **json_buffer)
-{
-	RTE_SET_USED(ep);
-	RTE_SET_USED(reg_index);
-	RTE_SET_USED(json_buffer);
-
-	return -ENOTSUP;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
-int32_t
-rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
-{
-	RTE_SET_USED(ep);
-
-	return -ENOTSUP;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
-int32_t
-rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
-{
-	RTE_SET_USED(ep);
-	RTE_SET_USED(data);
-
-	return -ENOTSUP;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_global_stats, 20.05)
-int32_t
-rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep)
-{
-	RTE_SET_USED(ep);
-
-	return -ENOTSUP;
-}
-
-#endif /* !RTE_HAS_JANSSON */
diff --git a/lib/metrics/rte_metrics_telemetry.h b/lib/metrics/rte_metrics_telemetry.h
deleted file mode 100644
index dd84f5431e..0000000000
--- a/lib/metrics/rte_metrics_telemetry.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2020 Intel Corporation
- */
-
-#ifdef RTE_HAS_JANSSON
-#include <jansson.h>
-#else
-#define json_t void *
-#endif
-
-#include <rte_compat.h>
-#include "rte_metrics.h"
-
-#ifndef _RTE_METRICS_TELEMETRY_H_
-#define _RTE_METRICS_TELEMETRY_H_
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-enum rte_telemetry_stats_type {
-	PORT_STATS = 0,
-	GLOBAL_STATS = 1
-};
-
-struct telemetry_encode_param {
-	enum rte_telemetry_stats_type type;
-	struct port_param {
-		int num_metric_ids;
-		uint32_t metric_ids[RTE_METRICS_MAX_METRICS];
-		int num_port_ids;
-		uint32_t port_ids[RTE_MAX_ETHPORTS];
-	} pp;
-};
-
-struct telemetry_metrics_data {
-	int reg_index[RTE_MAX_ETHPORTS];
-	int metrics_register_done;
-};
-
-__rte_experimental
-int32_t rte_metrics_tel_reg_all_ethdev(int *metrics_register_done,
-		int *reg_index_list);
-
-__rte_experimental
-int32_t
-rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
-		char **json_buffer);
-
-__rte_experimental
-int32_t
-rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep);
-
-__rte_experimental
-int32_t
-rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep);
-
-__rte_experimental
-int32_t
-rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
-		int *reg_index, char **json_buffer);
-
-__rte_experimental
-int32_t
-rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
-- 
2.53.0

