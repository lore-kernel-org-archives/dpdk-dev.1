Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29474CFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88626402F1;
	Fri, 21 Nov 2025 18:10:00 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9627A402E3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:55 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7aab061e7cbso2690622b3a.1
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744994;
 x=1764349794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRWOQLoj5J/25LUy3oBGt+1S4haxFxAx2gN88s6HlQM=;
 b=KKZ9Og0IDIHgcIeoxkywIpMy0ktswnfyl4vwjS+DR18cv5TlxSTvWSu+PSGXgKLrfW
 B6/aDnpYGPFOvP25wAMWaanebLsmyrzW5XHW54o7k42Usn4FbqYc/RtgtJ6jLPc6GTHG
 whrykAn6oO363XhlPHXh1d0Se3uv0pfMpasc9ED/wg80J1FkjEUjCmwLPYE+8Q7E0yS8
 dq3aNGJ1LZ9bxGbBQ4BpGan4kpEDb3JQgUTHUST4nacIwqibOOaU+Q2XSkRAWqZ3Dcc3
 4QTTbRdyInLdoVf7dYaMsOI9q6D7MgWWGb7M74LPNwpRLMn2xcg3ANcZpvpnCfhoUCkd
 0GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744994; x=1764349794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRWOQLoj5J/25LUy3oBGt+1S4haxFxAx2gN88s6HlQM=;
 b=ntlE82WIS3hYSktm7rrKdzy9EN9JdGFjqsBju4m1LUuS4etXH8sccj944GZLYP1HS/
 v7KZf0oxdAxgUySRaZio8OZydZRsBHtNhNZ9L3+lqzHds6k3AeAYaqyf+Qa8jFv1Ih5P
 zaOLO8UARA0NHdOCIHzgYmsIVQ7xVDouzjqktXaZIhHaCO985zrfTacQQNi+j5PtJ4A3
 p8A5Xy3F0j+d1TalYp4NkOk9MNUkyGwKho3Kq9KazzelIdJTXEiZPIEdmCFNR1ooQWap
 TfXb3sGcaZcCklOuadPGrmUXrGOy+An+M1bWURA3zvAq2Jl3UXQoW/LtRc64aDziLRVf
 i7Rg==
X-Gm-Message-State: AOJu0YxT4pH8vRlBiRt2g0yBZnjWvPYA4Wt5oxo4qj7iuM2d/x4KJTgJ
 XNltOPTHbwqv4JAH5vO08bR+fsgLKZ3FErvUanVgUz25Ar152wvt5scF6z/MqHxzmWzK8bBXsUn
 dWvVZ
X-Gm-Gg: ASbGncsRArtSRegEvJqKbKLVwGbwNuncl8Du6dAZLJtvzLCswsHOYfVv/+iR1rxhSBm
 zujIXRhkHrasprhwrEezXZO0jBCZWEVa/RkY3i0I0nihW662KeWhLk+l2Jl1lfIZL4Q6BwajjSP
 7FMtBVZOD2oEqyi8qoRXBRp+axUTeRkaqf2PEsG7Oo/aTgj3x7W40Kzg1sCSTekS5Z1TL56WkPR
 6eE+n9cBpdyiVkq/2MSExMh3jL2BWeVErvhQlnVQhcYb9OS1kg4IVXDzW1e01M33hjcjd9QhKTK
 qeQ+o5rn506QcaFoWnpqFeQ1jugrmUwFwmhH7eL7k1QjUj5QA2Kez5ph8Cc/LpZCUFfK5//ApP1
 gEdlyuRK3eu5oJoJLTclj9LpwexiL97mriN5rIYhoLrnDfhgEnHgvUPuJiCN+aAI4kLmsNpY0s0
 HWJZeyOzBSRW74ERY59Jkej8VV4aNmxA1JgXvHroTGDgmyYzuKFg==
X-Google-Smtp-Source: AGHT+IGfQ9KsLZkN9+pURT+ApKInQeG4lDONoUS/MDBZY5goqIqB66gbbZHR/HUHFEAeaOrsd4u70A==
X-Received: by 2002:a05:7022:6628:b0:11b:82b8:40ae with SMTP id
 a92af1059eb24-11c9d712b45mr1126350c88.18.1763744994455; 
 Fri, 21 Nov 2025 09:09:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 4/8] test: use unit test runner for eal flags
Date: Fri, 21 Nov 2025 09:08:23 -0800
Message-ID: <20251121170947.134502-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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
index 1d1ca87e0f..398f038bc8 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -777,7 +777,7 @@ static int
 test_no_hpet_flag(void)
 {
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	const char *prefix = get_file_prefix();
 	if (prefix == NULL)
@@ -796,8 +796,8 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
-#
 	return 0;
+#endif
 }
 
 /*
@@ -866,7 +866,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -1208,7 +1208,7 @@ test_file_prefix(void)
 	char prefix[PATH_MAX] = "";
 
 #ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
+	return TEST_SKIPPED;
 #else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
 		printf("Error - unable to get current prefix!\n");
@@ -1650,15 +1650,29 @@ test_memory_flags(void)
 
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

