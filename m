Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC35C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D1F40616;
	Thu, 20 Feb 2025 17:42:10 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id A1F65402E4
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:06 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2211cd4463cso24217725ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069726;
 x=1740674526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg2zjmdCfFG8ctBwsuR58cznWodpwBWybE2GC8aP5qM=;
 b=vIFPJOfJ4Xz+bPNgvB0g1OY0p6eGp+u1hlIcY6p41lB6tAl/I9uXAFhWA+Tz94oZuy
 LNXtmSn16Wuh/AzQ0VrHRD+JSYUcm9nevDqWhW0mTNoov6rhPC3KnVH8dO9lP7l/RrAn
 ZXAe2obUj+hQlv/Rx4JnBdRklCiW2DZzCI0XbDB2Tkr8zoIX2fMfm/yaZuRBH/OOehzK
 XQSnhxS4lcLGMecrKd8vU5603IqNKTggung9rSFtI6v1O6ZBTEdFFCRlKcwx2yJsiA3f
 M4WVHKSkhRmydn6ZajtqMNo0CcQR3QhfzpucISPZOTURco8m5aG9phNdmW3vLwdcv4zl
 ZOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069726; x=1740674526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jg2zjmdCfFG8ctBwsuR58cznWodpwBWybE2GC8aP5qM=;
 b=S3iXLS0B+L9Vr/F0F4xNrm4rBUjx20wr6lZ1wM/xTXmn6L7L/QD06kfCdvlw631fec
 XJOJP5U7q6HYe8KDTCc1fob6TyQVK9PfYElLSChsC9lJ8rKtWpDX7oh07PSr6fY7VF+A
 EvnxWRNXdxBqc1RKBCe+mKsDeISitGUhYxGxsgz+o+H3wzUUyVqVDEsTnnDo/QyaahGz
 cOnK4P6dEPPOnN7PCiHm2FZjd0flr4RFowXcXs1ZhHTfLtx6O9qZ4KC0rIkni4ErUJtv
 5z6TlasfttPs/QcpTEmywpbLyU06O+EIK7ajrrKx8zz+taDvb8CqHdx5GjIxQYbeZ5GX
 SbHw==
X-Gm-Message-State: AOJu0YyMBUECDp8sRRwH3KG1X8Jz/POkWo9n6x+K7sO7QncLnhVtl1P4
 UIs+Cyuz9AjANSejh6KmokfdIDr86KWKyAjq3grRjwqm+kfGniIvAF5Df2HfNePISKchCVCPXpH
 G
X-Gm-Gg: ASbGnctXI997NlcBhrMeB8S7gz5Wom2dCe1zHYWe/DsSkzYZZFvdLqH+b+7ALXd/CUc
 Oeec2i10ns0FbwgOelJ2XH0IBaBSIQaSmsWl2/CzTBvbZiUzEddj07zbyq4knqzYXgUhulL1mfo
 c1Qoghx9Hx/NQ3tnd36Y1lKdZb8F9anMgedORBmMlZlP/bpqNDIqd3gzd7w4BJatB/XlivERLMl
 fu+lieWGHg1rmw8h0woOU3s9ujD6d9AlB+LoJhINvRkGXhS0jCrcMcS7KisIhzk5/l+IruoZV2G
 rDqLLznrpDEdLoY+QV50NKUFJjUkVm/gNe/0tyP9LUUc+/CkMzwAGTswioYmPGs5lHOi
X-Google-Smtp-Source: AGHT+IFqjkPwozHh4HQFduKEGbXtHWievDL6BH0ry662Umxtu8NvhBN8xi6k+EHw3Kc1yvtbLsPISQ==
X-Received: by 2002:a17:902:ce03:b0:215:7446:2151 with SMTP id
 d9443c01a7336-221040135f4mr385387865ad.4.1740069725806; 
 Thu, 20 Feb 2025 08:42:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v9 05/15] app/test: add test for rte_free_sensitive
Date: Thu, 20 Feb 2025 08:27:11 -0800
Message-ID: <20250220164151.9606-6-stephen@networkplumber.org>
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

Similar to test for rte_memset_explicit, use a worker thread
to free and then check the result.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_malloc.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 4acb827543..fae28ab92a 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -1040,6 +1040,57 @@ test_alloc_socket(void)
 	return 0;
 }
 
+static int
+run_rte_free_sensitive(void *arg)
+{
+	rte_free_sensitive(arg);
+	return 0;
+}
+
+/* Check that memory freed is zero now.
+ * Need to disable address sanitizer since use after free is intentional here.
+ */
+__rte_no_asan
+static int
+check_free_memory_is_zero(const char *data, size_t sz)
+{
+	for (unsigned int i = 0; i < sz; i++)
+		if (data[i] != 0)
+			return 0;
+	return 1;
+}
+
+static int
+test_free_sensitive(void)
+{
+#define SENSITIVE_KEY_SIZE	128
+
+	if (rte_lcore_count() < 2) {
+		printf("Need multiple cores to run memzero explicit test.\n");
+		return TEST_SKIPPED;
+	}
+
+	unsigned int worker_lcore_id = rte_get_next_lcore(-1, 1, 0);
+	TEST_ASSERT(worker_lcore_id < RTE_MAX_LCORE, "get_next_lcore failed");
+
+	/* Allocate a buffer and fill with sensitive data */
+	char *key = rte_zmalloc("dummy", SENSITIVE_KEY_SIZE, 0);
+	TEST_ASSERT(key != NULL, "rte_zmalloc failed");
+	rte_strscpy(key, "Super secret key", SENSITIVE_KEY_SIZE);
+
+	/* Pass that data to worker thread to free */
+	int rc = rte_eal_remote_launch(run_rte_free_sensitive, key, worker_lcore_id);
+	TEST_ASSERT(rc == 0, "Worker thread launch failed");
+
+	/* Wait for worker */
+	rte_eal_mp_wait_lcore();
+
+	TEST_ASSERT(check_free_memory_is_zero(key, SENSITIVE_KEY_SIZE),
+		    "rte_free_sensitive data not zero");
+
+	return 0;
+}
+
 static struct unit_test_suite test_suite = {
 	.suite_name = "Malloc test suite",
 	.unit_test_cases = {
@@ -1053,6 +1104,7 @@ static struct unit_test_suite test_suite = {
 		TEST_CASE(test_rte_malloc_validate),
 		TEST_CASE(test_alloc_socket),
 		TEST_CASE(test_multi_alloc_statistics),
+		TEST_CASE(test_free_sensitive),
 		TEST_CASES_END()
 	}
 };
-- 
2.47.2

