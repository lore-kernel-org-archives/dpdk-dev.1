Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0A9F45A0C
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 20:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 560474064C;
	Fri, 10 Apr 2026 22:15:55 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 8A9DE40609
 for <dev@dpdk.org>; Fri, 10 Apr 2026 22:15:54 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso24011175e9.3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1775852154; x=1776456954; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abzgF3J9NyrIrwUV8sljRMzNwiQnV8GyVTovXm8HyZo=;
 b=iuriWT467Gk2wumQMFgZ9AhhuirfU1IDZMrYzdriDPLCbgkRhlO7yu18K9Kl7AbXBi
 oENBYEniZ8dMbZbHRfLHS+kQqix/a0frL8b8a2cpSLVwEqwwX6R2hzzW66fQW7xJ8dq3
 c/9oj4cLw0/hhVOtVMjQ4RlU+PqdoENyB0vW4UWgKy5CZKBgcWpg7jV2bqQgvEC+GemE
 ++gj2Bik7TqJx6k63oJxWuRaxD7JhY4UyGg6DTPOv+ochY0iMkGEVq4cyplP00Teg/46
 zaV2++y6mTbFYbdhDlRzgZLsajuA8hIndX9bAVdcXLFztUyQap5Gw1thph9+DVV82Ghk
 fKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775852154; x=1776456954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abzgF3J9NyrIrwUV8sljRMzNwiQnV8GyVTovXm8HyZo=;
 b=I85MoBF9H3coHevykzmWITAtw+V17AA09ZOrksYYMuMRp+jyUFp7wfzXpZJximZbos
 OrYsA9uXHV1XMRY59vXnnFNDHEVAluK7jzrn21PnI8/uQ01h1JHGxasiPxRxfSR6/U8Y
 5fmXBxnbwHuoBPLsym+D0v0BL2JkrJBDZ/VCnJM6Oh05otgCDpAOUYaO8SP1+yi0M39w
 euGXW9ufSLrK5Rpyg02Q+MYdDnzgsO9psjOELtgR5P1P0jOjzahILw3aaMzHkl74qGq1
 Uiodm7xurmgohuxpp6JvXzhkPS3mz3xXg1XfSLupSzZyNUNcsjgRQC24aOJpLwmxg4Sf
 U0Fw==
X-Gm-Message-State: AOJu0YxdB+prWTbU5dYwaw3ms2WTC1aMVXXYO2liE8yHG29Q1paya4qj
 SkDDF1xu3zCqTvCB/rYxJ39Q38AsdB6PJ9kAFzFw9jWkHTnU7J8vtA0tY+dUOrna2Xo=
X-Gm-Gg: AeBDieu3k/G+jNsnW9ibt0EGvF7hJNcHvbs990PKi4VCErdCm620UPrVv8s5dacq+s8
 xnqSTkx7IM2q0UHlcoEnLjQIaLxVJ//lh+nLyJHmNZrFoANI1id3f5WKaXqNPZbIfeiYbrBVwBR
 VcDenPPLl/GOp5NvkjSvYwikZ3iLcf1lwkeRw0z5MPolYHIUNkt70i4qRxI861GxXwWv11FB7xh
 otx3wanG8MRiOtDfPsfMWBsjSXwp0zxwLArZ3VX2rUeOCEGCjJh7Iq1cIokClBKUIPV2DYHB3ai
 aiL1sP7YafVZiD9Ez1Tsui8efqiH/Mixs+mMEpSrLLWgZEFQ5kBI6nmY41C67lhC8ao38fI3twp
 48NAwQ801eXAyM+gXcB4uhPcA+k5bbV7mOAOCCrijQouHuEkQrY0R5B5OWbFETjcA1+amXV9Kmq
 NrNiJl6uLZ7A623IcTuqHMjxPkJxzulO7ZqU2Qrv2U90Ch0UB6HyqAK8rgJS6Pn3U=
X-Received: by 2002:a05:600c:a11b:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-488d66559d0mr51887735e9.0.1775852154073; 
 Fri, 10 Apr 2026 13:15:54 -0700 (PDT)
Received: from dpdk-test6.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm26044405e9.24.2026.04.10.13.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 13:15:53 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: orika@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v11 2/6] ethdev: add RSS type helper APIs
Date: Fri, 10 Apr 2026 22:15:40 +0200
Message-ID: <e42017cbe8326992fe8f4b6c581467b1fc82076e.1775850858.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775850858.git.sismis@dyna-nic.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
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
 app/test/test_ethdev_api.c             |  56 +++++++++++++
 doc/guides/rel_notes/release_26_07.rst |   5 ++
 lib/ethdev/rte_ethdev.c                | 109 +++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h                |  60 ++++++++++++++
 4 files changed, 230 insertions(+)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..ab0e018c60 100644
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
 
@@ -162,12 +165,65 @@ ethdev_api_queue_status(void)
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
+		TEST_ASSERT_SUCCESS(rte_eth_rss_type_from_str(tbl[i].str,
+			&type), "rss type lookup failed for %s", tbl[i].str);
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
+		TEST_ASSERT_SUCCESS(rte_eth_rss_type_from_str(name, &type),
+			"rss type round-trip lookup failed for %s", name);
+		TEST_ASSERT_EQUAL(type, tbl[i].rss_type,
+			"rss type round-trip mismatch for %s", name);
+	}
+
+	TEST_ASSERT(tbl[i].str == NULL, "rss type table not NULL terminated");
+	TEST_ASSERT(rte_eth_rss_type_from_str(NULL, &type) != 0,
+		"rss type from NULL str should fail");
+	TEST_ASSERT(rte_eth_rss_type_from_str("ipv4", NULL) != 0,
+		"rss type from NULL rss_type should fail");
+	TEST_ASSERT(rte_eth_rss_type_from_str("not-a-type", &type) != 0,
+		"rss type unknown should fail");
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
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..e58c3365b6 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added experimental RSS type helper APIs in ethdev.**
+
+  * Added new APIs to convert between RSS type names and values.
+  * Added new API call to obtain the global RSS string table.
+
 
 Removed Items
 -------------
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..571947371c 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -5178,6 +5178,115 @@ rte_eth_find_rss_algo(const char *name, uint32_t *algo)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_info_get, 26.07)
+const struct rte_eth_rss_type_info *
+rte_eth_rss_type_info_get(void)
+{
+	return rte_eth_rss_type_table;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_from_str, 26.07)
+int
+rte_eth_rss_type_from_str(const char *str, uint64_t *rss_type)
+{
+	unsigned int i;
+
+	if (str == NULL || rss_type == NULL)
+		return -EINVAL;
+
+	for (i = 0; rte_eth_rss_type_table[i].str != NULL; i++) {
+		if (strcmp(rte_eth_rss_type_table[i].str, str) == 0) {
+			*rss_type = rte_eth_rss_type_table[i].rss_type;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_to_str, 26.07)
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
index 0d8e2d0236..72f0a64e75 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -4889,6 +4889,66 @@ __rte_experimental
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
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
+ * @param rss_type
+ *   Pointer to store RSS type value (RTE_ETH_RSS_*) on success.
+ * @return
+ *   0 on success, -EINVAL if str or rss_type is NULL, -ENOENT if not found.
+ */
+__rte_experimental
+int
+rte_eth_rss_type_from_str(const char *str, uint64_t *rss_type);
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

