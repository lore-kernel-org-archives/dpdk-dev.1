Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B36606A780
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xMgxDwep
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0460441133;
	Tue,  3 Nov 2026 15:55:16 +0100 (CET)
Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
 by mails.dpdk.org (Postfix) with ESMTPS id D51E34111C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:14 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Pzfccd2zO+QhMP9yhzUehH2dzkRZkuO6ggBuBP3ZJYU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717714; v=1; x=1794322514;
 b=xMgxDwep1QvVOLBQ4VJHrueTnWJH2dPN9e3qW1DFy38RQb10wFi3DACNFysCbBTCK1Ha089D
 p29NDGdSnBhZyDWWYvEeoywtnfIpBqrBIy+AKiSUYoYAiAyFakeRSj1SBiSgI3TDnv/nkq4JH1V
 ttUZKNB6VV8TLrEVXKe1aOgs=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 4b98f329a3e9cee8;
 Tue, 03 Nov 2026 14:55:12 +0000
X-Mizu-Trace-ID: 4b98f329a3e9cee8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 014/227] ipsec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:32 +0800
Message-ID: <20261103145306.487255-15-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the numa_id field of rte_ipsec_sad_conf (was socket_id),
keeping socket_id as a deprecated union alias, and update
in-tree users accordingly.

Also rename socket_id parameters and comments to the NUMA node
terminology, and switch internal calls to rte_zmalloc_numa()
and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-sad/main.c       |  2 +-
 app/test/test_ipsec_sad.c | 24 ++++++++++++------------
 lib/ipsec/ipsec_sad.c     |  6 +++---
 lib/ipsec/rte_ipsec_sad.h | 11 +++++++++--
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/app/test-sad/main.c b/app/test-sad/main.c
index 54e3fa0c91..6a65e637b8 100644
--- a/app/test-sad/main.c
+++ b/app/test-sad/main.c
@@ -638,7 +638,7 @@ main(int argc, char **argv)
 		config.fract_rnd_tuples = 0;
 		config.nb_tuples_rnd = 0;
 	}
-	conf.socket_id = -1;
+	conf.numa_id = -1;
 	conf.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = config.nb_rules_32 * 5 / 4;
 	conf.max_sa[RTE_IPSEC_SAD_SPI_DIP] = config.nb_rules_64 * 5 / 4;
 	conf.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = config.nb_rules_96 * 5 / 4;
diff --git a/app/test/test_ipsec_sad.c b/app/test/test_ipsec_sad.c
index 5e9dfb0f94..7c368d5f70 100644
--- a/app/test/test_ipsec_sad.c
+++ b/app/test/test_ipsec_sad.c
@@ -56,7 +56,7 @@ test_create_invalid(void)
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 
 	/* name == NULL */
@@ -75,13 +75,13 @@ test_create_invalid(void)
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
-	config.socket_id = -2;
+	config.numa_id = -2;
 	sad = rte_ipsec_sad_create(__func__, &config);
 	RTE_TEST_ASSERT(sad == NULL,
 		"Call succeeded with invalid parameters\n");
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 
 	return TEST_SUCCESS;
 }
@@ -98,7 +98,7 @@ test_find_existing(void)
 	struct rte_ipsec_sad *one, *two, *tmp;
 	struct rte_ipsec_sad_conf config;
 
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = 0;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = 0;
@@ -136,7 +136,7 @@ test_multiple_create(void)
 	struct rte_ipsec_sad *sad = NULL;
 	struct rte_ipsec_sad_conf config;
 
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
 
@@ -167,7 +167,7 @@ __test_add_invalid(int ipv6, union rte_ipsec_sad_key *tuple)
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
@@ -240,7 +240,7 @@ __test_delete_invalid(int ipv6, union rte_ipsec_sad_key *tuple)
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
@@ -300,7 +300,7 @@ __test_lookup_invalid(int ipv6, union rte_ipsec_sad_key *tuple)
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
@@ -359,7 +359,7 @@ __test_lookup_basic(int ipv6, union rte_ipsec_sad_key *tuple,
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
@@ -437,7 +437,7 @@ __test_lookup_adv(int ipv6, union rte_ipsec_sad_key *tuple,
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
@@ -702,7 +702,7 @@ __test_lookup_order(int ipv6, union rte_ipsec_sad_key *tuple,
 	config.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP] = MAX_SA;
 	config.max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP] = MAX_SA;
-	config.socket_id = SOCKET_ID_ANY;
+	config.numa_id = RTE_NUMA_ID_ANY;
 	config.flags = 0;
 	if (ipv6)
 		config.flags = RTE_IPSEC_SAD_FLAG_IPV6;
diff --git a/lib/ipsec/ipsec_sad.c b/lib/ipsec/ipsec_sad.c
index df2d1b4877..19ac196c7b 100644
--- a/lib/ipsec/ipsec_sad.c
+++ b/lib/ipsec/ipsec_sad.c
@@ -290,9 +290,9 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 		conf->max_sa[RTE_IPSEC_SAD_SPI_DIP]) +
 		RTE_MAX(MIN_HASH_ENTRIES,
 		conf->max_sa[RTE_IPSEC_SAD_SPI_DIP_SIP]);
-	sad = rte_zmalloc_socket(NULL, sizeof(*sad) +
+	sad = rte_zmalloc_numa(NULL, sizeof(*sad) +
 		(sizeof(struct hash_cnt) * sa_sum),
-		RTE_CACHE_LINE_SIZE, conf->socket_id);
+		RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (sad == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -302,7 +302,7 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 	hash_params.hash_func = DEFAULT_HASH_FUNC;
 	hash_params.hash_func_init_val = rte_rand();
 	sad->init_val = hash_params.hash_func_init_val;
-	hash_params.numa_id = conf->socket_id;
+	hash_params.numa_id = conf->numa_id;
 	hash_params.name = hash_name;
 	if (conf->flags & RTE_IPSEC_SAD_FLAG_RW_CONCURRENCY)
 		hash_params.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY;
diff --git a/lib/ipsec/rte_ipsec_sad.h b/lib/ipsec/rte_ipsec_sad.h
index 8547630ae4..c48357e116 100644
--- a/lib/ipsec/rte_ipsec_sad.h
+++ b/lib/ipsec/rte_ipsec_sad.h
@@ -56,8 +56,15 @@ union rte_ipsec_sad_key {
 
 /** IPsec SAD configuration structure */
 struct rte_ipsec_sad_conf {
-	/** CPU socket ID where rte_ipsec_sad should be allocated */
-	int		socket_id;
+	union {
+		/** NUMA node ID where rte_ipsec_sad should be allocated */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	/** maximum number of SA for each type of key */
 	uint32_t	max_sa[RTE_IPSEC_SAD_KEY_TYPE_MASK];
 	/** RTE_IPSEC_SAD_FLAG_* flags */
-- 
2.55.0

