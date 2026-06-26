Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B75DCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B84D40609;
	Fri, 26 Jun 2026 12:34:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EC0D44025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470047; x=1814006047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kg87dDWToORl5gm0/PakerigSVxDZB0XyKgZ+Fx4E9k=;
 b=CNxNNtOqyoAPQCZxy24X1KCOV1UGUmtW6M/asLpsXWVDMn7BEoSAXYWN
 fYudE8bQuP8tygcJmu7v9tDLmy81Secil0kW8YF1pmiUKWsdnrwmjy6zu
 vyOKU7rkcTDp4CPaJgp2K6MhbzBnpLEcKYgiMqX9WrFG0kBQDvB/hDB9e
 xJkFxMuDCF8h40ICEBmoeYlp0G2GbtHoJMBCioQWK8URt+7ynx5QqLgpH
 V6eU7zjT7mSRy4sF2ubzYgZ4l6BbD9oUTKdl7s0kyQwfHJ0J2rvWriI2h
 9Xg8ewaHlBWTArcHvL85ynfV4AMz/vWCM84B0chd51SlQ0EIAJZWbBiuJ g==;
X-CSE-ConnectionGUID: bCPFW1OUQyu6/zOrVHz7qw==
X-CSE-MsgGUID: ymNgTJkZTsWI127w+7hC1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941967"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941967"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:06 -0700
X-CSE-ConnectionGUID: +jfKwttDQ4mvgoWaks0i4g==
X-CSE-MsgGUID: z0iYnFIGSkeOVzw98vqZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383959"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 2/6] eal: use request ID instead of pointers
Date: Fri, 26 Jun 2026 11:33:57 +0100
Message-ID: <4f373899b3b4dc3e529e31f5238594b4857b41c3.1782469943.git.anatoly.burakov@intel.com>
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

Initial implementation of async IPC request handling was using request
pointers directly. Because of the nature of how IPC is meant to work and
that requests ownership is disconnected from their creation (as in, freeing
a request may happen due to timeout, or due to received response, or due
to rollback because of a later failure), using pointers as identity is not
safe.

Use numeric request ID for async request lookup instead. This way, we can
safely free requests even if we are already waiting on responses/timeouts
for them, as the pointers themselves will not be referenced directly by
the response/timeout.

Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 66 ++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 799c6e81b0..347a174d22 100644
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
@@ -111,15 +114,15 @@ mp_send(struct rte_mp_msg *msg, const char *peer, int type);
 static void
 async_reply_handle(void *arg);
 
-/* for use with process_msg */
+/* for use with alarm callback and process_msg */
 static struct pending_request *
-async_reply_handle_thread_unsafe(void *arg);
+async_reply_handle_thread_unsafe(struct pending_request *req);
 
 static void
 trigger_async_action(struct pending_request *req);
 
 static struct pending_request *
-find_pending_request(const char *dst, const char *act_name)
+find_request_by_name(const char *dst, const char *act_name)
 {
 	struct pending_request *r;
 
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
@@ -354,7 +370,7 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
 		struct pending_request *req = NULL;
 
 		pthread_mutex_lock(&pending_requests.lock);
-		pending_req = find_pending_request(s->sun_path, msg->name);
+		pending_req = find_request_by_name(s->sun_path, msg->name);
 		if (pending_req) {
 			memcpy(pending_req->reply, msg, sizeof(*msg));
 			/* -1 indicates that we've been asked to ignore */
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
@@ -557,9 +573,16 @@ static void
 async_reply_handle(void *arg)
 {
 	struct pending_request *req;
+	/* alarm arg carries the request ID packed into a void * via uintptr_t */
+	unsigned long id = (uintptr_t)arg;
+
+	/* ensure request ID matches pointer size */
+	RTE_BUILD_BUG_ON(sizeof(next_request_id) != sizeof(uintptr_t));
 
 	pthread_mutex_lock(&pending_requests.lock);
-	req = async_reply_handle_thread_unsafe(arg);
+	req = find_async_request_by_id(id);
+	if (req != NULL)
+		req = async_reply_handle_thread_unsafe(req);
 	pthread_mutex_unlock(&pending_requests.lock);
 
 	if (req != NULL)
@@ -878,8 +901,18 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 {
 	struct rte_mp_msg *reply_msg;
 	struct pending_request *pending_req, *exist;
+	unsigned long id;
 	int ret = -1;
 
+	/* queue already locked by caller */
+
+	exist = find_request_by_name(dst, req->name);
+	if (exist) {
+		EAL_LOG(ERR, "A pending request %s:%s", dst, req->name);
+		rte_errno = EEXIST;
+		return -1;
+	}
+
 	pending_req = calloc(1, sizeof(*pending_req));
 	reply_msg = calloc(1, sizeof(*reply_msg));
 	if (pending_req == NULL || reply_msg == NULL) {
@@ -889,22 +922,14 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 		goto fail;
 	}
 
+	id = ++next_request_id;
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
@@ -919,7 +944,7 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 
 	/* if alarm set fails, we simply ignore the reply */
 	if (rte_eal_alarm_set(ts->tv_sec * 1000000 + ts->tv_nsec / 1000,
-			      async_reply_handle, pending_req) < 0) {
+			async_reply_handle, (void *)(uintptr_t)id) < 0) {
 		EAL_LOG(ERR, "Fail to set alarm for request %s:%s",
 			dst, req->name);
 		ret = -1;
@@ -952,7 +977,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req,
 	pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
 	pthread_cond_init(&pending_req.sync.cond, &attr);
 
-	exist = find_pending_request(dst, req->name);
+	exist = find_request_by_name(dst, req->name);
 	if (exist) {
 		EAL_LOG(ERR, "A pending request %s:%s", dst, req->name);
 		rte_errno = EEXIST;
@@ -1178,6 +1203,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	 * it, and put it on the queue if we don't send any requests.
 	 */
 	dummy->type = REQUEST_TYPE_ASYNC;
+	dummy->id = ++next_request_id;
 	dummy->request = copy;
 	dummy->reply = NULL;
 	dummy->async.param = param;
-- 
2.47.3

