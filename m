Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA05CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B20CA4066B;
	Fri, 26 Jun 2026 12:34:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1A0C240665
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470052; x=1814006052;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fkZ7ZdceJ+MMMV/uYuVPuMk76BkSdiFGXIaIelfMvAk=;
 b=SUUXS7l/bZE7ttU96AaSdd4eztZa/jzd2//Y6pgJRru6OkQpDmuvDJt4
 jiaYb3qZC0pf8vH00t1GhEMwou+AzYc+yLqPnzjL9Depw95+/7lzxYAuU
 9Jc9yh+1a7+jquXuttTjtXK2CZ6r/BOBRp6D3+vupxZZ0NQzm77GM3dNg
 fy34D+2qElWw7FhHSt4yGdsi1o2D7nq9Wt0J8CbkxXcwbos5aRkY1w9fO
 4uZfamvZTbiSeRAgRSoDBGFUATkKC0iQHjXGlqeinqEED63VYAPg3DQEo
 4Hs1kbTnnzX2rhxhzNvXU/sDt+D3f4gLVK3ET5MTN8f98fvPEECy94HiY w==;
X-CSE-ConnectionGUID: Lnf5tPCmSV+0ae3b7WIjig==
X-CSE-MsgGUID: kypdybBPRuuv3/vMjyTBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941975"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941975"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:11 -0700
X-CSE-ConnectionGUID: h9whYegoQNS1WxnVhH7XYA==
X-CSE-MsgGUID: SRvpf+zbTeCn3WIBU7pdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383983"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 6/6] eal: fix async IPC callback not fired when no peers
Date: Fri, 26 Jun 2026 11:34:01 +0100
Message-ID: <d300d7031f62113451e0004812e9b1926dedfc65.1782469943.git.anatoly.burakov@intel.com>
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

Currently, when rte_mp_request_async() is called and no peer processes
are connected (nb_sent == 0), the user callback is never invoked.

The original implementation used a dedicated background thread and
pthread_cond_signal() to wake it after queuing the dummy request. When
that thread was replaced with per-message alarms, no alarm was set for
the dummy request, silently breaking the nb_sent == 0 path.

This was not noticed because async requests are usually used while handling
secondary process requests, where peers are typically already present.

Fix it by setting a 1us alarm on the dummy request, so the callback path
immediately triggers and processes it.

Fixes: daf9bfca717e ("ipc: remove thread for async requests")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 8902159386..b0f7681547 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1200,11 +1200,22 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
 
-		/* if we didn't send anything, put dummy request on the queue */
+		/* if we didn't send anything, put dummy request on the queue
+		 * and set a minimum-delay alarm so the callback fires immediately.
+		 */
 		if (ret == 0 && reply->nb_sent == 0) {
 			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
 					next);
 			dummy_used = true;
+			if (rte_eal_alarm_set(1, async_reply_handle,
+					(void *)(uintptr_t)dummy->id) < 0) {
+				EAL_LOG(ERR, "Fail to set alarm for dummy request");
+				/* roll back the changes */
+				TAILQ_REMOVE(&pending_requests.requests, dummy, next);
+				dummy_used = false;
+				ret = -1;
+				goto unlock_fail;
+			}
 		}
 
 		pthread_mutex_unlock(&pending_requests.lock);
@@ -1273,10 +1284,22 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		reply->nb_sent = 0;
 	}
 
-	/* if we didn't send anything, put dummy request on the queue */
+	/* if we didn't send anything, put dummy request on the queue
+	 * and set a minimum-delay alarm so the callback fires immediately.
+	 */
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
 		dummy_used = true;
+
+		if (rte_eal_alarm_set(1, async_reply_handle,
+				(void *)(uintptr_t)dummy->id) < 0) {
+			EAL_LOG(ERR, "Fail to set alarm for dummy request");
+			/* roll back the changes */
+			TAILQ_REMOVE(&pending_requests.requests, dummy, next);
+			dummy_used = false;
+			ret = -1;
+			goto closedir_fail;
+		}
 	}
 
 	/* finally, unlock the queue */
-- 
2.47.3

