Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6432BD3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6D6F40658;
	Mon,  8 Dec 2025 12:52:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5F3934042E;
 Mon,  8 Dec 2025 12:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194773; x=1796730773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Kw7bqijBf2I/NoXZC5Dh7Vq52BrYgoh/2yIQXFyNOU=;
 b=YjhBnny9wCzEf/sLGM1XoUIf4OIN1kgve7KiBiAzfe2NmPLaK88TSrJU
 L9iA9RfIOozVzGZGVB9J52reuOFdYZbQXJZNl4PaIW/sXR3kYHq8YRn7L
 LIgANYfrDFCGz0RdtZiea2Pc1IfAVovUnlT2LOnkTLOOUerGEawojfosi
 9f9rTDdwUbSRsMBOdKGeTw0p+CNEazBQnhzYnRQjfNRxMSLh6N9QXYLQr
 B/RclMd41xT42e+kj2TCnMoEQi51P2ptnEDkzj5FS0EkSthFf81CCKlRh
 E7ngZkpQ/Bf/cVgDAgFJ8c+OW5dDqsnCxzmHIeSDY7FVpneWiSHlvO2JI A==;
X-CSE-ConnectionGUID: 20A0ab5pRVqRQsz+NcdEVw==
X-CSE-MsgGUID: D6bpmw/CTZCS77WW58RCKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096051"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096051"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:52 -0800
X-CSE-ConnectionGUID: LukuPl9aQt+WDJ74q9e5wg==
X-CSE-MsgGUID: tkwh+wJdRveIq26iV7nH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970641"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 02/11] app/test: fix undefined behaviour in red autotest
Date: Mon,  8 Dec 2025 11:52:36 +0000
Message-ID: <20251208115245.3809624-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

