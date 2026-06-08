Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C25CD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD724066A;
	Mon,  8 Jun 2026 15:13:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 442C7402AD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 15:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780924412; x=1812460412;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nJ9pBph0n0WBpUmoL3OPAXDkrR+PPCLSSthsUkL4q0Q=;
 b=eXeL2JlHvPP0+btGrpjLu62kWVRzqnZDGFYsh16SkQ2KUns0nk4IFCkZ
 dNwMF98Vh3zNZm/ABAg97dR6kGrOD60usE8xKqJBFwXT+9NsEO9YEjGtd
 NDP+flPKHhBSgxSqYpSXZFvB6cnlciFFFOriL4DNKiiCwpPIHPuKppRCB
 FBzFQ69jqx2Vw1YvcRLlDnjCoZv5OLD5YlXK7W59WnjpC5qAYN7jxOsaF
 smN6lWvOYDdXeupH3J/7DXUfj/FJeRJ0OHJLP3XQf/pkbYERGsTEEtq3V
 wx84yjQ/nsZPk/BHqAGhEVOJWkQ0c+2aOU1fgiTNz9x39/y1Rdiehq82H w==;
X-CSE-ConnectionGUID: 7IVnDASjRm2vvnTlp4jLCQ==
X-CSE-MsgGUID: MlsEMQeURL2G5haMjWnxVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81656723"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81656723"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 06:13:28 -0700
X-CSE-ConnectionGUID: Zyf4uRyJRMqmTS7KVIakUA==
X-CSE-MsgGUID: 7B3b5271T6KuiE1OLTUxIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245635499"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 08 Jun 2026 06:13:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v5 5/5] eal: avoid deadlock in async IPC alarm callback
Date: Mon,  8 Jun 2026 14:13:21 +0100
Message-ID: <4895601373f5c2b4e9ec3fcb39b39565dc6c52ed.1780924381.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780924381.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_proc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index ddcaa2f20b..908e86f6b0 100644
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
@@ -1273,9 +1264,10 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	}
 
 	/*
-	 * On partial failure, roll back all queued requests in this batch while
-	 * holding pending_requests.lock. Any alarm callback that runs later for
-	 * these removed IDs will not find a pending request and will return.
+	 * On partial failure, roll back all queued requests. We hold the lock
+	 * so no one else touches the queue. All requests in this batch share
+	 * the same param pointer. Stale alarms will fire and harmlessly find
+	 * nothing via ID-based lookup.
 	 */
 	if (ret != 0 && reply->nb_sent > 0) {
 		struct pending_request *r, *next;
-- 
2.47.3

