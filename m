Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D9E6BF10
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EEE140673;
	Fri, 30 Jan 2026 21:23:47 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id AF46340677
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:43 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so18967015e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804623;
 x=1770409423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ww5f8oBf4tr/AbiEAjXe6kcs2C1pYbiWCCm5cykfAag=;
 b=dLTB4VmBQWdmfgdx9mBgzzUXZbl8xVbfPfPGLK0EHD3KlwCh0yEHNq6MUoVqbogEQ9
 gP1R08O5Fu2549sIlsKXDJLgUfeVes9KOvnsT008CxCENjNvG9Tj4f1JV7tozeew9hs6
 e7dQlY7LuoFxLXSeJtcEr90hFfzkPxAxxRqvz8gU99ZQFsIYL6OHRIYvN4DbrQh3OMeK
 bDJKVDSU5odjf0OEnuybV2KCEGT2zCv/BlKmcSz2eB1ZQ7TxPHQGhpPG9eEcinUQdOEG
 TgT3KNzSO+YGGAF9FKYB+BN2T0yD+i+eMDgogxwVpMhS7pfmycAZXdKvWTgFieiCTQJk
 quPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804623; x=1770409423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ww5f8oBf4tr/AbiEAjXe6kcs2C1pYbiWCCm5cykfAag=;
 b=AiF9Z+sHCGhOkDEc+mAVy1Zq0iZA4CfzpEsJ9hN0W8uqStaZUVt556kARwoxof/De5
 dIuPqXhr2esd3L5nOJVRDlhDvFjawWreuXLtvEZ9MCiLnEOKZLuRrL6sdNuHpze9z93y
 MCQdxyTwKAX37XsXXbyH1+/QS8cn4VWLkZmlUgjzziD2Gvg0sSka+nBdKXHERYlq+oQW
 F7hqQfKZIiapCYVY/0DoGBZlrDLLz7pz2R/nG3csBFGbY0UHdEUN/SAp1ZnpXcCg6zaK
 4cbjkWgdalgqvc6BP7STs90QGB5FdGNTl7kgDjd2IvY8mX3fKcWbndYQ8I91CCBp+TRV
 vhUg==
X-Gm-Message-State: AOJu0YxWda4duBrv4vqBWkB/bIOOfgINPRCzhFqUFi4fbCVuYqHyRLIs
 V0a2xnVtLzd4jB9YZIXf944oyYh0PPDxNvjjp2/FLFljqgAQqdvvKaIwAR0HiipFKlmR9m2m87x
 KTn9G
X-Gm-Gg: AZuq6aLb3bVJotxS6I/k4YHxcQWeWCipeWX6ZsWEuIASKnJ9CIZlzcx/2rPktNdxBpP
 iH9jlbcw6VSMWyGmuCVbeNomH4KJmEzC7Am+Ng6TgKTvSmaaNVItp/OQy6+bczOhH6jKzhySPQ0
 1mGTsuQKF4A6RenUaeVullS+KlILVP3G0y0Tl7Q9d/q2z2qz8oS4fNCl1UYrk93yKSdRWsNSZEu
 oos83D8PaNXWf1VurK0KD+WjY3b8/7VExoIacAIddVEIO9/Si6FG+lGVDPq/uOKwzKLpeT6x5BT
 G/IoHMrJ+GK0jdF1Ph0aB1U5uipuY29Id3dpW1uzIcJRuF+u74x02LQzZTQzVqYLnWJlbXvaCIR
 ZR2GukrxscdIS3UnLhJ/8SvXRGQdmUdQnVMIi7VhZ0w3dYzfjaxleFVWZtoh6esQyuhxCrpCfb1
 96DHwdTRKGL5teaBPX4MDMu6iTFCB3XhfzpZEev75kl9bxD43jGw==
X-Received: by 2002:a05:600c:3b96:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-482db49978emr49287095e9.26.1769804623272; 
 Fri, 30 Jan 2026 12:23:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 7/7] test/hash: add test for key compare functions
Date: Fri, 30 Jan 2026 12:21:57 -0800
Message-ID: <20260130202324.37485-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130202324.37485-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260130202324.37485-1-stephen@networkplumber.org>
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
index f0825ca75d..499b064cb7 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1494,6 +1494,83 @@ test_hash_creation_with_good_parameters(void)
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
@@ -2411,6 +2488,7 @@ static struct unit_test_suite hash_test_suite = {
 		TEST_CASE(fbk_hash_unit_test),
 		TEST_CASE(test_hash_creation_with_bad_parameters),
 		TEST_CASE(test_hash_creation_with_good_parameters),
+		TEST_CASE(test_hash_creation_with_key_lengths),
 		TEST_CASE(test_average_table_utilization_no_ext),
 		TEST_CASE(test_hash_iteration_no_ext),
 		TEST_CASE(test_average_table_utilization_ext),
-- 
2.51.0

