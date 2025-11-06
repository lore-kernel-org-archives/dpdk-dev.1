Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472ACCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32E9F40E32;
	Thu,  6 Nov 2025 15:10:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 28BD340647;
 Thu,  6 Nov 2025 15:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438223; x=1793974223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZWPAXAoCWOi8rT04I1eWiE0ViBqI1VMFHQCJB7IQid4=;
 b=MKPYlHfBkEhEknBUnJR2MF/8R23PtvyqgMTNIrlX1/v5ccOb8b3ulqyl
 Pu0S4888/j6aSvjhzjIJfM5YNwsXFBWT99aXWgXMehlnvisMsJ+g9DIRB
 B4gU2QJ6KaJcYSt0O8B83eLBBsbg2vOW6P5nhIJTr2WQTIfFyFAYVVGnL
 4LNxmoj454qOUOBL+RM7YE3nGyI3tUZrc9+9VT2X5DFi6uPsHjt888Vkf
 rG6E9Vro4ue1kBQovgR645fcvXW/aiSB09Uj+PGCP+5XOO0oLM9oLS3wD
 z3e/ZhPjRBgZluxX6QlQIMDfRxUR7nz3oQEtPdTDqYSK6TnGlTa+e4liY w==;
X-CSE-ConnectionGUID: aRvmZxq/R1WViBPmGspRSQ==
X-CSE-MsgGUID: 1oczUcB7QJSJJayali2fbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185360"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:22 -0800
X-CSE-ConnectionGUID: i7iwlVUPQL+5YxRU1ZHtcw==
X-CSE-MsgGUID: 35JwhrIwSiOq2isXbD0Hqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054817"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 19/19] app/test-pmd: fix build with shadow warnings enabled
Date: Thu,  6 Nov 2025 14:09:48 +0000
Message-ID: <20251106140948.2894678-20-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

Rename or remove shadowed variables so as to build cleanly with
-Wshadow.

Fixes: 55c074f3ba1d ("app/testpmd: support GENEVE option item")
Fixes: 9213c50e36fa ("app/testpmd: support GTP PSC option in raw sets")
Fixes: 26b7259a798d ("app/testpmd: support GRE option flow item")
Fixes: d2121ceccd29 ("app/testpmd: rework display of Rx descriptors")
Fixes: 90c263867b00 ("app/testpmd: enhance command-line parsing")
Fixes: 62d3216d6194 ("app/testpmd: add latency statistics calculation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline_flow.c | 42 ++++++++++++++++++-------------------
 app/test-pmd/config.c       | 15 +++++--------
 app/test-pmd/parameters.c   |  4 +---
 app/test-pmd/testpmd.c      |  2 +-
 4 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 54b247899d..ebc036b14b 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -14064,7 +14064,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 	data_tail = data + ACTION_RAW_ENCAP_MAX_DATA;
 	for (i = n - 1 ; i >= 0; --i) {
 		const struct rte_flow_item_gtp *gtp;
-		const struct rte_flow_item_geneve_opt *opt;
+		const struct rte_flow_item_geneve_opt *geneve_opt;
 		struct rte_flow_item_ipv6_routing_ext *ext;
 
 		item = in->args.vc.pattern + i;
@@ -14136,16 +14136,16 @@ cmd_set_raw_parsed(const struct buffer *in)
 			size = sizeof(struct rte_geneve_hdr);
 			break;
 		case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
-			opt = (const struct rte_flow_item_geneve_opt *)
+			geneve_opt = (const struct rte_flow_item_geneve_opt *)
 								item->spec;
 			size = offsetof(struct rte_flow_item_geneve_opt,
 					option_len) + sizeof(uint8_t);
-			if (opt->option_len && opt->data) {
-				*total_size += opt->option_len *
+			if (geneve_opt->option_len && geneve_opt->data) {
+				*total_size += geneve_opt->option_len *
 					       sizeof(uint32_t);
 				rte_memcpy(data_tail - (*total_size),
-					   opt->data,
-					   opt->option_len * sizeof(uint32_t));
+					   geneve_opt->data,
+					   geneve_opt->option_len * sizeof(uint32_t));
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_L2TPV3OIP:
@@ -14195,7 +14195,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 				goto error;
 			} else {
 				const struct rte_flow_item_gtp_psc
-					*opt = item->spec;
+					*gtp_opt = item->spec;
 				struct rte_gtp_psc_generic_hdr *hdr;
 				size_t hdr_size = RTE_ALIGN(sizeof(*hdr),
 							 sizeof(int32_t));
@@ -14203,7 +14203,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 				*total_size += hdr_size;
 				hdr = (typeof(hdr))(data_tail - (*total_size));
 				memset(hdr, 0, hdr_size);
-				*hdr = opt->hdr;
+				*hdr = gtp_opt->hdr;
 				hdr->ext_hdr_len = 1;
 				gtp_psc = i;
 				size = 0;
@@ -14225,25 +14225,25 @@ cmd_set_raw_parsed(const struct buffer *in)
 			size = 0;
 			if (item->spec) {
 				const struct rte_flow_item_gre_opt
-					*opt = item->spec;
-				if (opt->checksum_rsvd.checksum) {
+					*gre_opt = item->spec;
+				if (gre_opt->checksum_rsvd.checksum) {
 					*total_size +=
-						sizeof(opt->checksum_rsvd);
+						sizeof(gre_opt->checksum_rsvd);
 					rte_memcpy(data_tail - (*total_size),
-						   &opt->checksum_rsvd,
-						   sizeof(opt->checksum_rsvd));
+						   &gre_opt->checksum_rsvd,
+						   sizeof(gre_opt->checksum_rsvd));
 				}
-				if (opt->key.key) {
-					*total_size += sizeof(opt->key.key);
+				if (gre_opt->key.key) {
+					*total_size += sizeof(gre_opt->key.key);
 					rte_memcpy(data_tail - (*total_size),
-						   &opt->key.key,
-						   sizeof(opt->key.key));
+						   &gre_opt->key.key,
+						   sizeof(gre_opt->key.key));
 				}
-				if (opt->sequence.sequence) {
-					*total_size += sizeof(opt->sequence.sequence);
+				if (gre_opt->sequence.sequence) {
+					*total_size += sizeof(gre_opt->sequence.sequence);
 					rte_memcpy(data_tail - (*total_size),
-						   &opt->sequence.sequence,
-						   sizeof(opt->sequence.sequence));
+						   &gre_opt->sequence.sequence,
+						   sizeof(gre_opt->sequence.sequence));
 				}
 			}
 			proto = 0x2F;
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 3ce2a14a1b..62d7408bc4 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -4490,15 +4490,9 @@ ring_rxd_display_dword(union igb_ring_dword dword)
 
 static void
 ring_rx_descriptor_display(const struct rte_memzone *ring_mz,
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			   portid_t port_id,
-#else
-			   __rte_unused portid_t port_id,
-#endif
 			   uint16_t desc_id)
 {
-	struct igb_ring_desc_16_bytes *ring =
-		(struct igb_ring_desc_16_bytes *)ring_mz->addr;
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	int ret;
 	struct rte_eth_dev_info dev_info;
@@ -4528,12 +4522,15 @@ ring_rx_descriptor_display(const struct rte_memzone *ring_mz,
 	}
 #endif
 	/* 16 bytes RX descriptor */
+	struct igb_ring_desc_16_bytes *ring =
+		(struct igb_ring_desc_16_bytes *)ring_mz->addr;
 	ring[desc_id].lo_dword.dword =
 		rte_le_to_cpu_64(ring[desc_id].lo_dword.dword);
 	ring_rxd_display_dword(ring[desc_id].lo_dword);
 	ring[desc_id].hi_dword.dword =
 		rte_le_to_cpu_64(ring[desc_id].hi_dword.dword);
 	ring_rxd_display_dword(ring[desc_id].hi_dword);
+	RTE_SET_USED(port_id);
 }
 
 static void
@@ -4742,7 +4739,6 @@ port_rss_hash_conf_show(portid_t port_id, int show_rss_key, int show_rss_algo)
 {
 	struct rte_eth_rss_conf rss_conf = {0};
 	uint8_t rss_key[RSS_HASH_KEY_LENGTH];
-	uint64_t rss_hf;
 	uint8_t i;
 	int diag;
 	struct rte_eth_dev_info dev_info;
@@ -4783,8 +4779,7 @@ port_rss_hash_conf_show(portid_t port_id, int show_rss_key, int show_rss_algo)
 		}
 		return;
 	}
-	rss_hf = rss_conf.rss_hf;
-	if (rss_hf == 0) {
+	if (rss_conf.rss_hf == 0) {
 		printf("RSS disabled\n");
 		return;
 	}
@@ -4796,7 +4791,7 @@ port_rss_hash_conf_show(portid_t port_id, int show_rss_key, int show_rss_algo)
 	}
 
 	printf("RSS functions:\n");
-	rss_types_display(rss_hf, TESTPMD_RSS_TYPES_CHAR_NUM_PER_LINE);
+	rss_types_display(rss_conf.rss_hf, TESTPMD_RSS_TYPES_CHAR_NUM_PER_LINE);
 
 	if (!show_rss_key)
 		return;
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 96973906fd..e91d45fc45 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -987,11 +987,10 @@ launch_args_parse(int argc, char** argv)
 			break;
 		case TESTPMD_OPT_STATS_PERIOD_NUM: {
 			char *end = NULL;
-			unsigned int n;
 
 			n = strtoul(optarg, &end, 10);
 			if ((optarg[0] == '\0') || (end == NULL) ||
-					(*end != '\0'))
+					(*end != '\0') || n <= 0 || n >= UINT16_MAX)
 				rte_exit(EXIT_FAILURE, "Invalid stats-period value\n");
 
 			stats_period = n;
@@ -1339,7 +1338,6 @@ launch_args_parse(int argc, char** argv)
 			break;
 		case TESTPMD_OPT_HAIRPIN_MODE_NUM: {
 			char *end = NULL;
-			unsigned int n;
 
 			errno = 0;
 			n = strtoul(optarg, &end, 0);
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..af724b2ea8 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4636,7 +4636,7 @@ main(int argc, char** argv)
 
 #ifdef RTE_LIB_LATENCYSTATS
 	if (latencystats_enabled != 0) {
-		int ret = rte_latencystats_init(1, NULL);
+		ret = rte_latencystats_init(1, NULL);
 		if (ret)
 			fprintf(stderr,
 				"Warning: latencystats init() returned error %d\n",
-- 
2.48.1

