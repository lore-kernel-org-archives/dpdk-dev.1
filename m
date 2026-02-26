Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A94FD9E1F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 23:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58F504028E;
	Fri, 27 Feb 2026 00:23:31 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 452B540265
 for <dev@dpdk.org>; Fri, 27 Feb 2026 00:23:29 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb3825b0fbso145911085a.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772148208;
 x=1772753008; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeHGpVOhQW+uLXM+gY2kKajuPA6T4TKb74+SjCFObd4=;
 b=tS2pHcNcpl1pNobOe9MeEQMwxPPhlw94+KVXnSOSFyRGPav/cuISbLChw05Pen2hHm
 LioYNA73gsA6kc62WapRyGYgVu/gkYGVO+xprEqSNwcIHJPy7+tTpQncYh5hYr6WT0i4
 Ljxe2u/IziGgA21I7Sfe/3OuC/+l1LnHKhsXqYd9vGH2SZW7MMVlfcG7m+O5AgTaV+9G
 Wp4GcBDY2TsJaAMar1Xas0bTrBQFa5httcnMJD2lVfeyi/xkTbWPzL1aKbNti5Z7PYkX
 7ErfvV5mcXipXepdyV93gI/wEn6Pni9H2WuxHLQCu5uKER80C2Df8WtlbYW9vCu3JL0Q
 GoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772148208; x=1772753008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xeHGpVOhQW+uLXM+gY2kKajuPA6T4TKb74+SjCFObd4=;
 b=J/+VfhQ6SeGTNQnIi8GKzuKFd+1QYiov4PWLsN+VkasmRa1It9Xi/BMoiyAXRxFnI7
 zkMxn6dyZ8yoPSepBMOkLKrjsX1nI4CWS3x4S8AP/OX3tLGZpRGxG9NKkqxwm2fRC7hx
 I0QX7l4yQRBdN+SWAfQjLeGXJRTXZn595m/GLd6CcjGIUprStkgb+L47LYPG76nHk6EA
 /OXTiKQjxEOZaPDD3d/5S99gryh10K0AwEdwfvLFTPs/UjLKTCa2m9TfqXaIGhKOO9Y1
 Arz4JnKVxBPnvsMEg6gM5ECx2i1xA1fsvdZT2TxMHcmT/ZE3vSAyjVYLxM/q015OUEK1
 6zxA==
X-Gm-Message-State: AOJu0Yy7PFjZ06xMW9XD3RUu17qNMkchjEosFqE98GrEikELzLMK2yc3
 U8F4Ft+9QKkcaWT2SVkntZFhk2WC5E5QlZOgeu2/iNAwDJfk0SQd8aMscVq4Y2SFyvC1Jk97coV
 e8LSM
X-Gm-Gg: ATEYQzzp+JBYqi8eBzseHs96qMXyb+uKWmlxHd1X4UQfBiAt8X8bNlYMnrSsrHisMhj
 TAEcwCQ61jC4Shw6xodWML7zOaB88eL/cjbcumivU2OmdIR8oUytY5osnAJI0fCrH6DTEESYJIQ
 tXg7PMxZkTInL7w5lboze1qS3/O40xyFP+17aiL2cu2ccytC4JlD1CRvf1OQ7tZMNuKAxoijaQY
 zAhQpjj/r75XjLrPOZiKnHLGMHoLrPf5HxTxoUVQ37SXoDsqGV2m+FNthkdH3RpaMoWKf8tF27T
 nTUV2naU/Tr1u9xW1axSasuEZrnENKIz/FAMH/JYvaX42kLa4mN/Knr4tYN5m0JELIT54bqX+1P
 009NYR1H5Yv4Z/zrW/st6XItI2/5y1TKBRT1bj8a4C8i7niq0lm1SRB6FAHmz0mXAYVSfJtHrEi
 TGo1l6aSSNXMsIkAeGnxOQhmiSEgC6uIU7kF7dIdf5UhMNjNuCBhT0IBXFwfIz3Q==
X-Received: by 2002:a05:620a:2a04:b0:8c6:ae78:f750 with SMTP id
 af79cd13be357-8cbc8d67d85mr104015585a.14.1772148208188; 
 Thu, 26 Feb 2026 15:23:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c73a3130sm29638046d6.49.2026.02.26.15.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:23:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: longli@microsoft.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] app/testpmd: add configurable flow count for txonly multi-flow
Date: Thu, 26 Feb 2026 15:21:43 -0800
Message-ID: <20260226232323.545972-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226191625.1049670-1-longli@microsoft.com>
References: <20260226191625.1049670-1-longli@microsoft.com>
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

Started with Long's patch to change port and added a parameter.
This is suggestion only *DO NOT MERGE*
Not sure what good name for parameter is, this is just a quick hack.

The txonly multi-flow mode generates 64 unique UDP source ports per
lcore by cycling the high byte from 0xC0 to 0xFF. On SmartNICs with
limited hardware flow table caching, this fixed count can exhaust the
flow cache and degrade receive-side performance.

Add --txonly-nb-flows=N command line parameter and 'set txonly-nb-flows'
runtime command to limit the number of unique source ports per lcore
to between 1 and 64. The default remains 64 to preserve existing
behavior.

The source port encoding is unchanged: the low byte carries the lcore
ID (avoiding atomics) and the high byte cycles through N values
starting at 0xC0. Total unique flows = txonly_nb_flows * active_lcores.

Reported-by: Long Li <longli@microsoft.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

 app/test-pmd/cmdline.c                      | 49 +++++++++++++++++++++
 app/test-pmd/parameters.c                   | 13 ++++++
 app/test-pmd/testpmd.c                      |  3 ++
 app/test-pmd/testpmd.h                      |  1 +
 app/test-pmd/txonly.c                       | 24 +++++-----
 doc/guides/testpmd_app_ug/run_app.rst       |  8 ++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 16 +++++++
 7 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..debd226762 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -384,6 +384,10 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Set the scheduling on timestamps"
 			" timings for the TXONLY mode\n\n"
 
+			"set txonly-nb-flows (N)\n"
+			"    Set the number of flows per lcore in"
+			" txonly multi-flow mode (1-64)\n\n"
+
 			"set corelist (x[,y]*)\n"
 			"    Set the list of forwarding cores.\n\n"
 
@@ -4612,6 +4616,50 @@ static cmdline_parse_inst_t cmd_set_txtimes = {
 	},
 };
 
+/* *** SET NUMBER OF FLOWS IN TXONLY MULTI-FLOW MODE *** */
+
+struct cmd_set_txonly_nb_flows_result {
+	cmdline_fixed_string_t cmd_keyword;
+	cmdline_fixed_string_t name;
+	uint16_t value;
+};
+
+static void
+cmd_set_txonly_nb_flows_parsed(void *parsed_result,
+			       __rte_unused struct cmdline *cl,
+			       __rte_unused void *data)
+{
+	struct cmd_set_txonly_nb_flows_result *res = parsed_result;
+
+	if (res->value < 1 || res->value > 64) {
+		fprintf(stderr, "txonly-nb-flows must be >= 1 and <= 64\n");
+		return;
+	}
+	txonly_nb_flows = res->value;
+}
+
+static cmdline_parse_token_string_t cmd_set_txonly_nb_flows_keyword =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
+				 cmd_keyword, "set");
+static cmdline_parse_token_string_t cmd_set_txonly_nb_flows_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
+				 name, "txonly-nb-flows");
+static cmdline_parse_token_num_t cmd_set_txonly_nb_flows_value =
+	TOKEN_NUM_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
+			      value, RTE_UINT16);
+
+static cmdline_parse_inst_t cmd_set_txonly_nb_flows = {
+	.f = cmd_set_txonly_nb_flows_parsed,
+	.data = NULL,
+	.help_str = "set txonly-nb-flows <N>",
+	.tokens = {
+		(void *)&cmd_set_txonly_nb_flows_keyword,
+		(void *)&cmd_set_txonly_nb_flows_name,
+		(void *)&cmd_set_txonly_nb_flows_value,
+		NULL,
+	},
+};
+
 /* *** ADD/REMOVE ALL VLAN IDENTIFIERS TO/FROM A PORT VLAN RX FILTER *** */
 struct cmd_rx_vlan_filter_all_result {
 	cmdline_fixed_string_t rx_vlan;
@@ -14102,6 +14150,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_txpkts,
 	&cmd_set_txsplit,
 	&cmd_set_txtimes,
+	&cmd_set_txonly_nb_flows,
 	&cmd_set_fwd_list,
 	&cmd_set_fwd_mask,
 	&cmd_set_fwd_mode,
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index f2037925c2..2432d720fb 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -193,6 +193,8 @@ enum {
 	TESTPMD_OPT_MULTI_RX_MEMPOOL_NUM,
 #define TESTPMD_OPT_TXONLY_MULTI_FLOW "txonly-multi-flow"
 	TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM,
+#define TESTPMD_OPT_TXONLY_NB_FLOWS "txonly-nb-flows"
+	TESTPMD_OPT_TXONLY_NB_FLOWS_NUM,
 #define TESTPMD_OPT_RXQ_SHARE "rxq-share"
 	TESTPMD_OPT_RXQ_SHARE_NUM,
 #define TESTPMD_OPT_ETH_LINK_SPEED "eth-link-speed"
@@ -348,6 +350,7 @@ static const struct option long_options[] = {
 	REQUIRED_ARG(TESTPMD_OPT_TXPKTS),
 	NO_ARG(TESTPMD_OPT_MULTI_RX_MEMPOOL),
 	NO_ARG(TESTPMD_OPT_TXONLY_MULTI_FLOW),
+	REQUIRED_ARG(TESTPMD_OPT_TXONLY_NB_FLOWS),
 	OPTIONAL_ARG(TESTPMD_OPT_RXQ_SHARE),
 	REQUIRED_ARG(TESTPMD_OPT_ETH_LINK_SPEED),
 	NO_ARG(TESTPMD_OPT_DISABLE_LINK_CHECK),
@@ -499,6 +502,8 @@ usage(char* progname)
 		" or total packet length.\n");
 	printf("  --multi-rx-mempool: enable multi-rx-mempool support\n");
 	printf("  --txonly-multi-flow: generate multiple flows in txonly mode\n");
+	printf("  --txonly-nb-flows=N: number of flows per lcore in txonly"
+	       " multi-flow mode (1-64, default 64)\n");
 	printf("  --tx-ip=src,dst: IP addresses in Tx-only mode\n");
 	printf("  --tx-udp=src[,dst]: UDP ports in Tx-only mode\n");
 	printf("  --eth-link-speed: force link speed.\n");
@@ -1566,6 +1571,14 @@ launch_args_parse(int argc, char** argv)
 		case TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM:
 			txonly_multi_flow = 1;
 			break;
+		case TESTPMD_OPT_TXONLY_NB_FLOWS_NUM:
+			n = atoi(optarg);
+			if (n >= 1 && n <= 64)
+				txonly_nb_flows = (uint16_t)n;
+			else
+				rte_exit(EXIT_FAILURE,
+					 "txonly-nb-flows must be >= 1 and <= 64\n");
+			break;
 		case TESTPMD_OPT_RXQ_SHARE_NUM:
 			if (optarg == NULL) {
 				rxq_share = UINT32_MAX;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fbacee89ea..6661bf16cd 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -287,6 +287,9 @@ enum tx_pkt_split tx_pkt_split = TX_PKT_SPLIT_OFF;
 uint8_t txonly_multi_flow;
 /**< Whether multiple flows are generated in TXONLY mode. */
 
+uint16_t txonly_nb_flows = 64;
+/**< Number of unique flows per lcore in TXONLY multi-flow mode. */
+
 uint32_t tx_pkt_times_inter;
 /**< Timings for send scheduling in TXONLY mode, time between bursts. */
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index f319471c73..13c3915848 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -673,6 +673,7 @@ enum tx_pkt_split {
 extern enum tx_pkt_split tx_pkt_split;
 
 extern uint8_t txonly_multi_flow;
+extern uint16_t txonly_nb_flows; /**< Number of flows in txonly multi-flow */
 
 extern uint32_t rxq_share;
 
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index bdcf6ea660..7ba9abf656 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -223,18 +223,22 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 				sizeof(struct rte_ether_hdr) +
 				sizeof(struct rte_ipv4_hdr));
 		/*
-		 * Generate multiple flows by varying UDP source port.
-		 * This enables packets are well distributed by RSS in
-		 * receiver side if any and txonly mode can be a decent
-		 * packet generator for developer's quick performance
-		 * regression test.
+		 * Generate a configurable number of flows per lcore by
+		 * varying the UDP source port. The low byte is the lcore
+		 * ID, ensuring each lcore produces unique ports without
+		 * atomic operations. The high byte cycles through
+		 * txonly_nb_flows values starting at 0xC0, keeping ports
+		 * in the ephemeral range 49152-65535 (RFC 6335).
 		 *
-		 * Only ports in the range 49152 (0xC000) and 65535 (0xFFFF)
-		 * will be used, with the least significant byte representing
-		 * the lcore ID. As such, the most significant byte will cycle
-		 * through 0xC0 and 0xFF.
+		 * Total unique flows = txonly_nb_flows * active_lcores.
+		 *
+		 * Note: lcore IDs above 255 will alias in the low byte,
+		 * causing flow overlap between those lcores. This is
+		 * acceptable as the total flow count at that scale
+		 * already exceeds typical hardware flow table sizes.
 		 */
-		src_port = ((src_var++ | 0xC0) << 8) + rte_lcore_id();
+		src_port = (((src_var++ % txonly_nb_flows) + 0xC0) << 8)
+			   + rte_lcore_id();
 		udp_hdr->src_port = rte_cpu_to_be_16(src_port);
 		RTE_PER_LCORE(_src_port_var) = src_var;
 	}
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 97d6c75716..a4a57ea383 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -386,6 +386,14 @@ The command line options are:
 
     Generate multiple flows in txonly mode.
 
+*   ``--txonly-nb-flows=N``
+
+    Set the number of unique flows per lcore when txonly multi-flow mode
+    is enabled. Valid range is 1 to 64. Default is 64, which preserves
+    the original behavior. Reducing this value limits the number of unique
+    UDP source ports generated, which can prevent exhaustion of hardware
+    flow table entries on SmartNICs.
+
 *   ``--rxq-share=[X]``
 
     Create queues in shared Rx queue mode if device supports.
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 62bb167d56..ff1c8a444d 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -924,6 +924,22 @@ Where:
 
 * ``rand`` same as 'on', but number of segments per each packet is a random value between 1 and total number of segments.
 
+set txonly-nb-flows
+~~~~~~~~~~~~~~~~~~~
+
+Set the number of unique flows per lcore in txonly multi-flow mode::
+
+   testpmd> set txonly-nb-flows <N>
+
+Where ``N`` is the number of unique UDP source port values each lcore will
+cycle through, in the range 1 to 64. Default is 64.
+
+Each lcore generates unique flows by combining the flow index with its lcore
+ID, so the total number of unique flows across the system is
+``txonly-nb-flows * active_lcores``. Reducing this value can prevent exhaustion
+of hardware flow table entries on SmartNICs that have limited flow caching
+capacity.
+
 set corelist
 ~~~~~~~~~~~~
 
-- 
2.51.0

