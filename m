Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2AD111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9BBB40BA4;
	Mon,  1 Dec 2025 12:45:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C99504066B;
 Mon,  1 Dec 2025 12:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589523; x=1796125523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+51h8nd3nlGKSzJlAhD1lOrCwWB2/tccmT8EmbcWM4o=;
 b=CHmrNusIPoedTleHzHWEJ3z5qguUcpfDXJwBRP+uMa4NjGBPOmiuooD2
 o+yZ4E4a4SktvcWBzk3mhqQI5euQRX6TLztrMwpKRBmXnC0Wp4qtgZJWA
 uJe1j6Io137ag7/iACABWiR9bfmbhH5bgFuP9u74J+XZoJOsW2ds2Bz9c
 MX9sXuSfx61+tldzbOOGckvp1ERq14gKUwM/RheDwnQ1f+ZxKk3e0OQzs
 P/F5Iehvaj1MRC46kuAGiB+oZXo8mK6+P/1qknWsoYVyqhXfMGkFAYNl9
 Jsxx3oW4LheNwEM6s75tzB4ZVo/dixxmRBcSNd5xUd2k5IG3RblKT7BmR w==;
X-CSE-ConnectionGUID: wet40tHzRJmqCIHeXfa1BA==
X-CSE-MsgGUID: u/LptOh5RUGaOzpgJho+GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991747"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:22 -0800
X-CSE-ConnectionGUID: ChVtvqZPQGOrCDZ3YPORIA==
X-CSE-MsgGUID: icn6M9o0Qt+SyoLM3IgtFg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 18/31] app/testpmd: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:35 +0000
Message-ID: <20251201114448.1441377-19-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline_flow.c | 42 ++++++++++++++++++-------------------
 app/test-pmd/config.c       | 15 +++++--------
 app/test-pmd/parameters.c   | 38 ++++++++++++++++-----------------
 app/test-pmd/testpmd.c      |  2 +-
 4 files changed, 45 insertions(+), 52 deletions(-)

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
index 6ea506254b..b6d194340b 100644
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
index 96973906fd..f2037925c2 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -777,42 +777,42 @@ parse_ringnuma_config(const char *q_arg)
 }
 
 static int
-parse_event_printing_config(const char *optarg, int enable)
+parse_event_printing_config(const char *event_arg, int enable)
 {
 	uint32_t mask = 0;
 
-	if (!strcmp(optarg, "unknown"))
+	if (!strcmp(event_arg, "unknown"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_UNKNOWN;
-	else if (!strcmp(optarg, "intr_lsc"))
+	else if (!strcmp(event_arg, "intr_lsc"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_INTR_LSC;
-	else if (!strcmp(optarg, "queue_state"))
+	else if (!strcmp(event_arg, "queue_state"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_QUEUE_STATE;
-	else if (!strcmp(optarg, "intr_reset"))
+	else if (!strcmp(event_arg, "intr_reset"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_INTR_RESET;
-	else if (!strcmp(optarg, "vf_mbox"))
+	else if (!strcmp(event_arg, "vf_mbox"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_VF_MBOX;
-	else if (!strcmp(optarg, "ipsec"))
+	else if (!strcmp(event_arg, "ipsec"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_IPSEC;
-	else if (!strcmp(optarg, "macsec"))
+	else if (!strcmp(event_arg, "macsec"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_MACSEC;
-	else if (!strcmp(optarg, "intr_rmv"))
+	else if (!strcmp(event_arg, "intr_rmv"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_INTR_RMV;
-	else if (!strcmp(optarg, "dev_probed"))
+	else if (!strcmp(event_arg, "dev_probed"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_NEW;
-	else if (!strcmp(optarg, "dev_released"))
+	else if (!strcmp(event_arg, "dev_released"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_DESTROY;
-	else if (!strcmp(optarg, "flow_aged"))
+	else if (!strcmp(event_arg, "flow_aged"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_FLOW_AGED;
-	else if (!strcmp(optarg, "err_recovering"))
+	else if (!strcmp(event_arg, "err_recovering"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_ERR_RECOVERING;
-	else if (!strcmp(optarg, "recovery_success"))
+	else if (!strcmp(event_arg, "recovery_success"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_RECOVERY_SUCCESS;
-	else if (!strcmp(optarg, "recovery_failed"))
+	else if (!strcmp(event_arg, "recovery_failed"))
 		mask = UINT32_C(1) << RTE_ETH_EVENT_RECOVERY_FAILED;
-	else if (!strcmp(optarg, "all"))
+	else if (!strcmp(event_arg, "all"))
 		mask = ~UINT32_C(0);
 	else {
-		fprintf(stderr, "Invalid event: %s\n", optarg);
+		fprintf(stderr, "Invalid event: %s\n", event_arg);
 		return -1;
 	}
 	if (enable)
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
index 1fe41d852a..41695afd42 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4660,7 +4660,7 @@ main(int argc, char** argv)
 
 #ifdef RTE_LIB_LATENCYSTATS
 	if (latencystats_enabled != 0) {
-		int ret = rte_latencystats_init(1, NULL);
+		ret = rte_latencystats_init(1, NULL);
 		if (ret)
 			fprintf(stderr,
 				"Warning: latencystats init() returned error %d\n",
-- 
2.51.0

