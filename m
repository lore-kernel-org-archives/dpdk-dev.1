Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B5CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:29:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AC4C4065B;
	Fri,  5 Jun 2026 16:29:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A62E4402E0
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780669771; x=1812205771;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UFjiue/hSfL9SZ4ggDPV3VauW/kmxXQbaduY+AaoFU0=;
 b=mXbeKCiar5xLzWttYsTpja7JNgvW41vOjeLsjd2G8ZvvA5T34ykxiZ5M
 qfVJkNojrej9g0egL3OQ3FT2XwgGKTrZO3PZUkWM0D42JSBIIdAF3vLjf
 jAYIkx3e9PYRBe12eVNF/AlXhbZyptjh3vX1YBXAp6cNg1h3RFMXiTXb0
 sqV8cmKQJA342ROG+SBSlMPHdJHKCUheBpW2gdIyeoohe6cfYh7X0ZpHA
 iH/xqqZrtx7PddsTWEfDrTU0hfMWb+ag33C0qeHUUwuhVR67hramP2Xd+
 aZQLcunbURy8hKpDz3lqwYdrBlASgMwuPHjf0+FdrHyO6D9c8+NJL1fk0 w==;
X-CSE-ConnectionGUID: +URaTt2hSKmuMVy8rgGyVw==
X-CSE-MsgGUID: SZYmdKgqRXy+IUrAo4rd5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81482618"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81482618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:29:30 -0700
X-CSE-ConnectionGUID: wOovD9gdRl+vDCPrqJiIWw==
X-CSE-MsgGUID: UVzFDCgxRmyvVHxsdGaEOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="242383082"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2026 07:29:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v4 4/5] eal: fix async IPC resource leaks on partial failure
Date: Fri,  5 Jun 2026 15:29:23 +0100
Message-ID: <99e1b118d90a6d7865044e907c38b01b6e15e3ce.1780669755.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780669755.git.anatoly.burakov@intel.com>
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

On partial failure, some requests may already be queued and still
reference copy and param, so freeing them directly on the error
path can cause use-after-free when those requests are later handled.

Fix this by rolling back queued requests from the current batch,
resetting nb_sent to 0, and freeing copy/param only after rollback.
Use a numeric request ID for alarm callback lookup so stale callbacks
from rolled-back requests become harmless no-ops.

Coverity issue: 501503
Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 112 +++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 28 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index c8e59967d9..64812bcfd7 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -74,6 +74,7 @@ struct async_request_param {
 
 struct pending_request {
 	TAILQ_ENTRY(pending_request) next;
+	unsigned long id;
 	enum {
 		REQUEST_TYPE_SYNC,
 		REQUEST_TYPE_ASYNC
@@ -92,6 +93,8 @@ struct pending_request {
 	};
 };
 
+static unsigned long next_request_id;
+
 TAILQ_HEAD(pending_request_list, pending_request);
 
 static struct {
@@ -111,9 +114,9 @@ mp_send(struct rte_mp_msg *msg, const char *peer, int type);
 static void
 async_reply_handle(void *arg);
 
-/* for use with process_msg */
+/* for use with alarm callback and process_msg */
 static struct pending_request *
-async_reply_handle_thread_unsafe(void *arg);
+async_reply_handle_thread_unsafe(struct pending_request *req);
 
 static void
 trigger_async_action(struct pending_request *req);
@@ -132,6 +135,19 @@ find_pending_request(const char *dst, const char *act_name)
 	return r;
 }
 
+static struct pending_request *
+find_async_request_by_id(unsigned long id)
+{
+	struct pending_request *r;
+
+	TAILQ_FOREACH(r, &pending_requests.requests, next) {
+		if (r->id == id && r->type == REQUEST_TYPE_ASYNC)
+			return r;
+	}
+
+	return NULL;
+}
+
 /*
  * Combine prefix and name(optional) to return unix domain socket path
  * return the number of characters that would have been put into buffer.
@@ -519,9 +535,8 @@ trigger_async_action(struct pending_request *sr)
 }
 
 static struct pending_request *
-async_reply_handle_thread_unsafe(void *arg)
+async_reply_handle_thread_unsafe(struct pending_request *req)
 {
-	struct pending_request *req = (struct pending_request *)arg;
 	enum async_action action;
 	struct timespec ts_now;
 
@@ -534,7 +549,8 @@ async_reply_handle_thread_unsafe(void *arg)
 
 	TAILQ_REMOVE(&pending_requests.requests, req, next);
 
-	if (rte_eal_alarm_cancel(async_reply_handle, req) < 0) {
+	if (rte_eal_alarm_cancel(async_reply_handle,
+			(void *)(uintptr_t)req->id) < 0) {
 		/* if we failed to cancel the alarm because it's already in
 		 * progress, don't proceed because otherwise we will end up
 		 * handling the same message twice.
@@ -557,9 +573,13 @@ static void
 async_reply_handle(void *arg)
 {
 	struct pending_request *req;
+	/* alarm arg carries the request ID packed into a void * via uintptr_t */
+	unsigned long id = (uintptr_t)arg;
 
 	pthread_mutex_lock(&pending_requests.lock);
-	req = async_reply_handle_thread_unsafe(arg);
+	req = find_async_request_by_id(id);
+	if (req != NULL)
+		req = async_reply_handle_thread_unsafe(req);
 	pthread_mutex_unlock(&pending_requests.lock);
 
 	if (req != NULL)
@@ -878,7 +898,29 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 {
 	struct rte_mp_msg *reply_msg;
 	struct pending_request *pending_req, *exist;
-	int ret = -1;
+	unsigned long id;
+	int ret;
+
+	/* queue already locked by caller */
+
+	exist = find_pending_request(dst, req->name);
+	if (exist) {
+		EAL_LOG(ERR, "A pending request %s:%s", dst, req->name);
+		rte_errno = EEXIST;
+		return -1;
+	}
+
+	/* Set alarm before allocating or sending so request timeout tracking
+	 * is active as soon as this request ID is reserved.
+	 */
+	id = ++next_request_id;
+	if (rte_eal_alarm_set(ts->tv_sec * 1000000 + ts->tv_nsec / 1000,
+			async_reply_handle,
+			(void *)(uintptr_t)id) < 0) {
+		EAL_LOG(ERR, "Fail to set alarm for request %s:%s",
+			dst, req->name);
+		return -1;
+	}
 
 	pending_req = calloc(1, sizeof(*pending_req));
 	reply_msg = calloc(1, sizeof(*reply_msg));
@@ -890,21 +932,12 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 	}
 
 	pending_req->type = REQUEST_TYPE_ASYNC;
+	pending_req->id = id;
 	strlcpy(pending_req->dst, dst, sizeof(pending_req->dst));
 	pending_req->request = req;
 	pending_req->reply = reply_msg;
 	pending_req->async.param = param;
 
-	/* queue already locked by caller */
-
-	exist = find_pending_request(dst, req->name);
-	if (exist) {
-		EAL_LOG(ERR, "A pending request %s:%s", dst, req->name);
-		rte_errno = EEXIST;
-		ret = -1;
-		goto fail;
-	}
-
 	ret = send_msg(dst, req, MP_REQ);
 	if (ret < 0) {
 		EAL_LOG(ERR, "Fail to send request %s:%s",
@@ -917,14 +950,6 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 	}
 	param->user_reply.nb_sent++;
 
-	/* if alarm set fails, we simply ignore the reply */
-	if (rte_eal_alarm_set(ts->tv_sec * 1000000 + ts->tv_nsec / 1000,
-			      async_reply_handle, pending_req) < 0) {
-		EAL_LOG(ERR, "Fail to set alarm for request %s:%s",
-			dst, req->name);
-		ret = -1;
-		goto fail;
-	}
 	TAILQ_INSERT_TAIL(&pending_requests.requests, pending_req, next);
 
 	return 0;
@@ -1178,6 +1203,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	 * it, and put it on the queue if we don't send any requests.
 	 */
 	dummy->type = REQUEST_TYPE_ASYNC;
+	dummy->id = ++next_request_id;
 	dummy->request = copy;
 	dummy->reply = NULL;
 	dummy->async.param = param;
@@ -1194,8 +1220,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
 					next);
 			dummy_used = true;
-
-			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0) {
+			if (rte_eal_alarm_set(1, async_reply_handle,
+					(void *)(uintptr_t)dummy->id) < 0) {
 				EAL_LOG(ERR, "Fail to set alarm for dummy request");
 				/* roll back the changes */
 				TAILQ_REMOVE(&pending_requests.requests, dummy, next);
@@ -1245,13 +1271,38 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		} else if (mp_request_async(path, copy, param, ts))
 			ret = -1;
 	}
+
+	/*
+	 * On partial failure, roll back all queued requests in this batch while
+	 * holding pending_requests.lock. Any alarm callback that runs later for
+	 * these removed IDs will not find a pending request and will return.
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
 	/* if we didn't send anything, put dummy request on the queue
 	 * and set a minimum-delay alarm so the callback fires immediately.
 	 */
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
 		dummy_used = true;
-		if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
+		if (rte_eal_alarm_set(1, async_reply_handle,
+				(void *)(uintptr_t)dummy->id) < 0)
 			EAL_LOG(ERR, "Fail to set alarm for dummy request");
 	}
 
@@ -1267,6 +1318,11 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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

