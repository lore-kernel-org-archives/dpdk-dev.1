Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BECD6E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F361440668;
	Fri, 29 May 2026 17:26:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3EF6140612
 for <dev@dpdk.org>; Fri, 29 May 2026 17:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068398; x=1811604398;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LsxGM8hfZ0aDSBS0gF0SdB19A10BCpvl+Nyw3BkqcpU=;
 b=Ga+XdtwKNLKJYPte2ETMS6UpR4kiQgYHPSTFpvxdwp65/XuYR9yqQLO9
 JTT9vMDWuNqXaK2eQvYtlkrJr+jLTzOVzFzRz0E88+ktg2tmo2gARHOAw
 AnPqAz9cHoqQFjpqAe4k9fdIVl/JRqr42b5CMTQnlaqNNJOgSyc0ov2kd
 oLBIWznrCbQfcs8ezBY3uaC0NJpbTCKhWBlMYA1W8STYyKwyPZv1Jry7w
 sEP+0dv1n/BjpZjzSUKM5KSmtvmm0LdKFUis0wnfkxV+xcbFlNS64tTgY
 wOof62yOZCkIYPzhF9WJI4bIlH5LfN5m+4tKPORdIsaV0Jaa91C61RdOT A==;
X-CSE-ConnectionGUID: Oyfg3SGaRc+zGLenypSorw==
X-CSE-MsgGUID: +b2+Bn2ZTniaUtVGvuyMTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91231665"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91231665"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:26:38 -0700
X-CSE-ConnectionGUID: XDuMHzXfSPmISKFY6icINw==
X-CSE-MsgGUID: mDmwjqiUSkqfp6DJELmZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="236520620"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 29 May 2026 08:26:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v2 5/5] eal: avoid deadlock in async IPC alarm callback
Date: Fri, 29 May 2026 16:26:31 +0100
Message-ID: <d12f7e7fd9177180d4c8ac64cb984530ae7e23b5.1780068382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d7204c81e2494027fe467b8e3f5744888059fcbd.1780068382.git.anatoly.burakov@intel.com>
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
callback triggered without a pending request becomes a noop.

Fixes: daf9bfca717e ("ipc: remove thread for async requests")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 967186382e..67a393f53e 100644
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
@@ -910,8 +897,12 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 		return -1;
 	}
 
-	/* Set alarm before allocating or sending so request timeout tracking
-	 * is active as soon as this request ID is reserved.
+	/* Set alarm before allocating or sending. The alarm is never cancelled:
+	 * rte_eal_alarm_cancel spin-waits for an executing callback to finish,
+	 * which deadlocks if we hold pending_requests.lock while the callback
+	 * is blocked on it. Instead, let stale alarms fire; with ID-based
+	 * lookup the callback will simply not find the request and return
+	 * harmlessly.
 	 */
 	id = ++next_request_id;
 	if (rte_eal_alarm_set(ts->tv_sec * 1000000 + ts->tv_nsec / 1000,
-- 
2.47.3

