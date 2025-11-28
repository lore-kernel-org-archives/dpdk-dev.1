Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA61D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1EB40672;
	Fri, 28 Nov 2025 23:44:45 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id DA1E04065B
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:37 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8826b83e405so30730126d6.0
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369877;
 x=1764974677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr8lLVUaDzfhjeeS4Qg1RkqDcqG860slFuIJXrkTb/k=;
 b=CUWSMfJ7LSC3mizWZUkGmwWLUc+pe/5BlCt60yBwIqNk5F+hGi8coA75AiL+0Zdxqt
 CcpsTXnLigGOvWVit/+8mhh01NI84dHSLNhbAD4otEDoV2vVH90bjIpCVs5GujAlzfa4
 tLarAQMo7geLdTsCtLX+FIPERmVi3YLV7tdBiEqf1bo34OCFxnigp/nIdZyQLRy9eR6f
 QEpjEOmLPLOx5aek0nhMq0QENswMsYTz/iEM7j3zdojE7kFLx3cYGsUsdpVLK9COxe9g
 iep006qaxH4TqgSATSWi0kLrNOGz02009eKSCBNWZfNajCpx4rlZIS8UZvpHrp/zG5db
 HTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369877; x=1764974677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lr8lLVUaDzfhjeeS4Qg1RkqDcqG860slFuIJXrkTb/k=;
 b=p90I1B9DtOadl3vIrBj1gxogE7rv+PV1/IJq2HdIG/a2GDELlCDYqkDAeX/MWYlEHc
 uqEE8hA06P6VdO1t+3d4+Pa82CdDN4ztRIKEEkG/Z74oHs+UgEkHTN7NiPDTyUZ5LHRz
 ChwwrNYEJgbLWZUgbj9T3Q3Uzifive+vwvNUsI0HMMYZIMxLK3H0b+BjzWSL5uEJA0kO
 E3ZEvrMOaqGQpp0HZconkbAi1UARECu1KWXli0iYdzZ5AbL/Y3+8ZzUWs/Tzz+poKQe+
 alVLsD2Clr68RQ0Ge+egGOiMEcxmoELyjqPToPas7x9CYjTDhMjqkyNefr7PPQ9k/w9s
 Ou3A==
X-Gm-Message-State: AOJu0YzDAE77lnMTsIIAp80+PEIeOvekl4aIOIqQgWw8HoDCTeAl51oV
 fhIhYZoztg8Yn0r/AMDeYiNX0ahRlTm8ZWBZNu7X+mbtI4FRRDGCiAA/RvsOMORB4NzTubPfRR7
 66sAg
X-Gm-Gg: ASbGncvL8oszP7eNTCIz/nfo7Vj2WQXfIMA/mT9HnXQDLdd0bE5hXMRl/b+69ILfkVs
 e/K2geT7wKbUvXr18d8ceHaeKULvV0vzz9WNLi7YhYlPEE+ce7vpk1W3p0+doEnuE5Xk4y7mZUb
 xpKV4zwT2V/BjUx2BUCYzkSO2+YE7zzard1Qimhe6LsvoYCgsu0fcvJ5g/XE+wffLzyhQZj53k3
 MXPeQPhP3JCjmPH4uu2X4XFx1esecVsN912ooAZpBepCgbTtO5thuCjcMhUXPTCVPzHXvA996oL
 Hhibu6WAlsUMdwmqaxcL6VP9qPCBaLVA3xfdzY2Hf0/qAgid3Ueai5aWqsrvC4BfMqfwzkdLG7J
 h8ESinzQFzSaOYBcTUXl/BjNB+7wqDFJPjDB0QkH6ZMVHjdsoUgorOoUxJfgy15MYAHWaT0vrEK
 szagi5ouvjhEzndn877esDwByA/SNQSIHBm6uHSWl24PuB/LSrtw==
X-Google-Smtp-Source: AGHT+IFNrvGA3QPNbX9i+htCwuVe2wA4G6CaTyJGMDfeBjZHeYDC3YFeaMjecuoRJcBldKdxzAHGDg==
X-Received: by 2002:a05:6214:3008:b0:880:498e:a63e with SMTP id
 6a1803df08f44-8847c49c7f1mr418867686d6.2.1764369877252; 
 Fri, 28 Nov 2025 14:44:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 09/10] test: use unit test runner for eal flags
Date: Fri, 28 Nov 2025 14:42:12 -0800
Message-ID: <20251128224420.195013-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 75 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index fbdc972240..faace5c866 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -32,13 +32,6 @@ test_invalid_n_flag(void)
 	return TEST_SKIPPED;
 }
 
-static int
-test_no_hpet_flag(void)
-{
-	printf("no_hpet_flag not supported on Windows, skipping test\n");
-	return TEST_SKIPPED;
-}
-
 static int
 test_no_huge_flag(void)
 {
@@ -81,13 +74,6 @@ test_memory_flags(void)
 	return TEST_SKIPPED;
 }
 
-static int
-test_file_prefix(void)
-{
-	printf("file_prefix not supported on Windows, skipping test\n");
-	return TEST_SKIPPED;
-}
-
 static int
 test_misc_flags(void)
 {
@@ -730,15 +716,13 @@ test_invalid_n_flag(void)
 	return 0;
 }
 
+#ifdef RTE_EXEC_ENV_LINUX
 /*
  * Test that the app runs with HPET, and without HPET
  */
 static int
 test_no_hpet_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
-#else
 	const char *prefix = file_prefix_arg();
 	if (prefix == NULL)
 		return -1;
@@ -756,9 +740,9 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
-#
 	return 0;
 }
+#endif
 
 /*
  * Test that the app runs with --no-huge and doesn't run when --socket-mem are
@@ -826,7 +810,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -1140,16 +1124,7 @@ test_misc_flags(void)
 	return -1;
 }
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-
-static int
-test_file_prefix(void)
-{
-	printf("file_prefix not supported on FreeBSD, skipping test\n");
-	return TEST_SKIPPED;
-}
-
-#else
+#ifdef RTE_EXEC_ENV_LINUX
 
 static int
 test_file_prefix(void)
@@ -1611,15 +1586,33 @@ test_memory_flags(void)
 
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
+#ifdef RTE_EXEC_ENV_LINUX
+		TEST_CASE(test_no_hpet_flag),
+#endif
+		TEST_CASE(test_no_huge_flag),
+		TEST_CASE(test_allow_flag),
+		TEST_CASE(test_invalid_b_flag),
+		TEST_CASE(test_invalid_vdev_flag),
+		TEST_CASE(test_invalid_r_flag),
+		TEST_CASE(test_memory_flags),
+#ifdef RTE_EXEC_ENV_LINUX
+		TEST_CASE(test_file_prefix),
+#endif
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

