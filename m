Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C49DCD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED3841611;
	Sun, 16 Nov 2025 20:00:43 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7DE084278A
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:42 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so2075887a12.0
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319641;
 x=1763924441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQaB4O5GM69//Id1UMPcDAPMD+xjQw6deQuKA4cZ7os=;
 b=g5+1Du3Zhx625N+07+2WMGYqCKXNJ57u2jL732EA7zyBs7VxyvhcTElYL+DKUfZD8d
 VzYE6/mwgkhnIrJ8cAghKZg15uNopev2AlOB+CPU31Sb2i6kWiAcyj18qODuZdaNImMz
 CSL9xHbnR9Xiu1LWqjNNeS1PUL1E/mLT1CeadauBJmb0qCB6XuQlIcUf5h91ChUnr2k9
 6CEGOOPVWyytD4Mh91MTHhabSXW//yW5AeHReRPljcgOpP43pFzmqtSzY7jrS/WVgUOp
 p/UlrqkEMMkPzbHoyvgi70gJdMJ8iGvcL4pnf+UCrc53O0t4DqVIpY4AyqFzZE/VrUKU
 RRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319641; x=1763924441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQaB4O5GM69//Id1UMPcDAPMD+xjQw6deQuKA4cZ7os=;
 b=uRj4/Fvz1YDbASpbNqof9YJYjbh6Kt1X0LfWCMc2TJcmwJCautHwjKkLVvdOU16zK0
 FatHbjIYZ+3nJpzBKEQpqs6w0T8TEFETOELU0vwMSXZUV34K040xldpvGHZbzqPkYF70
 lMhv+FEoNnPgqFb2Siep/9oCLEzWz8Wyj5MMxuNLoEWmXoAEYEf93e8GAaCWl4oRi6TX
 WNkTY6upCcnVoBSNlYCJVqu/MdekRfzCqWLZK3xcRd/kfl+xGmNmSLGj2HWaUkHMmi/0
 j7x+3LWk8T+wb9mroPSIbbDFKbgX/NGPnqgPWD30LQTeKD8/UWo+AxgUfQaKJt8HDi+1
 m34w==
X-Gm-Message-State: AOJu0YzcbtB6H1iJH/M9eLc3ZNhS/Tu7+TzxedueXYKALsJBsH2tD/QS
 wl09r+CS3eSeRqmoFc/3aV2f3xhzK9aMh6ItQ9ugFG3ALqgOAOpLE9qzUvNTsMw0ZSgzoLI4kYO
 R3gbj
X-Gm-Gg: ASbGncv/fzrmm9Z8mdf2gesHHUuDXrZnlWaChUF2xJWixe5+xI3SHmd2w58nMoNKn1+
 mSGRybnTE5nheP3q838jgB0+yR4Dg13kTWkLOH4x8afPf6P5wAIc5bc0R3Ok8v6jlEox0kqYh2Q
 /Ys5bi8aCPe7uF2r434tEkjwlI3E8QVwNwIUTD+7Gix/jwMSK5Qy0EB98KhGN9M3M6CIB5XKPfY
 7FhrcLGnvCnDYDJEU9oc3iPmj5mY3gsq9Gm1Uag6WYqoC/JXDAlR6d9fbTwn7DuApLVA2D0qoI0
 1rxIHLD+sdHlmt9nlLcV9vbEyWtgHddsd/UVgbcpfEJH5+OO2jDLdBp0yiOXMTflKkl7HuCO2Af
 BPcXGjrmvAJvV2Zwk8D9DGL2gQK0CcqKLdUCC6Z6NzyQHXelkLEh9o+lDd4ILsHqpRHjvwv+GXx
 B5QI4HcvyvmafLHRadr3RkjZUcM5BtEpCTz0KRtnHOEtWrx3wJgA==
X-Google-Smtp-Source: AGHT+IFHEaEg3N8xe16Oad4vY28iSNMlQV0tBgOfMhlXuNmMi+/5G0aajuwfvTYstwNiTouo0fWrwg==
X-Received: by 2002:a05:693c:40ca:b0:2a4:3593:466d with SMTP id
 5a478bee46e88-2a4abb0ae8bmr3451070eec.9.1763319641482; 
 Sun, 16 Nov 2025 11:00:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 3/5] test: use unit test runner for eal flags
Date: Sun, 16 Nov 2025 10:59:31 -0800
Message-ID: <20251116190035.76123-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116190035.76123-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251116190035.76123-1-stephen@networkplumber.org>
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

