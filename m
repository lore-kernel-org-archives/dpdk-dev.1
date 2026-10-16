Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F52BCCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2CD406B6;
	Fri, 16 Oct 2026 16:02:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E5904402DA
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159348; x=1823695348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=K2XQY4HGXli+PtVelLYaje3azPke+JAbIk90u5e19pc=;
 b=RqGI7CC2nuIxowQiqkvcV5kAbffCO8ANeZxXd7zcbCcYjzBRd/HPUzKD
 gX9/wQF2BQIlS3tWZYQg91zq1SxgON6IunchOn/YuwD0ZfbeIPiZzLRrh
 nQU7ugNZx6zQ6gM0VdX6qL/DHoYd3VeV7mskJAmr0Yk+ID6QbOlO6rz9G
 ExsD/W/ogSc4+UgJRMTAhWaEI6sRotxSvXfxeEmV4eptZ56Aqou149Hai
 Iyvs4G2kuUFFyjoH0LjC0MSt6iW0sbvpTeCgNuzZ2M9dGGBP+O7O3dVx4
 peON9rsWyh+A1S1f+tlKrDJ4RqlMLm/IYqvzIFUlX9VhHAIggTqFyyu6m w==;
X-CSE-ConnectionGUID: zngjt4+jSRGD1CqmGP/RXA==
X-CSE-MsgGUID: yGJNNCjtRbegefTzJiL2Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043675"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:26 -0700
X-CSE-ConnectionGUID: xj4Yrt9ZTtWJ5Kxvl+YTmg==
X-CSE-MsgGUID: kQgkSofZSJamcQc4biHQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951703"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [27.03 RFC PATCH v1 6/8] thash: use usage counters for ref counting
Date: Fri, 16 Oct 2026 15:02:13 +0100
Message-ID: <d6986920cb08db0e8b9ff088d794841b933c94be.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
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

Use EAL usage counters instead of raw integers for ref counting.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/hash/rte_thash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..bbbd932f92 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -15,6 +15,7 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_cpuflags.h>
+#include <rte_usage_count.h>
 
 RTE_LOG_REGISTER_SUFFIX(thash_logtype, thash, INFO);
 #define RTE_LOGTYPE_HASH thash_logtype
@@ -34,7 +35,7 @@ static struct rte_tailq_elem rte_thash_tailq = {
 EAL_REGISTER_TAILQ(rte_thash_tailq)
 
 struct thash_lfsr {
-	uint32_t	ref_cnt;
+	rte_usage_count_t	ref_cnt;
 	uint32_t	poly;
 	/**< polynomial associated with the lfsr */
 	uint32_t	rev_poly;
@@ -187,7 +188,7 @@ alloc_lfsr(uint32_t poly_degree)
 
 	/* clear bits_cnt after rev_state was inited */
 	lfsr->bits_cnt = 0;
-	lfsr->ref_cnt = 1;
+	rte_usage_count_claim(&lfsr->ref_cnt);
 
 	return lfsr;
 }
@@ -195,15 +196,14 @@ alloc_lfsr(uint32_t poly_degree)
 static void
 attach_lfsr(struct rte_thash_subtuple_helper *h, struct thash_lfsr *lfsr)
 {
-	lfsr->ref_cnt++;
+	rte_usage_count_claim(&lfsr->ref_cnt);
 	h->lfsr = lfsr;
 }
 
 static void
 free_lfsr(struct thash_lfsr *lfsr)
 {
-	lfsr->ref_cnt--;
-	if (lfsr->ref_cnt == 0)
+	if (rte_usage_count_release(&lfsr->ref_cnt))
 		rte_free(lfsr);
 }
 
-- 
2.52.0

