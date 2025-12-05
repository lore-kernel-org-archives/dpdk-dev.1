Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B4D2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB42940613;
	Fri,  5 Dec 2025 03:29:57 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0B60C40653
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:55 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4ed75832448so22294941cf.2
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901794;
 x=1765506594; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72Gwj6FE486qkGuVYLBhuZG0xkuu5VfNoUdh02LKd8E=;
 b=kc4fIbupdWJpYMztY6SrHIEGWoaWMMkQl9+AwEH3/VBzprYkUWCVT2L7T3DzsoFsOt
 HzTJ93WAqwzU5jpZRA7moIe8avcqVkiRdC3ua/JiabyJH871exyvUxpsFTRPkZIk2Azp
 m4687FeTvM4DJnED0fNbtGlgKRCJkVU42pKO7iAuX05dK86DtvWOdIonZU4HDXkJyB7Z
 /EHsmHHXKxGbr0n5hnwSinblqbAlmYHI5fv/YNnw6gyCDZHDOiKXz7muRzY/8NQapSoc
 0SjrkRtH0C1DzpzvsRgYoiUuy3lRfLYeGcewdNzzRrJAYZ3ZDU7r/hSZQf9DZVm2mxak
 rxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901794; x=1765506594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72Gwj6FE486qkGuVYLBhuZG0xkuu5VfNoUdh02LKd8E=;
 b=ECS9R5Je0qMgcPFP4QCvap8fLjI/5y4crTwvrJK54CsTdNK2epbqP2f0EkOt/0Dx0g
 QX3vcVUyxZQcc8mut2QWybB7+1ysGPc6wN/3j3rJ/ELp7n+rDOMtco1wRfvekm1xmvjV
 ePvy2CNMeabezMU/ghsc21sSBxJssAVIu+Yy/6VQUH0yZTQVEVmiGvWCH6EQ/iYgkGkI
 I35kaJRoRhWdrfJohnqxEKpkARErRmQLDUpmZRg2Uj3kJSfRBVVl5ICQZ1713sByo4QF
 rl2J8dnt+6dEV5gRXme7SGUMf81NqkMwAlXXYFkbIewUEFLWQ2nYWPIr0Fec8WO07wgQ
 l2rw==
X-Gm-Message-State: AOJu0YzVtuq/D5JedMr6TVMq18s/8MCYpKS0jSIEWC5kQL6xJDR1gJY9
 XP6cePxZIv8v04TSnw7cLisA2/xpY6vyHaflE6S8COjiz+yCrZiB5WpPNu8VJyrJ/0lHYZXj3KZ
 CjvMt
X-Gm-Gg: ASbGncvKNy/W6zEthlf67t/J9O2n0EtpXyOzIXVCZPQq93zm71crDNf/1ESjFkMH0qt
 t6ys7ZeRquHTJBQ52BhxZvDsIGIMn+3QqS3cHA1KtH5JmZLKZ2tgFQVVThgGlLIEtAVwFqeBEER
 uE69hsDS22OGPBlE04WAartkSk6taF0l8YCvSGYTQ+fyhcldvylPbVmmWioAL9kpZ2aVZ0iI46e
 2B55sKDOQzYCe6xd+0SPlst32Pb2Qt1AqV82PqscBn0Vj3RBHBcOax94ZouaxukDPABURXBcKSo
 ROgmYoj0547iC+y0cOXJDqFGWPj6zzWy1k0f0Pw6ABX5KGr3RjlwRf6g/pUc4FFsfJMueBicfBm
 RniCPT9Ijj5YQv379ltDlAw+MhspUoIj7jJtAqRwPq3eXxE++CXGlFmpTZzUoK7jNcBxtcWwMWA
 X0N+weBlbAM0v4cKs63aUw8wmiPIkYIaSIAOPY1eEBvPgN36mNJA==
X-Google-Smtp-Source: AGHT+IFy8CO6CcoBJogf78hfeYb4T2bGIRMrx/o63jHbtoXmUcept8x27cYuqItG3H1/1XY0SWLqoA==
X-Received: by 2002:a05:622a:286:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4f0175cc120mr144373801cf.32.1764901794255; 
 Thu, 04 Dec 2025 18:29:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFC v2 02/14] test: avoid long hash names
Date: Thu,  4 Dec 2025 18:28:11 -0800
Message-ID: <20251205022948.327743-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

The test was using hash table names which were too long and
would break if the hash library was checking the parameters.

Fixes: af75078fece3 ("first public release")
Fixes: 9c7d8eed1a45 ("test/hash: add RCU tests")
Fixes: 567bb951716f ("hash: reclaim RCU defer queue")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..8cecc28d11 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1399,8 +1399,16 @@ static int test_hash_creation_with_bad_parameters(void)
 		return -1;
 	}
 
-	memcpy(&params, &ut_params, sizeof(params));
-	params.name = "creation_with_bad_parameters_0";
+	params = ut_params;
+	params.name = "really_long_name_of_22";
+	handle = rte_hash_create(&params);
+	if (handle != NULL) {
+		rte_hash_free(handle);
+		printf("Impossible creating hash successfully with excessively long name\n");
+		return -1;
+	}
+
+	params.name = "with_bad_parameters_0";
 	params.entries = RTE_HASH_ENTRIES_MAX + 1;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
@@ -1410,7 +1418,7 @@ static int test_hash_creation_with_bad_parameters(void)
 	}
 
 	memcpy(&params, &ut_params, sizeof(params));
-	params.name = "creation_with_bad_parameters_2";
+	params.name = "with_bad_parameters_2";
 	params.entries = BUCKET_ENTRIES - 1;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
@@ -1420,7 +1428,7 @@ static int test_hash_creation_with_bad_parameters(void)
 	}
 
 	memcpy(&params, &ut_params, sizeof(params));
-	params.name = "creation_with_bad_parameters_3";
+	params.name = "with_bad_parameters_3";
 	params.key_len = 0;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
@@ -1430,7 +1438,7 @@ static int test_hash_creation_with_bad_parameters(void)
 	}
 
 	memcpy(&params, &ut_params, sizeof(params));
-	params.name = "creation_with_bad_parameters_4";
+	params.name = "with_bad_parameters_4";
 	params.socket_id = RTE_MAX_NUMA_NODES + 1;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
@@ -1510,7 +1518,8 @@ static int test_average_table_utilization(uint32_t ext_table)
 	printf("Measuring performance, please wait");
 	fflush(stdout);
 	ut_params.entries = 1 << 16;
-	ut_params.name = "test_average_utilization";
+	/* the maximum length of name is 21 characters */
+	ut_params.name = "test_avge_utilization";
 	ut_params.hash_func = rte_jhash;
 	if (ext_table)
 		ut_params.extra_flag |= RTE_HASH_EXTRA_FLAGS_EXT_TABLE;
@@ -1898,7 +1907,7 @@ test_hash_rcu_qsbr_add(void)
 
 	printf("\n# Running RCU QSBR add tests\n");
 	memcpy(&params, &ut_params, sizeof(params));
-	params.name = "test_hash_rcu_qsbr_add";
+	params.name = "test_hash_qsbr_add";
 	params.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF |
 				RTE_HASH_EXTRA_FLAGS_MULTI_WRITER_ADD;
 	g_handle = rte_hash_create(&params);
@@ -1976,7 +1985,7 @@ test_hash_rcu_qsbr_dq_mode(uint8_t ext_bkt)
 		hash_extra_flag |= RTE_HASH_EXTRA_FLAGS_EXT_TABLE;
 
 	struct rte_hash_parameters params_pseudo_hash = {
-		.name = "test_hash_rcu_qsbr_dq_mode",
+		.name = "test_hash_qsbr_mode",
 		.entries = total_entries,
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
@@ -2146,7 +2155,7 @@ test_hash_rcu_qsbr_sync_mode(uint8_t ext_bkt)
 		hash_extra_flag |= RTE_HASH_EXTRA_FLAGS_EXT_TABLE;
 
 	struct rte_hash_parameters params_pseudo_hash = {
-		.name = "test_hash_rcu_qsbr_sync_mode",
+		.name = "test_hash_qsbr_sync",
 		.entries = total_entries,
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
@@ -2250,7 +2259,7 @@ test_hash_rcu_qsbr_dq_reclaim(void)
 	uint32_t reclaim_keys[8] = {10, 11, 12, 13, 14, 15, 16, 17};
 	struct rte_hash_rcu_config rcu_cfg = {0};
 	struct rte_hash_parameters hash_params = {
-			.name = "test_hash_rcu_qsbr_dq_reclaim",
+			.name = "test_qsbr_reclaim",
 			.entries = total_entries,
 			.key_len = sizeof(uint32_t),
 			.hash_func = NULL,
-- 
2.51.0

