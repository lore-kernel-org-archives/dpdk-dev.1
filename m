Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C366CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:15:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C82674064A;
	Thu, 28 Aug 2025 01:15:37 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 9D9134060C
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:36 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso236445f8f.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336536;
 x=1756941336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/M+Ka25uareeqr/Cb0odwDR3VM8aPRRsnB/xC/o7pKQ=;
 b=QgntlWA/80xuge/3DeMhYuWg9gOIhZBvfHEhLV3/9xcyYYSLf/0LZ16xuKjSWW1pXt
 mJiNWsWlQh5xVi41LNbtOAWX4RoY2xT+SXxikF+bdYqYb58y8rNS4GjcMFFc+MarbKhS
 wGcl08yvlcYwSAjuFjIM1aYw+d7XFrZQfZUVjSJWU4QNokruMKHwYvtyCTKErMTbJIcu
 KyE5Y1p/IgTNeWAmzzwr/crWW7jhxQpOW8sAvX1BFZx8ybfFJN2qttnG+ZXVP422ZoZS
 CQTS31xUziQG3trlJzq1/UencZNH5VURJprTx3AR487J47Amr50S3TF6/lkHotjWovn6
 f1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336536; x=1756941336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/M+Ka25uareeqr/Cb0odwDR3VM8aPRRsnB/xC/o7pKQ=;
 b=sH8RrwbppN154R3gPXeaEZtYusCwpmzKh4hHudbCmQ/Aj45FtNL0gOg4PTk3ApfT4v
 vcGt2n3RM0uS1eDQNT8w/qpzaO5NVco0Z6uF8e3iWvJsRFL/IQnAhnePGGBbbm55Mcxh
 20GOC2MaP4OgKTcb5KoytlwBls09lmkZSbR6PiBESDWz1qXybSRvmvDiApoo4Mn5Bi8q
 XNE/vepIip/oMRHGo+oM2blytXjDN2dUHM7+n2ZpqBg1oY2SCRvJSrQdQO7sUynSaVE+
 kn8PRvDGuP5saI5WgaKkjxBYny/okFmQuv5p7GsEd/WpA9ccCWvAdmtNGVyfjqsiUE9F
 BeEg==
X-Gm-Message-State: AOJu0YwcItqrLj26IwQC4uZIT2V9/JN9izNZQinw+DfgOHCsrTV5cSmY
 6oeMHudmteTimdVEYUS5empCQsa1uHEiw+z+mfoujv5TXMb8M8m3qmpXh7AE9VPbgxNypza7i8d
 mGd7q
X-Gm-Gg: ASbGncv9SPj9Ona/oawPab0sEpXpj+bu3QsY0qjbkO+3YYw7Q3plPKn+8GFUChbeno4
 YGqtrpCaKILf1NKaWmIb2ngp2c13hh5VYOEynj7gjxZqPDupsgjP4DgkQWln5z18HjJHjUW1o0r
 UV9T9XOtVnCKJ5nZC9hJaGjxcyt5f39cFRh9womJEMg52VHIWAEMiQoMdniz7RwUYwJd63T/zyf
 m0Lqr7uZcmCeenZFHm6jqATZ762NrSkHzwGgXFd9RGj3KnndURYGqPDftYbi08DHVDKKSFt1Eon
 tHbjpuVXoZ115D/hdPygKLfY9s4LqLwl6QiRYR3CW3GHSJlpGlzq/4aBubBLBpJ76Q+kW/NpUkl
 jXKPIG11jjUzIhOobLgn/pieeev5JksnV2vrHiImo3E+adXPTiWiSVDyfl2JNdr2Jo8TnZMZO
X-Google-Smtp-Source: AGHT+IFdKh3VkXf6Df6QN9TgF5pjQU4nppCvH8ONhKLZ1SbrRVGKWNDKxtxUk4ar9Lxr5MOcXQv+9g==
X-Received: by 2002:a5d:5f42:0:b0:3c7:ac80:6938 with SMTP id
 ffacd0b85a97d-3c7ac8fbe53mr11992325f8f.27.1756336535741; 
 Wed, 27 Aug 2025 16:15:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 honnappa.nagarahalli@arm.com,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Gavin Hu <gahu@nvidia.com>, Olivier Matz <olivier.matz@6wind.com>
Subject: [RFC 1/8] test/ring: avoid shadow variable usage
Date: Wed, 27 Aug 2025 16:14:04 -0700
Message-ID: <20250827231528.236172-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

The code had a global array "esize" and also local variable
with same name. This would cause warnings if -Wshadow was enabled.
Fix by renaming the array to "esizes".

Fixes: a9fe152363e2 ("test/ring: add custom element size functional tests")
Cc: honnappa.nagarahalli@arm.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_ring.c | 190 +++++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index ba1fec1de3..dadd8be612 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -66,7 +66,7 @@
 
 #define TEST_RING_FULL_EMPTY_ITER	8
 
-static const int esize[] = {-1, 4, 8, 16, 20};
+static const int esizes[] = {-1, 4, 8, 16, 20};
 
 /* Wrappers around the zero-copy APIs. The wrappers match
  * the normal enqueue/dequeue API declarations.
@@ -514,9 +514,9 @@ test_ring_negative_tests(void)
 	}
 
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		/* Test if ring size is not power of 2 */
-		rp = test_ring_create("test_bad_ring_size", esize[i],
+		rp = test_ring_create("test_bad_ring_size", esizes[i],
 					RING_SIZE + 1, SOCKET_ID_ANY, 0);
 		if (rp != NULL) {
 			printf("Test failed to detect odd count\n");
@@ -524,7 +524,7 @@ test_ring_negative_tests(void)
 		}
 
 		/* Test if ring size is exceeding the limit */
-		rp = test_ring_create("test_bad_ring_size", esize[i],
+		rp = test_ring_create("test_bad_ring_size", esizes[i],
 					RTE_RING_SZ_MASK + 1, SOCKET_ID_ANY, 0);
 		if (rp != NULL) {
 			printf("Test failed to detect limits\n");
@@ -541,12 +541,12 @@ test_ring_negative_tests(void)
 		/* Test to if a non-power of 2 count causes the create
 		 * function to fail correctly
 		 */
-		rp = test_ring_create("test_ring_count", esize[i], 4097,
+		rp = test_ring_create("test_ring_count", esizes[i], 4097,
 					SOCKET_ID_ANY, 0);
 		if (rp != NULL)
 			goto test_fail;
 
-		rp = test_ring_create("test_ring_negative", esize[i], RING_SIZE,
+		rp = test_ring_create("test_ring_negative", esizes[i], RING_SIZE,
 					SOCKET_ID_ANY,
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (rp == NULL) {
@@ -562,7 +562,7 @@ test_ring_negative_tests(void)
 		/* Tests if it would always fail to create ring with an used
 		 * ring name.
 		 */
-		rt = test_ring_create("test_ring_negative", esize[i], RING_SIZE,
+		rt = test_ring_create("test_ring_negative", esizes[i], RING_SIZE,
 					SOCKET_ID_ANY, 0);
 		if (rt != NULL)
 			goto test_fail;
@@ -593,24 +593,24 @@ test_ring_burst_bulk_tests1(unsigned int test_idx)
 	int rand;
 	const unsigned int rsz = RING_SIZE - 1;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		test_ring_print_test_string(test_enqdeq_impl[test_idx].desc,
-			test_enqdeq_impl[test_idx].api_type, esize[i]);
+			test_enqdeq_impl[test_idx].api_type, esizes[i]);
 
 		/* Create the ring */
-		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
+		r = test_ring_create("test_ring_burst_bulk_tests", esizes[i],
 				RING_SIZE, SOCKET_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
-		src = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		src = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (src == NULL)
 			goto fail;
-		test_ring_mem_init(src, RING_SIZE * 2, esize[i]);
+		test_ring_mem_init(src, RING_SIZE * 2, esizes[i]);
 		cur_src = src;
 
 		/* alloc some room for copied objects */
-		dst = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		dst = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (dst == NULL)
 			goto fail;
 		cur_dst = dst;
@@ -622,16 +622,16 @@ test_ring_burst_bulk_tests1(unsigned int test_idx)
 			rand = RTE_MAX(rte_rand() % RING_SIZE, 1UL);
 			printf("%s: iteration %u, random shift: %u;\n",
 			    __func__, i, rand);
-			ret = test_ring_enq_impl(r, cur_src, esize[i], rand,
+			ret = test_ring_enq_impl(r, cur_src, esizes[i], rand,
 							test_idx);
 			TEST_RING_VERIFY(ret != 0, r, goto fail);
 
-			ret = test_ring_deq_impl(r, cur_dst, esize[i], rand,
+			ret = test_ring_deq_impl(r, cur_dst, esizes[i], rand,
 							test_idx);
 			TEST_RING_VERIFY(ret == rand, r, goto fail);
 
 			/* fill the ring */
-			ret = test_ring_enq_impl(r, cur_src, esize[i], rsz,
+			ret = test_ring_enq_impl(r, cur_src, esizes[i], rsz,
 							test_idx);
 			TEST_RING_VERIFY(ret != 0, r, goto fail);
 
@@ -641,7 +641,7 @@ test_ring_burst_bulk_tests1(unsigned int test_idx)
 			TEST_RING_VERIFY(rte_ring_empty(r) == 0, r, goto fail);
 
 			/* empty the ring */
-			ret = test_ring_deq_impl(r, cur_dst, esize[i], rsz,
+			ret = test_ring_deq_impl(r, cur_dst, esizes[i], rsz,
 							test_idx);
 			TEST_RING_VERIFY(ret == (int)rsz, r, goto fail);
 
@@ -652,8 +652,8 @@ test_ring_burst_bulk_tests1(unsigned int test_idx)
 
 			/* check data */
 			temp_sz = rsz * sizeof(void *);
-			if (esize[i] != -1)
-				temp_sz = rsz * esize[i];
+			if (esizes[i] != -1)
+				temp_sz = rsz * esizes[i];
 			TEST_RING_VERIFY(test_ring_mem_cmp(src, dst,
 						temp_sz) == 0, r, goto fail);
 		}
@@ -688,58 +688,58 @@ test_ring_burst_bulk_tests2(unsigned int test_idx)
 	int ret;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		test_ring_print_test_string(test_enqdeq_impl[test_idx].desc,
-			test_enqdeq_impl[test_idx].api_type, esize[i]);
+			test_enqdeq_impl[test_idx].api_type, esizes[i]);
 
 		/* Create the ring */
-		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
+		r = test_ring_create("test_ring_burst_bulk_tests", esizes[i],
 				RING_SIZE, SOCKET_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
-		src = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		src = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (src == NULL)
 			goto fail;
-		test_ring_mem_init(src, RING_SIZE * 2, esize[i]);
+		test_ring_mem_init(src, RING_SIZE * 2, esizes[i]);
 		cur_src = src;
 
 		/* alloc some room for copied objects */
-		dst = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		dst = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (dst == NULL)
 			goto fail;
 		cur_dst = dst;
 
 		printf("enqueue 1 obj\n");
-		ret = test_ring_enq_impl(r, cur_src, esize[i], 1, test_idx);
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], 1, test_idx);
 		TEST_RING_VERIFY(ret == 1, r, goto fail);
-		cur_src = test_ring_inc_ptr(cur_src, esize[i], 1);
+		cur_src = test_ring_inc_ptr(cur_src, esizes[i], 1);
 
 		printf("enqueue 2 objs\n");
-		ret = test_ring_enq_impl(r, cur_src, esize[i], 2, test_idx);
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], 2, test_idx);
 		TEST_RING_VERIFY(ret == 2, r, goto fail);
-		cur_src = test_ring_inc_ptr(cur_src, esize[i], 2);
+		cur_src = test_ring_inc_ptr(cur_src, esizes[i], 2);
 
 		printf("enqueue MAX_BULK objs\n");
-		ret = test_ring_enq_impl(r, cur_src, esize[i], MAX_BULK,
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], MAX_BULK,
 						test_idx);
 		TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
 
 		printf("dequeue 1 obj\n");
-		ret = test_ring_deq_impl(r, cur_dst, esize[i], 1, test_idx);
+		ret = test_ring_deq_impl(r, cur_dst, esizes[i], 1, test_idx);
 		TEST_RING_VERIFY(ret == 1, r, goto fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 1);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 1);
 
 		printf("dequeue 2 objs\n");
-		ret = test_ring_deq_impl(r, cur_dst, esize[i], 2, test_idx);
+		ret = test_ring_deq_impl(r, cur_dst, esizes[i], 2, test_idx);
 		TEST_RING_VERIFY(ret == 2, r, goto fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 2);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 2);
 
 		printf("dequeue MAX_BULK objs\n");
-		ret = test_ring_deq_impl(r, cur_dst, esize[i], MAX_BULK,
+		ret = test_ring_deq_impl(r, cur_dst, esizes[i], MAX_BULK,
 						test_idx);
 		TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], MAX_BULK);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], MAX_BULK);
 
 		/* check data */
 		TEST_RING_VERIFY(test_ring_mem_cmp(src, dst,
@@ -775,40 +775,40 @@ test_ring_burst_bulk_tests3(unsigned int test_idx)
 	int ret;
 	unsigned int i, j;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		test_ring_print_test_string(test_enqdeq_impl[test_idx].desc,
-			test_enqdeq_impl[test_idx].api_type, esize[i]);
+			test_enqdeq_impl[test_idx].api_type, esizes[i]);
 
 		/* Create the ring */
-		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
+		r = test_ring_create("test_ring_burst_bulk_tests", esizes[i],
 				RING_SIZE, SOCKET_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
-		src = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		src = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (src == NULL)
 			goto fail;
-		test_ring_mem_init(src, RING_SIZE * 2, esize[i]);
+		test_ring_mem_init(src, RING_SIZE * 2, esizes[i]);
 		cur_src = src;
 
 		/* alloc some room for copied objects */
-		dst = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		dst = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (dst == NULL)
 			goto fail;
 		cur_dst = dst;
 
 		printf("fill and empty the ring\n");
 		for (j = 0; j < RING_SIZE / MAX_BULK; j++) {
-			ret = test_ring_enq_impl(r, cur_src, esize[i], MAX_BULK,
+			ret = test_ring_enq_impl(r, cur_src, esizes[i], MAX_BULK,
 							test_idx);
 			TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
-			cur_src = test_ring_inc_ptr(cur_src, esize[i],
+			cur_src = test_ring_inc_ptr(cur_src, esizes[i],
 								MAX_BULK);
 
-			ret = test_ring_deq_impl(r, cur_dst, esize[i], MAX_BULK,
+			ret = test_ring_deq_impl(r, cur_dst, esizes[i], MAX_BULK,
 							test_idx);
 			TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
-			cur_dst = test_ring_inc_ptr(cur_dst, esize[i],
+			cur_dst = test_ring_inc_ptr(cur_dst, esizes[i],
 								MAX_BULK);
 		}
 
@@ -849,41 +849,41 @@ test_ring_burst_bulk_tests4(unsigned int test_idx)
 
 	api_type = test_enqdeq_impl[test_idx].api_type;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		test_ring_print_test_string(test_enqdeq_impl[test_idx].desc,
-			test_enqdeq_impl[test_idx].api_type, esize[i]);
+			test_enqdeq_impl[test_idx].api_type, esizes[i]);
 
 		/* Create the ring */
-		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
+		r = test_ring_create("test_ring_burst_bulk_tests", esizes[i],
 				RING_SIZE, SOCKET_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
-		src = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		src = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (src == NULL)
 			goto fail;
-		test_ring_mem_init(src, RING_SIZE * 2, esize[i]);
+		test_ring_mem_init(src, RING_SIZE * 2, esizes[i]);
 		cur_src = src;
 
 		/* alloc some room for copied objects */
-		dst = test_ring_calloc(RING_SIZE * 2, esize[i]);
+		dst = test_ring_calloc(RING_SIZE * 2, esizes[i]);
 		if (dst == NULL)
 			goto fail;
 		cur_dst = dst;
 
 		printf("Test enqueue without enough memory space\n");
 		for (j = 0; j < (RING_SIZE/MAX_BULK - 1); j++) {
-			ret = test_ring_enq_impl(r, cur_src, esize[i], MAX_BULK,
+			ret = test_ring_enq_impl(r, cur_src, esizes[i], MAX_BULK,
 							test_idx);
 			TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
-			cur_src = test_ring_inc_ptr(cur_src, esize[i],
+			cur_src = test_ring_inc_ptr(cur_src, esizes[i],
 								MAX_BULK);
 		}
 
 		printf("Enqueue 2 objects, free entries = MAX_BULK - 2\n");
-		ret = test_ring_enq_impl(r, cur_src, esize[i], 2, test_idx);
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], 2, test_idx);
 		TEST_RING_VERIFY(ret == 2, r, goto fail);
-		cur_src = test_ring_inc_ptr(cur_src, esize[i], 2);
+		cur_src = test_ring_inc_ptr(cur_src, esizes[i], 2);
 
 		printf("Enqueue the remaining entries = MAX_BULK - 3\n");
 		/* Bulk APIs enqueue exact number of elements */
@@ -892,42 +892,42 @@ test_ring_burst_bulk_tests4(unsigned int test_idx)
 		else
 			num_elems = MAX_BULK;
 		/* Always one free entry left */
-		ret = test_ring_enq_impl(r, cur_src, esize[i], num_elems,
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], num_elems,
 						test_idx);
 		TEST_RING_VERIFY(ret == MAX_BULK - 3, r, goto fail);
-		cur_src = test_ring_inc_ptr(cur_src, esize[i], MAX_BULK - 3);
+		cur_src = test_ring_inc_ptr(cur_src, esizes[i], MAX_BULK - 3);
 
 		printf("Test if ring is full\n");
 		TEST_RING_VERIFY(rte_ring_full(r) == 1, r, goto fail);
 
 		printf("Test enqueue for a full entry\n");
-		ret = test_ring_enq_impl(r, cur_src, esize[i], MAX_BULK,
+		ret = test_ring_enq_impl(r, cur_src, esizes[i], MAX_BULK,
 						test_idx);
 		TEST_RING_VERIFY(ret == 0, r, goto fail);
 
 		printf("Test dequeue without enough objects\n");
 		for (j = 0; j < RING_SIZE / MAX_BULK - 1; j++) {
-			ret = test_ring_deq_impl(r, cur_dst, esize[i], MAX_BULK,
+			ret = test_ring_deq_impl(r, cur_dst, esizes[i], MAX_BULK,
 							test_idx);
 			TEST_RING_VERIFY(ret == MAX_BULK, r, goto fail);
-			cur_dst = test_ring_inc_ptr(cur_dst, esize[i],
+			cur_dst = test_ring_inc_ptr(cur_dst, esizes[i],
 								MAX_BULK);
 		}
 
 		/* Available memory space for the exact MAX_BULK entries */
-		ret = test_ring_deq_impl(r, cur_dst, esize[i], 2, test_idx);
+		ret = test_ring_deq_impl(r, cur_dst, esizes[i], 2, test_idx);
 		TEST_RING_VERIFY(ret == 2, r, goto fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 2);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 2);
 
 		/* Bulk APIs enqueue exact number of elements */
 		if ((api_type & TEST_RING_ELEM_BULK) == TEST_RING_ELEM_BULK)
 			num_elems = MAX_BULK - 3;
 		else
 			num_elems = MAX_BULK;
-		ret = test_ring_deq_impl(r, cur_dst, esize[i], num_elems,
+		ret = test_ring_deq_impl(r, cur_dst, esizes[i], num_elems,
 						test_idx);
 		TEST_RING_VERIFY(ret == MAX_BULK - 3, r, goto fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], MAX_BULK - 3);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], MAX_BULK - 3);
 
 		printf("Test if ring is empty\n");
 		/* Check if ring is empty */
@@ -966,8 +966,8 @@ test_ring_basic_ex(void)
 	struct rte_ring *rp = NULL;
 	void **src = NULL, **cur_src = NULL, **dst = NULL, **cur_dst = NULL;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
-		rp = test_ring_create("test_ring_basic_ex", esize[i], RING_SIZE,
+	for (i = 0; i < RTE_DIM(esizes); i++) {
+		rp = test_ring_create("test_ring_basic_ex", esizes[i], RING_SIZE,
 					SOCKET_ID_ANY,
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (rp == NULL) {
@@ -976,16 +976,16 @@ test_ring_basic_ex(void)
 		}
 
 		/* alloc dummy object pointers */
-		src = test_ring_calloc(RING_SIZE, esize[i]);
+		src = test_ring_calloc(RING_SIZE, esizes[i]);
 		if (src == NULL) {
 			printf("%s: failed to alloc src memory\n", __func__);
 			goto fail_test;
 		}
-		test_ring_mem_init(src, RING_SIZE, esize[i]);
+		test_ring_mem_init(src, RING_SIZE, esizes[i]);
 		cur_src = src;
 
 		/* alloc some room for copied objects */
-		dst = test_ring_calloc(RING_SIZE, esize[i]);
+		dst = test_ring_calloc(RING_SIZE, esizes[i]);
 		if (dst == NULL) {
 			printf("%s: failed to alloc dst memory\n", __func__);
 			goto fail_test;
@@ -1001,19 +1001,19 @@ test_ring_basic_ex(void)
 			rte_ring_free_count(rp));
 
 		for (j = 0; j < RING_SIZE - 1; j++) {
-			ret = test_ring_enqueue(rp, cur_src, esize[i], 1,
+			ret = test_ring_enqueue(rp, cur_src, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 			TEST_RING_VERIFY(ret == 0, rp, goto fail_test);
-			cur_src = test_ring_inc_ptr(cur_src, esize[i], 1);
+			cur_src = test_ring_inc_ptr(cur_src, esizes[i], 1);
 		}
 
 		TEST_RING_VERIFY(rte_ring_full(rp) == 1, rp, goto fail_test);
 
 		for (j = 0; j < RING_SIZE - 1; j++) {
-			ret = test_ring_dequeue(rp, cur_dst, esize[i], 1,
+			ret = test_ring_dequeue(rp, cur_dst, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 			TEST_RING_VERIFY(ret == 0, rp, goto fail_test);
-			cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 1);
+			cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 1);
 		}
 
 		TEST_RING_VERIFY(rte_ring_empty(rp) == 1, rp, goto fail_test);
@@ -1034,25 +1034,25 @@ test_ring_basic_ex(void)
 		cur_dst = dst;
 
 		/* Covering the ring burst operation */
-		ret = test_ring_enqueue(rp, cur_src, esize[i], 2,
+		ret = test_ring_enqueue(rp, cur_src, esizes[i], 2,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_BURST);
 		TEST_RING_VERIFY(ret == 2, rp, goto fail_test);
-		cur_src = test_ring_inc_ptr(cur_src, esize[i], 2);
+		cur_src = test_ring_inc_ptr(cur_src, esizes[i], 2);
 
-		ret = test_ring_dequeue(rp, cur_dst, esize[i], 2,
+		ret = test_ring_dequeue(rp, cur_dst, esizes[i], 2,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_BURST);
 		TEST_RING_VERIFY(ret == 2, rp, goto fail_test);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 2);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 2);
 
 		/* Covering the ring bulk operation */
-		ret = test_ring_enqueue(rp, cur_src, esize[i], 2,
+		ret = test_ring_enqueue(rp, cur_src, esizes[i], 2,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_BULK);
 		TEST_RING_VERIFY(ret == 2, rp, goto fail_test);
 
-		ret = test_ring_dequeue(rp, cur_dst, esize[i], 2,
+		ret = test_ring_dequeue(rp, cur_dst, esizes[i], 2,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_BULK);
 		TEST_RING_VERIFY(ret == 2, rp, goto fail_test);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], 2);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], 2);
 
 		/* check data */
 		TEST_RING_VERIFY(test_ring_mem_cmp(src, dst,
@@ -1089,19 +1089,19 @@ test_ring_with_exact_size(void)
 	unsigned int i, j;
 	int ret = -1;
 
-	for (i = 0; i < RTE_DIM(esize); i++) {
+	for (i = 0; i < RTE_DIM(esizes); i++) {
 		test_ring_print_test_string("Test exact size ring",
 				TEST_RING_IGNORE_API_TYPE,
-				esize[i]);
+				esizes[i]);
 
-		std_r = test_ring_create("std", esize[i], ring_sz,
+		std_r = test_ring_create("std", esizes[i], ring_sz,
 					rte_socket_id(),
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (std_r == NULL) {
 			printf("%s: error, can't create std ring\n", __func__);
 			goto test_fail;
 		}
-		exact_sz_r = test_ring_create("exact sz", esize[i], ring_sz,
+		exact_sz_r = test_ring_create("exact sz", esizes[i], ring_sz,
 				rte_socket_id(),
 				RING_F_SP_ENQ | RING_F_SC_DEQ |
 				RING_F_EXACT_SZ);
@@ -1114,14 +1114,14 @@ test_ring_with_exact_size(void)
 		/* alloc object pointers. Allocate one extra object
 		 * and create an unaligned address.
 		 */
-		src_orig = test_ring_calloc(17, esize[i]);
+		src_orig = test_ring_calloc(17, esizes[i]);
 		if (src_orig == NULL)
 			goto test_fail;
-		test_ring_mem_init(src_orig, 17, esize[i]);
+		test_ring_mem_init(src_orig, 17, esizes[i]);
 		src = (void **)((uintptr_t)src_orig + 1);
 		cur_src = src;
 
-		dst_orig = test_ring_calloc(17, esize[i]);
+		dst_orig = test_ring_calloc(17, esizes[i]);
 		if (dst_orig == NULL)
 			goto test_fail;
 		dst = (void **)((uintptr_t)dst_orig + 1);
@@ -1140,26 +1140,26 @@ test_ring_with_exact_size(void)
 		 * than the standard ring. (16 vs 15 elements)
 		 */
 		for (j = 0; j < ring_sz - 1; j++) {
-			ret = test_ring_enqueue(std_r, cur_src, esize[i], 1,
+			ret = test_ring_enqueue(std_r, cur_src, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 			TEST_RING_VERIFY(ret == 0, std_r, goto test_fail);
-			ret = test_ring_enqueue(exact_sz_r, cur_src, esize[i], 1,
+			ret = test_ring_enqueue(exact_sz_r, cur_src, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 			TEST_RING_VERIFY(ret == 0, exact_sz_r, goto test_fail);
-			cur_src = test_ring_inc_ptr(cur_src, esize[i], 1);
+			cur_src = test_ring_inc_ptr(cur_src, esizes[i], 1);
 		}
-		ret = test_ring_enqueue(std_r, cur_src, esize[i], 1,
+		ret = test_ring_enqueue(std_r, cur_src, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 		TEST_RING_VERIFY(ret == -ENOBUFS, std_r, goto test_fail);
-		ret = test_ring_enqueue(exact_sz_r, cur_src, esize[i], 1,
+		ret = test_ring_enqueue(exact_sz_r, cur_src, esizes[i], 1,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_SINGLE);
 		TEST_RING_VERIFY(ret != -ENOBUFS, exact_sz_r, goto test_fail);
 
 		/* check that dequeue returns the expected number of elements */
-		ret = test_ring_dequeue(exact_sz_r, cur_dst, esize[i], ring_sz,
+		ret = test_ring_dequeue(exact_sz_r, cur_dst, esizes[i], ring_sz,
 				TEST_RING_THREAD_DEF | TEST_RING_ELEM_BURST);
 		TEST_RING_VERIFY(ret == (int)ring_sz, exact_sz_r, goto test_fail);
-		cur_dst = test_ring_inc_ptr(cur_dst, esize[i], ring_sz);
+		cur_dst = test_ring_inc_ptr(cur_dst, esizes[i], ring_sz);
 
 		/* check that the capacity function returns expected value */
 		TEST_RING_VERIFY(rte_ring_get_capacity(exact_sz_r) == ring_sz,
-- 
2.47.2

