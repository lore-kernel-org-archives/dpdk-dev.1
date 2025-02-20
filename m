Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC4BC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55DD04060F;
	Thu, 20 Feb 2025 17:42:09 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id BE24D402E4
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:05 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so30363555ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069725;
 x=1740674525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=da7+iBP8QA1/vMO5qGgbkgWizw9pmAaAFqLEnwqeXoVJ2YXENuMu/h5Bpn/CDDc1QY
 Ihdg9tlnMORxBM/UrEeyyVOy7miYLle7uIsv974DrYIUp/VJOUjsNxGcEFs4RS+lXNjj
 YNv8Ftt/5IFlDXJRjCsgz0UUtW1AfpHvqFp0gdMJCj7G8gVsw9Lw1B1ddnNFxLzUIB78
 NSossoDzwsE81tpWT6lKNqSbPg8dw0RHdiEvWufaXqjcOeE3y+RVqBQ7ueq2z1Kp4Qsn
 ZqQKP2ysSor+JTVSI3pMfHCNpq47prbKD8pzEm98krT4MrvlRkDq54nIihpHkWa+W9Pw
 vGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069725; x=1740674525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=pxw6/fkJxn6W9RqkoK0cyNISE9AHdq37XR8cxRI8xeiAyj68P7V7Zw1ZDEXLxp9MAT
 TlY44dk9GBXNdsNZb255mJ0ftAaALZDXlaj1g+6r2BWJ07tpoHADfsF3hO/BXTmbIkmV
 7nUbqBG/TdWNPX4y9boknY11EApo5KAeuCQZzaBSJVZBQ0CAn2qdl5vtRSANxLcw1xaJ
 U+s+G0v995UbStLl0Q+CQ7Esxxis9jiRLTAJVohNCuznCaFMTvqiQjTn+WLWMU089KKy
 XbUcjC3Wm2SkgmhE8Mqkk5C/2QgWzBV7JZjtLpfEGojgQwwXB+AWf7D0wAALsOpe1Qu+
 HFYw==
X-Gm-Message-State: AOJu0YySqg1B9/sx8RZsDyYT3Jko7WyCUhU0kHMalJwjyinQo+NED6TV
 V2MagCNxu1KSlX+Nwc/3GPpAjNhWVHGBsMPKBRu2/LBqVdSXB8BkdiaudsCYR+s2tIBb0H0Tyh9
 b
X-Gm-Gg: ASbGnctXFrI3DKxnp3RpkwDEIMMoxRrHZbn3AiCVAruZhwrXEyOi7rMenhdSfENfed0
 +yz6XVc6KRoLNfnGQcqbP7/N0TDQTv+Ov0M/h+JTuccp/jszrV0vL7C1G39XsaZmcYLs6O3NjMb
 Qj1H9QELeT8zVc/upXJBtm2Qo+6I+zhaey7ihiyeBMAkbKxYQzeDV7fIGecyfh24skqgoatEP6P
 f0pCembwB+Ld8lVtkdPb2OQHoz3rZTStRRDHMSJzQepoT7+50JvNetRdLSY9P5y6MlZWUTCT6p1
 oJV4fkeJhtPOQWmvLD0Gxx1VpBJ3fT1fhirYW7FnugaMM8bI7xKpSxSA3k7pyboSnknV
X-Google-Smtp-Source: AGHT+IHeLCQFROo6xZc35huhUFbCG9JVKM/1QjZ8A7u+3+9LVmLS84jbHU3e1PP8oMMA7mrHrqFR1g==
X-Received: by 2002:a17:903:32c7:b0:21f:baa:80be with SMTP id
 d9443c01a7336-221040bf7c3mr349193955ad.46.1740069724826; 
 Thu, 20 Feb 2025 08:42:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v9 04/15] app/test: use unit test runner for malloc tests
Date: Thu, 20 Feb 2025 08:27:10 -0800
Message-ID: <20250220164151.9606-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

