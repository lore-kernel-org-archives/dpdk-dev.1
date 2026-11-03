Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F9606C84E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bbC0ZWox
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2B1D4111B;
	Tue,  3 Nov 2026 15:53:51 +0100 (CET)
Received: from mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
 by mails.dpdk.org (Postfix) with ESMTPS id 45B68410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:50 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=xk8Co+TKAJfc6dPFeqNoLx3+VwxXeMqmofdRMta40/I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717630; v=1; x=1794322430;
 b=bbC0ZWoxUf6XUN7Urun1agt1teDlr6CMlrhSBmq3vyZ9GIok24itrEJIFhd2XDEKeLSqf3O7
 HRtcGZRc8x/lG5SGhTPIMkvAd5NVH4+BeKwj96SSAFIVvtVvyfZmrTFxkaHcWRZrJ6wDAcyYR0v
 NNWKxdG676PKMihu+oSTGB+E=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 73cb0163739ccbef;
 Tue, 03 Nov 2026 14:53:49 +0000
X-Mizu-Trace-ID: 73cb0163739ccbef
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 004/227] hash: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:22 +0800
Message-ID: <20261103145306.487255-5-chengwen.feng@linux.dev>
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

Rename the numa_id field of rte_hash_parameters and
rte_fbk_hash_params (was socket_id), and update in-tree users
accordingly.

Also rename socket_id parameters, internal variables and comments
to the NUMA node terminology, and switch internal calls to the
NUMA-named APIs (rte_zmalloc_numa(), RTE_NUMA_ID_ANY).

No functional change.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_func_reentrancy.c              |  4 +-
 app/test/test_hash.c                         | 52 ++++++++++----------
 app/test/test_hash_multiwriter.c             |  2 +-
 app/test/test_hash_perf.c                    |  4 +-
 app/test/test_hash_readwrite.c               |  2 +-
 app/test/test_hash_readwrite_lf_perf.c       |  2 +-
 app/test/test_rcu_qsbr.c                     |  2 +-
 app/test/test_rcu_qsbr_perf.c                |  2 +-
 drivers/net/bnxt/bnxt_vnic.c                 |  2 +-
 drivers/net/bnxt/tf_ulp/ulp_matcher.c        |  4 +-
 drivers/net/enic/enic_fm_flow.c              |  2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c     |  2 +-
 drivers/net/hns3/hns3_fdir.c                 |  2 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c         |  4 +-
 drivers/net/intel/i40e/i40e_ethdev.c         |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c           |  2 +-
 drivers/net/intel/i40e/i40e_flow_ethertype.c |  2 +-
 drivers/net/intel/ice/ice_fdir_filter.c      |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c       |  2 +-
 drivers/net/memif/memif_socket.c             |  2 +-
 drivers/net/nfp/flower/nfp_conntrack.c       |  2 +-
 drivers/net/nfp/flower/nfp_flower_flow.c     | 10 ++--
 drivers/net/nfp/nfp_net_flow.c               |  2 +-
 drivers/net/sfc/sfc_tbl_meta_cache.c         |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c             |  4 +-
 lib/hash/rte_cuckoo_hash.c                   | 28 +++++------
 lib/hash/rte_fbk_hash.c                      |  2 +-
 lib/hash/rte_fbk_hash.h                      | 10 +++-
 lib/hash/rte_hash.h                          | 10 +++-
 lib/ipsec/ipsec_sad.c                        |  2 +-
 lib/lpm/rte_lpm6.c                           |  2 +-
 lib/node/udp4_input.c                        |  4 +-
 lib/vhost/vhost_crypto.c                     |  2 +-
 33 files changed, 97 insertions(+), 81 deletions(-)

diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index ce55ab991e..ee65422054 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -238,7 +238,7 @@ hash_create_free(__rte_unused void *arg)
 		.key_len = 4,
 		.hash_func = (rte_hash_function)rte_jhash_32b,
 		.hash_func_init_val = 0,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	WAIT_SYNCHRO_FOR_WORKERS();
@@ -303,7 +303,7 @@ fbk_create_free(__rte_unused void *arg)
 		.name = NULL,
 		.entries = 4,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 		.hash_func = rte_jhash_1word,
 		.init_val = RTE_FBK_HASH_INIT_VAL_DEFAULT,
 	};
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 640a33e16c..de7fc414e3 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -188,7 +188,7 @@ static struct rte_hash_parameters ut_params = {
 	.key_len = sizeof(struct flow_key),
 	.hash_func = rte_jhash,
 	.hash_func_init_val = 0,
-	.socket_id = 0,
+	.numa_id = 0,
 };
 
 #define CRC32_ITERATIONS (1U << 10)
@@ -835,7 +835,7 @@ static int test_full_bucket(void)
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
 		.hash_func_init_val = 0,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 	const void *key_array[KEY_PER_BUCKET+1] = {0};
 	struct rte_hash *handle;
@@ -962,7 +962,7 @@ static int test_extendable_bucket(void)
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
 		.hash_func_init_val = 0,
-		.socket_id = 0,
+		.numa_id = 0,
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_EXT_TABLE
 	};
 	struct rte_hash *handle;
@@ -1069,63 +1069,63 @@ fbk_hash_unit_test(void)
 		.name = "fbk_hash_test",
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_1 = {
 		.name = "invalid_1",
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX + 1, /* Not power of 2 */
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_2 = {
 		.name = "invalid_2",
 		.entries = 4,
 		.entries_per_bucket = 3,         /* Not power of 2 */
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_3 = {
 		.name = "invalid_3",
 		.entries = 0,                    /* Entries is 0 */
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_4 = {
 		.name = "invalid_4",
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 0,         /* Entries per bucket is 0 */
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_5 = {
 		.name = "invalid_5",
 		.entries = 4,
 		.entries_per_bucket = 8,         /* Entries per bucket > entries */
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_6 = {
 		.name = "invalid_6",
 		.entries = RTE_FBK_HASH_ENTRIES_MAX * 2,   /* Entries > max allowed */
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_7 = {
 		.name = "invalid_7",
 		.entries = RTE_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = RTE_FBK_HASH_ENTRIES_PER_BUCKET_MAX * 2,	/* Entries > max allowed */
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params invalid_params_8 = {
 		.name = "invalid_7",
 		.entries = RTE_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = RTE_MAX_NUMA_NODES + 1, /* invalid socket */
+		.numa_id = RTE_MAX_NUMA_NODES + 1, /* invalid NUMA node */
 	};
 
 	/* try and create hash with an excessively long name */
@@ -1133,7 +1133,7 @@ fbk_hash_unit_test(void)
 		.name = "four_byte_key_hash_name_length_32",
 		.entries = 4,
 		.entries_per_bucket = 2,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	/* try to create two hashes with identical names
@@ -1145,7 +1145,7 @@ fbk_hash_unit_test(void)
 		.name = "same_name",				/* hash with identical name */
 		.entries = 4,
 		.entries_per_bucket = 2,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	/* trying to create this hash should return a pointer to an existing hash */
@@ -1153,7 +1153,7 @@ fbk_hash_unit_test(void)
 		.name = "same_name",				/* hash with identical name */
 		.entries = RTE_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	/* this is a sanity check for "same name" test
@@ -1164,14 +1164,14 @@ fbk_hash_unit_test(void)
 		.name = "different_name",			/* different name */
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 	};
 
 	struct rte_fbk_hash_params params_jhash = {
 		.name = "valid",
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 		.hash_func = rte_jhash_1word,              /* Tests for different hash_func */
 		.init_val = RTE_FBK_HASH_INIT_VAL_DEFAULT,
 	};
@@ -1180,7 +1180,7 @@ fbk_hash_unit_test(void)
 		.name = "valid nohash",
 		.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 		.entries_per_bucket = 4,
-		.socket_id = 0,
+		.numa_id = 0,
 		.hash_func = NULL,                            /* Tests for null hash_func */
 		.init_val = RTE_FBK_HASH_INIT_VAL_DEFAULT,
 	};
@@ -1380,7 +1380,7 @@ static int test_fbk_hash_find_existing(void)
 			.name = "fbk_hash_find_existing",
 			.entries = LOCAL_FBK_HASH_ENTRIES_MAX,
 			.entries_per_bucket = 4,
-			.socket_id = 0,
+			.numa_id = 0,
 	};
 	struct rte_fbk_hash_table *handle = NULL, *result = NULL;
 
@@ -1450,7 +1450,7 @@ static int test_hash_creation_with_bad_parameters(void)
 
 	memcpy(&params, &ut_params, sizeof(params));
 	params.name = "creation_with_bad_parameters_4";
-	params.socket_id = RTE_MAX_NUMA_NODES + 1;
+	params.numa_id = RTE_MAX_NUMA_NODES + 1;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
 		rte_hash_free(handle);
@@ -1460,7 +1460,7 @@ static int test_hash_creation_with_bad_parameters(void)
 
 	memcpy(&params, &ut_params, sizeof(params));
 	params.name = "hash_creation_with_too_long_name";
-	params.socket_id = SOCKET_ID_ANY;
+	params.numa_id = RTE_NUMA_ID_ANY;
 	handle = rte_hash_create(&params);
 	if (handle != NULL) {
 		rte_hash_free(handle);
@@ -1764,7 +1764,7 @@ static struct rte_hash_parameters hash_params_ex = {
 	.key_len = 0,
 	.hash_func = NULL,
 	.hash_func_init_val = 0,
-	.socket_id = 0,
+	.numa_id = 0,
 };
 
 /*
@@ -2087,7 +2087,7 @@ test_hash_rcu_qsbr_dq_mode(uint8_t ext_bkt)
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
 		.hash_func_init_val = 0,
-		.socket_id = 0,
+		.numa_id = 0,
 		.extra_flag = hash_extra_flag,
 	};
 	int pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
@@ -2257,7 +2257,7 @@ test_hash_rcu_qsbr_sync_mode(uint8_t ext_bkt)
 		.key_len = sizeof(struct flow_key),
 		.hash_func = pseudo_hash,
 		.hash_func_init_val = 0,
-		.socket_id = 0,
+		.numa_id = 0,
 		.extra_flag = hash_extra_flag,
 	};
 	int pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
@@ -2361,7 +2361,7 @@ test_hash_rcu_qsbr_dq_reclaim(void)
 			.key_len = sizeof(uint32_t),
 			.hash_func = NULL,
 			.hash_func_init_val = 0,
-			.socket_id = 0,
+			.numa_id = 0,
 	};
 
 	hash_params.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF;
@@ -2462,7 +2462,7 @@ test_hash_rcu_qsbr_replace_auto_free(void)
 		.key_len = sizeof(uint32_t),
 		.hash_func = NULL,
 		.hash_func_init_val = 0,
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF,
 	};
 	struct rte_hash *hash = NULL;
diff --git a/app/test/test_hash_multiwriter.c b/app/test/test_hash_multiwriter.c
index 0af3eb2c33..7c0b4434e6 100644
--- a/app/test/test_hash_multiwriter.c
+++ b/app/test/test_hash_multiwriter.c
@@ -119,7 +119,7 @@ test_hash_multiwriter(void)
 		.key_len = sizeof(uint32_t),
 		.hash_func = rte_jhash,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 	if (use_htm)
 		hash_params.extra_flag =
diff --git a/app/test/test_hash_perf.c b/app/test/test_hash_perf.c
index d66b96e5ce..b3d78f4c6d 100644
--- a/app/test/test_hash_perf.c
+++ b/app/test/test_hash_perf.c
@@ -104,7 +104,7 @@ create_table(unsigned int with_data, unsigned int table_index,
 
 	ut_params.name = name;
 	ut_params.key_len = hashtest_key_lens[table_index];
-	ut_params.socket_id = rte_socket_id();
+	ut_params.numa_id = rte_numa_id();
 	h[table_index] = rte_hash_find_existing(name);
 	rte_hash_free(h[table_index]);
 	h[table_index] = rte_hash_create(&ut_params);
@@ -653,7 +653,7 @@ fbk_hash_perf_test(void)
 		.name = "fbk_hash_test",
 		.entries = ENTRIES,
 		.entries_per_bucket = 4,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 	struct rte_fbk_hash_table *handle = NULL;
 	uint32_t *keys = NULL;
diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 25fe072fc9..156edd84e2 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -149,7 +149,7 @@ init_params(int use_ext, int use_htm, int rw_lf, int use_jhash, bool perf)
 		.entries = TOTAL_ENTRY * (perf ? PERF_MULTIPLIER : 1),
 		.key_len = sizeof(uint32_t),
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 	if (use_jhash)
 		hash_params.hash_func = rte_jhash;
diff --git a/app/test/test_hash_readwrite_lf_perf.c b/app/test/test_hash_readwrite_lf_perf.c
index bef987d29d..bcad2fc813 100644
--- a/app/test/test_hash_readwrite_lf_perf.c
+++ b/app/test/test_hash_readwrite_lf_perf.c
@@ -154,7 +154,7 @@ init_params(int rwc_lf, int use_jhash, int htm, int ext_bkt)
 		.entries = TOTAL_ENTRY,
 		.key_len = sizeof(uint32_t),
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	if (use_jhash)
diff --git a/app/test/test_rcu_qsbr.c b/app/test/test_rcu_qsbr.c
index 05ad1ab5dd..7f749d6d7f 100644
--- a/app/test/test_rcu_qsbr.c
+++ b/app/test/test_rcu_qsbr.c
@@ -1050,7 +1050,7 @@ init_hash(int hash_id)
 		.entries = TOTAL_ENTRY,
 		.key_len = sizeof(uint32_t),
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.hash_func = rte_hash_crc,
 		.extra_flag =
 			RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF,
diff --git a/app/test/test_rcu_qsbr_perf.c b/app/test/test_rcu_qsbr_perf.c
index bdffd64e60..d5cb3d90bb 100644
--- a/app/test/test_rcu_qsbr_perf.c
+++ b/app/test/test_rcu_qsbr_perf.c
@@ -339,7 +339,7 @@ static struct rte_hash *init_hash(void)
 		.entries = TOTAL_ENTRY,
 		.key_len = sizeof(uint32_t),
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.hash_func = rte_hash_crc,
 		.extra_flag =
 			RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF,
diff --git a/drivers/net/bnxt/bnxt_vnic.c b/drivers/net/bnxt/bnxt_vnic.c
index f0ec87198f..31c6facef6 100644
--- a/drivers/net/bnxt/bnxt_vnic.c
+++ b/drivers/net/bnxt/bnxt_vnic.c
@@ -998,7 +998,7 @@ int32_t bnxt_vnic_queue_db_init(struct bnxt *bp)
 		hash_tbl_params.entries = RTE_HASH_BUCKET_ENTRIES;
 
 	hash_tbl_params.key_len = BNXT_VNIC_MAX_QUEUE_SZ_IN_8BITS;
-	hash_tbl_params.socket_id = rte_socket_id();
+	hash_tbl_params.numa_id = rte_numa_id();
 	bp->vnic_queue_db.rss_q_db = rte_hash_create(&hash_tbl_params);
 	if (bp->vnic_queue_db.rss_q_db == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to create rss hash tbl");
diff --git a/drivers/net/bnxt/tf_ulp/ulp_matcher.c b/drivers/net/bnxt/tf_ulp/ulp_matcher.c
index f739cdf2a3..5d799dd3da 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_matcher.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_matcher.c
@@ -358,7 +358,7 @@ int32_t ulp_matcher_init(struct bnxt_ulp_context *ulp_ctx)
 				  RTE_HASH_BUCKET_ENTRIES;
 
 	hash_tbl_params.key_len = sizeof(struct ulp_matcher_hash_db_key);
-	hash_tbl_params.socket_id = rte_socket_id();
+	hash_tbl_params.numa_id = rte_numa_id();
 	data->class_matcher_db = rte_hash_create(&hash_tbl_params);
 	if (data->class_matcher_db == NULL) {
 		BNXT_DRV_DBG(ERR, "Failed to create class matcher hash tbl\n");
@@ -380,7 +380,7 @@ int32_t ulp_matcher_init(struct bnxt_ulp_context *ulp_ctx)
 	/* The hash list size set to max support and not dependent on template*/
 	hash_tbl_params.entries = BNXT_ULP_ACT_HASH_LIST_SIZE;
 	hash_tbl_params.key_len = sizeof(struct ulp_matcher_action_hash_db_key);
-	hash_tbl_params.socket_id = rte_socket_id();
+	hash_tbl_params.numa_id = rte_numa_id();
 	data->action_matcher_db = rte_hash_create(&hash_tbl_params);
 	if (data->action_matcher_db == NULL) {
 		BNXT_DRV_DBG(ERR, "Failed to create action matcher hash tbl\n");
diff --git a/drivers/net/enic/enic_fm_flow.c b/drivers/net/enic/enic_fm_flow.c
index 4b0a513977..ed328217e4 100644
--- a/drivers/net/enic/enic_fm_flow.c
+++ b/drivers/net/enic/enic_fm_flow.c
@@ -3144,7 +3144,7 @@ enic_fm_init_actions(struct enic_flowman *fm)
 		.key_len = sizeof(struct fm_action),
 		.hash_func = rte_jhash,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	ENICPMD_FUNC_TRACE();
diff --git a/drivers/net/hinic/base/hinic_pmd_hwdev.c b/drivers/net/hinic/base/hinic_pmd_hwdev.c
index 9a1b126632..3aca40d17d 100644
--- a/drivers/net/hinic/base/hinic_pmd_hwdev.c
+++ b/drivers/net/hinic/base/hinic_pmd_hwdev.c
@@ -341,7 +341,7 @@ int hinic_osdep_init(struct hinic_hwdev *hwdev)
 	dh_params.key_len = HINIC_HASH_KEY_LEN;
 	dh_params.hash_func = HINIC_HASH_FUNC;
 	dh_params.hash_func_init_val = HINIC_HASH_FUNC_INIT_VAL;
-	dh_params.socket_id = SOCKET_ID_ANY;
+	dh_params.numa_id = RTE_NUMA_ID_ANY;
 
 	paddr_hash = rte_hash_find_existing(dh_params.name);
 	if (paddr_hash == NULL) {
diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
index 0096aa21e9..11f28be758 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -911,7 +911,7 @@ int hns3_fdir_filter_init(struct hns3_adapter *hns)
 		return ret;
 	}
 
-	fdir_hash_params.socket_id = rte_socket_id();
+	fdir_hash_params.numa_id = rte_numa_id();
 	TAILQ_INIT(&fdir_info->fdir_list);
 	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE, "%s", hns->hw.data->name);
 	fdir_info->hash_handle = rte_hash_create(&fdir_hash_params);
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index fd84d9b21e..d9465fcae2 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2517,7 +2517,7 @@ cpfl_vport_map_init(struct cpfl_adapter_ext *adapter)
 		.entries = CPFL_VPORT_MAP_HASH_ENTRY_NUM,
 		.key_len = sizeof(struct cpfl_vport_id),
 		.hash_func = rte_hash_crc,
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 	};
 
 	adapter->vport_map_hash = rte_hash_create(&params);
@@ -2559,7 +2559,7 @@ cpfl_repr_allowlist_init(struct cpfl_adapter_ext *adapter)
 		.entries = CPFL_REPR_HASH_ENTRY_NUM,
 		.key_len = sizeof(struct cpfl_repr_id),
 		.hash_func = rte_hash_crc,
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 	};
 
 	adapter->repr_allowlist_hash = rte_hash_create(&params);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 498c5c7ec4..66db44aaa1 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1000,7 +1000,7 @@ i40e_tunnel_state_attach(struct rte_eth_dev_data *dev_data)
 		.key_len = sizeof(struct i40e_tunnel_filter_match_key),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	snprintf(tunnel_hash_name, RTE_HASH_NAMESIZE, "tunnel_%s", dev_data->name);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 69b3b763ba..11e11b6713 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1078,7 +1078,7 @@ i40e_fdir_tmpl_store_init(struct rte_eth_dev *dev)
 		.key_len = sizeof(struct i40e_fdir_tmpl_key),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	if (tmpls->hash_table != NULL)
diff --git a/drivers/net/intel/i40e/i40e_flow_ethertype.c b/drivers/net/intel/i40e/i40e_flow_ethertype.c
index 0b92c8dbfb..04787c937c 100644
--- a/drivers/net/intel/i40e/i40e_flow_ethertype.c
+++ b/drivers/net/intel/i40e/i40e_flow_ethertype.c
@@ -306,7 +306,7 @@ i40e_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused
 		.key_len = sizeof(struct i40e_ethertype_key),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	snprintf(ethertype_hash_name, RTE_HASH_NAMESIZE, "etype_%s", dev_data->name);
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 2350bd5523..3a15abe422 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -395,7 +395,7 @@ ice_fdir_init_filter_list(struct ice_pf *pf)
 		.key_len = sizeof(struct ice_fdir_fltr_pattern),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_EXT_TABLE,
 	};
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 5137663a61..60a9dbf2c1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1330,7 +1330,7 @@ ixgbe_fdir_state_attach(struct rte_eth_dev_data *dev_data)
 		.key_len = sizeof(union ixgbe_atr_input),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE, "fdir_%s",
diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 971964133c..5350133c29 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -1088,7 +1088,7 @@ memif_create_socket_hash(void)
 	params.key_len = MEMIF_SOCKET_UN_SIZE;
 	params.hash_func = rte_jhash;
 	params.hash_func_init_val = 0;
-	params.socket_id = SOCKET_ID_ANY;
+	params.numa_id = RTE_NUMA_ID_ANY;
 	return rte_hash_create(&params);
 }
 
diff --git a/drivers/net/nfp/flower/nfp_conntrack.c b/drivers/net/nfp/flower/nfp_conntrack.c
index 439a1a1b0e..f72bfd8d8b 100644
--- a/drivers/net/nfp/flower/nfp_conntrack.c
+++ b/drivers/net/nfp/flower/nfp_conntrack.c
@@ -865,7 +865,7 @@ nfp_ct_zone_entry_init(struct nfp_ct_zone_entry *ze,
 	struct rte_hash_parameters ct_merge_hash_params = {
 		.entries    = 1000,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..c494f0c7ed 100644
--- a/drivers/net/nfp/flower/nfp_flower_flow.c
+++ b/drivers/net/nfp/flower/nfp_flower_flow.c
@@ -5468,7 +5468,7 @@ nfp_flow_priv_init(struct nfp_pf_dev *pf_dev)
 		.name       = mask_name,
 		.entries    = NFP_MASK_TABLE_ENTRIES,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
@@ -5476,7 +5476,7 @@ nfp_flow_priv_init(struct nfp_pf_dev *pf_dev)
 	struct rte_hash_parameters flow_hash_params = {
 		.name       = flow_name,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
@@ -5485,7 +5485,7 @@ nfp_flow_priv_init(struct nfp_pf_dev *pf_dev)
 		.name       = pretun_name,
 		.entries    = 32,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
@@ -5494,7 +5494,7 @@ nfp_flow_priv_init(struct nfp_pf_dev *pf_dev)
 		.name       = ct_zone_table_name,
 		.entries    = 65536,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
@@ -5502,7 +5502,7 @@ nfp_flow_priv_init(struct nfp_pf_dev *pf_dev)
 	struct rte_hash_parameters ct_map_hash_params = {
 		.name       = ct_map_table_name,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
diff --git a/drivers/net/nfp/nfp_net_flow.c b/drivers/net/nfp/nfp_net_flow.c
index 0e5003ebe3..e04053f0e1 100644
--- a/drivers/net/nfp/nfp_net_flow.c
+++ b/drivers/net/nfp/nfp_net_flow.c
@@ -1082,7 +1082,7 @@ nfp_net_flow_priv_init(struct nfp_pf_dev *pf_dev,
 	struct rte_hash_parameters flow_hash_params = {
 		.name       = flow_name,
 		.hash_func  = rte_jhash,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(uint32_t),
 		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY,
 	};
diff --git a/drivers/net/sfc/sfc_tbl_meta_cache.c b/drivers/net/sfc/sfc_tbl_meta_cache.c
index bffbc4a158..78af60062e 100644
--- a/drivers/net/sfc/sfc_tbl_meta_cache.c
+++ b/drivers/net/sfc/sfc_tbl_meta_cache.c
@@ -22,7 +22,7 @@ sfc_tbl_meta_cache_ctor(struct rte_hash **ref_cache)
 		.name       = "meta_hash_table",
 		.hash_func  = rte_jhash,
 		.entries    = cache_size,
-		.socket_id  = rte_socket_id(),
+		.numa_id  = rte_numa_id(),
 		.key_len    = sizeof(efx_table_id_t),
 	};
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9dbdbfa309..fe7fed704f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -992,7 +992,7 @@ int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 		.key_len = sizeof(struct txgbe_atr_input),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	TAILQ_INIT(&fdir_info->fdir_list);
@@ -1028,7 +1028,7 @@ static int txgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev)
 		.key_len = sizeof(struct txgbe_l2_tn_key),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 
 	TAILQ_INIT(&l2_tn_info->l2_tn_list);
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 5d495ae973..6968bab789 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -537,7 +537,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create_elem(ring_name, sizeof(uint32_t),
-			rte_align32pow2(num_key_slots), params->socket_id, 0);
+			rte_align32pow2(num_key_slots), params->numa_id, 0);
 	if (r == NULL) {
 		HASH_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		goto err;
@@ -556,7 +556,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 		r_ext = rte_ring_create_elem(ext_ring_name, sizeof(uint32_t),
 				rte_align32pow2(num_buckets + 1),
-				params->socket_id, 0);
+				params->numa_id, 0);
 		if (r_ext == NULL) {
 			HASH_LOG(ERR, "ext buckets ring create failed: %s",
 				rte_strerror(rte_errno));
@@ -590,17 +590,17 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		goto err_unlock;
 	}
 
-	h = (struct rte_hash *)rte_zmalloc_socket(hash_name, sizeof(struct rte_hash),
-					RTE_CACHE_LINE_SIZE, params->socket_id);
+	h = (struct rte_hash *)rte_zmalloc_numa(hash_name, sizeof(struct rte_hash),
+					RTE_CACHE_LINE_SIZE, params->numa_id);
 
 	if (h == NULL) {
 		HASH_LOG(ERR, "memory allocation failed");
 		goto err_unlock;
 	}
 
-	buckets = rte_zmalloc_socket(NULL,
+	buckets = rte_zmalloc_numa(NULL,
 				num_buckets * sizeof(struct rte_hash_bucket),
-				RTE_CACHE_LINE_SIZE, params->socket_id);
+				RTE_CACHE_LINE_SIZE, params->numa_id);
 
 	if (buckets == NULL) {
 		HASH_LOG(ERR, "buckets memory allocation failed");
@@ -609,9 +609,9 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Allocate same number of extendable buckets */
 	if (ext_table_support) {
-		buckets_ext = rte_zmalloc_socket(NULL,
+		buckets_ext = rte_zmalloc_numa(NULL,
 				num_buckets * sizeof(struct rte_hash_bucket),
-				RTE_CACHE_LINE_SIZE, params->socket_id);
+				RTE_CACHE_LINE_SIZE, params->numa_id);
 		if (buckets_ext == NULL) {
 			HASH_LOG(ERR, "ext buckets memory allocation "
 							"failed");
@@ -641,16 +641,16 @@ rte_hash_create(const struct rte_hash_parameters *params)
 			  KEY_ALIGNMENT);
 	const uint64_t key_tbl_size = (uint64_t) key_entry_size * num_key_slots;
 
-	k = rte_zmalloc_socket(NULL, key_tbl_size,
-			RTE_CACHE_LINE_SIZE, params->socket_id);
+	k = rte_zmalloc_numa(NULL, key_tbl_size,
+			RTE_CACHE_LINE_SIZE, params->numa_id);
 
 	if (k == NULL) {
 		HASH_LOG(ERR, "memory allocation failed");
 		goto err_unlock;
 	}
 
-	tbl_chng_cnt = rte_zmalloc_socket(NULL, sizeof(uint32_t),
-			RTE_CACHE_LINE_SIZE, params->socket_id);
+	tbl_chng_cnt = rte_zmalloc_numa(NULL, sizeof(uint32_t),
+			RTE_CACHE_LINE_SIZE, params->numa_id);
 
 	if (tbl_chng_cnt == NULL) {
 		HASH_LOG(ERR, "memory allocation failed");
@@ -669,9 +669,9 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	}
 
 	if (use_local_cache) {
-		local_free_slots = rte_zmalloc_socket(NULL,
+		local_free_slots = rte_zmalloc_numa(NULL,
 				sizeof(struct lcore_cache) * RTE_MAX_LCORE,
-				RTE_CACHE_LINE_SIZE, params->socket_id);
+				RTE_CACHE_LINE_SIZE, params->numa_id);
 		if (local_free_slots == NULL) {
 			HASH_LOG(ERR, "local free slots memory allocation failed");
 			goto err_unlock;
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 45d4a13427..112a2ae958 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -135,7 +135,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 	}
 
 	/* Allocate memory for table. */
-	ht = rte_zmalloc_socket(hash_name, mem_size, 0, params->socket_id);
+	ht = rte_zmalloc_numa(hash_name, mem_size, 0, params->numa_id);
 	if (ht == NULL) {
 		HASH_LOG(ERR, "Failed to allocate fbk hash table");
 		rte_free(te);
diff --git a/lib/hash/rte_fbk_hash.h b/lib/hash/rte_fbk_hash.h
index 6b70cfaa0b..57ecca2527 100644
--- a/lib/hash/rte_fbk_hash.h
+++ b/lib/hash/rte_fbk_hash.h
@@ -50,7 +50,15 @@ struct rte_fbk_hash_params {
 	const char *name;		/**< Name of the hash table. */
 	uint32_t entries;		/**< Total number of entries. */
 	uint32_t entries_per_bucket;	/**< Number of entries in a bucket. */
-	int socket_id;			/**< Socket to allocate memory on. */
+	union {
+		/** NUMA node ID to allocate memory on. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	rte_fbk_hash_fn hash_func;	/**< The hash function. */
 	uint32_t init_val;		/**< For initialising hash function. */
 };
diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
index e33f0aea0f..c03c90cc32 100644
--- a/lib/hash/rte_hash.h
+++ b/lib/hash/rte_hash.h
@@ -86,7 +86,15 @@ struct rte_hash_parameters {
 	uint32_t key_len;		/**< Length of hash key. */
 	rte_hash_function hash_func;	/**< Primary Hash function used to calculate hash. */
 	uint32_t hash_func_init_val;	/**< Init value used by hash_func. */
-	int socket_id;			/**< NUMA Socket ID for memory. */
+	union {
+		/** NUMA node ID for memory. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint8_t extra_flag;		/**< Indicate if additional parameters are present. */
 };
 
diff --git a/lib/ipsec/ipsec_sad.c b/lib/ipsec/ipsec_sad.c
index 15ea868f77..df2d1b4877 100644
--- a/lib/ipsec/ipsec_sad.c
+++ b/lib/ipsec/ipsec_sad.c
@@ -302,7 +302,7 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 	hash_params.hash_func = DEFAULT_HASH_FUNC;
 	hash_params.hash_func_init_val = rte_rand();
 	sad->init_val = hash_params.hash_func_init_val;
-	hash_params.socket_id = conf->socket_id;
+	hash_params.numa_id = conf->socket_id;
 	hash_params.name = hash_name;
 	if (conf->flags & RTE_IPSEC_SAD_FLAG_RW_CONCURRENCY)
 		hash_params.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY;
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..5eb2f3761d 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -246,7 +246,7 @@ rte_lpm6_create(const char *name, int socket_id,
 		.hash_func_init_val = 0,
 		.name = mem_name,
 		.reserved = 0,
-		.socket_id = socket_id,
+		.numa_id = socket_id,
 		.extra_flag = 0
 	};
 
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..47aad42022 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -53,7 +53,7 @@ static struct rte_hash_parameters udp4_params = {
 	.key_len = sizeof(uint32_t),
 	.hash_func = rte_jhash,
 	.hash_func_init_val = 0,
-	.socket_id = 0,
+	.numa_id = 0,
 };
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_dst_port_add, 23.11)
@@ -109,7 +109,7 @@ setup_udp4_dstprt_hash(struct udp4_input_node_main *nm, int socket)
 	/* create Hash table */
 	snprintf(s, sizeof(s), "UDP4_INPUT_HASH_%d", socket);
 	hash_udp4->name = s;
-	hash_udp4->socket_id = socket;
+	hash_udp4->numa_id = socket;
 	nm->hash_tbl[socket] = rte_hash_create(hash_udp4);
 	if (nm->hash_tbl[socket] == NULL)
 		return -rte_errno;
diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 38a7bd75d6..6c851c173a 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1837,7 +1837,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 	params.entries = VHOST_CRYPTO_SESSION_MAP_ENTRIES;
 	params.hash_func = rte_jhash;
 	params.key_len = sizeof(uint64_t);
-	params.socket_id = socket_id;
+	params.numa_id = socket_id;
 	vcrypto->session_map = rte_hash_create(&params);
 	if (!vcrypto->session_map) {
 		VC_LOG_ERR("Failed to creath session map");
-- 
2.55.0

