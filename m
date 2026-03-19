Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1452109024D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF0340650;
	Thu, 19 Mar 2026 17:07:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6620E40430
 for <dev@dpdk.org>; Thu, 19 Mar 2026 17:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773936447; x=1805472447;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Wrf0m7RTwdUhj+jSoc+V3VYZ8ya6A/nIXZPPjl9ujbQ=;
 b=ahKDHXpWxUbAtBkZbEk3mkBi8J2IkU4NClujT5L3ox4oHt33el4SfwOa
 OZ2mOw9N3d33eRXHWZOU3lYPTI38kkC1jZLYDYD4QNaZFBdmhkOj6Ua76
 xl+Jf5tCAST6w9eokE/+UppVfUDNikdo2aa0CyJm6AtL00wtCEbg6UfOn
 8Y661ln8ApWHokk0I92wIDyOeUKVjj8wcqe/epSfbcBa7NEv8kDGHaxGb
 Dl8z6unh7g5RM2zV6AueXR+AMvjljXSIpoFqv1Yd0HBdhL6KLuROXogKc
 VRpOmhaNANXzWueo5FeQJxkZZuM0uRB2Gi4idQF4aIpkVuGO1SXMsWQm0 A==;
X-CSE-ConnectionGUID: 4rx0SHeMQm6cNsKG5+WxJA==
X-CSE-MsgGUID: H9qprwHzRGaGUEW18tCDoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74900641"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74900641"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 09:07:26 -0700
X-CSE-ConnectionGUID: R0fr3/C6T7CyJ4inYrrqGw==
X-CSE-MsgGUID: m684K5FfTESScxmtwuQZlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222987066"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Mar 2026 09:07:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v1 5/5] eal: avoid deadlock in async IPC alarm callback
Date: Thu, 19 Mar 2026 16:07:17 +0000
Message-ID: <398239c507619ce17786c94e0613a07819f2b7e9.1773936429.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
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
index d1a041b707..830c11f4ac 100644
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

