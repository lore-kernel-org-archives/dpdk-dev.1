Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19E606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g+CmrKF+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAECC402C3;
	Tue, 24 Nov 2026 19:06:04 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 8739C402C3
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:06:03 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so47238205e9.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543563; x=1796148363; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cc+ibCkudQxbdQZhlxZ++ZQOgQcxNKgsYM0hWtyen0c=;
 b=g+CmrKF+cCeBevqQFmfjY/SxpBp7SEVfDs+xvi/gdErYYzD4/JCYDRsji3r0oYTMnl
 CJvXvZ0Mvx623Aqf2mu2nsjdk9l5TGm+Nfe1KMxFQeB9FLxvHvCCKRvcgW5GggnD2252
 +108dr6CR+ZA7AbP8nMOoAsAU6W0Z5XVTec06EhPlY393ZHp3cEgN/k/+yDJCNNVHGRW
 NS+IBHZt5eOWZPrG732RTLxy7YVfH72PHm/v3OXruC09kXS1K6wHOws6lct/IQu0/a0/
 YtL3mtvPa0Lokq8INivvM5VZF4ZdtSK2hYUMLeh7PIFRsA+9yQNYrzZpugRCkJcMDmpJ
 NECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543563; x=1796148363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cc+ibCkudQxbdQZhlxZ++ZQOgQcxNKgsYM0hWtyen0c=;
 b=ex6+ZE1VbAoObN741Z3hEmxDCZ6OpGRYdOJZHH2sDq7v00hrK2KV9CrTYwL8Ihua+e
 7jO0rdCbd2CU74ncOP5GY1p09OyCrmKDodc97e/pVwnOqK9UTo4IXtr/gC7ItQ5vbqGp
 bDX/EqaxkILkjr0hTKgRBP4NN9WKQDLNv+JSSqdG+eWkbi9S6LYZs+jsSYxgpccO8sZn
 2T8AITmOWIkvVMepnel5l+c557lUzN/SmZadYnb7wPGgy5lxckF2hfgnTjV8xy6n6duY
 B1CyS+pDu79Cliouwi5dvT9Xfz7dOfyRn2Q12gRLlZAgZrGyVtAPwtlddqRtuwzQhCaf
 N0Yw==
X-Gm-Message-State: APuU4Z+0GojyOCUKNma1M+9oXrDJ5WqLpOkkT6FgpLO+V9EnCWWu/yil
 WRvHGWvK/+nC8SPEZiBhr1ZUWxRsoHV7ucLVSmnqE6EbUxu8ONx0b0tL
X-Gm-Gg: AZFdTZdUtUV2zb5K1vxSKWRcY4bjwWTSVHayJvPPE99lmsnAheXnNz2peUfzyPXwdeR
 ov8t0Y4Ygp+SEOSJSisJtIejfoqZKy0iouxPIHQ3XdAFKo9FtZA5H2sshMYcSmi5Lrski0EG0gD
 QGY4NMy/vATC5ShiKuR/IseOn1opQA8mmoTV3N+fyqAkadXJOPrq+hXbwqiqL5rAweztUPHOTtG
 itrSC0hGzRLBz4bzFZVcIcDDMbsd6Ahyh4kc9B+q9myKuqsNPGN7CFj/WOHnYuOxb3gywgdsoeU
 T0SF1b89hZFNtvJ8T1hio8XM5Lm7hTN0Fn0FnQee7mFc+w/RLDQBRo/2v3FHyEv3h0NAaD4717K
 +W3zVl0QRxvVUlgKdVT2aEESyDLkuu2Kok7yWAoTUXtiVM+ijLRUKzPm/vWrZ5Y0doPcwN0sWle
 Kriuxm2XpgV/Jfip38WVeshJ6tpBUjLl5sjgzPZN37wc2OHsjw7xGPZ6TSMO9G9NGVzOSxoXfzj
 Pxte6wpbmR7I6GmaaD5dg2tRn+biA00x78xvCibIXE3BrrL+ET6cKb3yRGAmLQN12OacZoqbYkH
 ULYwJ+SIapaHEPKh0neb3SysjA0OpXa6gdChjxw0hysalc1BIPzP4UrlAcbTcXoRkfca3p9OMlZ
 NIrL8NQ==
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4bb8892cb02mr309197755e9.21.1795543563017; 
 Tue, 24 Nov 2026 10:06:03 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f148aasm177956435e9.0.2026.11.24.10.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:06:02 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 5/5] app/test-fib: add lookup across a group of FIBs
Date: Tue, 24 Nov 2026 19:04:15 +0100
Message-ID: <20261124180415.1099828-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180415.1099828-1-maxime@leroys.fr>
References: <20261124180415.1099828-1-maxime@leroys.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the -G option to create several IPv4 DIR24_8 FIBs in a group and
fill each of them with the routes, the next hops being shifted by the
FIB number. Every address is then looked up in a FIB picked at random
with rte_fib_group_lookup_bulk().

The same lookups are also timed with one rte_fib_lookup_bulk() call
per address, which is what an application does without a lookup
across FIBs, and the results of both are compared.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test-fib/main.c | 154 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index 05f9b9a1c7..dfc3e2b1a3 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -82,6 +82,7 @@ static struct {
 	uint32_t	nb_routes_per_depth[128 + 1];
 	uint32_t	flags;
 	uint32_t	tbl8;
+	uint32_t	nb_fibs;
 	uint8_t		ent_sz;
 	uint8_t		rnd_lookup_ips_ratio;
 	uint8_t		print_fract;
@@ -95,6 +96,7 @@ static struct {
 	.nb_routes_per_depth = {0},
 	.flags = FIB_V4_DIR_TYPE,
 	.tbl8 = DEFAULT_LPM_TBL8,
+	.nb_fibs = 1,
 	.ent_sz = 4,
 	.rnd_lookup_ips_ratio = 0,
 	.print_fract = 10,
@@ -627,6 +629,8 @@ print_usage(void)
 		"[-e <entry size (valid only for dir and trie fib types): "
 		"1/2/4/8 (default 4)>]\n"
 		"[-g <number of tbl8's for dir24_8 or trie FIBs>]\n"
+		"[-G <number of FIBs filled with the routes and looked up as "
+		"a group, ipv4 dir fib type only (default 1)>]\n"
 		"[-w <path to the file to dump routing table>]\n"
 		"[-u <path to the file to dump ip's for lookup>]\n"
 		"[-v <type of lookup function:"
@@ -666,6 +670,13 @@ check_config(void)
 		printf("-e 1 is valid only for ipv4\n");
 		return -1;
 	}
+
+	if ((config.nb_fibs > 1) && ((config.flags & (IPV6_FLAG | CMP_FLAG)) ||
+			((config.flags & FIB_TYPE_MASK) != FIB_V4_DIR_TYPE))) {
+		printf("-G is only valid for the ipv4 dir fib type, "
+			"without -c\n");
+		return -1;
+	}
 	return 0;
 }
 
@@ -675,7 +686,7 @@ parse_opts(int argc, char **argv)
 	int opt;
 	char *endptr;
 
-	while ((opt = getopt(argc, argv, "f:t:n:d:l:r:c6ab:e:g:w:u:sv:")) !=
+	while ((opt = getopt(argc, argv, "f:t:n:d:l:r:c6ab:e:g:G:w:u:sv:")) !=
 			-1) {
 		switch (opt) {
 		case 'f':
@@ -767,6 +778,15 @@ parse_opts(int argc, char **argv)
 				rte_exit(-EINVAL, "Invalid option -g\n");
 			}
 			break;
+		case 'G':
+			errno = 0;
+			config.nb_fibs = strtoul(optarg, &endptr, 10);
+			if ((errno != 0) || (config.nb_fibs == 0) ||
+					(config.nb_fibs > UINT16_MAX)) {
+				print_usage();
+				rte_exit(-EINVAL, "Invalid option -G\n");
+			}
+			break;
 		case 'v':
 			if ((strcmp(optarg, "s1") == 0) ||
 					(strcmp(optarg, "s") == 0)) {
@@ -818,6 +838,135 @@ print_depth_err(void)
 		"-d 0:0 option or remove /0 prefix from routes file\n");
 }
 
+/*
+ * Fill several FIBs of a group with the routes, the next hops being
+ * shifted by the FIB number, and look up every address in a FIB picked
+ * at random.
+ */
+static int
+run_v4_group(struct rte_fib_conf *conf)
+{
+	static const enum rte_fib_lookup_type lookup_types[] = {
+		RTE_FIB_LOOKUP_DEFAULT,
+		RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO,
+		RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512,
+		RTE_FIB_LOOKUP_DIR24_8_SCALAR_INLINE,
+		RTE_FIB_LOOKUP_DIR24_8_SCALAR_UNI,
+	};
+	uint64_t max_nh = get_max_nh(conf->dir24_8.nh_sz);
+	struct rt_rule_4 *rt = (struct rt_rule_4 *)config.rt;
+	struct rte_fib_group_conf grp_conf = {0};
+	uint32_t *tbl4 = config.lookup_tbl;
+	uint64_t fib_nh[BURST_SZ], nh;
+	char name[RTE_FIB_NAMESIZE];
+	struct rte_fib_group *grp;
+	struct rte_fib **fibs;
+	uint64_t start, acc;
+	uint16_t *fib_ids;
+	uint32_t i, j, n;
+	void **dps;
+	int ret;
+
+	grp_conf.type = conf->type;
+	grp_conf.flags = conf->flags;
+	grp_conf.dir24_8.nh_sz = conf->dir24_8.nh_sz;
+	grp = rte_fib_group_create(&grp_conf);
+	if (grp == NULL) {
+		printf("Can not alloc FIB group, err %d\n", rte_errno);
+		return -rte_errno;
+	}
+	conf->group = grp;
+
+	ret = rte_fib_group_select_lookup(grp, lookup_types[config.lookup_fn]);
+	if (ret != 0) {
+		printf("Can not init lookup function\n");
+		return ret;
+	}
+
+	fibs = rte_calloc(NULL, config.nb_fibs, sizeof(*fibs), 0);
+	fib_ids = rte_malloc(NULL, sizeof(*fib_ids) * config.nb_lookup_ips, 0);
+	dps = rte_malloc(NULL, sizeof(*dps) * config.nb_lookup_ips, 0);
+	if ((fibs == NULL) || (fib_ids == NULL) || (dps == NULL)) {
+		printf("Can not alloc the FIB group tables\n");
+		return -ENOMEM;
+	}
+
+	start = rte_rdtsc_precise();
+	for (j = 0; j < config.nb_fibs; j++) {
+		snprintf(name, sizeof(name), "test_%u", j);
+		fibs[j] = rte_fib_create(name, -1, conf);
+		if (fibs[j] == NULL) {
+			printf("Can not alloc FIB, err %d\n", rte_errno);
+			return -rte_errno;
+		}
+		for (i = 0; i < config.nb_routes; i++) {
+			ret = rte_fib_add(fibs[j], rt[i].addr, rt[i].depth,
+				(rt[i].nh + j) & max_nh);
+			if (unlikely(ret != 0)) {
+				printf("Can not add a route to FIB, err %d\n",
+					ret);
+				return -ret;
+			}
+		}
+	}
+	printf("AVG FIB add %"PRIu64"\n", (rte_rdtsc_precise() - start) /
+		((uint64_t)config.nb_fibs * config.nb_routes));
+
+	for (i = 0; i < config.nb_lookup_ips; i++) {
+		fib_ids[i] = rte_rand() % config.nb_fibs;
+		dps[i] = rte_fib_get_dp(fibs[fib_ids[i]]);
+	}
+
+	acc = 0;
+	for (i = 0; i < config.nb_lookup_ips; i += n) {
+		n = RTE_MIN(config.nb_lookup_ips - i, (uint32_t)BURST_SZ);
+		start = rte_rdtsc_precise();
+		ret = rte_fib_group_lookup_bulk(grp, dps + i, tbl4 + i,
+			fib_nh, n);
+		acc += rte_rdtsc_precise() - start;
+		if (ret != 0) {
+			printf("FIB lookup fails, err %d\n", ret);
+			return -ret;
+		}
+	}
+	printf("AVG FIB lookup %.1f\n", (double)acc / (double)i);
+
+	acc = 0;
+	for (i = 0; i < config.nb_lookup_ips; i += n) {
+		n = RTE_MIN(config.nb_lookup_ips - i, (uint32_t)BURST_SZ);
+		start = rte_rdtsc_precise();
+		for (j = 0; j < n; j++)
+			rte_fib_lookup_bulk(fibs[fib_ids[i + j]],
+				tbl4 + i + j, &fib_nh[j], 1);
+		acc += rte_rdtsc_precise() - start;
+	}
+	printf("AVG FIB lookup, one call per address %.1f\n",
+		(double)acc / (double)i);
+
+	for (i = 0; i < config.nb_lookup_ips; i += n) {
+		n = RTE_MIN(config.nb_lookup_ips - i, (uint32_t)BURST_SZ);
+		rte_fib_group_lookup_bulk(grp, dps + i, tbl4 + i, fib_nh, n);
+		for (j = 0; j < n; j++) {
+			rte_fib_lookup_bulk(fibs[fib_ids[i + j]],
+				tbl4 + i + j, &nh, 1);
+			if (nh != fib_nh[j]) {
+				printf("FAIL\n");
+				return -1;
+			}
+		}
+	}
+	printf("FIB group and single FIB lookups return same values\n");
+
+	for (j = 0; j < config.nb_fibs; j++)
+		rte_fib_free(fibs[j]);
+	rte_fib_group_free(grp);
+	rte_free(dps);
+	rte_free(fib_ids);
+	rte_free(fibs);
+
+	return 0;
+}
+
 static int
 run_v4(void)
 {
@@ -856,6 +1005,9 @@ run_v4(void)
 			get_max_nh(conf.dir24_8.nh_sz));
 	}
 
+	if (config.nb_fibs > 1)
+		return run_v4_group(&conf);
+
 	fib = rte_fib_create("test", -1, &conf);
 	if (fib == NULL) {
 		printf("Can not alloc FIB, err %d\n", rte_errno);
-- 
2.43.0

