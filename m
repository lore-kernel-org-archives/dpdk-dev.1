Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66392E6BF10
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA6D40677;
	Fri, 30 Jan 2026 21:23:44 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 2EC624066B
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:42 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-480706554beso26583935e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804622;
 x=1770409422; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVO6YaqF0qWFnACfCRPncRue+yNQIdcEaZF2EImkOiM=;
 b=FOumOt8i/KSyLFF86lKfZpxaRbT8bXw/ZB2zrP90xgYDukkecMNGy9oDskSGYw3iwQ
 KPrYoB0ExdVkW0x8iVW97R44OBuG4fpp0RLCWHcdJYdWdeArgCD+EYcLZb1j6PCMveZy
 3ycFljLaM/TCB6wel76LBVG8Du3rjpg4iefJKwTm4wZb4e8Tub0rcodxJB59gpFrFE28
 n+CT6yxZkM8Euu3i26WOXcZ6Dt1LhFF0AB7g2YkivTLUUqqjzroREtgH3hqTrLLAVtK3
 ErBY9+8rMyVELr1Q3ar71LdHYo/wYADjxDerD/aiza8LAPLnzqvQQx8Vl09cT7P+WYSl
 kM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804622; x=1770409422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVO6YaqF0qWFnACfCRPncRue+yNQIdcEaZF2EImkOiM=;
 b=CAasHvqbfuKl8GhYpomPWUKNMm0ffX0QB9kRGYBQaTejBlUdys3/83s3++ag1BWqbQ
 dmDoM5qBD6SoDtQDmmRgmtCxwbshE4LqawMuDbvlsy5XD9n+4peU5kp+aowp7X0QikwZ
 CfN52gG1Nvvsg6gCMVaQ0Bgf4nmpx4II6xMoO6JKCUfiZkafa0UmQ6q8f7dUeK7z+8gl
 tIdUD0NX213HxVyZmE/Dg4uXikOXWgUhv4oPZNFtAeBBymhZ+CABBO3QGkssik3joJ26
 V/SI/EVUlslM7LdFGTbh1NB5EhFbJGqKv/WTs+e7zoJdhjLvIDfXU5uwVK2MCZ76vrfA
 5+Lg==
X-Gm-Message-State: AOJu0YzIVZWPuPz56REFKPB/c1wPcoiJ3W3KRlefz8989Kr8XOOATt7o
 mUoe+Nt8wjrjMvcXF+kI73OyG45ZsTbvD8p/1EeOOo2NRXBYnsdTum0ZsmqdndysPB/GI55R0Gf
 H/VEU
X-Gm-Gg: AZuq6aKdj7OPBRUMHJeaAEZfWjS7vArGq0Vcu2vi8z1o+LzwylxAjAQGn11X2jO10xI
 7rGYZP4gSgiKkpLKxQrxq2HDDLT4NWvkDlp6ykHx2gum1vb56BOeQhwO4idHMYHJbBLrW6p4jM+
 YSjhNE7CPa1SOP+5jfVcDPdrFmugx7UWcRzgvYCXVIsjoCOfygtaX7oWGPQuZ4XgHHl7U9eU3kx
 SlzwgH0Vq2AyX/skJsNF9sPpvwlYLm8LpSzQQmvX8U5EEnd8z9O9xvtZv3e/GujW972S5yBgYBH
 qXvgmPSMj4r4LT2Wko41Gj7XG4lsxUn+iShS3NLCJ7qg7dWxQrCCcf/y2u5oCNCSCMj4MdZYRic
 GLEfXNDdMN7E4/SUj8teeAkKoRGscy4fO1gtZNYTLcw0H5yLLzZ0wI31nzD2xlRImN8lqEINBmr
 dBs1hJbRaPwvweGGvAuSj5Y+eKk3dAktHX7N4vaciie09tdCUu9w==
X-Received: by 2002:a05:600c:3f0d:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-482db45deccmr45431155e9.8.1769804621749; 
 Fri, 30 Jan 2026 12:23:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 6/7] app/test: convert hash test to use test suite runner
Date: Fri, 30 Jan 2026 12:21:56 -0800
Message-ID: <20260130202324.37485-7-stephen@networkplumber.org>
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

Replace the manual sequence of if/return checks with the
unit_test_suite_runner framework. This provides structured
test output with per-test pass/fail status and summary counts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c | 159 +++++++++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 68 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 1d140ec2cc..f0825ca75d 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2330,87 +2330,110 @@ test_hash_rcu_qsbr_dq_reclaim(void)
 }
 
 /*
- * Do all unit and performance tests.
+ * Wrapper functions for tests that take parameters.
  */
 static int
-test_hash(void)
+test_average_table_utilization_no_ext(void)
 {
-	RTE_BUILD_BUG_ON(sizeof(struct flow_key) % sizeof(uint32_t) != 0);
-
-	if (test_add_delete() < 0)
-		return -1;
-	if (test_hash_add_delete_jhash2() < 0)
-		return -1;
-	if (test_hash_add_delete_2_jhash2() < 0)
-		return -1;
-	if (test_hash_add_delete_jhash_1word() < 0)
-		return -1;
-	if (test_hash_add_delete_jhash_2word() < 0)
-		return -1;
-	if (test_hash_add_delete_jhash_3word() < 0)
-		return -1;
-	if (test_hash_get_key_with_position() < 0)
-		return -1;
-	if (test_hash_find_existing() < 0)
-		return -1;
-	if (test_add_update_delete() < 0)
-		return -1;
-	if (test_add_update_delete_free() < 0)
-		return -1;
-	if (test_add_delete_free_lf() < 0)
-		return -1;
-	if (test_five_keys() < 0)
-		return -1;
-	if (test_full_bucket() < 0)
-		return -1;
-	if (test_extendable_bucket() < 0)
-		return -1;
-
-	if (test_fbk_hash_find_existing() < 0)
-		return -1;
-	if (fbk_hash_unit_test() < 0)
-		return -1;
-	if (test_hash_creation_with_bad_parameters() < 0)
-		return -1;
-	if (test_hash_creation_with_good_parameters() < 0)
-		return -1;
-
-	/* ext table disabled */
-	if (test_average_table_utilization(0) < 0)
-		return -1;
-	if (test_hash_iteration(0) < 0)
-		return -1;
+	return test_average_table_utilization(0);
+}
 
-	/* ext table enabled */
-	if (test_average_table_utilization(1) < 0)
-		return -1;
-	if (test_hash_iteration(1) < 0)
-		return -1;
+static int
+test_average_table_utilization_ext(void)
+{
+	return test_average_table_utilization(1);
+}
 
-	run_hash_func_tests();
+static int
+test_hash_iteration_no_ext(void)
+{
+	return test_hash_iteration(0);
+}
 
-	if (test_crc32_hash_alg_equiv() < 0)
-		return -1;
+static int
+test_hash_iteration_ext(void)
+{
+	return test_hash_iteration(1);
+}
 
-	if (test_hash_rcu_qsbr_add() < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_dq_mode_no_ext(void)
+{
+	return test_hash_rcu_qsbr_dq_mode(0);
+}
 
-	if (test_hash_rcu_qsbr_dq_mode(0) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_dq_mode_ext(void)
+{
+	return test_hash_rcu_qsbr_dq_mode(1);
+}
 
-	if (test_hash_rcu_qsbr_dq_mode(1) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_sync_mode_no_ext(void)
+{
+	return test_hash_rcu_qsbr_sync_mode(0);
+}
 
-	if (test_hash_rcu_qsbr_sync_mode(0) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_sync_mode_ext(void)
+{
+	return test_hash_rcu_qsbr_sync_mode(1);
+}
 
-	if (test_hash_rcu_qsbr_sync_mode(1) < 0)
-		return -1;
+static int
+test_hash_func_tests(void)
+{
+	run_hash_func_tests();
+	return TEST_SUCCESS;
+}
 
-	if (test_hash_rcu_qsbr_dq_reclaim() < 0)
-		return -1;
+static_assert(sizeof(struct flow_key) % sizeof(uint32_t) == 0,
+	     "flow_key size must be a multiple of 4 bytes");
+
+static struct unit_test_suite hash_test_suite = {
+	.suite_name = "Hash Unit Test Suite",
+	.unit_test_cases = {
+		TEST_CASE(test_add_delete),
+		TEST_CASE(test_hash_add_delete_jhash2),
+		TEST_CASE(test_hash_add_delete_2_jhash2),
+		TEST_CASE(test_hash_add_delete_jhash_1word),
+		TEST_CASE(test_hash_add_delete_jhash_2word),
+		TEST_CASE(test_hash_add_delete_jhash_3word),
+		TEST_CASE(test_hash_get_key_with_position),
+		TEST_CASE(test_hash_find_existing),
+		TEST_CASE(test_add_update_delete),
+		TEST_CASE(test_add_update_delete_free),
+		TEST_CASE(test_add_delete_free_lf),
+		TEST_CASE(test_five_keys),
+		TEST_CASE(test_full_bucket),
+		TEST_CASE(test_extendable_bucket),
+		TEST_CASE(test_fbk_hash_find_existing),
+		TEST_CASE(fbk_hash_unit_test),
+		TEST_CASE(test_hash_creation_with_bad_parameters),
+		TEST_CASE(test_hash_creation_with_good_parameters),
+		TEST_CASE(test_average_table_utilization_no_ext),
+		TEST_CASE(test_hash_iteration_no_ext),
+		TEST_CASE(test_average_table_utilization_ext),
+		TEST_CASE(test_hash_iteration_ext),
+		TEST_CASE(test_hash_func_tests),
+		TEST_CASE(test_crc32_hash_alg_equiv),
+		TEST_CASE(test_hash_rcu_qsbr_add),
+		TEST_CASE(test_hash_rcu_qsbr_dq_mode_no_ext),
+		TEST_CASE(test_hash_rcu_qsbr_dq_mode_ext),
+		TEST_CASE(test_hash_rcu_qsbr_sync_mode_no_ext),
+		TEST_CASE(test_hash_rcu_qsbr_sync_mode_ext),
+		TEST_CASE(test_hash_rcu_qsbr_dq_reclaim),
+		TEST_CASES_END()
+	}
+};
 
-	return 0;
+/*
+ * Do all unit and performance tests.
+ */
+static int
+test_hash(void)
+{
+	return unit_test_suite_runner(&hash_test_suite);
 }
 
 REGISTER_FAST_TEST(hash_autotest, NOHUGE_OK, ASAN_OK, test_hash);
-- 
2.51.0

