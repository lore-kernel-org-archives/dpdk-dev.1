Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B23DCEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B14410FD;
	Sat, 15 Nov 2025 20:34:20 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id D9FDD410FA
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:34:17 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso2695402b3a.3
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235257;
 x=1763840057; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQaB4O5GM69//Id1UMPcDAPMD+xjQw6deQuKA4cZ7os=;
 b=APB71p028ijMM/PAK8UpTKv8Tk2bWcAsQPbgmF06DmH05GBF+Iu33VaununrsZ0R1N
 E2EZlVwotowKInBKibvCMF6QWlcZomWblh6/iVmqcw5aHizlyXHXdu5Lq3HpyJLfZwLx
 vvbxJaixTxNY6wVGrR7NMRfiMumAgtavQW346V6Aiv/RuYDPgr8o0wWb4+RmvfdJXMLp
 qnGdUSU7JR6dq5yLTGsYg1tbEsnwesofGAGqPB0dyWF+NTzhZRpaDuovdiZm9wVTVP8S
 G4F5g+Tf62iaIlw+IVI++GQOstiWv383dTWt7SoJq4rP27A9AbsNZGg5SLjLzlAPm3Vj
 qhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235257; x=1763840057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQaB4O5GM69//Id1UMPcDAPMD+xjQw6deQuKA4cZ7os=;
 b=P212RKU0WebG1mPfBYsuMgIikcIF7L9mRxKTBmxnIAv9UkLh2p2dmAzVvHCaCOQjZM
 +Z0r7UApb1zxeFfD7yQV1nUxa1u6oRUDbYpDr9jZe3B5se9Ao/Oi9M2/wuWEs1kze6ai
 Ng3KnLUlYacUPY2khokPCr3qnxu81QSiVVxMYxa9LIlVXLSyERegAhBNXh0c8R4d70dv
 Uf9uzG+5w9ppEhdRNOA1VkH5OWuoEf8P/CLAkUFy9FKD+14A0pF4mwKRN1GuCmCriGMn
 WUufCjxG0KdTZExmV6fj4C6/mLVMBbra9ybCSzk7GhIlBOz+3uN4qU5LrUG7gid7Tq8e
 fyHQ==
X-Gm-Message-State: AOJu0YzgcUmN14AErfKGkBeKB9vUMMrVn185lCgsTlFp1lNMy0+V6PFu
 TBpBN1EjG7BOgPvjDiBv5HW2X/f50P+QIUlREEYkl9BQ6hpSPCM21BqgaMPYRUJdLAVupE/3Q3L
 MguS3
X-Gm-Gg: ASbGncuicSGwt1VIak9BBQtg4t0aOTtZg24PjtrBIpBR5KZ6eTevmI7F42Tg4jlWi1t
 mdwAnozj28I2TG0+MK2T1fXd0ofUB1ZCOfmnPC5Gf9Vgo+ZNmgJPa1UuRF8Kt0Cx/nxM2N/sNQC
 6rT2EwPDq6+qFo6QMQMTIno6Tu4eU7jz1hMlOW8UyE+jzTdH2URisju4XkqGHxdVUiufNrIBE0P
 A7Gon+gOkOWEtu7pKxzvV/8XFs+OKDkOd6sWjhonsPw0drO+7ROX65olkgXKXJuBMXP5RdKeQdg
 tLLgHsbq+puRiuOkP0X6xTrbtsRsrGBXSuHuuAwI541XLwqaIi9ruesBhDZtI+Bv5LuIoNVM/Sg
 nJ36gdOORlP7nINUdxnO29vgDKYo+t9yh5hTmRA+ToQtKajL4MasMS0gfgaImWQoYcMGuqh/BPj
 Y1cSFcIm/Qslr3Ygfdg0cAqJ+lKfqZhN3orASwtObfTgIrmsQyDg6+gI28wWe+
X-Google-Smtp-Source: AGHT+IFcNWefZzDobQjcumOtLYb7bbdztXtZP1IHrLJiN/a44wzhB9f5ARI1bVk3STRUtqzifqqrCg==
X-Received: by 2002:a05:7022:1b12:b0:11b:c2fd:3960 with SMTP id
 a92af1059eb24-11bc2fd3ad4mr500818c88.28.1763235256899; 
 Sat, 15 Nov 2025 11:34:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm26588644c88.7.2025.11.15.11.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:34:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH 4/4] test: use unit test runner for eal flags
Date: Sat, 15 Nov 2025 11:33:10 -0800
Message-ID: <20251115193409.99740-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 0eead2a422..12ba54339d 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -1649,15 +1649,29 @@ test_memory_flags(void)
 
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

