Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B49C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 13:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC9E940041;
	Thu, 20 Feb 2025 14:16:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C24754003C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740057406; x=1771593406;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MtS8Y88pKGY+hd8je3nFO88cNRxkQvf59FDS8SZYH1Q=;
 b=Y1tRJk4ag+nK2+g4BaiqlGNKEgMWjrPHaThbfRv6q//j11tK2bSV6wTI
 Aep/TEhuo3NBV8TavatMSU+QnADvYTndLBULtLTN/URLmHzPTS67DjxxK
 uzuoUvbMOdYjUK9I0R8CvTDPqh/U1hIU0jI2hDCSeT/f07iwNooR2vccQ
 CmyFaOPNXtjfrQjPUV04gQrw7QcZycTCvy7TFbOVtV+NuUCK6iBV8k9Sm
 kZPVTVr+JhsCnYQfxiJu3fdcLW9suHPWI3dE8W+TZJwyVD6w5qFS0ks4h
 eI7HXC5/k/HDIAhI1PWLx5JZa86pRSza2HA4ttro0F9A221w2riblMpP2 w==;
X-CSE-ConnectionGUID: JT3UqjA9SyypEUBef2Qo6A==
X-CSE-MsgGUID: OMufnoVdTMejUf5kt5o0aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44751051"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="44751051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 05:16:45 -0800
X-CSE-ConnectionGUID: DMuLX2cMRkin/BVoKQCAHg==
X-CSE-MsgGUID: KrPzYX/5Q/C7kYpcua1c0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="152234249"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 05:16:43 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 1/3] fbarray: rename tests to be more meaningful
Date: Thu, 20 Feb 2025 13:16:38 +0000
Message-ID: <602f4e304295ed06a999c93f70096dd5d4c0cba8.1740057387.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <47e02f706d284a2e2a49db51ce75081e62aee393.1724405387.git.anatoly.burakov@intel.com>
References: <47e02f706d284a2e2a49db51ce75081e62aee393.1724405387.git.anatoly.burakov@intel.com>
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

Some tests reference internal implementation details of fbarray, as well
as equivocate between mask and index. Most other test names are not
very descriptive. Rename them, and adjust comments to explain things
in terms of what the tests actually do, instead of referring to internal
implementation details.

Also, add more tests that fill up exactly one mask, with and without
neighbouring set bits.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_fbarray.c | 99 ++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 32 deletions(-)

diff --git a/app/test/test_fbarray.c b/app/test/test_fbarray.c
index 09f6907fb1..6ca509b898 100644
--- a/app/test/test_fbarray.c
+++ b/app/test/test_fbarray.c
@@ -104,7 +104,7 @@ static int first_msk_test_setup(void)
 	return init_aligned();
 }
 
-static int cross_msk_test_setup(void)
+static int contig_test_setup(void)
 {
 	/* put all within second and third mask */
 	param.start = 70;
@@ -112,7 +112,7 @@ static int cross_msk_test_setup(void)
 	return init_aligned();
 }
 
-static int multi_msk_test_setup(void)
+static int large_contig_test_setup(void)
 {
 	/* put all within first and last mask */
 	param.start = 3;
@@ -128,15 +128,39 @@ static int last_msk_test_setup(void)
 	return init_aligned();
 }
 
+static int full_index_test_setup(void)
+{
+	/* fill entire index */
+	param.start = 0;
+	param.end = FBARRAY_TEST_LEN - 1;
+	return init_aligned();
+}
+
 static int full_msk_test_setup(void)
 {
-	/* fill entire mask */
+	/* fill one mask */
 	param.start = 0;
-	param.end = FBARRAY_TEST_LEN - 1;
+	param.end = 63;
 	return init_aligned();
 }
 
-static int lookahead_test_setup(void)
+static int full_msk_contig_fwd_test_setup(void)
+{
+	/* fill one mask plus one item */
+	param.start = 64;
+	param.end = 128;
+	return init_aligned();
+}
+
+static int full_msk_contig_rev_test_setup(void)
+{
+	/* fill one mask plus one item */
+	param.start = 63;
+	param.end = 127;
+	return init_aligned();
+}
+
+static int cross_msk_test_setup(void)
 {
 	/* set index 64 as used */
 	param.start = 64;
@@ -144,7 +168,7 @@ static int lookahead_test_setup(void)
 	return init_aligned();
 }
 
-static int lookbehind_test_setup(void)
+static int cross_msk_rev_test_setup(void)
 {
 	/* set index 63 as used */
 	param.start = 63;
@@ -160,6 +184,13 @@ static int unaligned_test_setup(void)
 	return init_unaligned();
 }
 
+static int full_unaligned_test_setup(void)
+{
+	unaligned.start = 0;
+	unaligned.end = FBARRAY_UNALIGNED_TEST_LEN - 1;
+	return init_unaligned();
+}
+
 static int test_invalid(void)
 {
 	struct rte_fbarray dummy;
@@ -786,7 +817,7 @@ static int test_empty(void)
 	return TEST_SUCCESS;
 }
 
-static int test_lookahead(void)
+static int test_cross_msk(void)
 {
 	int ret;
 
@@ -801,7 +832,7 @@ static int test_lookahead(void)
 	return TEST_SUCCESS;
 }
 
-static int test_lookbehind(void)
+static int test_cross_rev_msk(void)
 {
 	int ret, free_len = 2;
 
@@ -816,19 +847,19 @@ static int test_lookbehind(void)
 	return TEST_SUCCESS;
 }
 
-static int test_lookahead_mask(void)
+static int test_broken_run(void)
 {
 	/*
-	 * There is a certain type of lookahead behavior we want to test here,
-	 * namely masking of bits that were scanned with lookahead but that we
-	 * know do not match our criteria. This is achieved in following steps:
+	 * There is a certain type of search behavior we want to test here,
+	 * namely starting cross-mask runs and failing to find them. This is
+	 * achieved when these conditions happen:
 	 *
 	 *   0. Look for a big enough chunk of free space (say, 62 elements)
-	 *   1. Trigger lookahead by breaking a run somewhere inside mask 0
-	 *      (indices 0-63)
-	 *   2. Fail lookahead by breaking the run somewhere inside mask 1
-	 *      (indices 64-127)
-	 *   3. Ensure that we can still find free space in mask 1 afterwards
+	 *   1. Break a run somewhere inside mask 0 (indices 0-63) but leave
+	 *      some free elements at the end of mask 0 to start a run
+	 *   2. Break the run somewhere inside mask 1 (indices 64-127)
+	 *   3. Ensure that we can still find a free space run right after the
+	 *      second broken run
 	 */
 
 	/* break run on first mask */
@@ -842,19 +873,19 @@ static int test_lookahead_mask(void)
 	return TEST_SUCCESS;
 }
 
-static int test_lookbehind_mask(void)
+static int test_rev_broken_run(void)
 {
 	/*
-	 * There is a certain type of lookbehind behavior we want to test here,
-	 * namely masking of bits that were scanned with lookbehind but that we
-	 * know do not match our criteria. This is achieved in two steps:
+	 * There is a certain type of search behavior we want to test here,
+	 * namely starting cross-mask runs and failing to find them. This is
+	 * achieved when these conditions happen:
 	 *
 	 *   0. Look for a big enough chunk of free space (say, 62 elements)
-	 *   1. Trigger lookbehind by breaking a run somewhere inside mask 2
-	 *      (indices 128-191)
-	 *   2. Fail lookbehind by breaking the run somewhere inside mask 1
-	 *      (indices 64-127)
-	 *   3. Ensure that we can still find free space in mask 1 afterwards
+	 *   1. Break a run somewhere inside mask 2 (indices 128-191) but leave
+	 *      some free elements at the beginning of mask 2 to start a run
+	 *   2. Break the run somewhere inside mask 1 (indices 64-127)
+	 *   3. Ensure that we can still find free space N elements down from
+	 *      our last broken run (inside mask 0 in this case)
 	 */
 
 	/* break run on mask 2 */
@@ -876,18 +907,22 @@ static struct unit_test_suite fbarray_test_suite = {
 		TEST_CASE(test_invalid),
 		TEST_CASE(test_basic),
 		TEST_CASE_ST(first_msk_test_setup, reset_aligned, test_find),
-		TEST_CASE_ST(cross_msk_test_setup, reset_aligned, test_find),
-		TEST_CASE_ST(multi_msk_test_setup, reset_aligned, test_find),
+		TEST_CASE_ST(contig_test_setup, reset_aligned, test_find),
+		TEST_CASE_ST(large_contig_test_setup, reset_aligned, test_find),
 		TEST_CASE_ST(last_msk_test_setup, reset_aligned, test_find),
 		TEST_CASE_ST(full_msk_test_setup, reset_aligned, test_find),
+		TEST_CASE_ST(full_msk_contig_fwd_test_setup, reset_aligned, test_find),
+		TEST_CASE_ST(full_msk_contig_rev_test_setup, reset_aligned, test_find),
+		TEST_CASE_ST(full_index_test_setup, reset_aligned, test_find),
 		/* empty test does not need setup */
 		TEST_CASE_ST(NULL, reset_aligned, test_empty),
-		TEST_CASE_ST(lookahead_test_setup, reset_aligned, test_lookahead),
-		TEST_CASE_ST(lookbehind_test_setup, reset_aligned, test_lookbehind),
+		TEST_CASE_ST(cross_msk_test_setup, reset_aligned, test_cross_msk),
+		TEST_CASE_ST(cross_msk_rev_test_setup, reset_aligned, test_cross_rev_msk),
 		/* setup for these tests is more complex so do it in test func */
-		TEST_CASE_ST(NULL, reset_aligned, test_lookahead_mask),
-		TEST_CASE_ST(NULL, reset_aligned, test_lookbehind_mask),
+		TEST_CASE_ST(NULL, reset_aligned, test_broken_run),
+		TEST_CASE_ST(NULL, reset_aligned, test_rev_broken_run),
 		TEST_CASE_ST(unaligned_test_setup, reset_unaligned, test_find_unaligned),
+		TEST_CASE_ST(full_unaligned_test_setup, reset_unaligned, test_find_unaligned),
 		TEST_CASES_END()
 	}
 };
-- 
2.43.5

