Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9688C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 08:06:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FDB1402D0;
	Mon, 28 Jul 2025 10:06:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 66DFA400D5
 for <dev@dpdk.org>; Mon, 28 Jul 2025 10:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753689997; x=1785225997;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XjcRvxKCR/9Q9TgzI+RjXii5AqJpbAknWQykQ7uRXVA=;
 b=bLUWKdLe1CI+Dq3cPs943PzURyQhbj1iz+9tKgS4JPqJlP4RVsXOF46P
 bMCoxc5kefBfiIwS2mIP3iA/zm1vRI91O1MYZFFMPZAn0st5mt0sYNgJt
 TAMEXj0QXh40b9eUOTrCSAexCq6GPDiUoeD1qTKKvWo4WtUUW4AAf2H93
 hvBUZs1ka5dO599hZxqiXSa9zaCyLXl+GTs1+69VYcrcsTToowlz2hojY
 zxCAr9nGWgmIRbLuu/8DMHAPK8cm2e7ZvxTyo/TONtc6C8vdTPpzW9S+2
 JNeue0M70fIefwRw/Z8sjZyMq3tBQpw3T1WlM2bSKpRx10T+AyZ0DEB0Y Q==;
X-CSE-ConnectionGUID: JqFpFZJFT8iPOjtd0BpBBw==
X-CSE-MsgGUID: j24TkTO7Q0uutXDxJnoPVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="78480890"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="78480890"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 01:06:25 -0700
X-CSE-ConnectionGUID: PSXPr5Y8SGyWiaz+IBgT+w==
X-CSE-MsgGUID: eHQZ4TUQSpaAgNHTc5wZ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="166552158"
Received: from silpixa00401454.ir.intel.com ([10.237.213.198])
 by orviesa003.jf.intel.com with ESMTP; 28 Jul 2025 01:06:23 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH] app/crypto-perf: Only run AEAD decrypt with valid test vector
 file.
Date: Mon, 28 Jul 2025 08:06:21 +0000
Message-Id: <20250728080621.1241228-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.34.1
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

The test dummy vector data is incorrect for AEAD decryption, so we should
only run when passed a valid test vector file. This patch also moves the
check for correct test vector data to after the vector has been
populated by test vector file or dummy data.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test-crypto-perf/cperf_options_parsing.c | 19 +++++++++++++++++--
 app/test-crypto-perf/main.c                  | 12 ++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 0e0dc4fd06..12623e4cfe 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1482,11 +1482,26 @@ cperf_options_check(struct cperf_options *options)
 		}
 	}
 
-	if (options->test == CPERF_TEST_TYPE_THROUGHPUT &&
+	if ((options->test == CPERF_TEST_TYPE_THROUGHPUT ||
+	    options->test == CPERF_TEST_TYPE_LATENCY) &&
 	    (options->aead_op == RTE_CRYPTO_AEAD_OP_DECRYPT ||
 	     options->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY) &&
 	    !options->out_of_place) {
-		RTE_LOG(ERR, USER1, "Only out-of-place is allowed in throughput decryption.\n");
+		RTE_LOG(ERR, USER1, "Only out-of-place is allowed in throughput and"
+			    " latency decryption.\n");
+		return -EINVAL;
+	}
+
+	if ((options->test == CPERF_TEST_TYPE_THROUGHPUT ||
+		 options->test == CPERF_TEST_TYPE_LATENCY) &&
+	    (options->aead_op == RTE_CRYPTO_AEAD_OP_DECRYPT ||
+	     options->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY) &&
+		 options->test_name == NULL &&
+		 options->test_file == NULL) {
+		RTE_LOG(ERR, USER1, "Define path to the file with test"
+				" vectors.\n");
+		RTE_LOG(ERR, USER1, "Define test name to get the correct digest"
+				" from the test vectors.\n");
 		return -EINVAL;
 	}
 
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 2e38c0011d..ef3c71b492 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -731,12 +731,6 @@ main(int argc, char **argv)
 					" specified file\n");
 			goto err;
 		}
-
-		if (cperf_check_test_vector(&opts, t_vec)) {
-			RTE_LOG(ERR, USER1, "Incomplete necessary test vectors"
-					"\n");
-			goto err;
-		}
 	} else {
 		t_vec = cperf_test_vector_get_dummy(&opts);
 		if (t_vec == NULL) {
@@ -746,6 +740,12 @@ main(int argc, char **argv)
 			goto err;
 		}
 	}
+	/* Add check for test vector data after dummy and file option. */
+	if (cperf_check_test_vector(&opts, t_vec)) {
+		RTE_LOG(ERR, USER1, "Incomplete necessary test vectors"
+				"\n");
+		goto err;
+	}
 
 	ret = cperf_get_op_functions(&opts, &op_fns);
 	if (ret) {
-- 
2.34.1

