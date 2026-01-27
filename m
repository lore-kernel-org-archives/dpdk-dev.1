Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8BDD2FED9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17921427A1;
	Tue, 27 Jan 2026 19:47:47 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id A2C854270A
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:47:45 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48068127f00so8774705e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769539665; x=1770144465; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5QYukk3iCd4C0GveKwe8h6jW9vSDPARhhcL8GdVP2M=;
 b=xudfIqGBLirVdoO741LvYVVZjFD/J2bU02e7VnesM5zGoC0V+2E8X8Hik780ZEzhTH
 MqFdtjPQ7aytM/jT+oZQF3II+FQaJm+oGniNo42m0SdBwE40xVG9YXkA0NEkvl1zgrLM
 cIWD3zH3P0fbrTKWTmFG8lvlPEMYxkP7Ou7VnI9gdw/g5l0rDBFdvLGlKp5q/L4X5Iq/
 F8xSQykwJf7RnbTamL6BV+R6U5eByb14PlMjkp2K8Eo9bjAFpAlBGdCQX3px3OSUGh0H
 ebIwuy3Wm9iH6id+yMhBpYYTHQpPsfvSjXBcmPkpYTfCqS+qyVW42ABbN2X2cmgSJEKs
 Nc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539665; x=1770144465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5QYukk3iCd4C0GveKwe8h6jW9vSDPARhhcL8GdVP2M=;
 b=IUFSZ4DmoKJ7z9ptNPDNfExn238Qb3YKjozjnBpAzla9qK0Rwx7PIv3eNOIR3afxYK
 vvdalm3uHvCtBPuZbcOSuIlXVZhy2AOlsYgCzdXZO/ZzAD+Dh/KgTDOhhVjXiYV1ZvLm
 4mOJ2/VIUqOb4STVAte22wl+Hd6abkY9XSVmGrlY/WKkWZ663HDK0bivKZcKTfk1cJgM
 B0gRGB6SWv88uzzG/sFPRVyinBxjS3R4v5hlw+vmr4+k86QG2UThC6AQiIjP5HIYDdx4
 d9ulUIqwdMroTAo+A8jD7ANO4c4kJUbBd1QubeQJ+TF/ERb+W9ne49671M4ZRJKsH+sR
 Wy8g==
X-Gm-Message-State: AOJu0YxBHheFKY1wwZCMv9hWZbaCZQef/9K53U/5bQtArGA+JpI9FLv1
 A979ZDnYeu6mNGY7A9kvg4/npXIaWPptdTZ6Izair6OyACv7uvQESwhwrgVNeXZK8IvAFAjOj1G
 SeQKR
X-Gm-Gg: AZuq6aJFrFWe5Lwg0+y1EZ0/AcPMHySzcg0sh9e+unQkf4PndO1O92+7Q+KSRPmGKRq
 835OT3Xzx8mXH94wjVD3RP/9vV7jOBiP/+pg1DOjENm3ZCoznwWWlq1CYKvGWGr1p7L/7KBme+P
 iVvLbNCnX98lZPG10it932NGoUVKdyN+o5AK3zBxGgUBgo0RhV/7DGEE6sGnT3HbDapcTYkeUEw
 Pw1cZRZxZQwNoDL0PPNrYlfet4YgTlwgmX8Vm/thBIWMhuzOkneWxDqbpO+KQc187a/uPptJitl
 FsV3uWBTag203OGrVY8wt1hwFPJEu1Y0T349ZOw4HVf+Brg8T6DOhPCDQbvt2px34Jj9o86rW7m
 I8f257XgfWiCRftHb3xrIq0D2yym1kQ8NbotvX9FE7gEJEUDFztaBXstkN2V7NpAgmareXuQdsk
 CNmLZPne/SCrBCyr1oAfhdm1oY8eCfm4Daw2JlS3ObpY0/Nhli6+qoHpm9
X-Received: by 2002:a05:600c:a08c:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48069c164bcmr34454265e9.1.1769539664958; 
 Tue, 27 Jan 2026 10:47:44 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm716958f8f.27.2026.01.27.10.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:47:44 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v5 2/6] ethdev: add RSS type helper APIs
Date: Tue, 27 Jan 2026 19:47:33 +0100
Message-ID: <20260127184738.200476-3-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260127184738.200476-1-sismis@dyna-nic.com>
References: <20260127184738.200476-1-sismis@dyna-nic.com>
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

Add a global RSS type string table and helper functions to convert
between RSS type names and values. Introduce rte_port_id_t and
rte_queue_id_t typedefs for shared port/queue identifiers, and add
unit tests for RSS type helper round-trips.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 app/test/test_ethdev_api.c             |  51 ++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  11 +++
 lib/ethdev/rte_ethdev.c                | 107 +++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h                |  77 ++++++++++++++++++
 4 files changed, 246 insertions(+)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..77fa5f4ffc 100644
--- a/app/test/test_ethdev_api.c
+++ b/app/test/test_ethdev_api.c
@@ -2,6 +2,9 @@
  * Copyright (C) 2023, Advanced Micro Devices, Inc.
  */
 
+#include <stdbool.h>
+#include <string.h>
+
 #include <rte_log.h>
 #include <rte_ethdev.h>
 
@@ -162,12 +165,60 @@ ethdev_api_queue_status(void)
 	return TEST_SUCCESS;
 }
 
+static int32_t
+ethdev_api_rss_type_helpers(void)
+{
+	const struct rte_eth_rss_type_info *tbl;
+	const char *zero_name = NULL;
+	unsigned int i;
+	bool has_zero = false;
+	const char *name;
+	uint64_t type;
+
+	tbl = rte_eth_rss_type_info_get();
+	TEST_ASSERT_NOT_NULL(tbl, "rss type table missing");
+
+	for (i = 0; tbl[i].str != NULL; i++) {
+		type = rte_eth_rss_type_from_str(tbl[i].str);
+		TEST_ASSERT_EQUAL(type, tbl[i].rss_type,
+			"rss type mismatch for %s", tbl[i].str);
+
+		if (tbl[i].rss_type == 0 && !has_zero) {
+			has_zero = true;
+			zero_name = tbl[i].str;
+		}
+
+		name = rte_eth_rss_type_to_str(tbl[i].rss_type);
+		TEST_ASSERT_NOT_NULL(name, "rss type name missing for %s",
+			tbl[i].str);
+		TEST_ASSERT_EQUAL(rte_eth_rss_type_from_str(name), tbl[i].rss_type,
+			"rss type round-trip mismatch for %s", name);
+	}
+
+	TEST_ASSERT(tbl[i].str == NULL, "rss type table not NULL terminated");
+	TEST_ASSERT_EQUAL(rte_eth_rss_type_from_str(NULL), 0,
+		"rss type from NULL should be 0");
+	TEST_ASSERT_EQUAL(rte_eth_rss_type_from_str("not-a-type"), 0,
+		"rss type unknown should be 0");
+	name = rte_eth_rss_type_to_str(0);
+	if (has_zero) {
+		TEST_ASSERT_NOT_NULL(name, "rss type 0 should be defined");
+		TEST_ASSERT(strcmp(name, zero_name) == 0,
+			"rss type 0 name mismatch");
+	} else {
+		TEST_ASSERT(name == NULL, "rss type 0 should be NULL");
+	}
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite ethdev_api_testsuite = {
 	.suite_name = "ethdev API tests",
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
 		TEST_CASE(ethdev_api_queue_status),
+		TEST_CASE(ethdev_api_rss_type_helpers),
 		/* TODO: Add deferred_start queue status test */
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..abd4d7149b 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,17 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added experimental RSS type helper APIs in ethdev.**
+
+  Added new experimental APIs ``rte_eth_rss_type_info_get()``,
+  ``rte_eth_rss_type_from_str()``, and ``rte_eth_rss_type_to_str()`` to
+  convert between RSS type names and values. These helpers provide a global
+  RSS type string table via ``struct rte_eth_rss_type_info``.
+
+* **Added experimental port and queue identifier typedefs in ethdev.**
+
+  Added new experimental typedefs ``rte_port_id_t`` and ``rte_queue_id_t``
+  to provide type-safe identifiers for Ethernet device ports and queues.
 
 Removed Items
 -------------
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2659e8d9eb..b572bbf321 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -5167,6 +5167,113 @@ rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 	return -EINVAL;
 }
 
+/* Global RSS type string table. */
+static const struct rte_eth_rss_type_info rte_eth_rss_type_table[] = {
+	/* Group types */
+	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP |
+		RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP |
+		RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_RSS_L2TPV3 |
+		RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS |
+		RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IB_BTH },
+	{ "none", 0 },
+	{ "ip", RTE_ETH_RSS_IP },
+	{ "udp", RTE_ETH_RSS_UDP },
+	{ "tcp", RTE_ETH_RSS_TCP },
+	{ "sctp", RTE_ETH_RSS_SCTP },
+	{ "tunnel", RTE_ETH_RSS_TUNNEL },
+	{ "vlan", RTE_ETH_RSS_VLAN },
+
+	/* Individual type */
+	{ "ipv4", RTE_ETH_RSS_IPV4 },
+	{ "ipv4-frag", RTE_ETH_RSS_FRAG_IPV4 },
+	{ "ipv4-tcp", RTE_ETH_RSS_NONFRAG_IPV4_TCP },
+	{ "ipv4-udp", RTE_ETH_RSS_NONFRAG_IPV4_UDP },
+	{ "ipv4-sctp", RTE_ETH_RSS_NONFRAG_IPV4_SCTP },
+	{ "ipv4-other", RTE_ETH_RSS_NONFRAG_IPV4_OTHER },
+	{ "ipv6", RTE_ETH_RSS_IPV6 },
+	{ "ipv6-frag", RTE_ETH_RSS_FRAG_IPV6 },
+	{ "ipv6-tcp", RTE_ETH_RSS_NONFRAG_IPV6_TCP },
+	{ "ipv6-udp", RTE_ETH_RSS_NONFRAG_IPV6_UDP },
+	{ "ipv6-sctp", RTE_ETH_RSS_NONFRAG_IPV6_SCTP },
+	{ "ipv6-other", RTE_ETH_RSS_NONFRAG_IPV6_OTHER },
+	{ "l2-payload", RTE_ETH_RSS_L2_PAYLOAD },
+	{ "ipv6-ex", RTE_ETH_RSS_IPV6_EX },
+	{ "ipv6-tcp-ex", RTE_ETH_RSS_IPV6_TCP_EX },
+	{ "ipv6-udp-ex", RTE_ETH_RSS_IPV6_UDP_EX },
+	{ "port", RTE_ETH_RSS_PORT },
+	{ "vxlan", RTE_ETH_RSS_VXLAN },
+	{ "geneve", RTE_ETH_RSS_GENEVE },
+	{ "nvgre", RTE_ETH_RSS_NVGRE },
+	{ "gtpu", RTE_ETH_RSS_GTPU },
+	{ "eth", RTE_ETH_RSS_ETH },
+	{ "s-vlan", RTE_ETH_RSS_S_VLAN },
+	{ "c-vlan", RTE_ETH_RSS_C_VLAN },
+	{ "esp", RTE_ETH_RSS_ESP },
+	{ "ah", RTE_ETH_RSS_AH },
+	{ "l2tpv3", RTE_ETH_RSS_L2TPV3 },
+	{ "pfcp", RTE_ETH_RSS_PFCP },
+	{ "pppoe", RTE_ETH_RSS_PPPOE },
+	{ "ecpri", RTE_ETH_RSS_ECPRI },
+	{ "mpls", RTE_ETH_RSS_MPLS },
+	{ "ipv4-chksum", RTE_ETH_RSS_IPV4_CHKSUM },
+	{ "l4-chksum", RTE_ETH_RSS_L4_CHKSUM },
+	{ "l2tpv2", RTE_ETH_RSS_L2TPV2 },
+	{ "l3-pre96", RTE_ETH_RSS_L3_PRE96 },
+	{ "l3-pre64", RTE_ETH_RSS_L3_PRE64 },
+	{ "l3-pre56", RTE_ETH_RSS_L3_PRE56 },
+	{ "l3-pre48", RTE_ETH_RSS_L3_PRE48 },
+	{ "l3-pre40", RTE_ETH_RSS_L3_PRE40 },
+	{ "l3-pre32", RTE_ETH_RSS_L3_PRE32 },
+	{ "l2-dst-only", RTE_ETH_RSS_L2_DST_ONLY },
+	{ "l2-src-only", RTE_ETH_RSS_L2_SRC_ONLY },
+	{ "l4-dst-only", RTE_ETH_RSS_L4_DST_ONLY },
+	{ "l4-src-only", RTE_ETH_RSS_L4_SRC_ONLY },
+	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
+	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
+	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
+	{ "ib-bth", RTE_ETH_RSS_IB_BTH },
+	{ NULL, 0 },
+};
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_info_get, 26.03)
+const struct rte_eth_rss_type_info *
+rte_eth_rss_type_info_get(void)
+{
+	return rte_eth_rss_type_table;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_from_str, 26.03)
+uint64_t
+rte_eth_rss_type_from_str(const char *str)
+{
+	unsigned int i;
+
+	if (str == NULL)
+		return 0;
+
+	for (i = 0; rte_eth_rss_type_table[i].str != NULL; i++) {
+		if (strcmp(rte_eth_rss_type_table[i].str, str) == 0)
+			return rte_eth_rss_type_table[i].rss_type;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_to_str, 26.03)
+const char *
+rte_eth_rss_type_to_str(uint64_t rss_type)
+{
+	unsigned int i;
+
+	for (i = 0; rte_eth_rss_type_table[i].str != NULL; i++) {
+		if (rte_eth_rss_type_table[i].rss_type == rss_type)
+			return rte_eth_rss_type_table[i].str;
+	}
+
+	return NULL;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_add)
 int
 rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..cc179690d4 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -175,6 +175,28 @@
 extern "C" {
 #endif
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Ethernet device port identifier type.
+ *
+ * Used by libraries and applications to reference DPDK ports in a
+ * type-safe manner.
+ */
+typedef uint16_t rte_port_id_t;
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Ethernet device queue identifier type.
+ *
+ * Used by libraries and applications to reference Rx/Tx queues in a
+ * type-safe manner.
+ */
+typedef uint16_t rte_queue_id_t;
+
 extern int rte_eth_dev_logtype;
 #define RTE_LOGTYPE_ETHDEV rte_eth_dev_logtype
 
@@ -4889,6 +4911,61 @@ __rte_experimental
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo);
 
+/**
+ * RSS type name mapping entry.
+ *
+ * The table returned by rte_eth_rss_type_info_get() is terminated by an entry
+ * with a NULL string.
+ */
+struct rte_eth_rss_type_info {
+	const char *str; /**< RSS type name. */
+	uint64_t rss_type; /**< RSS type value (RTE_ETH_RSS_*). */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Get the global RSS type string table.
+ *
+ * @return
+ *   Pointer to a table of RSS type string mappings terminated by an entry with
+ *   a NULL string.
+ */
+__rte_experimental
+const struct rte_eth_rss_type_info *
+rte_eth_rss_type_info_get(void);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Convert an RSS type name to its value.
+ *
+ * @param str
+ *   RSS type name.
+ * @return
+ *   RSS type value (RTE_ETH_RSS_*), or 0 if not found or if str is NULL.
+ */
+__rte_experimental
+uint64_t
+rte_eth_rss_type_from_str(const char *str);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Convert an RSS type value to its name.
+ *
+ * @param rss_type
+ *   RSS type value (RTE_ETH_RSS_*).
+ * @return
+ *   RSS type name, or NULL if the value cannot be recognized.
+ */
+__rte_experimental
+const char *
+rte_eth_rss_type_to_str(uint64_t rss_type);
+
 /**
  * Add UDP tunneling port for a type of tunnel.
  *
-- 
2.43.7

