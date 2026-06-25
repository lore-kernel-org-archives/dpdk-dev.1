Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD70CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9DD840DCF;
	Thu, 25 Jun 2026 17:48:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A703940B9B
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782402501; x=1813938501;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xQWVbgi/7v0UWFaB+fYWzmmck7L+3foxRoVSe5vE/c0=;
 b=lqsYTk1E7tyLKc1F0+lqbM09u3C+MmALin1fg0hpC5K2tThFiDQAXjKw
 EIzKyg/2hNrCSAHXlF/h5udQ90mo6Y9bIqssTG0xIFF/JfhSYFvdO9BEL
 9/aXXC930CNLSUPA6WK7pVUUsjwOgRdv/HYQ+v6MW2oixwCfagWSQoR2G
 MOgMpwLCdMXjbE1+Oww6DwAtktwMQv1MBxVO+RkurSuBwImQ9w0yf1rke
 nfxLsWh3gSByDDK6KHFuD6j2jGj9gb3hYSTUtYXzsDAZJmzU8kboWoGjI
 JLFteqBEZjj/8vvzzQKNB9jxN78gcRE/wbumJEyK4Z9yID3bZRF8qQ1ih Q==;
X-CSE-ConnectionGUID: vT+lXQZIQVekJq/8JFETcA==
X-CSE-MsgGUID: tDliU9tUQDG7uBIHf0bApw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83279881"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83279881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:48:20 -0700
X-CSE-ConnectionGUID: X//ipGwjR0+2cMBwgfTP8Q==
X-CSE-MsgGUID: eT0P7udcTp2FB1g0GS4fkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="247571052"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2026 08:48:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 4/4] net/iavf: fix potential NULL dereference
Date: Thu, 25 Jun 2026 16:48:13 +0100
Message-ID: <1a5ce2f876f5f707fd36eb3117486d326e6ce827.1782402484.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
References: 
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

Static analysis reports that a rule might have a valid engine but invalid
rule pointer while having a valid rule size. This should not happen in
normal operation, but it's a good defensive check, so fix the potential
issue by checking for the problematic condition before dumping flow memory.

Coverity issue: 503764

Fixes: 32251f047e92 ("net/iavf: support flow dump")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 23 ++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 8bd874c32a..84bb161bd1 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2414,18 +2414,21 @@ iavf_flow_dev_dump(struct rte_eth_dev *dev,
 		if (flow != NULL && f != flow)
 			continue;
 
+		/* this should not happen */
+		if (f->engine == NULL || f->rule == NULL) {
+			PMD_DRV_LOG(DEBUG, "Invalid flow");
+			continue;
+		}
+
 		found = true;
-		if (f->engine != NULL) {
-			rule_size = f->engine->rule_size;
-			if (f->rule != NULL)
-				rule_data = f->rule;
-		}
 
-		if (f->engine != NULL)
-			iavf_flow_dump_blob(file,
-				f->engine->name != NULL ?
-					f->engine->name : "unknown",
-				rule_data, rule_size);
+		rule_size = f->engine->rule_size;
+		rule_data = f->rule;
+
+		iavf_flow_dump_blob(file,
+			f->engine->name != NULL ?
+				f->engine->name : "unknown",
+			rule_data, rule_size);
 	}
 	rte_spinlock_unlock(&vf->flow_ops_lock);
 
-- 
2.47.3

