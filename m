Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D06BD46C04
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F5254067D;
	Wed, 28 Jan 2026 22:59:03 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 773EF402E1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:59:00 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso2636015e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769637540; x=1770242340; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWgK9l8FLG1G7+BqxJ4RPYbjrgYM8L/npbgZXmUlStI=;
 b=VwzRNd150M2yb3W/iCdzIEK7M6qJV8zMVwxB+8588hD3/5Neji4ZUtQ3qc+D0QsIs6
 QVj6Bs56cXtVRWjtdA0GAoWplYzRrdmFtqk7AbC2Z+fzIs+gsp1LKAwUBKJK9JMgwhKL
 IKeNCM6WPh8t/zY3cGqNYCx+8MFlubs7N3styHQ2Od1oG5HZk+tK9/cJqT/YMyezcPG1
 623+c7m0gDrr6dVQ/yK8iIfB2oKVTcKleNnII2LSeW49w8rN76RW19ICjOVt/KMbT3sB
 nWCpxvJ2pTLvbWvYv+SqMIskL62nCOiQG0XrsCerQHvebXjabdukv8cfB7SCYxODuAAP
 BbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637540; x=1770242340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xWgK9l8FLG1G7+BqxJ4RPYbjrgYM8L/npbgZXmUlStI=;
 b=OFoJPyVVPTzzsbTZqh6AN/yKaPE81NlJK9i9VRShqWe5stItbGIhCKodrA+JBxXAjn
 zoHaVx5P+gVPvhpAmFnIPATaaIt47qth25Ga9nISDx+ZV03vzWt+KlP62E9QAJqoLXrs
 aNC20WVeAxvb5fbjryLe/kDMlrJYiE9XCHOinjBDOmpEWq8KjxjavzzkZLS1cTcvHGYT
 EmMFvLu1CgXKgWu5sim8XwUi9ZilH7d7lacoMlSL2vAYwaMuTTc8ZIVFYjsGOF769VG5
 U+cquW03pdTXjmF5Lzfvi55oL5+GyjbLlRkNO1Sg5ijdAngv8cD7YSCFZ5oGBz7fDF60
 BCRw==
X-Gm-Message-State: AOJu0YxGEDQHDuHmPv9I/pJ55reYpV4m+z7e1vW8vdMjtYSM8SXSDdrR
 +hBh56CU2CighaymSuz4DMotYlKAn/74P4n+S+zJn6FQ5UDdbgJNjqRqq1wENmFza2nq81pr3FV
 ePjUv
X-Gm-Gg: AZuq6aIXabKY+VlkZ0wbqvHZjPkp+vsc6OpmbewvJNcKMlzqEs8uBIu+Oh0HuOt33+0
 Dh1FU/yNio9t3vOapnESPu1rkL9wLzmcyluso31lagp7bbU4zA7PkH7eyJN+KUNoVjyL+Vqwqre
 AvpmeBD2IRcqZ6jAkUsN/2oQana9cfGcPmg1QmCGHFagLQ+jFBBf6rWr5HLzDjWsBynNaKEPvu8
 wo3M3qHcvRzY3mSZZS0iLuscygNBvm15r6Jp8iqfy03vphWRlsKAqh5J8zDVdYosnF7QISrq+tF
 smce30vFDm/ROsEFRgAptL/8dCMIPCumWASaHm+BxMT+kixiUcmJ23EZ2d5jIyPqkIpYUeniapD
 fwQz43rA21Id+Y3pF/Hd+NklOy/2oM5BUxbzEV0PN61ZtQ06+HlCpkfQrRgFD68YmGFO3nHD7OR
 KiEYoLGWDpnaZmRW6G8Zdll0e3hg6ZLbKH/iwjbzHBbnx28A==
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-48069c8a660mr91760275e9.33.1769637539784; 
 Wed, 28 Jan 2026 13:58:59 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm91536885e9.6.2026.01.28.13.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:58:58 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v7 2/6] ethdev: add RSS type helper APIs
Date: Wed, 28 Jan 2026 22:58:34 +0100
Message-ID: <20260128215838.73502-3-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260128215838.73502-1-sismis@dyna-nic.com>
References: <20260128215838.73502-1-sismis@dyna-nic.com>
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

