Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76606104891F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 22:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E1AB4060F;
	Fri, 27 Feb 2026 23:44:12 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 6EFDC402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 23:44:10 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-899a5cb04f9so34189866d6.2
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772232249;
 x=1772837049; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzRc52OJ7OU6JlxwkUsHGJssvnpn6iZzeZpmVESut3k=;
 b=x6VJMaUglpSlubzpLzkGYkSJ5ustxcW6nIU6JhZxZOqOafOWujhs7YmHklrnm92b4r
 fqMSLkdbZW78xjIQkLraRBaaaJWb07UMBfG0V8chnsNN0VAXjAqC2eYLMPhy6wUopyWB
 S2H2Stja+biNl/GO6+ExNDAFM98tuVr6jm1Xj/xXAne5r6roKy7MjMISDrVktH7KWuTJ
 p6GjNyQOdzugPMViH8tp1Y5hcIQi1Jkdfj//aS590qqkVJf0ggM94Z485F90043Q5BLU
 OoMNoAReDLTzVMnrDhB5KgVbM6VmkqQt9l+Gl3o5c+ehbXt7vu7Zx0dvd0k8k8PyUViZ
 NUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232249; x=1772837049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzRc52OJ7OU6JlxwkUsHGJssvnpn6iZzeZpmVESut3k=;
 b=jjNWFBhCLsIzXHfjQv+KP+XUhNXl+qaxs3wOF5nsepuX0KNWtQ1ovNE6tPk01Kke2Y
 KkxfW7sMNwQjc2ZK0bLXcYw6AzH6870jU3nUOSM49KIuMMDXdRBGBYdm1wsmZezu3n7C
 GPJ6xpUxYMvN6FKf/0XmY4fVQZkv4GrmgJwdrhAhr28JpTiawcu+o1z3lFjuRnJjnmWK
 XTzv58+KQYf9ZIGB5tD+UJTrqTrs6jhW42VYpo7VcL0N5ACPAr5Igey4vzktnCLaZrq/
 sJGuzxNQbgUEDAx3EiLh4DlFs7W7mctr0lVABY+6ZjMRJCYEOSkeaiZcSHTIicdcUQ0z
 mmGw==
X-Gm-Message-State: AOJu0Yx+Z6u0/tAyREcCVyGjTD7uwEXnxcw9XzXKgIpvhvMG0dJGxfwW
 4a/2dX6ytd5y5MK33PipClOKMUG1fgVHum8tq+ockfB/2R+shxQI8Rjq0tavcwPgZMzUw8PgI/o
 gWGxr
X-Gm-Gg: ATEYQzzzet1LA9XU3BWzwIkTy6wMILVOGek4fnhL4li1QhFKCsIOxta9QRmakxsIBbf
 sbZlf9c+vtOjW/aYWK42qpYtRGAyUFsA+PTEplemYoEHdh3Rg5cp2TrBb5jF2OlX5vfR89IW2mD
 b5KgGl+FPLltfOm0E5WNJjHAvLIJ8oVJNMBpzelBBKtoK2R2tHxLALm2P1+Us0p4XCLcopKZMBR
 GoKQloTYwPz9jVsFcQCSxZLjuThEV66g0n5Zg3K6qR/THodzpryBdfrBGTEjm7PfHVugWT5yPus
 X8HrX+/Rv4Ely7pE5y0ruX6zAZA2dp4NBCiOeyC4m22pcHJbNsNheIrdA6erqAcgh6t6CGc2Si1
 +q/buRHFulzzLI7QpPTknVvzD6QK54/2GX0U5l4rjrVtD7QV+9tSd60/3yCn9nGDVOCc1zHfBaZ
 v9GMRzUiWKFbcpxCgP/ASpJEZRY8AlRps3PGcKRirJkes+pIuXFr5IWIAUcBspvw==
X-Received: by 2002:a05:6214:300b:b0:897:b90:3628 with SMTP id
 6a1803df08f44-899d1d75b7bmr71099516d6.7.1772232249569; 
 Fri, 27 Feb 2026 14:44:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f926csm578154285a.32.2026.02.27.14.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 14:44:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2] app/testpmd: add configurable flow count for txonly
 multi-flow
Date: Fri, 27 Feb 2026 14:43:19 -0800
Message-ID: <20260227224405.61074-1-stephen@networkplumber.org>
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

The txonly multi-flow mode generates 64 unique UDP source ports per
lcore by cycling the high byte from 0xC0 to 0xFF. On SmartNICs with
limited hardware flow table caching, this fixed count can exhaust the
flow cache and degrade receive-side performance.

Add --txonly-flows=N command line parameter and 'set txonly-flows'
runtime command to limit the number of unique source ports per lcore
to between 1 and 64. The default remains 64 to preserve existing
behavior.

The source port encoding is unchanged: the low byte carries the lcore
ID (avoiding atomics) and the high byte cycles through N values
starting at 0xC0. Total unique flows = txonly_nb_flows * active_lcores.

Reported-by: Long Li <longli@microsoft.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Long Li <longli@microsoft.com>

---
v2 - rename to shorter command line option

 app/test-pmd/cmdline.c                      | 49 +++++++++++++++++++++
 app/test-pmd/parameters.c                   | 12 +++++
 app/test-pmd/testpmd.c                      |  3 ++
 app/test-pmd/testpmd.h                      |  1 +
 app/test-pmd/txonly.c                       | 19 ++++----
 doc/guides/testpmd_app_ug/run_app.rst       |  6 +++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 17 +++++++
 7 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..a0d6ee37aa 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -384,6 +384,10 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Set the scheduling on timestamps"
 			" timings for the TXONLY mode\n\n"
 
+			"set txflows (N)\n"
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
+struct cmd_set_txflows_result {
+	cmdline_fixed_string_t cmd_keyword;
+	cmdline_fixed_string_t name;
+	uint16_t value;
+};
+
+static void
+cmd_set_txflows_parsed(void *parsed_result,
+			       __rte_unused struct cmdline *cl,
+			       __rte_unused void *data)
+{
+	struct cmd_set_txflows_result *res = parsed_result;
+
+	if (res->value < 1 || res->value > 64) {
+		fprintf(stderr, "txonly-flows must be >= 1 and <= 64\n");
+		return;
+	}
+	txonly_flows = res->value;
+}
+
+static cmdline_parse_token_string_t cmd_set_txflows_keyword =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_txflows_result,
+				 cmd_keyword, "set");
+static cmdline_parse_token_string_t cmd_set_txflows_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_txflows_result,
+				 name, "txonly-flows");
+static cmdline_parse_token_num_t cmd_set_txflows_value =
+	TOKEN_NUM_INITIALIZER(struct cmd_set_txflows_result,
+			      value, RTE_UINT16);
+
+static cmdline_parse_inst_t cmd_set_txflows = {
+	.f = cmd_set_txflows_parsed,
+	.data = NULL,
+	.help_str = "set txonly-flows <N>",
+	.tokens = {
+		(void *)&cmd_set_txflows_keyword,
+		(void *)&cmd_set_txflows_name,
+		(void *)&cmd_set_txflows_value,
+		NULL,
+	},
+};
+
 /* *** ADD/REMOVE ALL VLAN IDENTIFIERS TO/FROM A PORT VLAN RX FILTER *** */
 struct cmd_rx_vlan_filter_all_result {
 	cmdline_fixed_string_t rx_vlan;
@@ -14099,6 +14147,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_rxoffs,
 	&cmd_set_rxpkts,
 	&cmd_set_rxhdrs,
+	&cmd_set_txflows,
 	&cmd_set_txpkts,
 	&cmd_set_txsplit,
 	&cmd_set_txtimes,
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index f2037925c2..3617860830 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -193,6 +193,8 @@ enum {
 	TESTPMD_OPT_MULTI_RX_MEMPOOL_NUM,
 #define TESTPMD_OPT_TXONLY_MULTI_FLOW "txonly-multi-flow"
 	TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM,
+#define TESTPMD_OPT_TXONLY_FLOWS "txonly-flows"
+	TESTPMD_OPT_TXONLY_FLOWS_NUM,
 #define TESTPMD_OPT_RXQ_SHARE "rxq-share"
 	TESTPMD_OPT_RXQ_SHARE_NUM,
 #define TESTPMD_OPT_ETH_LINK_SPEED "eth-link-speed"
@@ -348,6 +350,7 @@ static const struct option long_options[] = {
 	REQUIRED_ARG(TESTPMD_OPT_TXPKTS),
 	NO_ARG(TESTPMD_OPT_MULTI_RX_MEMPOOL),
 	NO_ARG(TESTPMD_OPT_TXONLY_MULTI_FLOW),
+	REQUIRED_ARG(TESTPMD_OPT_TXONLY_FLOWS),
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
@@ -1566,6 +1571,13 @@ launch_args_parse(int argc, char** argv)
 		case TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM:
 			txonly_multi_flow = 1;
 			break;
+		case TESTPMD_OPT_TXONLY_FLOWS_NUM:
+			n = atoi(optarg);
+			if (n >= 1 && n <= 64)
+				txonly_flows = (uint16_t)n;
+			else
+				rte_exit(EXIT_FAILURE, "txonly-flows must be >= 1 and <= 64\n");
+			break;
 		case TESTPMD_OPT_RXQ_SHARE_NUM:
 			if (optarg == NULL) {
 				rxq_share = UINT32_MAX;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fbacee89ea..aad880aa34 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -287,6 +287,9 @@ enum tx_pkt_split tx_pkt_split = TX_PKT_SPLIT_OFF;
 uint8_t txonly_multi_flow;
 /**< Whether multiple flows are generated in TXONLY mode. */
 
+uint16_t txonly_flows = 64;
+/**< Number of unique flows per lcore in TXONLY multi-flow mode. */
+
 uint32_t tx_pkt_times_inter;
 /**< Timings for send scheduling in TXONLY mode, time between bursts. */
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index f319471c73..af185540c3 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -673,6 +673,7 @@ enum tx_pkt_split {
 extern enum tx_pkt_split tx_pkt_split;
 
 extern uint8_t txonly_multi_flow;
+extern uint16_t txonly_flows;
 
 extern uint32_t rxq_share;
 
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index bdcf6ea660..64893fa205 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -223,18 +223,17 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
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
+		 * txonly_flows values starting at 0xC0, keeping ports
+		 * in the ephemeral range 49152-65535 (RFC 6335).
 		 *
-		 * Only ports in the range 49152 (0xC000) and 65535 (0xFFFF)
-		 * will be used, with the least significant byte representing
-		 * the lcore ID. As such, the most significant byte will cycle
-		 * through 0xC0 and 0xFF.
+		 * Total unique flows = txonly_flows * active_lcores.
 		 */
-		src_port = ((src_var++ | 0xC0) << 8) + rte_lcore_id();
+		src_port = (((src_var++ % txonly_flows) + 0xC0) << 8)
+			   + rte_lcore_id();
 		udp_hdr->src_port = rte_cpu_to_be_16(src_port);
 		RTE_PER_LCORE(_src_port_var) = src_var;
 	}
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 97d6c75716..0340b3e2b3 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -386,6 +386,12 @@ The command line options are:
 
     Generate multiple flows in txonly mode.
 
+*   ``--txonly-flows=N``
+
+    Set the number of unique flows per lcore when txonly multi-flow mode
+    is enabled. Valid range is 1 to 64. Default is 64.
+    Reducing this value limits the number of unique UDP source ports generated.
+
 *   ``--rxq-share=[X]``
 
     Create queues in shared Rx queue mode if device supports.
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 62bb167d56..6695940dd2 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -924,6 +924,23 @@ Where:
 
 * ``rand`` same as 'on', but number of segments per each packet is a random value between 1 and total number of segments.
 
+set txonly-flows
+~~~~~~~~~~~~~~~~
+
+Set the number of unique flows per lcore in txonly multi-flow mode::
+
+   testpmd> set txonly-flows <N>
+
+Where ``N`` is the number of unique UDP source port values each lcore will
+cycle through, in the range 1 to 64. Default is 64. The UDP port value
+is in ephemeral range 49152-65535 (RFC 6335). The least signficant byte
+of the port is the core id, and the most significant byte cycles throgh
+the range of ``N``.
+
+Each lcore generates unique flows by combining the flow index with its lcore
+ID, so the total number of unique flows across the system is
+``txonly-flows * active_lcores``.
+
 set corelist
 ~~~~~~~~~~~~
 
-- 
2.51.0

