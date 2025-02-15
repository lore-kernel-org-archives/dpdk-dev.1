Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1338AC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76C1740B9B;
	Sat, 15 Feb 2025 20:06:03 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 67E6740A82
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:00 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220dc3831e3so43200035ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646359;
 x=1740251159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=c4cb2aWaROMwskImWV4rDBDO5iqPrmTdw/OrfFFzkclWdpyXj0nmku04ShMqGj79ic
 eIIMAp30DbW2Q0vc3Ln8c+IuR/ZO/IgYkfbG2yygrbVdx1K5Q55SX3CxwmHYSO421JfW
 adAg+UL4RfYJIIxqmPPweSoOsFFzuJ1nokr60MVhkG8zzk5FpJlmj+Q7Jlrm+nng11DS
 is3XnUu2xJ2Gb23PgOxqGB5hNivPPg6lf9MiDXD0KJo+oLq+w5AhW1CYKRvVWbMXa+E7
 PKEztJuKl5ZHzAgDsSYWHVSD/CzEx/9THBJDGAaVnezMlvOtZjLtZss8ccK0v9uiX9bT
 hkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646359; x=1740251159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=X3xh1IYow2IAWM/2+edBjEfLLReowjn3Ztd1N9SbOVVoqmE8WcnkWZ2kYnhtCfLa5v
 aa4G8v+HBxBvmA2cDf9TbSjkK0WkfQnnuG+GitelFTbe2aeiZN/QEPlj3JiOzZ33suHB
 jwk6o+gU3c7YCA+sBSPwQ9H53O9YwZpaBzRazHt8XoOsQYC1bi24rPBTUprgrSYiT320
 INTDbEsXwbpepzZ2O1xx+9WXun5ZUkrhYg1QKH/PQglJniRXzfVyd4FPNk7kPyim6b7K
 AaELYCYJ5YIBNfJZPK36gahX5EezIN+sTfMJntiMxExQM09kE4TNMCeWUSKrMGUiRnde
 Slaw==
X-Gm-Message-State: AOJu0YzZRuRsjEY8ZeL69ihpKjYqHJ4eCO51vXLTQNdAn38soP1jychi
 Zzx7Wip5KGwazk3TgXUDVBWNOVIE0Z8DTfxpkJZ5+bvJoutEUqFK9jvrdTqY1dagx9za4S4o5eP
 4
X-Gm-Gg: ASbGncs5uFQ2gq6LVty5kmG9HldIavE5z0C/aDQfgxf3rnyMkRLbu6E9xTIi0vXPpGp
 Qd9DcrmDDpDjqieBY1Qir3dizrGI6PXABwdE2WfciCJYcOXT5D6Sk/5UwKx6fm/pKp1CZPg4HDv
 Crw3P5erT9bYuVqzbL9IZnDSQ+Jt4mkr0qIpiLB+xYGbMX9nkW/TJ0lQcaO/Mt2neGDimC40md/
 MA9tjaTM+udEr6Kg5mgWxTCyjQxp7gCY0W9FHpJ+1aGxV4+B7cnoiHTr0yUAeZDz/pRG2Ewge9k
 dMTF41mJoHCyHEv1ML5F75Kx5CogcP1N20tP6T8V9aoEfwZBUjHhYF4Cj0k+4zvsFORE
X-Google-Smtp-Source: AGHT+IGPNBCNsb8vRebDJJGitvSM8FlCzMewHYUrpF/av7TsWFWk1jGvw2HplsbOQsAZlCMECOqtcA==
X-Received: by 2002:a05:6a20:729f:b0:1ed:a4b1:9124 with SMTP id
 adf61e73a8af0-1ee8d6a1788mr6056895637.8.1739646359629; 
 Sat, 15 Feb 2025 11:05:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 05/16] app/test: use unit test runner for malloc tests
Date: Sat, 15 Feb 2025 11:04:33 -0800
Message-ID: <20250215190544.988310-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

There are several malloc tests and switching to the table
driven unit test runner improves readability and makes adding
new tests easier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_malloc.c | 166 +++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 96 deletions(-)

diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 02a7d8ef20..4acb827543 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -140,6 +140,24 @@ test_align_overlap_per_lcore(__rte_unused void *arg)
 	return ret;
 }
 
+static int
+test_align_overlap(void)
+{
+	unsigned int lcore_id;
+	int ret = 0;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_remote_launch(test_align_overlap_per_lcore, NULL, lcore_id);
+	}
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			ret = -1;
+	}
+
+	return ret;
+}
+
 static int
 test_reordered_free_per_lcore(__rte_unused void *arg)
 {
@@ -235,6 +253,23 @@ test_reordered_free_per_lcore(__rte_unused void *arg)
 	return ret;
 }
 
+static int
+test_reordered_free(void)
+{
+	unsigned int lcore_id;
+	int ret = 0;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_remote_launch(test_reordered_free_per_lcore, NULL, lcore_id);
+	}
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			ret = -1;
+	}
+	return ret;
+}
+
 /* test function inside the malloc lib*/
 static int
 test_str_to_size(void)
@@ -729,6 +764,23 @@ test_random_alloc_free(void *_ __rte_unused)
 	return 0;
 }
 
+static int
+test_random(void)
+{
+	unsigned int lcore_id;
+	int ret = 0;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_remote_launch(test_random_alloc_free, NULL, lcore_id);
+	}
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			ret = -1;
+	}
+	return ret;
+}
+
 #define err_return() do { \
 	printf("%s: %d - Error\n", __func__, __LINE__); \
 	goto err_return; \
@@ -988,105 +1040,27 @@ test_alloc_socket(void)
 	return 0;
 }
 
+static struct unit_test_suite test_suite = {
+	.suite_name = "Malloc test suite",
+	.unit_test_cases = {
+		TEST_CASE(test_str_to_size),
+		TEST_CASE(test_zero_aligned_alloc),
+		TEST_CASE(test_malloc_bad_params),
+		TEST_CASE(test_realloc),
+		TEST_CASE(test_align_overlap),
+		TEST_CASE(test_reordered_free),
+		TEST_CASE(test_random),
+		TEST_CASE(test_rte_malloc_validate),
+		TEST_CASE(test_alloc_socket),
+		TEST_CASE(test_multi_alloc_statistics),
+		TEST_CASES_END()
+	}
+};
+
 static int
 test_malloc(void)
 {
-	unsigned lcore_id;
-	int ret = 0;
-
-	if (test_str_to_size() < 0){
-		printf("test_str_to_size() failed\n");
-		return -1;
-	}
-	else printf("test_str_to_size() passed\n");
-
-	if (test_zero_aligned_alloc() < 0){
-		printf("test_zero_aligned_alloc() failed\n");
-		return -1;
-	}
-	else printf("test_zero_aligned_alloc() passed\n");
-
-	if (test_malloc_bad_params() < 0){
-		printf("test_malloc_bad_params() failed\n");
-		return -1;
-	}
-	else printf("test_malloc_bad_params() passed\n");
-
-	if (test_realloc() < 0){
-		printf("test_realloc() failed\n");
-		return -1;
-	}
-	else printf("test_realloc() passed\n");
-
-	/*----------------------------*/
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		rte_eal_remote_launch(test_align_overlap_per_lcore, NULL, lcore_id);
-	}
-
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (rte_eal_wait_lcore(lcore_id) < 0)
-			ret = -1;
-	}
-	if (ret < 0){
-		printf("test_align_overlap_per_lcore() failed\n");
-		return ret;
-	}
-	else printf("test_align_overlap_per_lcore() passed\n");
-
-	/*----------------------------*/
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		rte_eal_remote_launch(test_reordered_free_per_lcore, NULL, lcore_id);
-	}
-
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (rte_eal_wait_lcore(lcore_id) < 0)
-			ret = -1;
-	}
-	if (ret < 0){
-		printf("test_reordered_free_per_lcore() failed\n");
-		return ret;
-	}
-	else printf("test_reordered_free_per_lcore() passed\n");
-
-	/*----------------------------*/
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		rte_eal_remote_launch(test_random_alloc_free, NULL, lcore_id);
-	}
-
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (rte_eal_wait_lcore(lcore_id) < 0)
-			ret = -1;
-	}
-	if (ret < 0){
-		printf("test_random_alloc_free() failed\n");
-		return ret;
-	}
-	else printf("test_random_alloc_free() passed\n");
-
-	/*----------------------------*/
-	ret = test_rte_malloc_validate();
-	if (ret < 0){
-		printf("test_rte_malloc_validate() failed\n");
-		return ret;
-	}
-	else printf("test_rte_malloc_validate() passed\n");
-
-	ret = test_alloc_socket();
-	if (ret < 0){
-		printf("test_alloc_socket() failed\n");
-		return ret;
-	}
-	else printf("test_alloc_socket() passed\n");
-
-	ret = test_multi_alloc_statistics();
-	if (ret < 0) {
-		printf("test_multi_alloc_statistics() failed\n");
-		return ret;
-	}
-	else
-		printf("test_multi_alloc_statistics() passed\n");
-
-	return 0;
+	return unit_test_suite_runner(&test_suite);
 }
 
 REGISTER_FAST_TEST(malloc_autotest, false, true, test_malloc);
-- 
2.47.2

