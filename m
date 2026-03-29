Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA650FF4923
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D63F84065C;
	Mon, 30 Mar 2026 01:24:52 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 11A4F40269
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:51 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35da8d037a5so105851a91.0
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826690;
 x=1775431490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MK5UZ4XakwRYBxRHpelsZ8UCAsa2HEHEiRF+NOs2UAM=;
 b=0Sm9rVc4R8Zcw1YM8rX3zdg5p4fGlseiYtGiTLt7AnMyfgatv+EJCyqkaOxpxzC8AD
 GO6vv10cephcW7K3IUrn7HzUoi/oFNJJdSAhdNJgC1moQc6YPqnctAvE3jqXP5vqLc+q
 odJ9Pl1k4OakCc2NzX8A8bqgJCCf9dw8QCED/J7PBwzQfTBzI2Dz8NtvuQsb1xUubbNm
 RDzZBRnY4tn8Vy7snA0Wdzq49qb/+oVmkcYMfjVt9+D4WIca5/wunKbbrePAmSGJ+ARG
 PWKeA4z+mffdYGryq7OtJLqByEnUfmec20C2nlfK2vYPh8I7X6kAHSW1tDQ1dxrkN2wj
 E0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826690; x=1775431490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MK5UZ4XakwRYBxRHpelsZ8UCAsa2HEHEiRF+NOs2UAM=;
 b=H7NWttKamxZ2ZmX1fHc+a3sKFszuSMjiiEU4WQqPWekukEZPVBgsL5pPRV0BLNuHz8
 j8GUxAphZPNXy8dAOipdXRgrIWjSdebThUk9Ghhlnq9GXkD5IGQz5umr+aqLifEw6I6o
 SLlI6EReuQoIbx8zMUgZ8jQ6Ngh12ND3NXs1AR2uyBE2zZiKM01T1l67zPptil95SyGr
 WpS0bHuTOEDs14/nnBiXttLns55Fquv13owDC1xzWrWw/Q2oA949HBtUd/ETTOlMyRgH
 0StK9a5rE9s+KZH9ftL30cIn9jFtQOogvDlzVI+tdwW5b97AQFlUrB/PLmOkh5mjP6bR
 pD2Q==
X-Gm-Message-State: AOJu0YzieDifKntmmciKmayHqMHpTYKeJWl1lNcakE/n+wBzxoCBwlgQ
 mPhwxakr4hmL+uo04NiWl1kpZSsnFURRlaGouTBcMu7aWjnjWcoODCyPtwOTWBaKu3L7OYV1C6y
 g/71D
X-Gm-Gg: ATEYQzzlk6au/rnvu/abERbu21huFArWPys+sBEmae+EmZMnbE4+MPkdqynQ/H4i0bA
 SNoXmw5YrFrPNRw5lDdZ3p1pSdNkn0FPCq/Frs9PuwoEtZlEQMw208nOr4vcE+l0NbzNUEZDIM+
 /zRZLZ2zprYXOB7xnV0i/aR/Dz9LrWg8iIA3uxdMVbzoOjE+FvlAiEm2+ZRbColuwa65grnRxD+
 mJ4aCX3pmzpR7BlzgXdxQ0DUlc1TmXMBPF+09lKFC0q0O44EgTXJ6RVg6Kfr76OOojinS4ch6+w
 HWW+C9Agmyyvm4tlG73KKiIgrwWh9i1soDO7uSbyICqyPiXtClNlW0YNIN9iM/Z7jzyzMWLpk7e
 mBGBXgnI8qTLEY1Quun1C3W+XqfcEFcyXdfjcTzB9QnrB73qD22R4MxUZHsiJ3oc7qvpqm6PB4U
 +XUfrKWkTlUu6bSBUl8fVtg/IUxpjao/7EROMTgh4ii/Y=
X-Received: by 2002:a17:90b:164a:b0:35b:ea35:c3d7 with SMTP id
 98e67ed59e1d1-35c2fd51bd5mr10555006a91.0.1774826690178; 
 Sun, 29 Mar 2026 16:24:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 7/7] test/hash: add test for key compare functions
Date: Sun, 29 Mar 2026 16:22:41 -0700
Message-ID: <20260329232409.205940-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
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

The hash library has optimized key compare functions for various
key lengths (in rte_cmp_jump_table). Add a test that creates hash
tables with each length in hashtest_key_lens[] and verifies that
add, lookup, and delete work correctly. The test also verifies
that the compare function properly detects when a key differs
by modifying the last byte and confirming lookup fails.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 0ddf71ff3c..640a33e16c 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1515,6 +1515,83 @@ test_hash_creation_with_good_parameters(void)
 	return 0;
 }
 
+/*
+ * Test hash creation and key operations with various key lengths.
+ * This exercises the key compare functions for different sizes.
+ */
+static int
+test_hash_creation_with_key_lengths(void)
+{
+	struct rte_hash *handle;
+	struct rte_hash_parameters params;
+	uint8_t key[MAX_KEYSIZE];
+	unsigned int i, j;
+	int pos, expected_pos;
+
+	for (i = 0; i < RTE_DIM(hashtest_key_lens); i++) {
+		uint32_t key_len = hashtest_key_lens[i];
+
+		/* key_len of 0 is invalid */
+		if (key_len == 0)
+			continue;
+
+		memcpy(&params, &ut_params, sizeof(params));
+		params.name = "key_len_test";
+		params.key_len = key_len;
+
+		handle = rte_hash_create(&params);
+		if (handle == NULL) {
+			printf("Creating hash with key_len %u failed\n", key_len);
+			return -1;
+		}
+
+		/* initialize key with pattern */
+		for (j = 0; j < key_len; j++)
+			key[j] = (uint8_t)j;
+
+		/* add the key */
+		pos = rte_hash_add_key(handle, key);
+		if (pos < 0) {
+			printf("Adding key with key_len %u failed\n", key_len);
+			rte_hash_free(handle);
+			return -1;
+		}
+		expected_pos = pos;
+
+		/* lookup should find same key */
+		pos = rte_hash_lookup(handle, key);
+		if (pos != expected_pos) {
+			printf("Lookup key with key_len %u failed: expected %d got %d\n",
+			       key_len, expected_pos, pos);
+			rte_hash_free(handle);
+			return -1;
+		}
+
+		/* modify one byte and lookup should fail */
+		key[key_len - 1] ^= 0xff;
+		pos = rte_hash_lookup(handle, key);
+		if (pos != -ENOENT) {
+			printf("Lookup modified key with key_len %u should have failed\n",
+			       key_len);
+			rte_hash_free(handle);
+			return -1;
+		}
+
+		/* restore key and delete */
+		key[key_len - 1] ^= 0xff;
+		pos = rte_hash_del_key(handle, key);
+		if (pos != expected_pos) {
+			printf("Delete key with key_len %u failed\n", key_len);
+			rte_hash_free(handle);
+			return -1;
+		}
+
+		rte_hash_free(handle);
+	}
+
+	return 0;
+}
+
 #define ITERATIONS 3
 /*
  * Test to see the average table utilization (entries added/max entries)
@@ -2563,6 +2640,7 @@ static struct unit_test_suite hash_test_suite = {
 		TEST_CASE(fbk_hash_unit_test),
 		TEST_CASE(test_hash_creation_with_bad_parameters),
 		TEST_CASE(test_hash_creation_with_good_parameters),
+		TEST_CASE(test_hash_creation_with_key_lengths),
 		TEST_CASE(test_average_table_utilization_no_ext),
 		TEST_CASE(test_hash_iteration_no_ext),
 		TEST_CASE(test_average_table_utilization_ext),
-- 
2.53.0

