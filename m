Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4415C61DB9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 19:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 649BD40264;
	Sun, 30 Aug 2026 21:14:00 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3494025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 21:13:59 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso2341698b3a.1
 for <dev@dpdk.org>; Sun, 30 Aug 2026 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788117238;
 x=1788722038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OEA84t662h1GPEsKw5ACJkwi+2SBE8BWAyGmC5bU3oA=;
 b=sTQv1bQRZb7Kn3McSJvc9gp+b6a9bzKsthPyfLsOZSLDq5GHrgI8FhF2FXBi+mHJke
 MIXHtmdQVdASWFJuOF0Jogug3svnlhiPj4ULignq30HFkxbeArlrJ9UOb8uQb6Zs7yfs
 e3bdYXghnjsGKTvGuGVS468/wXHUI9SGn+VbGj4ueSz8oA6RH4+2Xv1zaIuKK3Rm2tOe
 k17Qh/Nbjv0UYDjFF+KGSdkByRtHMM3QPvDlO4ps3N4y6fAyGG7la6VNeAwyiwAZ1CcR
 r8yBdEw1nLolvFp10+TwKlor11byls4wRBCpLAIxlT3ZwBePnp5G1ygf42fOWmSZdTPH
 juoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788117238; x=1788722038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OEA84t662h1GPEsKw5ACJkwi+2SBE8BWAyGmC5bU3oA=;
 b=aAHX+/Gwza9UdtnM+/483PzoIxrn+HOsisv6bAQIxty8Gm28VLPWzEUYulirExDHj3
 wrKv6oOQ+Faj6QY+ARwxhq6ksYHgMvV4LuKGHJn/KgI0IaPUkkyV1HziKDParq152Vqa
 be+9LFoYeecWrwPPt8s1J1q8U/W4L1OsKCDbJDGovvieXUzsfukq/WFqgqFD28KqcMmg
 fxacKgSHcW1K9yrWV7/NmgPzF8QFFSW7oVfhyGDi0gK/vdgWMQwQOlzcNuC96UtEPHAA
 Wd8W7s2Ktnqd6cA1z15c/C/pf1pVGBvkeikX8C8wGgRYHTHZ32ERJ1xWqiInGEf2ulJW
 7BLg==
X-Gm-Message-State: AFuF++kXdbRKdaLKM2WOJ80X+60pz78E/fUtQ99S/iGEEeXQQgxrW9LI
 JfJFulGMyqTwN2RwP2r1vQGCxKKD0y3gdUePdoQe1HPLe6eiaziRlkV9lToCxmkwqjOhvFUmE02
 bHlMA
X-Gm-Gg: AR+sD10lZ0p1YoE8kiVen/X6FtAgz2NTCOm0tsW79AXfUpPJnFweQXNTRmJnpK+XMRY
 ABHi5oU+bK4c3xIfXXtvXDytlSXZZjPzHZ42Y+BdXdxTAjZBUPeyz4RFf1+FNPxvbDN2B8LNptB
 SWvNHFD04bVV3x5PzJpNVMMWv3cFW+d6z0C2b9WC2SxGLJPf7vTYRO9PGIl4PWzj8KEJcZSpUfr
 nRxok6Y/pMH2d6JW5+tc50MZgHuXaTYgBkOTm4RxL1Upw1NGC9GC/Zl7DOFWnm5kVkgNJECrSpm
 RyM7y9xcaAjzQiEfMOm2bXXXfT9HmTHkdhlGFrv/eRalAlxNSK19G2iucyEEnboo/STxMzV7O8A
 c7SjqAZQDKhfefK6wsnl41ibQRDvGwTuqduPJ8D/Z5CGJ6cKVelxaNoIlXA9LnOGOFOty6VcTOf
 /FnV6bubCAIHPcb18VeydeBtIryxomRkS22UX9vxTQ4GhlC6igv+bnhhJTJZ73AyCirs1MoCPyI
 TKj8YKcz1PKqrIP4Pk9ajAYMBQ=
X-Received: by 2002:a05:6a00:6f12:b0:857:7317:cff8 with SMTP id
 d2e1a72fcca58-8577317d1c7mr17631170b3a.25.1788117238138; 
 Sun, 30 Aug 2026 12:13:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a2ea718asm2538710b3a.33.2026.08.30.12.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 12:13:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH] test/bpf: use unit test suite
Date: Sun, 30 Aug 2026 12:13:49 -0700
Message-ID: <20260830191349.604934-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The BPF tests registered 23 separate autotests. Collapse them into a
single bpf_autotest suite run by unit_test_suite_runner().

Rename the old table-driven test_bpf() to test_bpf_progs() so that
test_bpf() can be the suite entry point.

Move the #endif of the RTE_LIB_BPF guard to the end of the file. It
closed mid-file, leaving the stack, ELF, convert and atomic tests
outside the guard even though they all call rte_bpf functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 86 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index d85e64e7fb..7f235720e7 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -27,6 +27,8 @@ test_bpf(void)
 	return TEST_SKIPPED;
 }
 
+REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
+
 #else
 
 #include <rte_bpf.h>
@@ -92,7 +94,6 @@ test_no_instructions(void)
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
-REGISTER_FAST_TEST(bpf_no_instructions_autotest, NOHUGE_OK, ASAN_OK, test_no_instructions);
 
 /*
  * Try and load a BPF program comprising single EXIT instruction.
@@ -109,7 +110,6 @@ test_exit_only(void)
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
-REGISTER_FAST_TEST(bpf_exit_only_autotest, NOHUGE_OK, ASAN_OK, test_exit_only);
 
 /*
  * Try and load a BPF program with no EXIT instruction.
@@ -129,7 +129,6 @@ test_no_exit(void)
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
-REGISTER_FAST_TEST(bpf_no_exit_autotest, NOHUGE_OK, ASAN_OK, test_no_exit);
 
 /*
  * Try and load smallest possible valid BPF program.
@@ -151,7 +150,6 @@ test_minimal_working(void)
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
 }
 
-REGISTER_FAST_TEST(bpf_minimal_working_autotest, NOHUGE_OK, ASAN_OK, test_minimal_working);
 
 /*
  * Try and load valid BPF program adding one to the argument.
@@ -179,7 +177,6 @@ test_add_one(void)
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
 }
 
-REGISTER_FAST_TEST(bpf_add_one_autotest, NOHUGE_OK, ASAN_OK, test_add_one);
 
 /*
  * Try and load valid BPF program subtracting one from the argument.
@@ -207,7 +204,6 @@ test_subtract_one(void)
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
 }
 
-REGISTER_FAST_TEST(bpf_subtract_one_autotest, NOHUGE_OK, ASAN_OK, test_subtract_one);
 
 /*
  * Conditionally jump over invalid operation as first instruction.
@@ -243,8 +239,6 @@ test_jump_over_invalid_first(void)
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
-REGISTER_FAST_TEST(bpf_jump_over_invalid_first_autotest, NOHUGE_OK, ASAN_OK,
-	test_jump_over_invalid_first);
 
 /*
  * Conditionally jump over invalid operation as non-first instruction.
@@ -286,8 +280,6 @@ test_jump_over_invalid_non_first(void)
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
-REGISTER_FAST_TEST(bpf_jump_over_invalid_non_first_autotest, NOHUGE_OK, ASAN_OK,
-	test_jump_over_invalid_non_first);
 
 /*
  * Basic functional tests for librte_bpf.
@@ -3796,7 +3788,6 @@ test_bpf_load_null(void)
 
 	return 0;
 }
-REGISTER_FAST_TEST(bpf_load_null_autotest, NOHUGE_OK, ASAN_OK, test_bpf_load_null);
 
 /* Test calling wrong API for execution of a multi-argument eBPF program. */
 static int
@@ -3837,8 +3828,6 @@ test_bpf_exec_wrong_nb_prog_arg(void)
 
 	return 0;
 }
-REGISTER_FAST_TEST(bpf_exec_wrong_nb_prog_arg_autotest, NOHUGE_OK, ASAN_OK,
-		test_bpf_exec_wrong_nb_prog_arg);
 
 /* Test passing unsupported flags when executing an eBPF program. */
 static int
@@ -3876,10 +3865,9 @@ test_bpf_exec_wrong_flags(void)
 
 	return 0;
 }
-REGISTER_FAST_TEST(bpf_exec_wrong_flags_autotest, NOHUGE_OK, ASAN_OK, test_bpf_exec_wrong_flags);
 
 static int
-test_bpf(void)
+test_bpf_progs(void)
 {
 	int32_t rc, rv;
 	uint32_t i;
@@ -3894,10 +3882,6 @@ test_bpf(void)
 	return rc;
 }
 
-#endif /* !RTE_LIB_BPF */
-
-REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
-
 /* Tests of BPF JIT stack alignment when calling external functions (xfuncs). */
 
 /* Function called from the BPF program in a test. */
@@ -4010,7 +3994,6 @@ test_stack_alignment(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_stack_alignment_autotest, NOHUGE_OK, ASAN_OK, test_stack_alignment);
 
 /*
  * Test copying `__uint128_t`.
@@ -4066,7 +4049,6 @@ test_stack_copy_uint128(void)
 
 #endif
 
-REGISTER_FAST_TEST(bpf_stack_copy_uint128_autotest, NOHUGE_OK, ASAN_OK, test_stack_copy_uint128);
 
 /*
  * Test SSE2 load and store intrinsics.
@@ -4152,7 +4134,6 @@ test_stack_sse2(void)
 
 #endif
 
-REGISTER_FAST_TEST(bpf_stack_sse2_autotest, NOHUGE_OK, ASAN_OK, test_stack_sse2);
 
 /*
  * Run memcpy and rte_memcpy with various data sizes and offsets (unaligned and aligned).
@@ -4285,7 +4266,6 @@ test_stack_memcpy(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_stack_memcpy_autotest, NOHUGE_OK, ASAN_OK, test_stack_memcpy);
 
 /*
  * The BPF elf load test needs the BPF programs to be successfully
@@ -4801,7 +4781,6 @@ test_bpf_elf(void)
 
 #endif /* !(TEST_BPF_ELF_LOAD && RTE_NULL) */
 
-REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK, test_bpf_elf);
 
 #ifndef RTE_HAS_LIBPCAP
 
@@ -5087,7 +5066,6 @@ test_bpf_convert(void)
 
 #endif /* RTE_HAS_LIBPCAP */
 
-REGISTER_FAST_TEST(bpf_convert_autotest, NOHUGE_OK, ASAN_OK, test_bpf_convert);
 
 /*
  * Tests of BPF atomic instructions.
@@ -5244,7 +5222,6 @@ test_xadd32(void)
 	return run_xchg_test(RTE_DIM(ins), ins, expected);
 }
 
-REGISTER_FAST_TEST(bpf_xadd32_autotest, NOHUGE_OK, ASAN_OK, test_xadd32);
 
 /*
  * Test 64-bit XADD.
@@ -5313,7 +5290,6 @@ test_xadd64(void)
 	return run_xchg_test(RTE_DIM(ins), ins, expected);
 }
 
-REGISTER_FAST_TEST(bpf_xadd64_autotest, NOHUGE_OK, ASAN_OK, test_xadd64);
 
 /*
  * Test 32-bit XCHG.
@@ -5408,7 +5384,6 @@ test_xchg32(void)
 	return run_xchg_test(RTE_DIM(ins), ins, expected);
 }
 
-REGISTER_FAST_TEST(bpf_xchg32_autotest, NOHUGE_OK, ASAN_OK, test_xchg32);
 
 /*
  * Test 64-bit XCHG.
@@ -5473,7 +5448,6 @@ test_xchg64(void)
 	return run_xchg_test(RTE_DIM(ins), ins, expected);
 }
 
-REGISTER_FAST_TEST(bpf_xchg64_autotest, NOHUGE_OK, ASAN_OK, test_xchg64);
 
 /*
  * Test invalid and unsupported atomic imm values (also valid ones for control).
@@ -5546,4 +5520,56 @@ test_atomic_imms(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_atomic_imms_autotest, NOHUGE_OK, ASAN_OK, test_atomic_imms);
+static struct unit_test_suite test_bpf_suite = {
+	.suite_name = "BPF Unit Test Suite",
+	.unit_test_cases = {
+		/* Loading of the most simple programs. */
+		TEST_CASE(test_no_instructions),
+		TEST_CASE(test_exit_only),
+		TEST_CASE(test_no_exit),
+		TEST_CASE(test_minimal_working),
+		TEST_CASE(test_add_one),
+		TEST_CASE(test_subtract_one),
+		TEST_CASE(test_jump_over_invalid_first),
+		TEST_CASE(test_jump_over_invalid_non_first),
+
+		/* API misuse. */
+		TEST_CASE(test_bpf_load_null),
+		TEST_CASE(test_bpf_exec_wrong_nb_prog_arg),
+		TEST_CASE(test_bpf_exec_wrong_flags),
+
+		/* Execution of the programs in the tests[] table. */
+		TEST_CASE(test_bpf_progs),
+
+		/* JIT stack alignment when calling external functions. */
+		TEST_CASE(test_stack_alignment),
+		TEST_CASE(test_stack_copy_uint128),
+		TEST_CASE(test_stack_sse2),
+		TEST_CASE(test_stack_memcpy),
+
+		/* Loading of programs from ELF objects. */
+		TEST_CASE(test_bpf_elf),
+
+		/* Conversion of cBPF programs. */
+		TEST_CASE(test_bpf_convert),
+
+		/* Atomic instructions. */
+		TEST_CASE(test_xadd32),
+		TEST_CASE(test_xadd64),
+		TEST_CASE(test_xchg32),
+		TEST_CASE(test_xchg64),
+		TEST_CASE(test_atomic_imms),
+
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_bpf(void)
+{
+	return unit_test_suite_runner(&test_bpf_suite);
+}
+
+REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
+
+#endif /* !RTE_LIB_BPF */
-- 
2.53.0

