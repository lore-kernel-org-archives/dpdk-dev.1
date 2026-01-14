Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9BCD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8F6440E96;
	Wed, 14 Jan 2026 16:45:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id EBCED406B7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405550; x=1799941550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LNuSoXl4gEFmhFUktIexT/zi68ZoSQOtf5AFEyc0XSM=;
 b=QNIGxeDxyFElYiNV1xqkGSeXT7jh0aYylWGN59cojaWuD9tMD5aJlpfu
 hcd1wwnKY7VbOoxuFchVgRAid3C7DKp5hydgSQKfqL0rxyoX1Kp2Bw4pq
 aO1s68uQzqIe0QDKfNV5pgVLlfk8a7ejUB9TEV82Cp5CTSsGNQtt+rP94
 916YjZRkJaTt4nvPd5nR5mfxJh9/r3JOx8bVdOmlzz0Oo9Pn2xk6fvpit
 jXrUOfgeVIVG+HqYvWNNvaPvjx8ttvvI0QFFS1a22LUY+A51HxZSkRP4+
 u8HHbGnxSZRWO6niCRwHFsMko4vULOnI9q+lkf3o24elxX5wk16pRjuN7 A==;
X-CSE-ConnectionGUID: ZlfuPX4ER+GCyHB26Vix7g==
X-CSE-MsgGUID: L+MQbLnYSyOWxiPib5U5lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870945"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870945"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:44 -0800
X-CSE-ConnectionGUID: eIqq+smFToqugbMW7JB24Q==
X-CSE-MsgGUID: shQpCn0VT5W/ckO5NRoA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925073"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v4 26/31] app/test-security-perf: fix build with shadow
 warnings
Date: Wed, 14 Jan 2026 15:44:40 +0000
Message-ID: <20260114154450.2969716-27-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

Rename variables to eliminate variable shadowing.

NOTE: The test-security-perf app reuses code from "dpdk-test" app, so
some changes are made there too.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-security-perf/test_security_perf.c | 42 ++++++++++-----------
 app/test/test_cryptodev_security_ipsec.c    | 13 +++----
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/app/test-security-perf/test_security_perf.c b/app/test-security-perf/test_security_perf.c
index b0d55cbab0..dd377a6027 100644
--- a/app/test-security-perf/test_security_perf.c
+++ b/app/test-security-perf/test_security_perf.c
@@ -43,7 +43,7 @@ struct test_ctx {
 	bool is_inbound;
 };
 
-static struct test_ctx ctx;
+static struct test_ctx test_ctx;
 
 static int
 cryptodev_init(struct test_ctx *ctx, uint8_t nb_lcores)
@@ -355,7 +355,7 @@ test_security_session_perf(void *arg)
 		nb_sessions += (nb_sess_total - nb_sessions * nb_lcores);
 
 	ret = sec_conf_init(conf, &sess_conf, &ipsec_xform,
-			    &ctx.td[ctx.td_idx]);
+			    &test_ctx.td[test_ctx.td_idx]);
 	if (ret) {
 		RTE_LOG(ERR, USER1, "Could not initialize session conf\n");
 		return EXIT_FAILURE;
@@ -447,14 +447,14 @@ args_parse(int argc, char **argv)
 			if (strcmp(lgopts[opt_idx].name, "nb-sess") == 0) {
 				n = atoi(optarg);
 				if (n >= 0)
-					ctx.nb_sess = n;
+					test_ctx.nb_sess = n;
 				else
 					rte_exit(EXIT_FAILURE,
 						"nb-sess should be >= 0\n");
-				printf("nb-sess %d / ", ctx.nb_sess);
+				printf("nb-sess %d / ", test_ctx.nb_sess);
 			} else if (strcmp(lgopts[opt_idx].name, "inbound") ==
 				   0) {
-				ctx.is_inbound = true;
+				test_ctx.is_inbound = true;
 				printf("inbound / ");
 			}
 
@@ -482,7 +482,7 @@ main(int argc, char **argv)
 	unsigned long i;
 	int ret;
 
-	memset(&ctx, 0, sizeof(struct test_ctx));
+	memset(&test_ctx, 0, sizeof(struct test_ctx));
 	memset(&flags, 0, sizeof(flags));
 
 	ret = rte_eal_init(argc, argv);
@@ -498,18 +498,18 @@ main(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	ctx.nb_sess = DEF_NB_SESSIONS + RTE_MEMPOOL_CACHE_MAX_SIZE * nb_lcores;
+	test_ctx.nb_sess = DEF_NB_SESSIONS + RTE_MEMPOOL_CACHE_MAX_SIZE * nb_lcores;
 
 	if (argc > 1)
 		args_parse(argc, argv);
 
-	ctx.nb_lcores = nb_lcores;
+	test_ctx.nb_lcores = nb_lcores;
 
-	ret = cryptodev_init(&ctx, nb_lcores);
+	ret = cryptodev_init(&test_ctx, nb_lcores);
 	if (ret)
 		goto exit;
 
-	ret = mempool_init(&ctx, nb_lcores);
+	ret = mempool_init(&test_ctx, nb_lcores);
 	if (ret)
 		goto cryptodev_fini;
 
@@ -521,19 +521,19 @@ main(int argc, char **argv)
 				      &flags,
 				      &td_outb[i],
 				      1);
-		if (ctx.is_inbound)
+		if (test_ctx.is_inbound)
 			test_ipsec_td_in_from_out(&td_outb[i], &td_inb[i]);
 	}
 
-	ctx.td = td_outb;
-	if (ctx.is_inbound)
-		ctx.td = td_inb;
+	test_ctx.td = td_outb;
+	if (test_ctx.is_inbound)
+		test_ctx.td = td_inb;
 
-	for (ctx.td_idx = 0; ctx.td_idx < RTE_DIM(sec_alg_list); ctx.td_idx++) {
+	for (test_ctx.td_idx = 0; test_ctx.td_idx < RTE_DIM(sec_alg_list); test_ctx.td_idx++) {
 
 		printf("\n\n    Algorithm combination:");
-		test_sec_alg_display(sec_alg_list[ctx.td_idx].param1,
-				     sec_alg_list[ctx.td_idx].param2);
+		test_sec_alg_display(sec_alg_list[test_ctx.td_idx].param1,
+				     sec_alg_list[test_ctx.td_idx].param2);
 		printf("    ----------------------");
 
 		printf("\n%20s%20s%20s%20s%20s%20s\n\n",
@@ -545,7 +545,7 @@ main(int argc, char **argv)
 		i = 0;
 		RTE_LCORE_FOREACH_WORKER(lcore_id) {
 			rte_eal_remote_launch(test_security_session_perf,
-					      &ctx.lconf[i],
+					      &test_ctx.lconf[i],
 					      lcore_id);
 			i++;
 		}
@@ -556,12 +556,12 @@ main(int argc, char **argv)
 
 	}
 
-	cryptodev_fini(&ctx);
-	mempool_fini(&ctx);
+	cryptodev_fini(&test_ctx);
+	mempool_fini(&test_ctx);
 
 	return EXIT_SUCCESS;
 cryptodev_fini:
-	cryptodev_fini(&ctx);
+	cryptodev_fini(&test_ctx);
 exit:
 	return EXIT_FAILURE;
 
diff --git a/app/test/test_cryptodev_security_ipsec.c b/app/test/test_cryptodev_security_ipsec.c
index 2576afbd99..bc1b392da7 100644
--- a/app/test/test_cryptodev_security_ipsec.c
+++ b/app/test/test_cryptodev_security_ipsec.c
@@ -264,11 +264,10 @@ test_ipsec_td_prepare(const struct crypto_param *param1,
 
 {
 	struct ipsec_test_data *td;
-	int i;
 
 	memset(td_array, 0, nb_td * sizeof(*td));
 
-	for (i = 0; i < nb_td; i++) {
+	for (int i = 0; i < nb_td; i++) {
 		td = &td_array[i];
 
 		/* Prepare fields based on param */
@@ -339,7 +338,6 @@ test_ipsec_td_prepare(const struct crypto_param *param1,
 			struct rte_tcp_hdr *tcp;
 			int64_t payload_len;
 			uint8_t *data;
-			int64_t i;
 
 			payload_len = RTE_MIN(flags->plaintext_len, IPSEC_TEXT_MAX_LEN);
 			payload_len -= sizeof(struct rte_ipv6_hdr);
@@ -355,8 +353,8 @@ test_ipsec_td_prepare(const struct crypto_param *param1,
 			/* TCP */
 			tcp = (struct rte_tcp_hdr *)(ip6 + 1);
 			data = (uint8_t *)(tcp + 1);
-			for (i = 0; i < payload_len; i++)
-				data[i] = i;
+			for (int64_t j = 0; j < payload_len; j++)
+				data[j] = j;
 			tcp->cksum = 0;
 			tcp->cksum = rte_ipv6_udptcp_cksum(ip6, tcp);
 			td->input_text.len = payload_len + sizeof(struct rte_ipv6_hdr) +
@@ -366,7 +364,6 @@ test_ipsec_td_prepare(const struct crypto_param *param1,
 			struct rte_tcp_hdr *tcp;
 			int64_t payload_len;
 			uint8_t *data;
-			int64_t i;
 
 			payload_len = RTE_MIN(flags->plaintext_len, IPSEC_TEXT_MAX_LEN);
 			payload_len -= sizeof(struct rte_ipv4_hdr);
@@ -384,8 +381,8 @@ test_ipsec_td_prepare(const struct crypto_param *param1,
 			/* TCP */
 			tcp = (struct rte_tcp_hdr *)(ip + 1);
 			data = (uint8_t *)(tcp + 1);
-			for (i = 0; i < payload_len; i++)
-				data[i] = i;
+			for (int64_t j = 0; j < payload_len; j++)
+				data[j] = j;
 			tcp->cksum = 0;
 			tcp->cksum = rte_ipv4_udptcp_cksum(ip, tcp);
 			td->input_text.len = payload_len + sizeof(struct rte_ipv4_hdr) +
-- 
2.51.0

