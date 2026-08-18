Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1445C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D8A54067C;
	Tue, 18 Aug 2026 15:33:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CA1EC40269;
 Tue, 18 Aug 2026 15:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060026; x=1818596026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ms8UlimF8SjOk1j88k4seqVcnRTZUzxL/ikwNXfRiV4=;
 b=XQcUoxcXjYQz8AvBd5rNMyg+pA3B8nU6oc75QlD30uW5XVg9fXe21SsD
 Ehp27zRztB1HZ7xBCnb2WHSnBS9KEUAau8Jh4aFQjlBZv9toZV3ywZFVn
 TVTlUIAweVhfgmCNFM0xtonibaFHmM/SR1wia4c2g9t4s/9h3YAvbeBqd
 dfZo7W4H6PWC5A1E4XahQ8dRnTabwEmE/Bhn2J5jjS0h9oJDqvbkF/fYE
 Vj+kLRiGP+zb9PsXa9AzaLmsK0cptiaThxtCFv9giTpc1IMLDPPft+AnC
 bwx+xC8/EzB6hQv8E0MLWDi4xFx/Gld23q81pt+6G2aKwfrdozZ9aaCsj w==;
X-CSE-ConnectionGUID: H1a59pjPTTyLuMUdRUdFIA==
X-CSE-MsgGUID: Jakvo+iQSYWpMW2FVAkKAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757582"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757582"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:44 -0700
X-CSE-ConnectionGUID: 9ydZiQIFSGC7aTGr8SfjYg==
X-CSE-MsgGUID: ps0MOsFGS4mYOrf5OIVWXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736531"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 02/39] argparse: check for range overflow in CPU lists
Date: Tue, 18 Aug 2026 14:32:55 +0100
Message-ID: <20260818133334.2620165-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

Fixes: d78103fb9488 ("argparse: support core lists")
Cc: stable@dpdk.org

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

