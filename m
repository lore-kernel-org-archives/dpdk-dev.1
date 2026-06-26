Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C42CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F15C40663;
	Fri, 26 Jun 2026 12:34:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DEF2E4025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470048; x=1814006048;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f/pnZNbuwOEgCKzuzFrUq8/+dwYrWlESIVv79aisPUg=;
 b=oFsA/Zvm5bMUOylcuhsAYGZBrjoxuQAdbThkoRSI+UzMnuZZ7J8RLjEE
 SI21+tEKMOKhm4We9HafYoRK+94KSza2yQGmg23xl1WzAUk+G85XaKY9T
 Okxw5RPF8mz6UPP/S89qniYTacmNOZIgwZH8XvOcE72Lr8Rz0IZ6CGtuj
 maPIANW1NlxyfnIuaaiuoy4aRE7vZr8seaUKPLtEoSOoSLIYWegOQ2R18
 WY+9vGXCyErYiwQUOcpA5xbo0UTv4G3Zn6t8y6ERLpJKNvFSZZ/H+s6+3
 Rp3+UMKLm3SH4/OKSE77FtYrQ619pa3bopdYHjjiKUO/PVTgcvjnkHyii Q==;
X-CSE-ConnectionGUID: G1vcmjYGT+6SJ5RpsnsAQg==
X-CSE-MsgGUID: vB4npRvjRTaqDcyKy+0bUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941969"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:07 -0700
X-CSE-ConnectionGUID: VynSRbg2TUeFCkEBQAlXzg==
X-CSE-MsgGUID: LNZSX8WJQTWokvV/ZX6NZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383965"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 3/6] eal: avoid deadlock in async IPC alarm callback
Date: Fri, 26 Jun 2026 11:33:58 +0100
Message-ID: <10c5f2269c9b205499ac9944e5a0b01ed5f3d83b.1782469943.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782469943.git.anatoly.burakov@intel.com>
 <cover.1782469943.git.anatoly.burakov@intel.com>
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

async_reply_handle_thread_unsafe() can run while holding
pending_requests.lock and currently calls rte_eal_alarm_cancel().

rte_eal_alarm_cancel() may spin-wait for an executing callback, which can
deadlock if that callback is blocked on the same lock.

Remove callback-side alarm cancellation. It is safe to do so, because any
callback triggered without a pending request becomes a noop due to the
async request lookup now using numerical ID.

Fixes: daf9bfca717e ("ipc: remove thread for async requests")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 347a174d22..991bf215a3 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -549,19 +549,6 @@ async_reply_handle_thread_unsafe(struct pending_request *req)
 
 	TAILQ_REMOVE(&pending_requests.requests, req, next);
 
-	if (rte_eal_alarm_cancel(async_reply_handle,
-			(void *)(uintptr_t)req->id) < 0) {
-		/* if we failed to cancel the alarm because it's already in
-		 * progress, don't proceed because otherwise we will end up
-		 * handling the same message twice.
-		 */
-		if (rte_errno == EINPROGRESS) {
-			EAL_LOG(DEBUG, "Request handling is already in progress");
-			goto no_trigger;
-		}
-		EAL_LOG(ERR, "Failed to cancel alarm");
-	}
-
 	if (action == ACTION_TRIGGER)
 		return req;
 no_trigger:
-- 
2.47.3

