Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA14FF4923
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B72C840670;
	Mon, 30 Mar 2026 01:24:47 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id C2AEB40269
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:46 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so2513617a91.2
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826686;
 x=1775431486; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHB493CQnPwTb7+l4kut3X+HTme7AMQHfba/UEjRbeY=;
 b=NC8ITGq+hAmaVDhj7nn3pFv5QuNCtccDmk1Pi0QiRu9hpTIIUsrUgH0d7P+LstF6IM
 M4VoMltqmqTu/QDa4cmm6Mt24QD86vo20Zht8UF0gmE5P0ocotlFxm9xQPbwoyZw4/SS
 qvk6zViI+JmS1qHsSWeyy2BpVuMJYTzvRSemu3KOtf/ZDaRWE8edva7yFLa+NBO9/fp4
 xVMnNa3ZT5IgR5kd376LWhE1lXQSehz7O4o7MXp2Lp6d94RlfTVdzeQCN9Wnf4YpnF8D
 7KJlNiVBU8maUonSRjtwrh7Gppe5OPIsWFJyQVbZ9NFSV+zbfWaMuc+lt0CrXQOH9Xfp
 rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826686; x=1775431486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jHB493CQnPwTb7+l4kut3X+HTme7AMQHfba/UEjRbeY=;
 b=YzfIGFeIaIURx+zXyh9Eq+oVlt8LrZZoow4YPqFXyjkzNVkDeyA1V6HGEocMzBIBNg
 ZV4JM1ljdxUos15732qTLQ83JFi9dDIeKJJ2TWLVWaXKuiPwgKSTxUVXg6VNTejqbgck
 aDuYLl0NH13AhLaP7rixvMkg810nYlxJSRcrrsOLg0eobeQqJ2Jdu++pnUkmpK5Amvse
 t1bpnJGJ8rREHspvT94SMshrxvs+5caTeREQzs9hG/FjYnMSpIPvQWCwPJ7+2MiCrt0k
 QxGi7VUdncAZxS9QC6kqjivvyIoM0b/DxOSMp2BCHefEGLZQRFTIt7rau/pkNkxEKilA
 fbFg==
X-Gm-Message-State: AOJu0Yxx9mUV/PE0EmB/3CEEDducrrSVUueT7rkgMZB7u4PPxHst51K7
 5MlDHpcvgeM5LiM8kGlAy/k5Ve/33n2qJqjPIkwG+on+yXYYnXibE34tBZmRCLC+dj/GBAVMINd
 bNzQA
X-Gm-Gg: ATEYQzzDxMLUSLD+wZXvUAsL3zBjEwQNSc9VPPd8+oyXcVtpfmsMvAAK+PqyovhkLlU
 wseGpC1LhsyZU31KTuldSjmRXybLYIqeP/sBYCHVxjnGJNsMGHkfNLxBTLNfwDTjv1WBkTy0CQs
 i/n+CMYTARNr7HjdkGu1XSlgoKjCVORQ0HjX6PsZZ24Tz1LL2VUAyCpvDUTi8K6XBmzimJovDd+
 oSp0QwM/eRrqsnjdE62f72S4craO0f97XwNSBnTdvDBaqcCfiPsmFcZAVPqRql5TQPaBXnm+Iod
 lxpSTwzY4ebMLHMtad7VyJD2/OWu6yyOSJKC2ekxyZ1fmBh/lD5XfptUMvzZToxUFTRA5vD7ytP
 FEKgAFDpB/C6UqN6QMI39k+YVaEdJqtz82V6ps/1eLmIGjV1+TGet9LZG94MdLfqttjMHYJo2pa
 3g7/8m9zvBo/M4n+s1hqrQCiumMmpiNfFi
X-Received: by 2002:a17:90b:1643:b0:35d:8ea1:62c3 with SMTP id
 98e67ed59e1d1-35d8ea169b4mr7200537a91.3.1774826685905; 
 Sun, 29 Mar 2026 16:24:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 6/7] app/test: convert hash test to use test suite runner
Date: Sun, 29 Mar 2026 16:22:40 -0700
Message-ID: <20260329232409.205940-7-stephen@networkplumber.org>
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

Replace the manual sequence of if/return checks with the
unit_test_suite_runner framework. This provides structured
test output with per-test pass/fail status and summary counts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c | 163 ++++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 71 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 6da69154a3..0ddf71ff3c 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2482,90 +2482,111 @@ test_hash_rcu_qsbr_replace_auto_free(void)
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
-
-	/* ext table enabled */
-	if (test_average_table_utilization(1) < 0)
-		return -1;
-	if (test_hash_iteration(1) < 0)
-		return -1;
+	return test_average_table_utilization(0);
+}
 
-	run_hash_func_tests();
+static int
+test_average_table_utilization_ext(void)
+{
+	return test_average_table_utilization(1);
+}
 
-	if (test_crc32_hash_alg_equiv() < 0)
-		return -1;
+static int
+test_hash_iteration_no_ext(void)
+{
+	return test_hash_iteration(0);
+}
 
-	if (test_hash_rcu_qsbr_add() < 0)
-		return -1;
+static int
+test_hash_iteration_ext(void)
+{
+	return test_hash_iteration(1);
+}
 
-	if (test_hash_rcu_qsbr_dq_mode(0) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_dq_mode_no_ext(void)
+{
+	return test_hash_rcu_qsbr_dq_mode(0);
+}
 
-	if (test_hash_rcu_qsbr_dq_mode(1) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_dq_mode_ext(void)
+{
+	return test_hash_rcu_qsbr_dq_mode(1);
+}
 
-	if (test_hash_rcu_qsbr_sync_mode(0) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_sync_mode_no_ext(void)
+{
+	return test_hash_rcu_qsbr_sync_mode(0);
+}
 
-	if (test_hash_rcu_qsbr_sync_mode(1) < 0)
-		return -1;
+static int
+test_hash_rcu_qsbr_sync_mode_ext(void)
+{
+	return test_hash_rcu_qsbr_sync_mode(1);
+}
 
-	if (test_hash_rcu_qsbr_dq_reclaim() < 0)
-		return -1;
+static int
+test_hash_func_tests(void)
+{
+	run_hash_func_tests();
+	return TEST_SUCCESS;
+}
 
-	if (test_hash_rcu_qsbr_replace_auto_free() < 0)
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
+		TEST_CASE(test_hash_rcu_qsbr_replace_auto_free),
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
2.53.0

