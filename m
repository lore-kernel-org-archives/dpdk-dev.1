Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F918CFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A6C40431;
	Sun, 23 Nov 2025 18:45:23 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id AC419402DD
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:09 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2953ad5517dso43907535ad.0
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919909;
 x=1764524709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6Iwx4wa5+M1K5368dZpDXczj6viFYmm+BcEbvWSe74=;
 b=j5CPZLPWtKeS1gmyNty6lx3bm/mh+u/W9kuBObGvbTY3VmxMDRtnSzGL5jODmvoApK
 boV/Wd8/sh0wFN+Ek6ShPGTGInQ2nUv3//CwIwUKx6coTgHHq1y6Q3iq4QQif0Qc0X5/
 OPcC6tTOWHMdRH9x646AHWd5dVZk2FB+zYmcApYukKLWuLxBGcgTIEmo8vKJLJm8kTXK
 1LO1QGDTJRlTMjfecVZoRRP7bL6QCirUNygbkfZGaoCYt4m9hsQCezjfvHXe9/ez/uox
 MN2a5HNBPzEg9M4O0S1iTXd/1hGF1fBigxqiDrYb5yrWEBTaTl1R3KBTpmjiq6R8DeQ5
 p4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919909; x=1764524709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6Iwx4wa5+M1K5368dZpDXczj6viFYmm+BcEbvWSe74=;
 b=cps8DfoqboCL3eX7RBfMYNE9D5osrJt5Ggq24WPWw1o2hyEBlZfnXltF0oVcQNf6Ir
 X01IanpQfB5S6HHeobzfn4cTl6wFkTnWSpvhV0meyD8G+phq9p9KeH9tdx034MifPOln
 Zc9+zKvlpxbSoIa8w3vVw3fJPPcAzzY5FWp/SY4Qxun9v3Hlk12kovvTV+SsPAYOGtTR
 5yQKYfdOVIUCixBrcM1Qa6nGmZZvaowE4e7G9SNJZjHyHS8FZBjXBePMnWjNZ94tqEfi
 CbAY8fUvf2bdfx7HbKvz16RY7R4kz5VLnM3fyzfcbjI1xKie7qHG1ca+dNV0pW0Btaht
 H62A==
X-Gm-Message-State: AOJu0YzO3gPZPjCBRnR22drTdCECIhVZSPmcjcpy5wABsKzj8QXOrNj/
 yFsOMjDsKZwt73tgqBAnxsggwZtjnroEQAP+8LLjF7rFDBMw9vgloYsX181yxRz2Aljy8EyDuoH
 IHOMx
X-Gm-Gg: ASbGncvFf3qjoPLa9B7C8xjL5dNN/meKqZRe3mK+LQaib3ZJhXcY2Hbz2lCgyVGfVKF
 mYBmmcjYou/lXyMF1U3asrCYSa2D9jIv2X/Djv8Jc3t7GeQ6aa1qX2Jb2ID81vUh9u7hXXHAeiR
 daoNU/pkj76iPn0Rk/+ke+1+pr78aOG+f1DwcbMgkRh1IwUIZyfFhqh1rzNR5wtFmPLHLv9l0rz
 BOLrsaSB7zFzuWEwzhUq1mG9qqxwKSdDqb7sLDdcspfKEYZePtNgzbi4Zasmt1FD8Ej9ES5RNGy
 UZUC0nzo2rQN2w3KYtLgcwT9XIwiXihb1LUIqKkg3pFPztDiTttgUhsH3+Uh3Ngo9yyPb7jz/As
 pvYtzDwk80Ppx/gmbGwx96N9L42c3AvX3Ci3qmiYX87Hh36mty8j7XK3mdH841cWZOJqR3sFLeG
 l2ZO59cdRgXQUHwGtCRnqJuC/V+h/Q7ICxm8j6+Z/QfjS0PqyaPBf+VdzeMLGM
X-Google-Smtp-Source: AGHT+IFZ/+6j8Jpjp7Z4XjT7bwvPlB58jnIPinfGYTNVkJ+gsVagqEE4HRxM0HweF6Q3ibFnbmceyw==
X-Received: by 2002:a17:903:1212:b0:269:b2e5:ee48 with SMTP id
 d9443c01a7336-29b6bf8150bmr98640185ad.52.1763919908784; 
 Sun, 23 Nov 2025 09:45:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 4/9] test: use unit test runner for eal flags
Date: Sun, 23 Nov 2025 09:43:27 -0800
Message-ID: <20251123174503.20880-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

Make the sub tests in eal flags suite into a group
so that they are not individual tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_eal_flags.c | 46 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 0aebb5f611..ba25f8e1c8 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -755,7 +755,7 @@ static int
 test_no_hpet_flag(void)
 {
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	const char *prefix = get_file_prefix();
 	if (prefix == NULL)
@@ -774,8 +774,8 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
-#
 	return 0;
+#endif
 }
 
 /*
@@ -844,7 +844,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -1179,7 +1179,7 @@ test_file_prefix(void)
 	char prefix[PATH_MAX] = "";
 
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
 		printf("Error - unable to get current prefix!\n");
@@ -1621,15 +1621,29 @@ test_memory_flags(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(eal_flags_c_opt_autotest, false, false, test_missing_c_flag);
-REGISTER_FAST_TEST(eal_flags_main_opt_autotest, false, false, test_main_lcore_flag);
-REGISTER_FAST_TEST(eal_flags_n_opt_autotest, false, false, test_invalid_n_flag);
-REGISTER_FAST_TEST(eal_flags_hpet_autotest, false, false, test_no_hpet_flag);
-REGISTER_FAST_TEST(eal_flags_no_huge_autotest, false, false, test_no_huge_flag);
-REGISTER_FAST_TEST(eal_flags_a_opt_autotest, false, false, test_allow_flag);
-REGISTER_FAST_TEST(eal_flags_b_opt_autotest, false, false, test_invalid_b_flag);
-REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, false, false, test_invalid_vdev_flag);
-REGISTER_FAST_TEST(eal_flags_r_opt_autotest, false, false, test_invalid_r_flag);
-REGISTER_FAST_TEST(eal_flags_mem_autotest, false, false, test_memory_flags);
-REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, false, false, test_file_prefix);
-REGISTER_FAST_TEST(eal_flags_misc_autotest, false, false, test_misc_flags);
+static struct unit_test_suite eal_flags_test_suite = {
+	.suite_name = "EAL flags unit test suite",
+	.unit_test_cases = {
+		TEST_CASE(test_missing_c_flag),
+		TEST_CASE(test_main_lcore_flag),
+		TEST_CASE(test_invalid_n_flag),
+		TEST_CASE(test_no_hpet_flag),
+		TEST_CASE(test_no_huge_flag),
+		TEST_CASE(test_allow_flag),
+		TEST_CASE(test_invalid_b_flag),
+		TEST_CASE(test_invalid_vdev_flag),
+		TEST_CASE(test_invalid_r_flag),
+		TEST_CASE(test_memory_flags),
+		TEST_CASE(test_file_prefix),
+		TEST_CASE(test_misc_flags),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_eal_flags(void)
+{
+	return unit_test_suite_runner(&eal_flags_test_suite);
+}
+
+REGISTER_FAST_TEST(eal_flags_autotest, false, false, test_eal_flags);
-- 
2.51.0

