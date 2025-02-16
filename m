Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D82C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5393140E3F;
	Sun, 16 Feb 2025 18:01:31 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3296740DD8
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:26 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220d601886fso46238885ad.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725285;
 x=1740330085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=uD8TlbHZNRrg8Z3hv61ra2Px0n1bSFpS4zX+r7fIWQxD1TK2nh+jOLXMeGlUTtGHL+
 9gBcmynobaDyal+Er8k0YB4eH5ECCMTiuXG20VoqkgGbOYA8oy/etxKshU38w+tvhQl2
 2Tyln7rB6NrD1QI1DMz/tDNteVQ/0pHJHtyIzIMZZDwFObb5P7o2+wm8EptbiogGVBXP
 Eo/X3f73EJzbyaaV5OvXQ5ZDaWhT6gJa53HJ2+/FMWhnED0ByIGQ8k8kBkD/T5joVMwE
 ExLab9XjaBC82Lw0xJXEMYEJNzNrbIkINepQaUbPnkEIWa2/VbhIk2j1eKQMya/mgL2E
 c09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725285; x=1740330085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy+98sLwPn8ziR75rr2XPg61ZFAzFcXbQL5dXHx2hKo=;
 b=MqSTiAsyrPi1nYdQD3yYBVNS/kwn8rmEqhNlluxxMBCqvRIO+6k4TmblH9Dn1V7VtK
 9l26fRwdDDrVoU4dL7xYL/GvLYE/G9fO2K1jitJUwxCOMDtupuN1Wb3/7/diTYl+Do6s
 SkrIZCdudkz5P3F6zkJYlCVkHQ4PkIcYPEM3FDZd+LxzjYdqi4A2udCc9r/vy6vaQXw0
 WUAB2fTvyDxJTxSPwczInwgU2nxIjD1sASV+LzDAw8B7NK+nDtiLFO2k40TWOZ1dNfS2
 u+ErRdqZL958143lfTHD8SWyuHPSJRqwCw+1WKE8kMT6KzfCuakqJiI+MVjlkAvqd0M0
 kG/g==
X-Gm-Message-State: AOJu0YxPdd7TW5a5SV2pXNnmG5rd2AWESOXi6MhP3aBqz/ykfh/uEE8t
 aOCrCDO0U721FcuVH2FzwL595wvDInP/vwMDeTfUdeWGqDufM4T6E7Gjpud2cAcDyf4C1Rnt063
 k
X-Gm-Gg: ASbGnct3gIgrdjcFFkOIAzrH8o4u7DjEAYNcjW6wHjs9nNGP8kaqKIHIBujR+kv8jGj
 VzNm9zBGCn8SyBkr94/DHGG3Q79UZid4RL2t1Ch/FycNm2v+wTxezASQ7V0tmVMa+dJHHS5auLM
 aiYKQzl1KCvJHoQ2RfL361vmzDtCuo0LC1u/A5q801pCqO0qqlEuQadteW61kfvPVbMYAvbsBOo
 xmK/oKToXbgLUM9lJusL3Km018lVLvHX81/TBCFZmk6MdDrxMZvwmpeDuVgb2cRVNVq7gmhQzeI
 tMFbrkBBWtE3/IcZ76YmtgoOb3rX3W63UYWhKxV9tbvXP4fQWUHDkIapHclb+dj8RRQi
X-Google-Smtp-Source: AGHT+IGdyYGbeFuu2nlvHla+KhkT8Uoj/mPESblgy+MZuaPSQY+yDPD4sUS0iGpQPV7UwGI8tGb6/A==
X-Received: by 2002:a17:903:41c3:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-221040d8192mr97323775ad.45.1739725285347; 
 Sun, 16 Feb 2025 09:01:25 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 06/17] app/test: use unit test runner for malloc tests
Date: Sun, 16 Feb 2025 08:53:05 -0800
Message-ID: <20250216170110.7230-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

