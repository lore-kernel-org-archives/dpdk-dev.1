Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC12109024C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8C5240648;
	Thu, 19 Mar 2026 17:07:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D536E402EE
 for <dev@dpdk.org>; Thu, 19 Mar 2026 17:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773936445; x=1805472445;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NS+bZj/N4T7i6xNV/vdUtjVf5YLod074EtubNoYUFho=;
 b=G0sdaLSKc2zXpalnUXrTSafxlke1ZdOCx7W5TORhBjhNIs+g3/GJJe5V
 YHTdNuSzOwyr9g0tJDypurB2U5OkxGpEgyq5/fGDLkfDZRWSVHQVDmW4p
 C01VE6EbqJnphuIhIJnsCkukAbpy/M/RGeaS9VhP7FqiLd4o36Tfzg4Zi
 ZmIGUEul1FJCe3UpHtiHETDL0vDh8+aU6U/lK3/NcDKaTCJV1234qcoi9
 k5c3flf0wV7QFotqZOVeOOZISw+kPZ9gDARPwwnj1z+rMNtn9jy8n5ONn
 FbHssyylB9cvDleBnitPTmB5INLH8IA2xDD31a1BImTaEpT1DDuudkYRr g==;
X-CSE-ConnectionGUID: yejG1rmSQSWkGgPCZSz7+g==
X-CSE-MsgGUID: xvsWvdXDQ6y6HC+HEv+IIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74900638"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74900638"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 09:07:25 -0700
X-CSE-ConnectionGUID: SfsqF/p1ScOAMOmj3NaeLw==
X-CSE-MsgGUID: BYtxxRTeTc63VKW4CBb96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222987059"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Mar 2026 09:07:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v1 4/5] eal: fix async IPC resource leaks on partial failure
Date: Thu, 19 Mar 2026 16:07:16 +0000
Message-ID: <af8325076295d7f5400d6ff19451ea54828b63e9.1773936429.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_proc.c | 106 +++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 25 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 24d3557859..d1a041b707 100644
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
+find_pending_request_by_id(unsigned long id)
+{
+	struct pending_request *r;
+
+	TAILQ_FOREACH(r, &pending_requests.requests, next) {
+		if (r->id == id)
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
+	req = find_pending_request_by_id(id);
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
@@ -1238,6 +1264,31 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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
+		reply->nb_sent = 0;
+	}
+
 	/* if we didn't send anything, put dummy request on the queue
 	 * and set a minimum-delay alarm so the callback fires immediately.
 	 */
@@ -1260,6 +1311,11 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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

