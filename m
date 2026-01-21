Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5FEC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68855427E1;
	Wed, 21 Jan 2026 18:57:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 399534027A;
 Wed, 21 Jan 2026 18:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769018226; x=1800554226;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4OI7HT65jDTMonMAB8WzrLlK1guYHI/4tDQvSVBdL/A=;
 b=OOKPGc/BNizraj5RYr3gwihVfPwEKoik/93GTHCHYCMfDIcW29wVUxYf
 VHbi/NbRTzRjUPpUGqszPM2TDjq7chhnmp1KaX4Zuog4YLMVzfXu7cGsz
 DApZotN36XE9CJrYbvv+h9njtDMonVDFTT9yf0NPO3SBpLwF78tLqkizq
 DPi8IsdA1267w+PYjJBPWGE9Q+ZI3lRqDg8CgP8Tf6he0M6Hrtr89+B2m
 /iJAV26GO5/aIfvFVnyDsBJIPwTjG7oEFNuOMSLC7OOVkqDJh8uv5lT0M
 XIyHJaGUD7LajrLdrKHhr3kO+IATDKFrjhiOIgTSkNjK7+J76JMuzSVfb w==;
X-CSE-ConnectionGUID: KdLENLAyR8C53mjbYZorQg==
X-CSE-MsgGUID: ZC6b1RLISci11ImHdDDwow==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70417559"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="70417559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 09:57:05 -0800
X-CSE-ConnectionGUID: f4HZt1DZQveGlrgcc/mHbA==
X-CSE-MsgGUID: zpb5CAVDRaapzmi/6buJSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206118353"
Received: from silpixa00401176.ir.intel.com ([10.20.227.132])
 by fmviesa007.fm.intel.com with ESMTP; 21 Jan 2026 09:57:04 -0800
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH] fib: fix incorrect prefix addition handling
Date: Wed, 21 Jan 2026 17:57:01 +0000
Message-ID: <20260121175701.41102-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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

When adding a prefix longer than /24 in FIB/FIB6 as a first prefix within
its corresponding /24 supernet with the same next hop as its parent, the
code would incorrectly skip incrementing the number of reserved TBL8 due
to an early return statement. This could lead to integer overflow in
'dp->rsvd_tbl8s'. This commit corrects the logic to ensure that the
reserved TBL8 count is properly incremented in such scenarios.

Bugzilla ID: 1731
Fixes: 7dc7868b200d ("fib: add DIR24-8 dataplane algorithm")
Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/dir24_8.c | 3 ++-
 lib/fib/trie.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 2ba7e93511..1d99c8b21f 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -495,13 +495,14 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 		if (parent != NULL) {
 			rte_rib_get_nh(parent, &par_nh);
 			if (par_nh == next_hop)
-				return 0;
+				goto successfully_added;
 		}
 		ret = modify_fib(dp, rib, ip, depth, next_hop);
 		if (ret != 0) {
 			rte_rib_remove(rib, ip, depth);
 			return ret;
 		}
+successfully_added:
 		if ((depth > 24) && (tmp == NULL))
 			dp->rsvd_tbl8s++;
 		return 0;
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 24a08b827d..edb7442cb1 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -571,14 +571,14 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		if (parent != NULL) {
 			rte_rib6_get_nh(parent, &par_nh);
 			if (par_nh == next_hop)
-				return 0;
+				goto successfully_added;
 		}
 		ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
 		if (ret != 0) {
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return ret;
 		}
-
+successfully_added:
 		dp->rsvd_tbl8s += depth_diff;
 		return 0;
 	case RTE_FIB6_DEL:
-- 
2.43.0

