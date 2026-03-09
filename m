Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A5AEFCD7C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B191F40281;
	Mon,  9 Mar 2026 11:10:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7A6CD40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 11:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773051037; x=1804587037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Moe1brBo2EatZnl4sPbky7ElUAUKCgFIBxhCTaslVJQ=;
 b=CQc3DlWN94P38xq9sfYswH59jA14AicbNEdtB+5VP7gaEa+Q1Cl7jjuU
 4LEpFuSuVtu3SgKZW5jhS4i0sV0B+/bNtIyUYP38pBXXEDFfQHHHVdfpb
 bg8X5BKel0tPnsIgQz8ZbOIAmwoGoyyE1NOqVGuhI6/oB7dqvpPdC8Jz6
 14CEM86E2Bta/4EagYJOWy8uE2ZGwVhsnOibV5auD5pjQGRSuwTNXMDMq
 fqQJvVgS5As39Qr4cdu4z2bMcbRLTSqDccVqYRCEj+ka4pgat5x5f+45p
 pOrhU0obR5zhWIFw9/CzlRMJlkf5QmvOFWGH3iDl2I4nuTrFr4U5dZK8p g==;
X-CSE-ConnectionGUID: 4LjdDS9oSsiYhNpcy53MZA==
X-CSE-MsgGUID: MM1NOsPiTzyStqg5OG9DXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74148939"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74148939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 03:10:36 -0700
X-CSE-ConnectionGUID: 7uv24RG0QIqW5WCWi8vJPA==
X-CSE-MsgGUID: nbJXll1TS5uXZs0T50k15A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="224160118"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa004.jf.intel.com with ESMTP; 09 Mar 2026 03:10:36 -0700
From: Emma Finn <emma.finn@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] examples/fips_validation: fix dangling pointer for SHA and SHAKE
 test
Date: Mon,  9 Mar 2026 10:10:25 +0000
Message-ID: <20260309101025.958736-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828092822.2791101-1-emma.finn@intel.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
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

Set vector pointer to NULL after free to avoid calling rte_free()
on the same pointer twice in some cases.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* add fix to mct_shake_test
---
 examples/fips_validation/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index daf273bc85..2b6d55aa51 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -2610,7 +2610,7 @@ fips_mct_sha_test(void)
 		rte_free(md[i].val);
 
 	rte_free(vec.pt.val);
-
+	vec.pt.val = NULL;
 	rte_free(val.val);
 	return 0;
 }
@@ -2698,6 +2698,7 @@ fips_mct_shake_test(void)
 
 	rte_free(md.val);
 	rte_free(vec.pt.val);
+	vec.pt.val = NULL;
 	rte_free(val.val);
 	return 0;
 }
-- 
2.43.0

