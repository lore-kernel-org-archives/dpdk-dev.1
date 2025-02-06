Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E629C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEA4C40DCA;
	Thu,  6 Feb 2025 02:34:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D61B040687
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:38 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 552E6203F5B6; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 552E6203F5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805617;
 bh=XAAWZJKSfAlZkUeg6ZiXPc/N8XybIHCOrU1Y4WOkSBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YSh/fy/qnx40lE2zOT9wtcR34EV+YjnQ8r4n6CHBJNGzDQLzPXUxiwgL33nxg1IYV
 lGBKEUq4Mvv58siKM6P7jC3VqhiDPdBt3x3mQBIDY3EmTYNHipNWNwNI79JRMW7aiw
 C/FzuGvfv6OMPsLPB7QoW5zgIZBlXhLk6OPUj0K8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v22 18/27] test: remove use of VLAs for Windows built code in
 bitset tests
Date: Wed,  5 Feb 2025 17:33:21 -0800
Message-Id: <1738805610-17507-19-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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

1) MSVC does not support VLAs. Use standard fixed C arrays of
maximum size required instead.

2) ../usr/lib/gcc/x86_64-redhat-linux/13/include/emmintrin.h:742:8:
    error: array subscript 9 is outside array bounds of 'uint64_t[16]'
    {aka 'long unsigned int[16]'} [-Werror=array-bounds=]
   3695 742 | *__P = __B;

Compile with -Wno-array-bounds to avoid false positives when
using gcc version 11 or newer (gcc compiler bug/limitation).

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_bitset.c             | 59 +++++++++++++++++-------------
 app/test/test_lcore_var_perf.c     |  2 +-
 app/test/test_reassembly_perf.c    | 22 ++++++-----
 app/test/test_soring_stress_impl.h | 13 ++++---
 4 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/app/test/test_bitset.c b/app/test/test_bitset.c
index 50b8bf0da4..88b2d8bab0 100644
--- a/app/test/test_bitset.c
+++ b/app/test/test_bitset.c
@@ -99,11 +99,13 @@ typedef void clear_fun(uint64_t *bitset, size_t bit_num);
 typedef void assign_fun(uint64_t *bitset, size_t bit_num, bool value);
 typedef void flip_fun(uint64_t *bitset, size_t bit_num);
 
+#define RAND_SET_MAX_SIZE 1000
+
 static int
 test_set_clear_size(test_fun test_fun, set_fun set_fun, clear_fun clear_fun, size_t size)
 {
 	size_t i;
-	bool reference[size];
+	bool reference[RAND_SET_MAX_SIZE];
 	uint64_t *bitset;
 
 	rand_bool_ary(reference, size);
@@ -131,8 +133,7 @@ test_set_clear_size(test_fun test_fun, set_fun set_fun, clear_fun clear_fun, siz
 	return TEST_SUCCESS;
 }
 
-#define RAND_ITERATIONS (10000)
-#define RAND_SET_MAX_SIZE (1000)
+#define RAND_ITERATIONS 10000
 
 static int
 test_set_clear_fun(test_fun test_fun, set_fun set_fun, clear_fun clear_fun)
@@ -168,7 +169,7 @@ test_flip_size(test_fun test_fun, assign_fun assign_fun, flip_fun flip_fun, size
 	rand_bitset(bitset, size);
 
 	for (i = 0; i < size; i++) {
-		RTE_BITSET_DECLARE(reference, size);
+		uint64_t *reference = alloca(RTE_BITSET_SIZE(size));
 
 		rte_bitset_copy(reference, bitset, size);
 
@@ -282,13 +283,13 @@ find_clear(const bool *ary, size_t num_bools, size_t start, size_t len)
 	return find(ary, num_bools, start, len, false);
 }
 
-#define FFS_ITERATIONS (100)
+#define FFS_ITERATIONS 100
 
 static int
 test_find_size(size_t size, bool set)
 {
 	uint64_t *bitset;
-	bool reference[size];
+	bool reference[RAND_SET_MAX_SIZE];
 	size_t i;
 
 	bitset = alloc_bitset(size);
@@ -388,8 +389,8 @@ record_match(ssize_t match_idx, size_t size, int *calls)
 static int
 test_foreach_size(ssize_t size, bool may_wrap, bool set)
 {
-	bool reference[size];
-	int calls[size];
+	bool reference[RAND_SET_MAX_SIZE];
+	int calls[RAND_SET_MAX_SIZE];
 	uint64_t *bitset;
 	ssize_t i;
 	ssize_t start_bit;
@@ -633,17 +634,19 @@ test_define(void)
 typedef void bitset_op(uint64_t *dst, const uint64_t *a, const uint64_t *b, size_t bit_num);
 typedef bool bool_op(bool a, bool b);
 
+#define LOGIC_MAX_SET_SIZE 200
+
 static int
 test_logic_op(bitset_op bitset_op, bool_op bool_op)
 {
-	const size_t size = 1 + rte_rand_max(200);
-	RTE_BITSET_DECLARE(bitset_a, size);
-	RTE_BITSET_DECLARE(bitset_b, size);
-	RTE_BITSET_DECLARE(bitset_d, size);
+	const size_t size = 1 + rte_rand_max(LOGIC_MAX_SET_SIZE);
+	RTE_BITSET_DECLARE(bitset_a, LOGIC_MAX_SET_SIZE);
+	RTE_BITSET_DECLARE(bitset_b, LOGIC_MAX_SET_SIZE);
+	RTE_BITSET_DECLARE(bitset_d, LOGIC_MAX_SET_SIZE);
 
-	bool ary_a[size];
-	bool ary_b[size];
-	bool ary_d[size];
+	bool ary_a[LOGIC_MAX_SET_SIZE];
+	bool ary_b[LOGIC_MAX_SET_SIZE];
+	bool ary_d[LOGIC_MAX_SET_SIZE];
 
 	rand_bool_ary(ary_a, size);
 	rand_bool_ary(ary_b, size);
@@ -708,14 +711,14 @@ test_complement(void)
 	for (i = 0; i < RAND_ITERATIONS; i++) {
 		const size_t size = 1 + rte_rand_max(RAND_SET_MAX_SIZE - 1);
 
-		RTE_BITSET_DECLARE(src, size);
+		RTE_BITSET_DECLARE(src, RAND_SET_MAX_SIZE);
 
 		rand_bitset(src, size);
 
 		bool bit_idx = rte_rand_max(size);
 		bool bit_value = rte_bitset_test(src, bit_idx);
 
-		RTE_BITSET_DECLARE(dst, size);
+		RTE_BITSET_DECLARE(dst, RAND_SET_MAX_SIZE);
 
 		rte_bitset_complement(dst, src, size);
 
@@ -726,6 +729,8 @@ test_complement(void)
 	return TEST_SUCCESS;
 }
 
+#define SHIFT_SET_MAX_SIZE 500
+
 static int
 test_shift(bool right)
 {
@@ -734,12 +739,12 @@ test_shift(bool right)
 	const char *direction = right ? "right" : "left";
 
 	for (i = 0; i < 10000; i++) {
-		const int size = 1 + (int)rte_rand_max(500);
+		const int size = 1 + (int)rte_rand_max(SHIFT_SET_MAX_SIZE);
 		const int shift_count = (int)rte_rand_max(1.5 * size);
 		int src_idx;
 
-		RTE_BITSET_DECLARE(src, size);
-		RTE_BITSET_DECLARE(reference, size);
+		RTE_BITSET_DECLARE(src, SHIFT_SET_MAX_SIZE);
+		RTE_BITSET_DECLARE(reference, SHIFT_SET_MAX_SIZE);
 
 		rte_bitset_init(src, size);
 		rte_bitset_init(reference, size);
@@ -788,12 +793,14 @@ test_shift_left(void)
 	return test_shift(false);
 }
 
+#define EQUAL_SET_MAX_SIZE 100
+
 static int
 test_equal(void)
 {
-	const size_t size = 100;
-	RTE_BITSET_DECLARE(bitset_a, size);
-	RTE_BITSET_DECLARE(bitset_b, size);
+	const size_t size = EQUAL_SET_MAX_SIZE;
+	RTE_BITSET_DECLARE(bitset_a, EQUAL_SET_MAX_SIZE);
+	RTE_BITSET_DECLARE(bitset_b, EQUAL_SET_MAX_SIZE);
 
 	rand_buf(bitset_a, RTE_BITSET_SIZE(size));
 	rand_buf(bitset_b, RTE_BITSET_SIZE(size));
@@ -821,9 +828,9 @@ test_equal(void)
 static int
 test_copy(void)
 {
-	const size_t size = 100;
-	RTE_BITSET_DECLARE(bitset_a, size);
-	RTE_BITSET_DECLARE(bitset_b, size);
+	const size_t size = EQUAL_SET_MAX_SIZE;
+	RTE_BITSET_DECLARE(bitset_a, EQUAL_SET_MAX_SIZE);
+	RTE_BITSET_DECLARE(bitset_b, EQUAL_SET_MAX_SIZE);
 
 	rand_buf(bitset_a, RTE_BITSET_SIZE(size));
 	rand_buf(bitset_b, RTE_BITSET_SIZE(size));
diff --git a/app/test/test_lcore_var_perf.c b/app/test/test_lcore_var_perf.c
index 41e29bbd49..5a74ce4808 100644
--- a/app/test/test_lcore_var_perf.c
+++ b/app/test/test_lcore_var_perf.c
@@ -185,7 +185,7 @@ test_lcore_var_access_n(unsigned int num_mods)
 	double tls_latency;
 	double lazy_tls_latency;
 	double lvar_latency;
-	unsigned int mods[num_mods];
+	unsigned int mods[MAX_MODS];
 	unsigned int i;
 
 	for (i = 0; i < num_mods; i++)
diff --git a/app/test/test_reassembly_perf.c b/app/test/test_reassembly_perf.c
index 69cf029468..7d3c692547 100644
--- a/app/test/test_reassembly_perf.c
+++ b/app/test/test_reassembly_perf.c
@@ -557,6 +557,8 @@ ipv4_outstanding_reassembly_perf(int8_t nb_frags, uint8_t fill_order,
 	return TEST_SUCCESS;
 }
 
+#define TEST_REASSEMBLY_ITERATIONS 4
+
 static int
 ipv4_reassembly_interleaved_flows_perf(uint8_t nb_frags)
 {
@@ -568,17 +570,17 @@ ipv4_reassembly_interleaved_flows_perf(uint8_t nb_frags)
 	uint64_t total_cyc = 0;
 	uint32_t i, j;
 
-	for (i = 0; i < flow_cnt; i += 4) {
+	for (i = 0; i < flow_cnt; i += TEST_REASSEMBLY_ITERATIONS) {
 		struct rte_mbuf *buf_out[4] = {NULL};
 		uint8_t reassembled = 0;
 		uint8_t nb_frags = 0;
 		uint8_t prev = 0;
 
-		for (j = 0; j < 4; j++)
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++)
 			nb_frags += frag_per_flow[i + j];
 
-		struct rte_mbuf *buf_arr[nb_frags];
-		for (j = 0; j < 4; j++) {
+		struct rte_mbuf *buf_arr[TEST_REASSEMBLY_ITERATIONS * MAX_FRAGMENTS];
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++) {
 			join_array(buf_arr, mbufs[i + j], prev,
 				   frag_per_flow[i + j]);
 			prev += frag_per_flow[i + j];
@@ -608,7 +610,7 @@ ipv4_reassembly_interleaved_flows_perf(uint8_t nb_frags)
 		total_cyc += rte_rdtsc_precise() - flow_tstamp;
 		if (reassembled != 4)
 			return TEST_FAILED;
-		for (j = 0; j < 4; j++) {
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++) {
 			memset(mbufs[i + j], 0,
 			       sizeof(struct rte_mbuf *) * MAX_FRAGMENTS);
 			mbufs[i + j][0] = buf_out[j];
@@ -779,17 +781,17 @@ ipv6_reassembly_interleaved_flows_perf(int8_t nb_frags)
 	uint64_t total_cyc = 0;
 	uint32_t i, j;
 
-	for (i = 0; i < flow_cnt; i += 4) {
+	for (i = 0; i < flow_cnt; i += TEST_REASSEMBLY_ITERATIONS) {
 		struct rte_mbuf *buf_out[4] = {NULL};
 		uint8_t reassembled = 0;
 		uint8_t nb_frags = 0;
 		uint8_t prev = 0;
 
-		for (j = 0; j < 4; j++)
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++)
 			nb_frags += frag_per_flow[i + j];
 
-		struct rte_mbuf *buf_arr[nb_frags];
-		for (j = 0; j < 4; j++) {
+		struct rte_mbuf *buf_arr[TEST_REASSEMBLY_ITERATIONS * MAX_FRAGMENTS];
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++) {
 			join_array(buf_arr, mbufs[i + j], prev,
 				   frag_per_flow[i + j]);
 			prev += frag_per_flow[i + j];
@@ -825,7 +827,7 @@ ipv6_reassembly_interleaved_flows_perf(int8_t nb_frags)
 		total_cyc += rte_rdtsc_precise() - flow_tstamp;
 		if (reassembled != 4)
 			return TEST_FAILED;
-		for (j = 0; j < 4; j++) {
+		for (j = 0; j < TEST_REASSEMBLY_ITERATIONS; j++) {
 			memset(mbufs[i + j], 0,
 			       sizeof(struct rte_mbuf *) * MAX_FRAGMENTS);
 			mbufs[i + j][0] = buf_out[j];
diff --git a/app/test/test_soring_stress_impl.h b/app/test/test_soring_stress_impl.h
index bea33f58d1..9e22de98d2 100644
--- a/app/test/test_soring_stress_impl.h
+++ b/app/test/test_soring_stress_impl.h
@@ -630,24 +630,25 @@ role_mask_even_odd(uint32_t nb_stage, uint32_t role_mask[RTE_MAX_LCORE])
 static void
 role_mask_div(uint32_t nb_stage, uint32_t role_mask[RTE_MAX_LCORE])
 {
+	const uint32_t msk_count = nb_stage + 1;
 	uint32_t i, lc;
-	uint32_t msk[nb_stage + 1];
+	uint32_t *msk = alloca(sizeof(uint32_t) * msk_count);
 
 	memset(role_mask, 0, sizeof(role_mask[0]) * RTE_MAX_LCORE);
 
-	for (i = 0; i != RTE_DIM(msk); i++) {
+	for (i = 0; i != msk_count; i++) {
 		msk[i] = RTE_BIT32(i);
 	};
 
 	i = 0;
 	RTE_LCORE_FOREACH_WORKER(lc) {
-		role_mask[lc] = msk[i % RTE_DIM(msk)];
+		role_mask[lc] = msk[i % msk_count];
 		i++;
 	}
-	if (i < RTE_DIM(msk)) {
+	if (i < msk_count) {
 		lc = rte_get_next_lcore(-1, 1, 0);
-		for (; i != RTE_DIM(msk); i++)
-			role_mask[lc] |= msk[i % RTE_DIM(msk)];
+		for (; i != msk_count; i++)
+			role_mask[lc] |= msk[i % msk_count];
 	}
 }
 
-- 
2.47.2.vfs.0.1

