Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B29C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E53F40658;
	Tue, 21 Jul 2026 11:46:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 29A31402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627164; x=1816163164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TYLfB3VmLuqbaFLFW8MZLT7BfdaYFTZKeErJsXJo5/k=;
 b=UjeTd3Ljd2mvXaWr53hSBHzhLgUmpDLzxXknvxp+iPAluNruNr9fyfIK
 QFtIvSUfqSwtjX4jVrrlizlnbcT6KxTjLtc83qzhHp8X9JmWBTVaD5uNm
 W3MuYlLZkQyOhyjiGY+lqz6c1FSg2awRRdKMnzQ67WZvj+MBVMPypUldH
 HaZV/fGFsHW0H92XVTJ8DxIK6VvpsxoFmpzPus0t1gv++bKv8ei6lPfnq
 rqwjKEarrAB5nnqtsGW2tXinirVAwaRlaJHaYFokSc/0/57bKtEASJOn9
 BUbqAJGFGBNsCWuGjvmF4iOTqCRO7CcnPlpgkNIsVgQ7HFDwDMX++O/v1 Q==;
X-CSE-ConnectionGUID: iZ+wgV+RR3KQSXr/aw6L4g==
X-CSE-MsgGUID: Ay+UjaG7RsiYHI50YlWrSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872415"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:02 -0700
X-CSE-ConnectionGUID: saVUnsccQdagAtaAJc9oQg==
X-CSE-MsgGUID: iewOzdxGTaanxQqKT9y/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922219"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 02/39] argparse: check for range overflow in CPU lists
Date: Tue, 21 Jul 2026 10:45:10 +0100
Message-ID: <20260721094555.2188496-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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

The rte_cpuset_t type cannot handle core ids greater than CPU_SETSIZE
Add an explicit check for out of range values when processes a corelist.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c    | 10 ++++++++++
 lib/argparse/rte_argparse.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index fdc6dd113c..318f8df9fb 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -834,9 +834,13 @@ test_argparse_parse_type_corelist(void)
 	char *corelist_invalid_special_chars = test_strdup("1,2@3");
 	char *corelist_invalid_comma_only = test_strdup(",");
 	char *corelist_invalid_out_of_range = test_strdup("70000");
+	char corelist_invalid_cpu_set[32];
 	rte_cpuset_t val_cpuset;
 	int ret;
 
+	snprintf(corelist_invalid_cpu_set, sizeof(corelist_invalid_cpu_set),
+		"0-%d", CPU_SETSIZE);
+
 	/* test valid single core */
 	CPU_ZERO(&val_cpuset);
 	ret = rte_argparse_parse_type(corelist_valid_single,
@@ -966,6 +970,12 @@ test_argparse_parse_type_corelist(void)
 			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
 	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (out of range) should have failed!");
 
+	/* test invalid corelist that exceeds the destination CPU set */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_cpu_set,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist outside CPU set should have failed!");
+
 	return 0;
 }
 
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 88c3e7740c..158c413bdc 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -623,6 +623,11 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 				/* range from low to high */
 				max = idx;
 			}
+			if (max >= CPU_SETSIZE) {
+				ARGPARSE_LOG(ERR, "argument %s contains a core outside the CPU set range!",
+					arg->name_long);
+				return -EINVAL;
+			}
 
 			for (; min <= max; min++)
 				CPU_SET(min, cpuset);
-- 
2.53.0

