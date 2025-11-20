Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D9CF9C4F
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E0AB40611;
	Thu, 20 Nov 2025 17:57:25 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 2843C402EF
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:23 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so939718b3a.0
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657842;
 x=1764262642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUs+MdEJXDjpU0v9KGMiAO5DAoNyDIa3EYbVTEsnydo=;
 b=PY8sSAU0rKbXWoIwpigHv1czVLh4IEP7vqU45q9HjJZmEUU5fdiRGI0sAFVTgmJBCK
 9f4paU/asmOV6iItLAiIKBHmP6xD1nSOvQzwspQoVmqOjL1QKyDwkMfxzQGOav6a3QBD
 EwpGAsXrPNqAUhBDHdP7Ta+MjF1qy0IqrgnIEuQ/mNt9lwSqh6AVlONDiWkspDYsITP6
 zA37RJjfKISSlfOGuvJ6lIsQTuj8xQyb0W8CaCPezTX9U52t33AanFYA2LZ0dHf3pKlr
 m1Rn/x7sg+3kGvX1bGrZ2HguRrx3q4SCBL3CKvTt/ueHstlAWkn7AIGPIXWkOqWPAp6t
 UlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657842; x=1764262642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUs+MdEJXDjpU0v9KGMiAO5DAoNyDIa3EYbVTEsnydo=;
 b=VTUae22KvoGZ3ald0SPdAtiA7CGjS6NDGcTkRS16015u7KmOnni4Ip53WB5Sx6oKe2
 YnhHEBS+6J8CTSNkVdby3BbmLJcYcAbN55CC1VS1beKqckfVJIG4eTUnR5zDCqqZxPKm
 KDbKjSZG7sLS3FK7QxheesQGXDPKHX3zsz5BqadLxo74bWB4CSXRYlDRG7lBi9wv5NxW
 Ov/QIMhhcBkaGEO+o7TvVEpiqn3QL6o33XeoUXSlzpUlIhoum9IylcttHs3oxm7bfIYA
 5AAj12k4XBJCkbrmRl4zP7xKdAOymgBGt4+vnmWT+lOkQcXB/xgOwaRTWbdnIjKI5eUr
 r8zA==
X-Gm-Message-State: AOJu0Yz0HSBEzF8tf4mKgEzNUC+s7KyilBxJ4uMnJdovNJ+cYr6XhD0D
 99m9ZiftK3jXXkRY4dbfLmeVUmzhW4jj3DOc59/wuql88WV6eeWP2eKknngAe3M/MajEM0xeTIf
 1asru
X-Gm-Gg: ASbGnctMidZL+6Dec2MuMRSgwpL+unAkpEt1kdgPS0tfIRC4sWseV72a2ef0bt8Jxrn
 Az5EqkcsCqSeybOPkMvPbX5/SVYOIjj3Sf3InXA1INkOUeoQXOZ7ed3+Ws6N84y/llMgF4wPWM+
 cor+6Pe8KVXGG4m5/SczoPz+aheaL4ss32AuNgtEcXDwNV7/XKE+I383Ec7TSMfhAA/eO7PCIvl
 4DNpFRL6jv5bEtJbeJKPZngxk2vf/xNE+9kOJi6ZSS++USlRVsp4QDOzPskiIE/p6tixeJqhcn+
 lqOBhM9GdULEokOt4PAF6IRjlTjegHZnKCnZxPhpkuWhTS2Hdg0PMguYGmAkSh7U5sWb55zqSHr
 +7NwmJ/G8apRPRl18npHivXA/U5Wjfqmk0mg/4106w+B8Qd/q41RhsPD7BhbwfO3cJRbiYX9ntP
 zT8qrshff5NukhW5Ap7Ic5ftT+fTgx7ERBEXNPk1MQEzqDP1/U7g==
X-Google-Smtp-Source: AGHT+IHbR5Ojl4w2wt7bJL8qyZZvSD/VhjHU35S2XsW03mDxKSaEGHSDbyLzWAV45wCQEsi3tTEWIg==
X-Received: by 2002:a05:7022:988:b0:119:e55a:9c00 with SMTP id
 a92af1059eb24-11c9388fe8amr1216077c88.28.1763657842012; 
 Thu, 20 Nov 2025 08:57:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 4/8] test: use unit test runner for eal flags
Date: Thu, 20 Nov 2025 08:55:32 -0800
Message-ID: <20251120165713.120238-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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
---
 app/test/test_eal_flags.c | 46 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e21029255e..f86f25a4e3 100644
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

