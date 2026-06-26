Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ECCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAA2B4066C;
	Fri, 26 Jun 2026 12:34:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 90C4B40659
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470050; x=1814006050;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=dbqQFHOFhifnKz8NS1T9cK5pPKTvkQG9DpH/oIfwAqA=;
 b=Pe3EWk2ON8RfnoUR7pu16n6xifwgfnyCCnTNwG/IHBx9QST0kLHLcImg
 /clD7TIBO8XburkBkTx2lSaQUpfilzhApt4McdnmKCzAH+1wIePp/43Op
 iFuOTNkPBU81Em8kneti5utAICBjYxIeabCpDsbSNf51DQjHWvJFUxyG5
 /g+mGU2ZEnFqSzoGei+b36P/fLKVRjK7dKX9oO/HTU9IxFm+1wHEGUzDI
 aJR8ygCYZgBMMoI5e7gzcIkVYHGLbkxnVkzP1OjqUmtZk6C7voqTJRrl/
 K+SN38K+c6y6uWOpXpoSiGODrk23sRG4o1Dif7rZNM2xBcSV+rZrXzClG g==;
X-CSE-ConnectionGUID: e7+Dmo5gRgyZCuU/mF3/mQ==
X-CSE-MsgGUID: +KRFVG/bSlGfZrdpNogDxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941971"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:09 -0700
X-CSE-ConnectionGUID: Xv3/mN2LSA6LIEer+Ea9LQ==
X-CSE-MsgGUID: J63Nc5JHRQqf1U6GZKsJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383968"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 4/6] eal: fix async IPC memory leaks on partial failure
Date: Fri, 26 Jun 2026 11:33:59 +0100
Message-ID: <c4564e3c9e7ad675c60655b80cac1a077ad24bb1.1782469943.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_proc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 991bf215a3..0cffc7a127 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1245,6 +1245,32 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		} else if (mp_request_async(path, copy, param, ts))
 			ret = -1;
 	}
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
+		/* requests on the queue were removed so keep things consistent */
+		reply->nb_sent = 0;
+	}
+
 	/* if we didn't send anything, put dummy request on the queue */
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
@@ -1263,6 +1289,11 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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

