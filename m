Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BBC021A6
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4240F40B91;
	Sat, 15 Feb 2025 20:06:01 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id B529240A77
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:05:58 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-220e83d65e5so43856635ad.1
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646358;
 x=1740251158; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4Wg9KmSl18f6D1XKcTbVPWKRJirkFfd+X6LdzzTeB0=;
 b=DB5P1XVyL2UwVR80OlErCHNQFQCioE0Le6YRP6OxUArJ3WMynmk/CR9O4ejDS790Ce
 FXsprGoiqX+nSt+UzoO0epWDDy+nD/X7oF0o9xblruXAkMynKm5KLifVLEWotNB3cLeN
 M7dmlvKt7rZzsrXYc9VscdUxJnC1l1BcO3aryh+QZjItwNQWoac1tyk+7DB9bx4mzkZW
 3UJ2HSFEJPIv49GDd2VL9Xbop9HtlfQJK8DMdxiXhgAhaztYtEBDUAS15KHoA9ro6yft
 /GaCd2di/MX95d/h3aaRmI3/0CA9Ake6yuEbrDJBUNbmH0zkIaEKgr4llSd6rN1u9meL
 uFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646358; x=1740251158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4Wg9KmSl18f6D1XKcTbVPWKRJirkFfd+X6LdzzTeB0=;
 b=whJDnySfDLiA6gBJQFdzOCn0oVZxJojUcxxn0rLpOhT4NSZgaqLi5Kn5yZe3u2o/TR
 eLHHoJi/wljR7U1KkBtw3uF9cyPkXZoUFOE/cm+G+QPDLG3rLcoCyDn31Ii3Tfr8lgUV
 sU4p7nsHost2zSgHdJFgPXZHAecjHk266RzDnca29qNFnCQUwfCZ7n2Q+u9+hpp9U4z0
 vE5AgU+UXURP0aybdmYAmelMby879wSuwvFNO6lP1kov1EItg7lAj0aRUz8nbBRCnEQK
 9HJVCzFPkkSG/T7gt2TB2n09qIzJvCIHtlwRVSRs1qWEm3T/1RRSB9ir+6eg73yxPuWk
 JGSA==
X-Gm-Message-State: AOJu0YxB14kyGja9RahogwRAPHaGEVoHKco7Z51BC+a6hhtMXDzH8/wg
 eY+zSQmZlW1FfWgSIOCe4Jv0qy4uYQGVL7AkKwQSDuSgVZxtcDtE3iWO1FjOtnDjX+rXBTuou5L
 5
X-Gm-Gg: ASbGnct6Yo3e5HjvlvPnBCVzsgauzd02pjPHepKmR05EKOEwAX35bZeZOcSJ1NZMf4z
 YmdvOdcSO0tsfsZRPI92hRnce5O4xZ5VSokv3ll8lZzLzCOXAsEC2ZlHYNQ8du/kAAf4L1OYDcX
 CpVYpfZrWM4HTP23vwqNKvLCglU9Soc8bmitRKSAaQMc4eNX7P6NXaXbw38hWGxq6v42j8AjWm7
 ORlnlVLPbmmnwuXtUK4K8LY2+QAv6AijmqLOZJ7/xMGW+Y7hvj4J+ANlWxjAoSdQnO7MySLMhH5
 Y1dVqejsvqFqLEBnxukDLz2lnEMOPvVU6a8Q24UPysbr1vlz3J2UfJJEw/ywMl0rkg40
X-Google-Smtp-Source: AGHT+IFEHerh3VMWZdHpFMTW+4re8s6aix9h62k4IMqumMQ/DXiTSap0KDAHxkRW6wYoxji07jEgmA==
X-Received: by 2002:a05:6a20:5481:b0:1ee:89e6:30f5 with SMTP id
 adf61e73a8af0-1ee8cad2c9emr7240098637.16.1739646357913; 
 Sat, 15 Feb 2025 11:05:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 03/16] app/test: add test for rte_memzero_explicit
Date: Sat, 15 Feb 2025 11:04:31 -0800
Message-ID: <20250215190544.988310-4-stephen@networkplumber.org>
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

Add a new test for rte_memzero_explcit.
Test strategy is based of glibc bzero_explicit test which
is based off a test in the OpenBSD regression test suite.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_string_fns.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index ce07c17228..b4fe3a7c30 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -8,6 +8,10 @@
 #include <errno.h>
 #include <string.h>
 
+#include <rte_debug.h>
+#include <rte_launch.h>
+#include <rte_lcore.h>
+#include <rte_random.h>
 #include <rte_string_fns.h>
 
 #include "test.h"
@@ -205,12 +209,64 @@ test_rte_str_skip_leading_spaces(void)
 	return 0;
 }
 
+/*
+ * This test does a variation of what OpenBSD regression suite does to test explicit bzero.
+ * One thread creates a buffer then zeros it but does not touch after that.
+ * Other thread checks that buffer has been cleared.
+ * A broken implementation would get optimized away.
+ */
+#define TEST_DATA_SIZE	123
+static int
+run_memzero_explicit(void *arg)
+{
+	uint8_t *data = arg;
+
+	for (unsigned int i = 0; i < TEST_DATA_SIZE; i++)
+		data[i] = rte_rand_max(256);
+
+	rte_memzero_explicit(data, TEST_DATA_SIZE);
+	return 0;
+}
+
+static unsigned int
+get_worker_lcore(void)
+{
+	unsigned int lcore_id = rte_get_next_lcore(-1, 1, 0);
+
+	/* avoid checkers (like Coverity) false positives */
+	RTE_VERIFY(lcore_id < RTE_MAX_LCORE);
+
+	return lcore_id;
+}
+
+static int
+test_rte_memzero_explicit(void)
+{
+	if (rte_lcore_count() < 2) {
+		printf("Need multiple cores to run memzero explicit test.\n");
+		return TEST_SKIPPED;
+	}
+
+	uint8_t test_data[TEST_DATA_SIZE] = { 1 };
+	unsigned int worker_lcore_id = get_worker_lcore();
+	int rc = rte_eal_remote_launch(run_memzero_explicit, test_data, worker_lcore_id);
+	TEST_ASSERT(rc == 0, "Worker thread launch failed");
+
+	rte_eal_mp_wait_lcore();
+
+	for (unsigned int i = 0; i < TEST_DATA_SIZE; i++)
+		TEST_ASSERT(test_data[i] == 0, "rte_memset_explicit did not zero");
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite test_suite = {
 	.suite_name = "String functions tests",
 	.unit_test_cases = {
 		TEST_CASE(test_rte_strsplit),
 		TEST_CASE(test_rte_strlcat),
 		TEST_CASE(test_rte_str_skip_leading_spaces),
+		TEST_CASE(test_rte_memzero_explicit),
 		TEST_CASES_END()
 	}
 };
-- 
2.47.2

