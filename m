Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42493606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dQtPXZiv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 322864067A;
	Thu, 26 Nov 2026 19:14:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 0A65C40430;
 Thu, 26 Nov 2026 19:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716865; x=1827252865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ahLA0EgR9gO1VvBd4ppAkQTtXU/4KTy59TWtcbFSNRc=;
 b=dQtPXZiv6DEdUYSDYMxsMElPA59TZTJyUr6vWNlEArIpD+YyVC/ayk6j
 4C2riyqBtSMqvpN5DRm+YdsjFJKZ60pi19flESH9pOpA91muXoWc9HtiH
 TSt+jEf+xs8FNMSxdUELvA7yfDwOiSdujoRsTjsv6VOdTUNIF9EOljSRQ
 aE6vdavfMpi+GP3Wf4wBNE+otfES6oMGDueGPI88k2MHwWvAiRmj42idF
 4/3s7llsOu00wP27Rz0O7KAlVhhItqdPYZREGE687HQaGjwDNRi46iR9g
 ox9+s8L+ZrXK5hZACAqtAzQJkkzgs+6C391EmZ2RtLe2yVUTjMVyZDWag w==;
X-CSE-ConnectionGUID: 22AQaB7EQWyABJlOg0FDuA==
X-CSE-MsgGUID: vg8tFD8SQkSGNTZ61QHQyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633541"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:20 -0800
X-CSE-ConnectionGUID: YxcyKaMiRmiR6DQix4ynPw==
X-CSE-MsgGUID: pRgdpjP1QQiCXNpiKzwNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732842"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3 02/39] argparse: check for range overflow in CPU lists
Date: Thu, 26 Nov 2026 18:13:35 +0000
Message-ID: <20261126181414.124094-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.55.0

