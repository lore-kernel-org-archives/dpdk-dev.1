Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E03606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEVRv1mk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57AB040395;
	Tue, 24 Nov 2026 19:03:23 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 58ABA402E2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:22 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso4185768f8f.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543402; x=1796148202; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O+RSWcctsn1xj1pEQXGoo4eNz7IpLxeqVNDCi9dTodg=;
 b=BEVRv1mkhWSaykUtAZvhINGzXNUCutyT0RwvG7lReSImaBtbruYSBVqW0Iv3zrxuHU
 BQnumLfGt/jmbqn7K6qTCKY7vPFHgqmMx0nL8BEWrfFuB+Om9wY7HI+M085yzkmQDrOi
 CvGgtgTL8RRowj8uvomOl5FZHmSuqdC3ws//Afm0VMLWKuSX48MVL80CQPpxuuHklkBf
 fSmebVqJerKTffcxNH76Mo/j/GgV1zBTO7zCEDddVRxBRLblFj9LLgACpbX/5MjG325V
 L3iWyVuNHUlR/38SInrvQhldn94hhUGNa/PeOby0za32j5SEES5Eb35PMR/w8YtNhOOY
 4oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543402; x=1796148202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+RSWcctsn1xj1pEQXGoo4eNz7IpLxeqVNDCi9dTodg=;
 b=pLYPOWh7myJt7WEb6DxaW5gFv90MHqxLBlMNyQSDgh2jg/iNNxOQLjyVZYXrhN9brX
 5mmlYCvnMNKHn5gwwT9lo+4V2UczjnaSPWG5eqYKOrYW8hPPKewqcnCIEcphwbGP+tA9
 eslyhBqSgeHY1dCVx5KTej2oD8XlHoE9a6WO7n3hxgjx48Xdv0JZVHQUEdQcuN0RdWOb
 1ZX2ChDXGVW6AQuFssXDB2zsKuKXblPgXCkagNGKvgZP9z3mE8d6KvkE0258w7cLQMk/
 1SU/bRLP0gsaWMH4ig5tccVz4ldGLsGzRxCk79XExFr1Dr2m3tXYBY+gEAEvkTgeeGVh
 Thsg==
X-Gm-Message-State: APuU4Z+NDlJSzUOdThZBu4hzyb1y2czZXmSvltE9BOsV2UElbiry5yld
 VwHhEqlTY0rA6fcB9BAwgHpQoZltr5230dJRxrcL5h+oC5LbaoGRGrmdnPSqqA==
X-Gm-Gg: AZFdTZfSKssB9EIMNR/Q2GyuSf48+drlHxC5dqV4QUoI7cpFGTLizun97dRQZJ2KdK5
 YBJ0GUmBxSdXN+XlYRlmL+YBgatfdZ7LYJFSDwkKezHoLzbx64Q+b9mA9fzECEfQFFl8MBY7JNu
 SNZ+VXkOBRBIR4C/ylXTluRubdA3v09HFVqvcsAw1gBtg1k5NxcbBL6IkScAlaj3odiF49Qb/RV
 5/YRWbTNNpzA4P1ed+VT+Lpsikgh3Dcco+k8PgiNO3AJq1cwF2bdIw5NBsyXMV6Rqnw2RjxC4Ee
 ZvhT5ib2c0WNtjzuveRqDyjAA4pD/+urAvmqeveHccytpHcdMm1MauAl1LhKW5aF4HMI6DSfFy9
 noO+dwufLMHASb6L13c6zny7M/91+mUdLHnOjSkMDxYwG+CTrPIQ4auWEountutnowNhpcsyJAi
 rzIplmlS9FH21A7pOEQ496dbSYwIMgSRdSrEfZD1GqEByQND6NGfcA7JiDuWshbc7GzZFe73qPB
 1tC2YhrYTFIMJcP9DhGSS3U6mGWbJRtd0MA2kQuUle39IsiMFCX5mVyv/v/yDMyroA59+pH1H+G
 rzZ14J1RjGFQzsCspgLGTgIPKEfh65t8sO03dDNV7M/NN6QGnQLIAoGz13Pi
X-Received: by 2002:a05:6000:1865:b0:4ac:5eed:1d62 with SMTP id
 ffacd0b85a97d-4ac5eed1d7dmr33368322f8f.10.1795543401866; 
 Tue, 24 Nov 2026 10:03:21 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm5416757f8f.54.2026.11.24.10.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:20 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 01/13] test/fib6: zero-initialize config struct
Date: Tue, 24 Nov 2026 19:02:37 +0100
Message-ID: <20261124180249.1099506-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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

Initialize rte_fib6_conf with { 0 } to avoid using uninitialized
fields, aligned with how it is already done in test_fib.c.

This is needed because the struct will gain new optional fields
(tbl8_pool) that must default to NULL.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c      | 10 +++++-----
 app/test/test_fib6_perf.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index 7204047941..b2364760a2 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -47,7 +47,7 @@ int32_t
 test_create_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -106,7 +106,7 @@ int32_t
 test_multiple_create(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	int32_t i;
 
 	config.rib_ext_sz = 0;
@@ -133,7 +133,7 @@ int32_t
 test_free_null(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -157,7 +157,7 @@ int32_t
 test_add_del_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t nh = 100;
 	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
 	int ret;
@@ -351,7 +351,7 @@ int32_t
 test_lookup(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t def_nh = 100;
 	int ret;
 
diff --git a/app/test/test_fib6_perf.c b/app/test/test_fib6_perf.c
index 246bc2d509..d0fe64d1e6 100644
--- a/app/test/test_fib6_perf.c
+++ b/app/test/test_fib6_perf.c
@@ -68,7 +68,7 @@ static int
 test_fib6_perf(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf conf;
+	struct rte_fib6_conf conf = { 0 };
 	uint64_t begin, total_time;
 	unsigned int i, j;
 	uint64_t next_hop_add;
-- 
2.43.0

