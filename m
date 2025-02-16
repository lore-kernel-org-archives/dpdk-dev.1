Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F565C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84E4940E49;
	Sun, 16 Feb 2025 18:01:32 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id E963040DD8
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:26 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-221057b6ac4so16768295ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725286;
 x=1740330086; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg2zjmdCfFG8ctBwsuR58cznWodpwBWybE2GC8aP5qM=;
 b=BOgD3OUTegl1cTuAvR9J727WxvgZwV67F2XxDFujlbbemDKriMpvEMtxiTSi/Oennd
 jQDnNxs65gMXimawSjR7PmzSW4CIqvAzrRZjfoLGeUFlF2Q0rNsIwCIZN6Ixrlka8iWK
 xR537hHgQVyOcrvzSyEKb1WaOiyseUv+XryfKfVyjpPhcnS7toxhE4YL6FclrSHoa9I9
 KHD1nHr8MLm8jP/ABX3QyjfOZt5/OueY5vw9cNcG2DtSExIhYSQrftSsU0bmkRHauxEx
 bJkYkzM/F/BuZ8uB6XM0NrcA0kKZgc8tMRyEjzxDEqicmult9tiSHpcsO6Tmz7rVgNq1
 /07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725286; x=1740330086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jg2zjmdCfFG8ctBwsuR58cznWodpwBWybE2GC8aP5qM=;
 b=BwI15K9CCwn/qfjgF9yUXlmgh2g+6p2m+Ol51pOj6HiIs3yvdNyjgm+FMnGliBBjnA
 y2aPZ5atgQJPX8XfmWPxZBdMzvFRyBA6xmF50exmaM+sKAv5likpyVH6WSYp7lx9wxSq
 p+hr2g83OvV8QMwIp9uBRRhW1SmGhNhJG2BRDhbPkJzJOnBxZA7MazK6nvoy0dpB4QVg
 +i8i5UkEfPTho4GFVVy7HLhVAsXkb1hm4kK/PKQJ78rF26Btk/gLWS0vqANFY81oQXSz
 wyTRkoOyedFOJLLin2uJ1Qdwoyy/oQ2YMflSLJeHe2eWH9d2p2lgwqTOJPr2TlAXXYxZ
 hLbw==
X-Gm-Message-State: AOJu0YxQ8cQlag/qPAIQPxxZ1UIQPE19qcwNp3ODhT4ucZXKcWAEZp8H
 e/PR4qZRxYKpYVi/qBOO9zSkJMFtzs9Jh8nwIfyv2LuVEPbXZMnyGPbkDn/idKyRph/2TDqtrB7
 m
X-Gm-Gg: ASbGnctyt3gUJJMp74E80iACcEn6xku3xDqjGFmXZz2uxeboqROdZBxZKsrD9JwekXN
 WPdkZFmEOoR6h4xnbnaVgBsMefXG1CBsATn44dfWwXKvOHzpEZMbs9XIyRI4tTHIW6GtCDaH8IN
 uUQqH56lpewtPDAYuuTu3/sI4R9X5CJdjsI0BFRDUF+TPNVJzb3qKYzGldzunrHj9tgQFPZH6LZ
 zbqOcS2HSWvI8sE91WBzHWQeg+myTtCGfprVuZQRT42OXcJUOjJEu1+QHk+UpUHNenoxwWynJwr
 C/T8IYFzU5OTBejNPnn2xg3KsL9K6Z+Efrxbq2yL59H9J1iiVkCr1KKBwyGmQ4azFvE0
X-Google-Smtp-Source: AGHT+IEpWv53e1sZj3emvhlR/9tEsy2TTegnmJp1jJZcOKNIg9St0VvR1mZDH9K2TYs6OI91+vocxw==
X-Received: by 2002:a17:903:3d0c:b0:220:d5a4:3ac with SMTP id
 d9443c01a7336-221040d7a6fmr100941195ad.45.1739725286179; 
 Sun, 16 Feb 2025 09:01:26 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 07/17] app/test: add test for rte_free_sensitive
Date: Sun, 16 Feb 2025 08:53:06 -0800
Message-ID: <20250216170110.7230-8-stephen@networkplumber.org>
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

