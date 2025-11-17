Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF89CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61811402C6;
	Mon, 17 Nov 2025 18:53:42 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id D2D35402C3
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:39 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b6ceb3b68eeso3388416a12.2
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402019;
 x=1764006819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eborOuTcJLG1p6ULX392U/1gY0f9aD0QGPS4MwExcGE=;
 b=sWSmMWQaTwfp30xLXKE205aJ0jY+iWLIauGg709MzBSCW6F7VvJ9JkH+tzmTzW0Na/
 KBQl/A4bXbPfrx5ATsyN6fvyQ3e7vMCFel+bCHhUjVn4cvBRVtsKwQhtFBr51PK0qMMj
 5NE4Lr0MEXG2QrytVY/523x7nAKfyHqbVLnHyyZ5kkThWAlA5okVhvprTKXMCYWQtzDj
 GPBcxcl6slIjoJKTm85pwUsHbnYskmvgHATwUqiw/sGkN8yx4pWspF7Y1qd+TRcIXvun
 i3l1HqmKFt8v9HLVN8RvY59sHW7/tmNs4cFamPewK4BRaoR3HlofBjTsA5ru/1llEmUe
 Vcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402019; x=1764006819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eborOuTcJLG1p6ULX392U/1gY0f9aD0QGPS4MwExcGE=;
 b=Z3XV55uEYsOOdEtseOS98d/4+hLGkP8/OZGERbvytvqjIAo3jZnUuoYRvQjIx4KNCn
 o6hA6O4ngU0h9pzgC+VsBBNfR8H+PdLBWC8GUVvRnS1biAXq2Y2oZoqr+JIiPLOG4HHH
 XabEVh5Ms969FUBk8SWw4I3z+8vdl+K/UsHagVC1R8FwxOoSVKdsIhm9Gko+wU0KkA+v
 sHZgx92kT5ekhpfSXIsZVNQJQ71u3pK/WileT4baKsz87XnV7PChcdoL+a/IvJaLNA5q
 E3MyylLx5RH01D9GXL2i5qbui91NSXR8P0hGFd4A28LIQWSEI3AWxivDwb88sFrGO0rM
 IBdQ==
X-Gm-Message-State: AOJu0YzJi4XOLdDByRk17oERlHr0qPdA0pZhU3abOGLU8w9cGKTgrHXQ
 peDszeqsCYxAEYTPXKW0nQYN6YeKEiGjVtM2nSdnwR/vw/Fmiy3dLPBQKGDk1aX5oHGssqPNh1x
 bD2a6
X-Gm-Gg: ASbGnct5xsOom64PNIEM6o2CDIuQTY+lZCHHjk8Bq9pvMDjnEqCrUnMbQDEiHZwmk1/
 xEfdaUTbUr/UyZk1uMvlSlvWFI5qickXWP/ayM6vb/A/g6lDrWfdBKlK8of7CZ/a5khvboj0Eiv
 3FOo8OXVq+oCermIFb9OjpC1PwwsjMDb1qVT6pQBCLcPdYv3vJcwtukwOFTpoh4kEw+FdYMwzEe
 8OmKiSMn0Znl7XGEKtWt09i5NFBf/jsxJ1aE03uTjb2UKsfPB3b8d4DtGJnbHdTH+5Kd0SV8Ktn
 EEqTOo4Gq6SBDAoh11O429HC53w/6KYz52mNs8odu57aKQIcLpfxYunq0cia2VzGpZLu2l/NNsh
 dxFrYFusjtGWffWwDV2xb7Si2kuazrcPSdH3KXjf6mqfX4iPE3a07CJGIWB66LMzIMzULlO9/7U
 Z/JLGz/9UqgLZ6tom+4PQw3y4af9GXj1fFkYKLJD0sJ8AONMhhRQ==
X-Google-Smtp-Source: AGHT+IHbedLJLj0lXf7q1bCQcEZw3UegXT7ReXTapQ7OWY7ru6hMM5gphIxTHPP7cJlfG9oSfmEP9g==
X-Received: by 2002:a05:693c:6098:b0:2a4:3594:d545 with SMTP id
 5a478bee46e88-2a4abb0fdafmr6662406eec.18.1763402018942; 
 Mon, 17 Nov 2025 09:53:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 3/6] test: use unit test runner for eal flags
Date: Mon, 17 Nov 2025 09:52:10 -0800
Message-ID: <20251117175332.14014-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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
index c2e6c00edb..263f26d037 100644
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

