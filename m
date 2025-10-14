Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1776BCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 18:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F260B40651;
	Tue, 14 Oct 2025 20:18:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1CC0940288;
 Tue, 14 Oct 2025 20:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760465880; x=1792001880;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LPgN7aOutGzmroklehrHZQQ0WDjmyRpSt7rSx51IcFU=;
 b=B9vv5fIyY0cIaedjebQyerxWIjoswzHyMqgoRLIqgZlCxs+avd6UiIMy
 skuvTPC6OogaVeklO5i+NCMYAmwSjF1CpoR1JGM9W2bD2MnQ64ev8KLcW
 sU+FSu6NwnQaTjgPUOVQgoDBlyw4j2+CcXtRbDf9HJ8Utcd9e28Eq18OM
 7bJ15pIB7IYDBP+Erw4vcKnB+AMgsWMqCs0Bz3wRGWv8vLZR6usrKmx+/
 9VttOJrKNPQsL/QOff2hw0McPpBEr/qsjuDsJotHFDOXRXNDssRvXwANu
 IkpStp0yaUVp3Q5uC7WaobUXyJW3cdl5b4EYBtTBr4fkX9aVlutmEn7td w==;
X-CSE-ConnectionGUID: QtV6/wANS+WkRfRMCBHN3Q==
X-CSE-MsgGUID: D0IVlLoWSIi2bGOW4O1tMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66286127"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="66286127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:17:59 -0700
X-CSE-ConnectionGUID: zxx58sevQZyFp4MmWCAUSA==
X-CSE-MsgGUID: 7ri8dv2oSy6yH4A1eSRBTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="212571025"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa002.jf.intel.com with ESMTP; 14 Oct 2025 11:17:59 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	stable@dpdk.org
Subject: [PATCH 2/2] fib6: fix tbl8 allocation check logic
Date: Tue, 14 Oct 2025 18:17:55 +0000
Message-ID: <20251014181755.114300-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
References: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
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

Currently if there were 'n' preallocated tbl8 entries only 'n - 1' were
able to be used. Fix the logic allowing to use all preallocated tbl8
entries.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 5a9978b4ca..6427920c58 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -576,8 +576,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s >=
-				dp->number_tbl8s - depth_diff))
+		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
 			return -ENOSPC;
 
 		node = rte_rib6_insert(rib, &ip_masked, depth);
-- 
2.43.0

