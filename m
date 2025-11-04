Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE1CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0057A4028C;
	Tue,  4 Nov 2025 12:15:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 51CEE40285;
 Tue,  4 Nov 2025 12:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762254924; x=1793790924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/ZtqZB/5BxLk/KqI9XJUfIfjZ1zM6qSUZsmg8u0p3Ls=;
 b=J4ReXtNG8qFxaxkrusU+n32DDWdja85SpJsL7dJsM3FwU0b03EgUEpbV
 ee0QTsyCWxsXV1ap7PaE0OXE5zwV04COdJHdI+j7yXppujRwMfCHeaDeo
 YgwpRfLXwoHyA1rfMtRl1N+hrqtGYBtcjzxmQ1/TMgKLMwCHkcOAsaWS7
 U+r3umqgkXgP4bNdlKSQAI7Mv926ABIU8/Q/sBd4hPAxVcTcXHtE2Kl3g
 z1Lu+V0RIwfz8lexshB6z3xSxy6152OsO0sBUL17TdJhAEbRSjEBZGUrJ
 m1vlJZmbldFxFtOWTVsB4uj9Z857erftejGJtxyQ7YjLwEWZWOSBI5op6 A==;
X-CSE-ConnectionGUID: lPyVAfgWRnet9EuqgICPDA==
X-CSE-MsgGUID: R4TdHG2aTgCuOQIyVmQ4yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75025652"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="75025652"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:15:23 -0800
X-CSE-ConnectionGUID: mg4PiOmfSc+unL5htPeU4A==
X-CSE-MsgGUID: g5FJ6iJ0SAyC8rug27sR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="186425659"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 04 Nov 2025 03:15:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 stephen@networkplumber.org
Subject: [PATCH] net/fm10k: fix build with GCC 16
Date: Tue,  4 Nov 2025 11:15:15 +0000
Message-ID: <20251104111515.1728873-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <bug-1822-3@http.bugs.dpdk.org/>
References: <bug-1822-3@http.bugs.dpdk.org/>
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

Build error reported with GCC 16, due to a set but unused variable. Fix
the issue by removing the setting of the var and marking it as unused.

../drivers/net/intel/fm10k/base/fm10k_common.c: In function 'fm10k_unbind_hw_stats_q':
../drivers/net/intel/fm10k/base/fm10k_common.c:480:62: warning:
parameter 'idx' set but not used [-Wunused-but-set-parameter=]
  480 | void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)

Bugzilla ID: 1822
Fixes: 7223d200c227 ("fm10k: add base driver")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/fm10k/base/fm10k_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/fm10k/base/fm10k_common.c b/drivers/net/intel/fm10k/base/fm10k_common.c
index b78d4b575b..677ef87608 100644
--- a/drivers/net/intel/fm10k/base/fm10k_common.c
+++ b/drivers/net/intel/fm10k/base/fm10k_common.c
@@ -477,11 +477,11 @@ void fm10k_update_hw_stats_q(struct fm10k_hw *hw, struct fm10k_hw_stats_q *q,
  *  Function invalidates the index values for the queues so any updates that
  *  may have happened are ignored and the base for the queue stats is reset.
  **/
-void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
+void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx __rte_unused, u32 count)
 {
 	u32 i;
 
-	for (i = 0; i < count; i++, idx++, q++) {
+	for (i = 0; i < count; i++, q++) {
 		q->rx_stats_idx = 0;
 		q->tx_stats_idx = 0;
 	}
-- 
2.48.1

