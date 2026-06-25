Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A9CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5421740B95;
	Thu, 25 Jun 2026 16:01:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 251D640A6E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396116; x=1813932116;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WdDAPK+xkbuMs+tDrCGKIPHYoSUoD4tygYl/y2QY+iA=;
 b=ZGYumFcsfwVLo1YRG5/j84xUULJD8TPcM5iTFh5lfWA+tc9xlMXcv1G2
 Ryl7i4aTBKRVwQK1tJem1/lKS42SeKb8bNWVRti5oaGXqDogzvlBllZlf
 f23ZtjvRLAC3qYLk8LQm82RCOdSmoTZ5tWcLpcaS029cGJak98cOPfq3c
 HLN1S56yMXNwbKJfpKUEpBvycO+IbkJnZwHuTOkvZ8k8ILNFqKS89zovg
 HUWlwaiDlAfa+btbcchfybIQpX/zWRuT5nGad4WqKT2Z0z1Az0eVFZz5s
 TpCa+F+tiPsVReXZJIys8isMg/gfhRHsWXa/9xUZXJV8BVSQjbJ5LJJjI A==;
X-CSE-ConnectionGUID: iveJFtfeRgKZG7647oxUDg==
X-CSE-MsgGUID: r+vZn0C1RLiIXUlHFZRtlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225263"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:56 -0700
X-CSE-ConnectionGUID: rjpXLYg+SOaik6XIeUYHIg==
X-CSE-MsgGUID: lnf83vxFS3C/NKoyLHSu6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908097"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v6 4/6] eal: fix async IPC memory leaks on partial failure
Date: Thu, 25 Jun 2026 15:01:46 +0100
Message-ID: <b6948ee12ab8dee7e12976478ce6642b69ce0200.1782395581.git.anatoly.burakov@intel.com>
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

When rte_mp_request_async() fails to send requests to all peers,
copy and param can lose ownership and leak.

However, we cannot simply free them unconditionally, as "partial failure"
means some requests were already queued and thus still reference `copy` and
`param`, so freeing them directly on the error path can cause
use-after-free when those requests are later handled by the async timeout.

Fix this by rolling back queued requests from the current batch, and reset
nb_sent to 0. Freeing the requests is now safe even if some requests were
sent, as any responses or timeouts will not find the request ID in the
queue and will safely exit without doing anything.

Coverity issue: 501503
Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 34 +++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 869ce99bf9..5cd1bb8d13 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1242,7 +1242,34 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		} else if (mp_request_async(path, copy, param, ts))
 			ret = -1;
 	}
-	/* if we didn't send anything, put dummy request on the queue */
+
+	/*
+	 * On partial failure, roll back all queued requests. We hold the lock
+	 * so no one else touches the queue. All requests in this batch share
+	 * the same param pointer. Stale alarms will fire and harmlessly find
+	 * nothing via ID-based lookup.
+	 */
+	if (ret != 0 && reply->nb_sent > 0) {
+		struct pending_request *r, *next;
+
+		for (r = TAILQ_FIRST(&pending_requests.requests);
+				r != NULL; r = next) {
+			next = TAILQ_NEXT(r, next);
+			if (r->type == REQUEST_TYPE_ASYNC &&
+					r->async.param == param) {
+				TAILQ_REMOVE(&pending_requests.requests,
+						r, next);
+				free(r->reply);
+				/* r->request == copy, freed below after the loop */
+				free(r);
+			}
+		}
+		reply->nb_sent = 0;
+	}
+
+	/* if we didn't send anything, put dummy request on the queue
+	 * and set a minimum-delay alarm so the callback fires immediately.
+	 */
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
 		dummy_used = true;
@@ -1260,6 +1287,11 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	/* if dummy was unused, free it */
 	if (!dummy_used)
 		free(dummy);
+	/* if nothing was sent, nobody owns copy/param */
+	if (ret != 0) {
+		free(param);
+		free(copy);
+	}
 
 	return ret;
 closedir_fail:
-- 
2.47.3

