Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54835CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 16:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A671402E0;
	Fri,  5 Jun 2026 18:48:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7AA5C4021F;
 Fri,  5 Jun 2026 18:48:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780678095; x=1812214095;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WHTCB38Jx57wPxwn8CuVcdfzl3jcpFEQjL8jw6tlHSs=;
 b=g94Nt7q8DbkqS5KUdvulmhAFQn8l8IMVmUvni4jUQiB2A11lp3rL0jUw
 XzZnejd4kYM779gOKry/g/NmU3eBdTm6QiehBY+RxHuls/HkwmCA600U8
 7lHd6cxlNZ4FToaD99RYFdGU4/hQrR1/jv0+/UbKby5KdBDrpgLHDl1vY
 g5v1ykYvSGnug5z6mlNKRkCKimW5eEpkfJ34gKVP2onCnvH9rPGB5rHwl
 SQB9d8U6noL0OAT9Tv82rGaZb7CrRlG7ZZb3CqUyYVLyVOGtyxidj3K8i
 cY7uRCfGxJAersaLFvdKll8j5SqRR5aQN68qBGDqCQsnbYAlw7FZZ0quF Q==;
X-CSE-ConnectionGUID: ob8qCTCAQfGvA8FCNXSq1Q==
X-CSE-MsgGUID: H6hTgTThTrODA6kw3pD2yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81422553"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="81422553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 09:48:02 -0700
X-CSE-ConnectionGUID: 3aXgv8QgSrC+N5yF5a4frQ==
X-CSE-MsgGUID: b9x3LQ97Ql2M7pwl4bO6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="238539251"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2026 09:48:00 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH] fib6: fix error code propagation on next hop update
Date: Fri,  5 Jun 2026 16:47:57 +0000
Message-ID: <20260605164757.927661-1-vladimir.medvedkin@intel.com>
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

When updating the next hop of an existing prefix, trie_modify() ignored
the return value of modify_dp() and always returned 0.  An out-of-range
next hop is rejected by modify_dp() with -EINVAL but was reported to
the caller as success. Return the actual result.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..99272f45bd 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -600,7 +600,8 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
 			if (ret == 0)
 				rte_rib6_set_nh(node, next_hop);
-			return 0;
+
+			return ret;
 		}
 
 		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
-- 
2.43.0

