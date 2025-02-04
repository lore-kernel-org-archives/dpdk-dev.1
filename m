Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452BC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45FC040649;
	Tue,  4 Feb 2025 17:23:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4D6E24042F
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D46B8210C339; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D46B8210C339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686167;
 bh=kueUIoi3zIyA9B9XC/OXG4lvpA3rwhyCg/uJebuSZJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BE8JDmmwM1oMtw7NW/GZ/O3o5f/rckl+DTsBRQW6i3cwc3hH429mPkEYj49KNov5Q
 TAA6iqADY/vbNVhPZSJVKmv6WEa3M7bDDWg454JKefmLnBcfkgG1H94CqY6GJpivkM
 TjUtRgBcHbkrgGkqeBxq3tGg55K5ODL/vy//VqH4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v20 13/27] test: remove use of VLAs for Windows built code
Date: Tue,  4 Feb 2025 08:21:50 -0800
Message-Id: <1738686124-16173-14-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test.c                       |  2 +-
 app/test/test_cmdline_string.c        |  2 +-
 app/test/test_cryptodev.c             | 34 +++++++++----------
 app/test/test_cryptodev_blockcipher.c |  4 +--
 app/test/test_cryptodev_crosscheck.c  |  2 +-
 app/test/test_dmadev.c                |  9 +++--
 app/test/test_hash.c                  | 14 ++++----
 app/test/test_mempool.c               | 25 +++++++-------
 app/test/test_reorder.c               | 48 +++++++++++++++------------
 app/test/test_service_cores.c         |  9 +++--
 app/test/test_thash.c                 |  7 ++--
 11 files changed, 82 insertions(+), 74 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 680351f6a3..fd653cbbfd 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -105,7 +105,7 @@ int
 main(int argc, char **argv)
 {
 	struct cmdline *cl;
-	char *tests[argc]; /* store an array of tests to run */
+	char **tests = alloca(sizeof(char *) * argc); /* store an array of tests to run */
 	int test_count = 0;
 	int i;
 	char *extra_args;
diff --git a/app/test/test_cmdline_string.c b/app/test/test_cmdline_string.c
index 97516c9400..e1cf86020f 100644
--- a/app/test/test_cmdline_string.c
+++ b/app/test/test_cmdline_string.c
@@ -40,7 +40,7 @@ struct string_elt_str string_elt_strs[] = {
 #if (CMDLINE_TEST_BUFSIZE < STR_TOKEN_SIZE) \
 || (CMDLINE_TEST_BUFSIZE < STR_MULTI_TOKEN_SIZE)
 #undef CMDLINE_TEST_BUFSIZE
-#define CMDLINE_TEST_BUFSIZE RTE_MAX(STR_TOKEN_SIZE, STR_MULTI_TOKEN_SIZE)
+#define CMDLINE_TEST_BUFSIZE RTE_MAX_T(STR_TOKEN_SIZE, STR_MULTI_TOKEN_SIZE, size_t)
 #endif
 
 struct string_nb_str {
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 7cddb1517c..441ecc6ad5 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -2886,7 +2886,7 @@ create_wireless_algo_hash_session(uint8_t dev_id,
 	enum rte_crypto_auth_operation op,
 	enum rte_crypto_auth_algorithm algo)
 {
-	uint8_t hash_key[key_len];
+	uint8_t *hash_key = alloca(key_len);
 
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
@@ -2922,7 +2922,7 @@ create_wireless_algo_cipher_session(uint8_t dev_id,
 			const uint8_t *key, const uint8_t key_len,
 			uint8_t iv_len)
 {
-	uint8_t cipher_key[key_len];
+	uint8_t *cipher_key = alloca(key_len);
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
 
@@ -3074,7 +3074,7 @@ create_wireless_cipher_auth_session(uint8_t dev_id,
 		const struct wireless_test_data *tdata)
 {
 	const uint8_t key_len = tdata->key.len;
-	uint8_t cipher_auth_key[key_len];
+	uint8_t *cipher_auth_key = alloca(key_len);
 
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
@@ -9078,7 +9078,7 @@ create_aead_session(uint8_t dev_id, enum rte_crypto_aead_algorithm algo,
 		const uint16_t aad_len, const uint8_t auth_len,
 		uint8_t iv_len)
 {
-	uint8_t aead_key[key_len];
+	uint8_t *aead_key = alloca(key_len);
 
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
@@ -12989,7 +12989,7 @@ test_cryptodev_error_recover_helper(uint8_t dev_id, const void *test_data, bool
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
 	const struct blockcipher_test_data *tdata = test_data;
-	uint8_t cipher_key[tdata->cipher_key.len];
+	uint8_t *cipher_key = alloca(tdata->cipher_key.len);
 	struct rte_crypto_sym_op *sym_op = NULL;
 	struct rte_crypto_op *op = NULL;
 	char *dst;
@@ -13345,7 +13345,7 @@ static int
 test_AES_GCM_auth_encryption_fail_aad_corrupt(void)
 {
 	struct aead_test_data tdata;
-	uint8_t aad[gcm_test_case_7.aad.len];
+	uint8_t *aad = alloca(gcm_test_case_7.aad.len);
 	int res;
 
 	RTE_LOG(INFO, USER1, "This is a negative test, errors are expected\n");
@@ -13734,7 +13734,7 @@ static int
 test_AES_GCM_auth_decryption_fail_aad_corrupt(void)
 {
 	struct aead_test_data tdata;
-	uint8_t aad[gcm_test_case_7.aad.len];
+	uint8_t *aad = alloca(gcm_test_case_7.aad.len);
 	int res;
 
 	memcpy(&tdata, &gcm_test_case_7, sizeof(struct aead_test_data));
@@ -13986,7 +13986,7 @@ test_authenticated_encryption_sessionless(
 	int retval;
 	uint8_t *ciphertext, *auth_tag;
 	uint16_t plaintext_pad_len;
-	uint8_t key[tdata->key.len + 1];
+	uint8_t *key = alloca(tdata->key.len + 1);
 	struct rte_cryptodev_info dev_info;
 
 	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
@@ -14088,7 +14088,7 @@ test_authenticated_decryption_sessionless(
 
 	int retval;
 	uint8_t *plaintext;
-	uint8_t key[tdata->key.len + 1];
+	uint8_t *key = alloca(tdata->key.len + 1);
 	struct rte_cryptodev_info dev_info;
 
 	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
@@ -15495,7 +15495,7 @@ static int create_gmac_session(uint8_t dev_id,
 		const struct gmac_test_data *tdata,
 		enum rte_crypto_auth_operation auth_op)
 {
-	uint8_t auth_key[tdata->key.len];
+	uint8_t *auth_key = alloca(tdata->key.len);
 
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
@@ -16152,7 +16152,7 @@ create_auth_session(struct crypto_unittest_params *ut_params,
 		enum rte_crypto_auth_operation auth_op)
 {
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
-	uint8_t auth_key[reference->auth_key.len + 1];
+	uint8_t *auth_key = alloca(reference->auth_key.len + 1);
 
 	memcpy(auth_key, reference->auth_key.data, reference->auth_key.len);
 
@@ -16184,8 +16184,8 @@ create_auth_cipher_session(struct crypto_unittest_params *ut_params,
 		enum rte_crypto_cipher_operation cipher_op)
 {
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
-	uint8_t cipher_key[reference->cipher_key.len + 1];
-	uint8_t auth_key[reference->auth_key.len + 1];
+	uint8_t *cipher_key = alloca(reference->cipher_key.len + 1);
+	uint8_t *auth_key = alloca(reference->auth_key.len + 1);
 
 	memcpy(cipher_key, reference->cipher_key.data,
 			reference->cipher_key.len);
@@ -16686,8 +16686,8 @@ test_authenticated_encrypt_with_esn(
 
 	uint8_t *authciphertext, *plaintext, *auth_tag;
 	uint16_t plaintext_pad_len;
-	uint8_t cipher_key[reference->cipher_key.len + 1];
-	uint8_t auth_key[reference->auth_key.len + 1];
+	uint8_t *cipher_key = alloca(reference->cipher_key.len + 1);
+	uint8_t *auth_key = alloca(reference->auth_key.len + 1);
 	struct rte_cryptodev_info dev_info;
 
 	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
@@ -16818,8 +16818,8 @@ test_authenticated_decrypt_with_esn(
 	int retval;
 
 	uint8_t *ciphertext;
-	uint8_t cipher_key[reference->cipher_key.len + 1];
-	uint8_t auth_key[reference->auth_key.len + 1];
+	uint8_t *cipher_key = alloca(reference->cipher_key.len + 1);
+	uint8_t *auth_key = alloca(reference->auth_key.len + 1);
 	struct rte_cryptodev_info dev_info;
 
 	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptodev_blockcipher.c
index 8e13cdfc7a..5a124bbb5e 100644
--- a/app/test/test_cryptodev_blockcipher.c
+++ b/app/test/test_cryptodev_blockcipher.c
@@ -85,8 +85,8 @@ test_blockcipher_one_case(const struct blockcipher_test_case *t,
 
 	int status = TEST_SUCCESS;
 	const struct blockcipher_test_data *tdata = t->test_data;
-	uint8_t cipher_key[tdata->cipher_key.len];
-	uint8_t auth_key[tdata->auth_key.len];
+	uint8_t *cipher_key = alloca(tdata->cipher_key.len);
+	uint8_t *auth_key = alloca(tdata->auth_key.len);
 	uint32_t buf_len = tdata->ciphertext.len;
 	uint32_t digest_len = tdata->digest.len;
 	char *buf_p = NULL;
diff --git a/app/test/test_cryptodev_crosscheck.c b/app/test/test_cryptodev_crosscheck.c
index c29b19cf6b..b9a53a430c 100644
--- a/app/test/test_cryptodev_crosscheck.c
+++ b/app/test/test_cryptodev_crosscheck.c
@@ -894,7 +894,7 @@ static int
 crosscheck_with_profile_run(const struct crosscheck_test_profile *profile)
 {
 	struct crosscheck_testsuite_params *ts_params = &testsuite_params;
-	uint8_t input_text[profile->input_buf_len];
+	uint8_t *input_text = alloca(profile->input_buf_len);
 	uint16_t output_len, encrypted_len;
 	uint8_t encrypted_text[MBUF_SIZE];
 	uint8_t output_text[MBUF_SIZE];
diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 143e1bcd68..9cbb9a6552 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -417,9 +417,12 @@ test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
 			dst_len = len / n_dst;
 			src_len = len / n_src;
 
-			struct rte_dma_sge sg_src[n_sge], sg_dst[n_sge];
-			struct rte_mbuf *src[n_sge], *dst[n_sge];
-			char *src_data[n_sge], *dst_data[n_sge];
+			struct rte_dma_sge *sg_src = alloca(sizeof(struct rte_dma_sge) * n_sge);
+			struct rte_dma_sge *sg_dst = alloca(sizeof(struct rte_dma_sge) * n_sge);
+			struct rte_mbuf **src = alloca(sizeof(struct rte_mbuf *) * n_sge);
+			struct rte_mbuf **dst = alloca(sizeof(struct rte_mbuf *) * n_sge);
+			char **src_data = alloca(sizeof(char *) * n_sge);
+			char **dst_data = alloca(sizeof(char *) * n_sge);
 
 			for (i = 0 ; i < len; i++)
 				orig_src[i] = rte_rand() & 0xFF;
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 6b5ef2d1e5..5791fd7f4c 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1947,6 +1947,8 @@ test_hash_rcu_qsbr_add(void)
 	return 0;
 }
 
+#define HASH_RCU_QSBR_MAX_TOTAL_ENTRIES 9
+
 /*
  * rte_hash_rcu_qsbr_add DQ mode functional test.
  * Reader and writer are in the same thread in this test.
@@ -1966,7 +1968,7 @@ test_hash_rcu_qsbr_add(void)
 static int
 test_hash_rcu_qsbr_dq_mode(uint8_t ext_bkt)
 {
-	uint32_t total_entries = (ext_bkt == 0) ? 8 : 9;
+	const uint32_t total_entries = (ext_bkt == 0) ? 8 : HASH_RCU_QSBR_MAX_TOTAL_ENTRIES;
 
 	uint8_t hash_extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF;
 
@@ -1982,8 +1984,8 @@ test_hash_rcu_qsbr_dq_mode(uint8_t ext_bkt)
 		.socket_id = 0,
 		.extra_flag = hash_extra_flag,
 	};
-	int pos[total_entries];
-	int expected_pos[total_entries];
+	int pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
+	int expected_pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
 	unsigned int i;
 	size_t sz;
 	int32_t status;
@@ -2136,7 +2138,7 @@ test_hash_rcu_qsbr_reader(void *arg)
 static int
 test_hash_rcu_qsbr_sync_mode(uint8_t ext_bkt)
 {
-	uint32_t total_entries = (ext_bkt == 0) ? 8 : 9;
+	const uint32_t total_entries = (ext_bkt == 0) ? 8 : HASH_RCU_QSBR_MAX_TOTAL_ENTRIES;
 
 	uint8_t hash_extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF;
 
@@ -2152,8 +2154,8 @@ test_hash_rcu_qsbr_sync_mode(uint8_t ext_bkt)
 		.socket_id = 0,
 		.extra_flag = hash_extra_flag,
 	};
-	int pos[total_entries];
-	int expected_pos[total_entries];
+	int pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
+	int expected_pos[HASH_RCU_QSBR_MAX_TOTAL_ENTRIES];
 	unsigned int i;
 	size_t sz;
 	int32_t status;
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 3f7ba5872d..61385e096e 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -515,19 +515,20 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 #undef RTE_TEST_TRACE_FAILURE
 #define RTE_TEST_TRACE_FAILURE(...) do { goto fail; } while (0)
 
-	static const size_t callback_num = 3;
-	static const size_t mempool_num = 2;
+#define CALLBACK_NUM 3u
+#define MEMPOOL_NUM 2u
+
 	static const unsigned int mempool_elt_size = 64;
 	static const unsigned int mempool_size = 64;
 
-	struct test_mempool_events_data data[callback_num];
-	struct rte_mempool *mp[mempool_num], *freed;
+	struct test_mempool_events_data data[CALLBACK_NUM];
+	struct rte_mempool *mp[MEMPOOL_NUM], *freed;
 	char name[RTE_MEMPOOL_NAMESIZE];
 	size_t i, j;
 	int ret;
 
 	memset(mp, 0, sizeof(mp));
-	for (i = 0; i < callback_num; i++) {
+	for (i = 0; i < CALLBACK_NUM; i++) {
 		ret = rte_mempool_event_callback_register
 				(test_mempool_events_cb, &data[i]);
 		RTE_TEST_ASSERT_EQUAL(ret, 0, "Failed to register the callback %zu: %s",
@@ -548,7 +549,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 					 SOCKET_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mp[0], "Cannot create mempool %s: %s",
 				 name, rte_strerror(rte_errno));
-	for (j = 0; j < callback_num; j++)
+	for (j = 0; j < CALLBACK_NUM; j++)
 		RTE_TEST_ASSERT_EQUAL(data[j].invoked, false,
 				      "Callback %zu invoked on %s mempool creation",
 				      j, name);
@@ -557,7 +558,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 	ret = populate(mp[0]);
 	RTE_TEST_ASSERT_EQUAL(ret, (int)mp[0]->size, "Failed to populate mempool %s: %s",
 			      name, rte_strerror(-ret));
-	for (j = 0; j < callback_num; j++) {
+	for (j = 0; j < CALLBACK_NUM; j++) {
 		RTE_TEST_ASSERT_EQUAL(data[j].invoked, true,
 					"Callback %zu not invoked on mempool %s population",
 					j, name);
@@ -589,7 +590,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 			      "Unregistered callback 0 invoked on %s mempool populaton",
 			      name);
 
-	for (i = 0; i < mempool_num; i++) {
+	for (i = 0; i < MEMPOOL_NUM; i++) {
 		memset(&data, 0, sizeof(data));
 		sprintf(name, "empty%zu", i);
 		rte_mempool_free(mp[i]);
@@ -599,7 +600,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 		 */
 		freed = mp[i];
 		mp[i] = NULL;
-		for (j = 1; j < callback_num; j++) {
+		for (j = 1; j < CALLBACK_NUM; j++) {
 			RTE_TEST_ASSERT_EQUAL(data[j].invoked, true,
 					      "Callback %zu not invoked on mempool %s destruction",
 					      j, name);
@@ -615,7 +616,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 				      name);
 	}
 
-	for (j = 1; j < callback_num; j++) {
+	for (j = 1; j < CALLBACK_NUM; j++) {
 		ret = rte_mempool_event_callback_unregister
 					(test_mempool_events_cb, &data[j]);
 		RTE_TEST_ASSERT_EQUAL(ret, 0, "Failed to unregister the callback %zu: %s",
@@ -624,10 +625,10 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 	return TEST_SUCCESS;
 
 fail:
-	for (j = 0; j < callback_num; j++)
+	for (j = 0; j < CALLBACK_NUM; j++)
 		rte_mempool_event_callback_unregister
 					(test_mempool_events_cb, &data[j]);
-	for (i = 0; i < mempool_num; i++)
+	for (i = 0; i < MEMPOOL_NUM; i++)
 		rte_mempool_free(mp[i]);
 	return TEST_FAILED;
 
diff --git a/app/test/test_reorder.c b/app/test/test_reorder.c
index 501780cb26..aaa2c57086 100644
--- a/app/test/test_reorder.c
+++ b/app/test/test_reorder.c
@@ -130,11 +130,12 @@ test_reorder_free(void)
 static int
 test_reorder_insert(void)
 {
+#define INSERT_NUM_BUFS 7u
+
 	struct rte_reorder_buffer *b = NULL;
 	struct rte_mempool *p = test_params->p;
 	const unsigned int size = 4;
-	const unsigned int num_bufs = 7;
-	struct rte_mbuf *bufs[num_bufs];
+	struct rte_mbuf *bufs[INSERT_NUM_BUFS];
 	int ret = 0;
 	unsigned i;
 
@@ -146,7 +147,7 @@ test_reorder_insert(void)
 	b = rte_reorder_create("test_insert", rte_socket_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < INSERT_NUM_BUFS; i++) {
 		bufs[i] = rte_pktmbuf_alloc(p);
 		TEST_ASSERT_NOT_NULL(bufs[i], "Packet allocation failed\n");
 		*rte_reorder_seqn(bufs[i]) = i;
@@ -207,26 +208,27 @@ test_reorder_insert(void)
 	ret = 0;
 exit:
 	rte_reorder_free(b);
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < INSERT_NUM_BUFS; i++)
 		rte_pktmbuf_free(bufs[i]);
-	}
+
 	return ret;
 }
 
 static int
 test_reorder_drain(void)
 {
+#define DRAIN_NUM_BUFS 8u
+
 	struct rte_reorder_buffer *b = NULL;
 	struct rte_mempool *p = test_params->p;
 	const unsigned int size = 4;
-	const unsigned int num_bufs = 8;
-	struct rte_mbuf *bufs[num_bufs];
-	struct rte_mbuf *robufs[num_bufs];
+	struct rte_mbuf *bufs[DRAIN_NUM_BUFS];
+	struct rte_mbuf *robufs[DRAIN_NUM_BUFS];
 	int ret = 0;
 	unsigned i, cnt;
 
 	/* initialize all robufs to NULL */
-	for (i = 0; i < num_bufs; i++)
+	for (i = 0; i < DRAIN_NUM_BUFS; i++)
 		robufs[i] = NULL;
 
 	/* This would create a reorder buffer instance consisting of:
@@ -246,7 +248,7 @@ test_reorder_drain(void)
 		goto exit;
 	}
 
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < DRAIN_NUM_BUFS; i++) {
 		bufs[i] = rte_pktmbuf_alloc(p);
 		TEST_ASSERT_NOT_NULL(bufs[i], "Packet allocation failed\n");
 		*rte_reorder_seqn(bufs[i]) = i;
@@ -320,7 +322,7 @@ test_reorder_drain(void)
 	ret = 0;
 exit:
 	rte_reorder_free(b);
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < DRAIN_NUM_BUFS; i++) {
 		rte_pktmbuf_free(bufs[i]);
 		rte_pktmbuf_free(robufs[i]);
 	}
@@ -337,15 +339,16 @@ buffer_to_reorder_move(struct rte_mbuf **mbuf, struct rte_reorder_buffer *b)
 static int
 test_reorder_drain_up_to_seqn(void)
 {
+#define DRAIN_TO_NUM_BUFS 10u
+
 	struct rte_mempool *p = test_params->p;
 	struct rte_reorder_buffer *b = NULL;
-	const unsigned int num_bufs = 10;
 	const unsigned int size = 4;
 	unsigned int i, cnt;
 	int ret = 0;
 
-	struct rte_mbuf *bufs[num_bufs];
-	struct rte_mbuf *robufs[num_bufs];
+	struct rte_mbuf *bufs[DRAIN_TO_NUM_BUFS];
+	struct rte_mbuf *robufs[DRAIN_TO_NUM_BUFS];
 
 	/* initialize all robufs to NULL */
 	memset(robufs, 0, sizeof(robufs));
@@ -358,7 +361,7 @@ test_reorder_drain_up_to_seqn(void)
 	b = rte_reorder_create("test_drain_up_to_seqn", rte_socket_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < DRAIN_TO_NUM_BUFS; i++) {
 		bufs[i] = rte_pktmbuf_alloc(p);
 		TEST_ASSERT_NOT_NULL(bufs[i], "Packet allocation failed\n");
 		*rte_reorder_seqn(bufs[i]) = i;
@@ -372,7 +375,7 @@ test_reorder_drain_up_to_seqn(void)
 	buffer_to_reorder_move(&bufs[2], b);
 	buffer_to_reorder_move(&bufs[3], b);
 	/* Draining 1, 2 */
-	cnt = rte_reorder_drain_up_to_seqn(b, robufs, num_bufs, 3);
+	cnt = rte_reorder_drain_up_to_seqn(b, robufs, DRAIN_TO_NUM_BUFS, 3);
 	if (cnt != 2) {
 		printf("%s:%d:%d: number of expected packets not drained\n",
 				__func__, __LINE__, cnt);
@@ -396,7 +399,7 @@ test_reorder_drain_up_to_seqn(void)
 	buffer_to_reorder_move(&bufs[8], b);
 
 	/* Drain 3 and 5 */
-	cnt = rte_reorder_drain_up_to_seqn(b, robufs, num_bufs, 6);
+	cnt = rte_reorder_drain_up_to_seqn(b, robufs, DRAIN_TO_NUM_BUFS, 6);
 	if (cnt != 2) {
 		printf("%s:%d:%d: number of expected packets not drained\n",
 				__func__, __LINE__, cnt);
@@ -410,7 +413,7 @@ test_reorder_drain_up_to_seqn(void)
 	ret = 0;
 exit:
 	rte_reorder_free(b);
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < DRAIN_TO_NUM_BUFS; i++) {
 		rte_pktmbuf_free(bufs[i]);
 		rte_pktmbuf_free(robufs[i]);
 	}
@@ -420,14 +423,15 @@ test_reorder_drain_up_to_seqn(void)
 static int
 test_reorder_set_seqn(void)
 {
+#define SET_SEQN_NUM_BUFS 7u
+
 	struct rte_mempool *p = test_params->p;
 	struct rte_reorder_buffer *b = NULL;
-	const unsigned int num_bufs = 7;
 	const unsigned int size = 4;
 	unsigned int i;
 	int ret = 0;
 
-	struct rte_mbuf *bufs[num_bufs];
+	struct rte_mbuf *bufs[SET_SEQN_NUM_BUFS];
 
 	/* This would create a reorder buffer instance consisting of:
 	 * reorder_seq = 0
@@ -437,7 +441,7 @@ test_reorder_set_seqn(void)
 	b = rte_reorder_create("test_min_seqn_set", rte_socket_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
-	for (i = 0; i < num_bufs; i++) {
+	for (i = 0; i < SET_SEQN_NUM_BUFS; i++) {
 		bufs[i] = rte_pktmbuf_alloc(p);
 		if (bufs[i] == NULL) {
 			printf("Packet allocation failed\n");
@@ -479,7 +483,7 @@ test_reorder_set_seqn(void)
 	ret = 0;
 exit:
 	rte_reorder_free(b);
-	for (i = 0; i < num_bufs; i++)
+	for (i = 0; i < SET_SEQN_NUM_BUFS; i++)
 		rte_pktmbuf_free(bufs[i]);
 
 	return ret;
diff --git a/app/test/test_service_cores.c b/app/test/test_service_cores.c
index 46ed9a1868..d95a71f80b 100644
--- a/app/test/test_service_cores.c
+++ b/app/test/test_service_cores.c
@@ -603,9 +603,8 @@ service_lcore_add_del(void)
 			"Service core count not equal to one");
 
 	/* retrieve core list, checking lcore ids */
-	const uint32_t size = 4;
-	uint32_t service_core_ids[size];
-	int32_t n = rte_service_lcore_list(service_core_ids, size);
+	uint32_t service_core_ids[4];
+	int32_t n = rte_service_lcore_list(service_core_ids, RTE_DIM(service_core_ids));
 	TEST_ASSERT_EQUAL(1, n, "Service core list return should equal 1");
 	TEST_ASSERT_EQUAL(slcore_id, service_core_ids[0],
 				"Service core list lcore must equal slcore_id");
@@ -631,7 +630,7 @@ service_lcore_add_del(void)
 			cores_at_this_point);
 
 	/* check longer service core list */
-	n = rte_service_lcore_list(service_core_ids, size);
+	n = rte_service_lcore_list(service_core_ids, RTE_DIM(service_core_ids));
 	TEST_ASSERT_EQUAL(3, n, "Service core list return should equal 3");
 	TEST_ASSERT_EQUAL(slcore_id, service_core_ids[0],
 				"Service core list[0] lcore must equal 1");
@@ -649,7 +648,7 @@ service_lcore_add_del(void)
 			"Service core add did not return zero");
 	TEST_ASSERT_EQUAL(1, rte_service_lcore_count(),
 			"Service core count not equal to one");
-	n = rte_service_lcore_list(service_core_ids, size);
+	n = rte_service_lcore_list(service_core_ids, RTE_DIM(service_core_ids));
 	TEST_ASSERT_EQUAL(1, n, "Service core list return should equal one");
 	TEST_ASSERT_EQUAL(slcore_id, service_core_ids[0],
 				"Service core list[0] lcore must equal %d",
diff --git a/app/test/test_thash.c b/app/test/test_thash.c
index b9c6e9118e..33b0c6adac 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -565,9 +565,8 @@ test_predictable_rss_min_seq(void)
 {
 	struct rte_thash_ctx *ctx;
 	struct rte_thash_subtuple_helper *h;
-	const int key_len = 40;
 	int reta_sz = 6;
-	uint8_t initial_key[key_len];
+	uint8_t initial_key[40];
 	const uint8_t *new_key;
 	int ret;
 	union rte_thash_tuple tuple;
@@ -575,9 +574,9 @@ test_predictable_rss_min_seq(void)
 	unsigned int desired_value = 27 & HASH_MSK(reta_sz);
 	uint16_t port_value = 22;
 
-	memset(initial_key, 0, key_len);
+	memset(initial_key, 0, RTE_DIM(initial_key));
 
-	ctx = rte_thash_init_ctx("test", key_len, reta_sz, initial_key,
+	ctx = rte_thash_init_ctx("test", RTE_DIM(initial_key), reta_sz, initial_key,
 		RTE_THASH_MINIMAL_SEQ);
 	RTE_TEST_ASSERT(ctx != NULL, "can not create thash ctx\n");
 
-- 
2.47.2.vfs.0.1

