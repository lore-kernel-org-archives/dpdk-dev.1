Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F4E65298
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14EC4065D;
	Sun,  1 Feb 2026 21:46:57 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 96D3A40654
 for <dev@dpdk.org>; Sun,  1 Feb 2026 21:46:54 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2741943f8f.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769978814; x=1770583614; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtFnwPGRhnyTH3UVU9GBJnL3vTO/i5Qq674/9NlkLU4=;
 b=J2+MuG6EO60Ay/Ioi3ZSM4/jr2Xn5MFCrzQPzHf6KOQftqg4hoFulfUbcu+J9R+zrm
 J3L4i/op0rAgpxTBezpTjdGXbqtJtJqJiLhh6uSMLp09dZnjJByybAhmkABFA79NBKHe
 WKd8UbkwrCc7rgMowMkldxQ8A9exnnYZGuHC8bMHsH7goQCICy6RuGe8YcE8q4sHsvaq
 nJQGlJl25gPkqrfFyk8aBI3dHnpGsscr+ofkP9v87zzbnvk28IbtHju4qopBKAPT/HJD
 T3OOzeLneJhqXdzs3yK3c8oswNQgqFufV3GdIr/X/2KPTsQc8MfG7+9vazk0V3xVTRl8
 jDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769978814; x=1770583614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TtFnwPGRhnyTH3UVU9GBJnL3vTO/i5Qq674/9NlkLU4=;
 b=QmKcFSSss4FOHkt1n1Idsn60Cgb1KuR85tKXL+RCHaYgDqIi7gMe13gkxK9CADwTGm
 fg+yyDalE/NzXsYMcMAljkLo8h96wCg4RdKRse0jkFCuLWciCPMj09iPVydoToj6e75l
 MaOjqXAF+TiMczLCCSRW8KHMKj9tNh+jns3zgOTPNo8X2ziWBeWTXSfW/KKDGlFV0DxC
 oysg3xPMRMoQk+D+Uew7uNKiOq1A3gnRrnqQlpzjUpzs60PzgAzjTzQ9pJI7tH6BQsWO
 2sdG/1ZSVSn5N0MeN9WHP/VH8PPocNjhh+/VrSaWvbtetPC3brPWz3rnMzil/wBSFY5X
 l8Cg==
X-Gm-Message-State: AOJu0YzTFNkSr19cc8KrBNcpZiEPD2klINnP1+dt2NSMvmhdvqb886hA
 4dQpTNOypXZU1Xa0icb+lT79WjSfvpYlVl3g5mgDc3vPWfHfb4cGumTin2KgZIF1uhQaxxDJc8p
 +b//l
X-Gm-Gg: AZuq6aKrQGlaGhNJhyaWD0x+qhzcL2IhR2zG43yDvU13LN3hFrw2Eh3Wqtnl9utfAnJ
 WzhYhUXYqzu7p89FPm/MWX7nHqmt01ZkjKp9dVN8Wn5lp6512pAxAxxf6ysFjKaHRn9gg3cdmQe
 VH5Eo1NXvWGO/yMp4FK8Hup7KHZ1JTRmx//GRAUXk5W4WPczcZGRnp/KR1n9L8dV17p+jTqJaay
 T3SatJHA0yzj4xXDrXtXL+3aMzcXrYSfuhVMEQhIbPzZqYxQjHYmduXv9zszFylNgJzwI+bSadH
 2lQju/9i++96BKJYyhFEsI+DuzJB0yR/PdZLro4KyItq9wIBY8AdldsCtDSc7Nr7DoRcr7RGImi
 z3sIc8GkD4acW0PPJQXx74LddwOCymbOZoEWcgxP8DnZBdR58lG00JBdZMtJkAlFQGXu7JiuEGT
 IlK45ARRTz81HntAPwIxdPKXFvr9GjTUmYSWijZi6RpWGKng==
X-Received: by 2002:a5d:588f:0:b0:432:59d4:f54a with SMTP id
 ffacd0b85a97d-435ea220e78mr20738855f8f.30.1769978813529; 
 Sun, 01 Feb 2026 12:46:53 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm37721491f8f.8.2026.02.01.12.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 12:46:52 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v9 2/6] ethdev: add RSS type helper APIs
Date: Sun,  1 Feb 2026 21:46:39 +0100
Message-ID: <20260201204643.9951-3-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260201204643.9951-1-sismis@dyna-nic.com>
References: <20260201204643.9951-1-sismis@dyna-nic.com>
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
between RSS type names and values.
Add unit tests for RSS type helper.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 app/test/test_ethdev_api.c             |  51 ++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   6 ++
 lib/ethdev/rte_ethdev.c                | 107 +++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h                |  55 +++++++++++++
 4 files changed, 219 insertions(+)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..7c0cde87a6 100644
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
 
+static int
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
index 15dabee7a1..84cba63d06 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added experimental RSS type helper APIs in ethdev.**
+
+  Added new experimental APIs ``rte_eth_rss_type_info_get()``,
+  ``rte_eth_rss_type_from_str()``, and ``rte_eth_rss_type_to_str()`` to
+  convert between RSS type names and values. These helpers provide a global
+  RSS type string table via ``struct rte_eth_rss_type_info``.
 
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
index a66c2abbdb..e7bb7384a6 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -4889,6 +4889,61 @@ __rte_experimental
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

