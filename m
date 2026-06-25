Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E15CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6841140B8F;
	Thu, 25 Jun 2026 16:01:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id EEFEF40652
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396115; x=1813932115;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0fY6JnDtrODSM7nVyRIDxczWTIsvOYYq7dWRPso+niU=;
 b=TjUX7eMk6MA+D0ejxbEtrzm5i5hhE+SwZ32eCxH+aS9ONAR71c1J30kq
 /9tm4VLm4WlnwRLq+SgGNI1eUhd7y/771fxGGnd1tRcmbkbhnliyYSCrb
 Yg+9s59GaGr0XTvL6x4MYb7el504RaSGY7w/r1FTSmbJEt2tJwSlC4rNk
 6UUxdemIxRzYlvtRvLkIfgdoWBmgRiGZZWYQtClLJVL2uumet+YhjzGIg
 7+UtUZNh/8hErwEjf1XaRAVeGOCZry9AIJvOBIkt4hBKfX3oQO3ly8tLf
 0fckVxKFRFh+qsLcn9iTtJ+dIe3P69V9+e1TcNtxbmypoxEo+bKm/As2m Q==;
X-CSE-ConnectionGUID: 0sipV2XeREi0tJw21kPYcw==
X-CSE-MsgGUID: lTzShE02RbWFPuZ0RgUnOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225260"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:55 -0700
X-CSE-ConnectionGUID: FjA3Az1EQKyyZ7HpIPcJKQ==
X-CSE-MsgGUID: EsQbLyYxQj2JVui2JlV8aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908076"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v6 3/6] eal: avoid deadlock in async IPC alarm callback
Date: Thu, 25 Jun 2026 15:01:45 +0100
Message-ID: <d3fa44b1e6eb4415342a7f5edffbba3a61135754.1782395581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782395581.git.anatoly.burakov@intel.com>
 <cover.1782395581.git.anatoly.burakov@intel.com>
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
index 3e32ee5027..869ce99bf9 100644
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

