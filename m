Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A7D0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99CBF40E18;
	Tue, 25 Nov 2025 16:22:56 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7795E40DD0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:45 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2980d9b7df5so69878945ad.3
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084164;
 x=1764688964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoU0VWa+5nKkCp+jRCCUOdFZmgoYYbBOsS5LjzzWbA4=;
 b=zi9z2zFP04rb6uInJWuWX/pVJvYWB5gPfAjTDNSusMS9wSVTo2iH/0ky/UKYZ29JK8
 N5CzzYKRBmfSe5BGl8UbLVKFr/ygol+GLDGH2xXh1CEltFjGh42GeQ8sLLGt2v9MVedH
 2y2gc2v7N2gzGik4VGCyZxdohVgH+vHLqeAg8P/JBrUm9BTOt189ru4DNbactu512faG
 Pp+8dU10X3SzIMGlSksTjb7Fh/O0GBcuk1FsjcWanTJYLYbdEvuCjEzO1an6Cx0uOaDE
 FDMAJZLIE98M4YtUvxLobHDQ4FX7uKKzgVSp3YQkxmiVIPU9uQM8p9DFgHhpSUYtg/0O
 /FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084165; x=1764688965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eoU0VWa+5nKkCp+jRCCUOdFZmgoYYbBOsS5LjzzWbA4=;
 b=QKdU3Tdn4nzw5K6x6olzvnO4vFzsEfjWOId1v5M5DBFayxojW0Fn2gg7Hlgnbh/uUi
 I4Ha8nshFq3z1jv4nPpu1PrimsEz6ev66bSv9L2M+45K4xNYbBgB4sV6Kl7J0bLFrZV0
 ruGa3R3jJUo5JuVYbFekjaiVmI9kJW8UjuCA2owo559PB4jAF2A2ATdS4rVDWrdIISss
 YMYJTt6VtgO1rWs55zntukO6wiqFFkoNNXy+HvfuY3MS93XA7Fi4lI5K45JgFVXIp0M9
 eRDc1fdO+LC8onY+CZmj0QUglZMVF2hn9GssTr/uoejf+OJtf0pCCgsORAJbHDjbuYZH
 A3bg==
X-Gm-Message-State: AOJu0YzbIvsBPUzpqxn3HXbhDZkW8vm+NhFHf1+vt+xYCOLamZbiPIoN
 0IqGvyQJNBOx/OZlrku3ze5+DtNScX8LaOjRySaZG+bh80X5oT3h2KSL4iqqgQEd1l2H3Z42n2X
 1ccMh
X-Gm-Gg: ASbGncvlE4YOEPUJPtECgIvpWw4xzOvZUTUBjpsvuhtEYr8R/ogRBQWB9pjCA9l7xlW
 hCG2anCIKDzAXKiZpmi7n8AT6tU2PPH28f3rSbyhMR8PMtCdEFaETVsY2Rc6qGmNVWQFszjIFbJ
 KnzExne4ZaPdqo1tgl94BAvj95WqfT7G3ZWeMYnL1XYfNbb6yrAIy7IyUeGoFWe8a1oXbfF0d7r
 qKuuuotyujGMWTkLbpxb3MuZVYns/8fi0n3gmJatFUVol92X9AZZLbEDlLh/Y7+XQyEVneMEyp5
 2S1gwnSqTYy9Mnhs51nWf9A8POwF1ppdN0aPCZDd14lA5no7A2Eutl3S1FGVVSxpDvbgdcMVD8s
 EwRzOHNv3/U7LSzjdwoaQ/GstaHc2kIGk3K8LRTY22JTzQLBF/oEdT/PovrGl4TJ7yxGj7e24I7
 zkGV4upS4I1nE0MU4tHVtAbSptRKQyqDCmmpKulG45MjgsFIhYqw==
X-Google-Smtp-Source: AGHT+IH0cQybClDbRVJ1tB5+4dOEZTlNnA8SOQO7kc3sGSbdxJQSk90X70vQQgpIZX6vyXjTgMh1eg==
X-Received: by 2002:a17:903:2f87:b0:295:269d:87d1 with SMTP id
 d9443c01a7336-29b6bf84213mr173068675ad.52.1764084164400; 
 Tue, 25 Nov 2025 07:22:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 09/10] test: use unit test runner for eal flags
Date: Tue, 25 Nov 2025 07:20:59 -0800
Message-ID: <20251125152232.73528-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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
index 6cf061864d..92a8fce3fe 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -736,7 +736,7 @@ static int
 test_no_hpet_flag(void)
 {
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	const char *prefix = file_prefix_arg();
 	if (prefix == NULL)
@@ -755,8 +755,8 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
-#
 	return 0;
+#endif
 }
 
 /*
@@ -825,7 +825,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -1160,7 +1160,7 @@ test_file_prefix(void)
 	char prefix[PATH_MAX] = "";
 
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
 		printf("Error - unable to get current prefix!\n");
@@ -1602,15 +1602,29 @@ test_memory_flags(void)
 
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

