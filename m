Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE1C83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 09:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1580740668;
	Tue, 29 Jul 2025 11:50:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 41B0C40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 11:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753782650; x=1785318650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9lzJ4sRZ2aXYEs5MGmJNMRN6qUZzXJhcVR4/dyvo4PA=;
 b=ajpJm0B6xTBOhzMe+qmU/gEcoh0gSAk7R+E092Ype6DHv8ND4Us4Dsr9
 OYLgsBKuC1FfCM8ZlAGTQdOZQWRxyJfjcKt2Zdc3DPLzPBLhE4cfxnDil
 3zDGKaRU1Xvgds7vvHzvWxxDNbL72MvSDD1EE/LnIrNg26CpvNaqhBTfS
 l4G2UzlC2OoX24WQMxxjYQxc98donOr0CdYWW0UiT2k83GWD9YTbV0wwa
 wdXWfMdwQuopNRuAA9O5ig6cgN9QcBLXer+ysfGLP1Kslh6rlAcGHrHBx
 3OzvobndjvUzq6JKHtimfGSUVAnCV9X+sYNF2lTiGPPDyh32qPqQXL7NG w==;
X-CSE-ConnectionGUID: irDm7r8QRMGazWEzvmV6Wg==
X-CSE-MsgGUID: ZUFoHZuLQZKPzQIWYI5LOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67400721"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="67400721"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:50:49 -0700
X-CSE-ConnectionGUID: +lGvPBERTXadHQJal0rAuA==
X-CSE-MsgGUID: zES6rxqASIKsXOyEYPA6Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="161922802"
Received: from silpixa00401454.ir.intel.com ([10.237.213.198])
 by orviesa010.jf.intel.com with ESMTP; 29 Jul 2025 02:50:48 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] app/crypto-perf: Only run AEAD decrypt with valid test vector
 file.
Date: Tue, 29 Jul 2025 09:50:45 +0000
Message-Id: <20250729095045.1293981-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728080621.1241228-1-emma.finn@intel.com>
References: <20250728080621.1241228-1-emma.finn@intel.com>
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
only run when passed a valid test vector file.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test-crypto-perf/cperf_options_parsing.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

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
 
-- 
2.34.1

