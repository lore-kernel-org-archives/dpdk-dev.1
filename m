Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DAC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF0140B9E;
	Sat, 15 Feb 2025 20:06:04 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 55C6040B94
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:01 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220dc3831e3so43200145ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646360;
 x=1740251160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=il12+85OHD8li0aUkG8PmLsBftGSqHGhJMEWAevzoMk=;
 b=OCcTFSiKBe47UxBg75L3QVqmT+zDMB9DOBiz2DotvIwdPUSR9NMrIFMcrFAgble5ZV
 GujL5Kztct4t60cmU9wzW6kzEzFLr9+Yxr+XlwxuMUqRvkC+p367NmyP9wI/Ivzx9Bvu
 M5OcGPRZRmuXPodfRIuEQ66vS1KAOvjR1/W9vsBkz9TyZvE3bfbCJGg56yubDy0VMyy2
 ZtHd91UBKETbOPIiB5NOCSFthv5Kfo0F+rG00dw1T1hJWP8K3jlOupKdVxHNeMYbIr7m
 1EF8uZTheaBBirxFGlyl5gz5UZiUIKZdTUXtx2mFuq+/84uUSemIMBg1n4yGPmsRMJdP
 1vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646360; x=1740251160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=il12+85OHD8li0aUkG8PmLsBftGSqHGhJMEWAevzoMk=;
 b=E+uES93SxClpjX4eDgtP+3DQGB7HRClllkqJ4TWbdan8r7QBjPF5Gdq4QwhAlY0qDh
 grwy3w86J7chYN0G8dlxmXSUCzD2t7WvOJ1hSwmYpAPVdUIU1hk/o2K8ILDjvhXMXS97
 nB6BBJqOq76NE3YgtUpbw+C9SeRgjcSQMzZenr0OjG+JNLpZId29BEf+/XgAOgdH869Q
 nYpXvO9N9iAPWi67UktK5StkR+iymg5mTJHXmt6xERb5VDT2ze4Jc6aSRJkXWgBmLFSN
 enrYesMfis3+Qa+4pOtbjMYqV2u2AgtQYZCzSwWkgWFX7zLs3ulgEtEgP8RIuC7W2yKY
 NSBg==
X-Gm-Message-State: AOJu0Yx4UzG2IPL9dKlskp2hv1BoL2TLjFZKWbXsT2uAVvjf2yd42iM9
 SFsrujIcayVaqk/4noMFz9ZwVHFw2+9TUDjXe6TMrCzo+h0NTCENfDjxUSKYqiow+SEEHr5nSB1
 W
X-Gm-Gg: ASbGncvAt3f53sRWXxjGofgticW4HVn0FrgrYh/LT8MkXElynjH/jFlKKvuFrxOUOl1
 smhZSTvlmkk5B5hTtNkitj8vmMd6qJ4shGLsQCN4td/hjyY8rMXQGxquFPdvl3+1k6g7i+glt+n
 IhHPXPVGf29u+uAj9TJqhQ1Gnt7oVoza4Ltbmnc0shNSQnAqnxhNcEH8aOXqFpLrNJmtMTs4XsV
 lSSTRhTUzSWWozfZ6F0SH9+7DxWR+aZI/rQJbMXY9LsPsFrVb9XZ/KWVEmG2lCcVh2Xi8lDEaPO
 5irGH+eYPXfrip3oCroN9A+JqqaWEVwLrmE0sWxmFwXIPUGhHLP5xLksJ+4Ur8+osqB1
X-Google-Smtp-Source: AGHT+IFIf4Be94q3WHOvxij4MoT1pFT/conZc81qmK94SlsW9wPU7Hmhlvv/hvwtfqQ9YJYCkjlUcA==
X-Received: by 2002:a05:6a00:1495:b0:732:6a48:22f6 with SMTP id
 d2e1a72fcca58-7326a4825a1mr2112754b3a.9.1739646360473; 
 Sat, 15 Feb 2025 11:06:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 06/16] app/test: add test for rte_free_sensitive
Date: Sat, 15 Feb 2025 11:04:34 -0800
Message-ID: <20250215190544.988310-7-stephen@networkplumber.org>
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

Similar to test for rte_memset_explicit, use a worker thread
to free and then check the result.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_malloc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 4acb827543..e6ca60ff8c 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -1040,6 +1040,44 @@ test_alloc_socket(void)
 	return 0;
 }
 
+static int
+run_rte_free_sensitive(void *arg)
+{
+	rte_free_sensitive(arg);
+	return 0;
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
+	rte_eal_mp_wait_lcore();
+
+	/* Do intentional use after free check to ensure it is zero */
+	for (unsigned int i = 0; i < SENSITIVE_KEY_SIZE; i++)
+		TEST_ASSERT(key[i] == 0, "rte_free_sensitive data not zero");
+	return 0;
+}
+
+
 static struct unit_test_suite test_suite = {
 	.suite_name = "Malloc test suite",
 	.unit_test_cases = {
@@ -1053,6 +1091,7 @@ static struct unit_test_suite test_suite = {
 		TEST_CASE(test_rte_malloc_validate),
 		TEST_CASE(test_alloc_socket),
 		TEST_CASE(test_multi_alloc_statistics),
+		TEST_CASE(test_free_sensitive),
 		TEST_CASES_END()
 	}
 };
-- 
2.47.2

