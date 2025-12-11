Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE738D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F90940E17;
	Thu, 11 Dec 2025 18:17:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BF34E406FF;
 Thu, 11 Dec 2025 18:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473437; x=1797009437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Kw7bqijBf2I/NoXZC5Dh7Vq52BrYgoh/2yIQXFyNOU=;
 b=FL63cJolc8ixc2oPA4fUCaEHNHiaWzs6SeryN77F6SK0xSw5YNOgetZ4
 ex1oZj+iOVrc8jOT7lQdVpzCclqctOyWwYoBN9PcquejB5D8K2xus9V5e
 TGcr2ZYttfuLopUhTlroBEI0EhqClUQh5eC8PsRJo8NHaV2yrvLJR9MdV
 WtFEovWp2vcSrK3nYGoL56wZ+uqr6ksE+uRkR7RCQAgMskh+DQZ3KKhdL
 cOhnHhilUQlCLb03zkch2+eLsRSknApnLz0UgUVgxPF64oLti84Ocsx5G
 cC+yg+G4XM9EUzaFbrld+i5eqTclG+rtQrravcac3l3Os323NYp4QUinj A==;
X-CSE-ConnectionGUID: rwnptBTnTQu6KsXs1fwlEQ==
X-CSE-MsgGUID: FR+oxUESTOa6eM3Ro9nVQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069980"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:16 -0800
X-CSE-ConnectionGUID: YKUQfGKBR825JdRDlYPH5A==
X-CSE-MsgGUID: wODSGx85QMW7wYQAu9KeYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461557"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 02/11] app/test: fix undefined behaviour in red autotest
Date: Thu, 11 Dec 2025 17:17:00 +0000
Message-ID: <20251211171709.714229-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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
Acked-by: Marat Khalili <marat.khalili@huawei.com>
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

