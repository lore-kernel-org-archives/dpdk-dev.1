Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760AD29FAB
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54CA04067C;
	Thu,  4 Dec 2025 19:21:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E3D6340144;
 Thu,  4 Dec 2025 19:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872464; x=1796408464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B+CECV4QjcusK1P61r53evBVyn89mhgShMcOVkfWt8E=;
 b=gVcmvyZhlAsBz0Czu3/QD8/yjTvnUTvIHSImZzYlhxiNkjjTID/40FLk
 r7g3Ikvjm5+MWqs+dukvX9T9RLR79yWTCcIEaTlyN2lkEsscj9s3rl+He
 YbAymPn1kLoLDRPwz5bXTVkh/b+3axdnaQUTwpQYZ0yA7q180CqAu2oUq
 XPWaudsnbkFslfYDBoKJ+DESi9nJWoWvhqkuZC4sJPJfPOG5EcYiItBc7
 0hP0g42ztp4V6vap1NmeQJP7xX00HLPC5tN0mWs8PdIk3Th8RW44NzCXv
 veh6IeAtDVcz+ThEjKG8A4R22RCU8ZG3TV4v1HkbxYgP0KU0hMt5y8d+C g==;
X-CSE-ConnectionGUID: au+LZLElTSS8gcxprp5hMg==
X-CSE-MsgGUID: v85VMl9FSWGwx9ED/jOfGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013013"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:03 -0800
X-CSE-ConnectionGUID: kiNPeAX7StSm45gye+52jw==
X-CSE-MsgGUID: 4qbqxPf7QLOti9Nu9/Rwew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423156"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 02/10] app/test: fix undefined behaviour in red autotest
Date: Thu,  4 Dec 2025 18:20:39 +0000
Message-ID: <20251204182047.3154429-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

The shift of a negative number (or very large positive) is undefined
behaviour which causes errors when run with UBSan. Fix this by making
the behaviour explicit for the edge case of n being zero in the
calculation.

Fixes: de3cfa2c9823 ("sched: initial import")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/sched/rte_red.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/sched/rte_red.h b/lib/sched/rte_red.h
index e62abb9295..3b90cc46a9 100644
--- a/lib/sched/rte_red.h
+++ b/lib/sched/rte_red.h
@@ -172,8 +172,15 @@ __rte_red_calc_qempty_factor(uint8_t wq_log2, uint16_t m)
 	f = (n >> 6) & 0xf;
 	n >>= 10;
 
-	if (n < RTE_RED_SCALING)
+	if (n < RTE_RED_SCALING) {
+		/* When n == 0, no rounding or shifting needed.
+		 * For n > 0, add 2^(n-1) for rounding before right shift.
+		 * This avoids UB from (1 << -1) when n == 0.
+		 */
+		if (n == 0)
+			return (uint16_t) rte_red_pow2_frac_inv[f];
 		return (uint16_t) ((rte_red_pow2_frac_inv[f] + (1 << (n - 1))) >> n);
+	}
 
 	return 0;
 }
-- 
2.51.0

