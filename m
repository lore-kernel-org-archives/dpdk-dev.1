Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3517C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A648140B91;
	Tue,  8 Jul 2025 14:31:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AE59640A89
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:31:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vdnOFJA1Ivv3PM9qY4dyFUm9IcjkI+yOQ9AMHlvLpg=;
 b=SxOpZn+hK4rh0mjoEdNGeP67TDvHFy5Y+pxY0f/KZukarDn7OnCt680sSHry/7SGKv+KFF
 qlW+882RGU451TUvK8hee0oNP7OaWlkZrxDGk/oyRQtHOSHd1HgUW3U0huUUSRWeEMi4S7
 EczM2y0e/K2z5ANiYvjrh8ptyeC1EQs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-wBKMoL7ZNTiN1fZoeZ9V6g-1; Tue,
 08 Jul 2025 08:31:14 -0400
X-MC-Unique: wBKMoL7ZNTiN1fZoeZ9V6g-1
X-Mimecast-MFC-AGG-ID: wBKMoL7ZNTiN1fZoeZ9V6g_1751977873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8541801208; Tue,  8 Jul 2025 12:31:12 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86E0C180045B; Tue,  8 Jul 2025 12:31:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 12/18] malloc: fix mp message alignment
Date: Tue,  8 Jul 2025 14:28:16 +0200
Message-ID: <20250708122823.3406288-13-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oy0FJPPFuYvOZdXVsm45QCn-svB3LrwmoXVfTbGWWFE_1751977873
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Content (param[]) of received multiprocess messages are aligned with
a 4 bytes constraint.

Before patch:
struct mp_msg_internal {
 int type;                                                     /*   0     4 */
 struct rte_mp_msg {
  char name[64];                                               /*   4    64 */
  /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
  int len_param;                                               /*  68     4 */
  int num_fds;                                                 /*  72     4 */
  /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76   256 */
  /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
  int fds[253];                                                /* 332  1012 */
 } msg;                                                        /*   4  1340 */

 /* size: 1344, cachelines: 21, members: 2 */
};

This results in many unaligned accesses for multiprocess malloc requests.

Examples:
../lib/eal/common/malloc_mp.c:308:32: runtime error:
	member access within misaligned address 0x7f7b35df4684 for type
	'const struct malloc_mp_req', which requires 8 byte alignment

../lib/eal/common/malloc_mp.c:158:9: runtime error:
	member access within misaligned address 0x7f36a535bb5c for type
	'const struct malloc_mp_req', which requires 8 byte alignment

../lib/eal/common/malloc_mp.c:171:8: runtime error:
	member access within misaligned address 0x7f4ba65f296c for type
	'struct malloc_mp_req', which requires 8 byte alignment

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_common_proc.c |  2 +-
 lib/eal/common/malloc_mp.c       | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 0dea787e38..3846c7178d 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -62,7 +62,7 @@ enum mp_type {
 
 struct mp_msg_internal {
 	int type;
-	struct rte_mp_msg msg;
+	alignas(8) struct rte_mp_msg msg;
 };
 
 struct async_request_param {
diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
index 9765277f5d..000c7f6b47 100644
--- a/lib/eal/common/malloc_mp.c
+++ b/lib/eal/common/malloc_mp.c
@@ -148,7 +148,7 @@ get_unique_id(void)
 static int
 handle_sync(const struct rte_mp_msg *msg, const void *peer)
 {
-	struct rte_mp_msg reply;
+	alignas(8) struct rte_mp_msg reply;
 	const struct malloc_mp_req *req =
 			(const struct malloc_mp_req *)msg->param;
 	struct malloc_mp_req *resp =
@@ -330,7 +330,7 @@ handle_request(const struct rte_mp_msg *msg, const void *peer __rte_unused)
 	}
 
 	if (ret != 0) {
-		struct rte_mp_msg resp_msg;
+		alignas(8) struct rte_mp_msg resp_msg;
 		struct malloc_mp_req *resp =
 				(struct malloc_mp_req *)resp_msg.param;
 
@@ -351,7 +351,7 @@ handle_request(const struct rte_mp_msg *msg, const void *peer __rte_unused)
 		/* we did not modify the request */
 		free(entry);
 	} else {
-		struct rte_mp_msg sr_msg;
+		alignas(8) struct rte_mp_msg sr_msg;
 		struct malloc_mp_req *sr =
 				(struct malloc_mp_req *)sr_msg.param;
 		struct timespec ts;
@@ -444,7 +444,7 @@ handle_sync_response(const struct rte_mp_msg *request,
 	}
 
 	if (entry->user_req.t == REQ_TYPE_FREE) {
-		struct rte_mp_msg msg;
+		alignas(8) struct rte_mp_msg msg;
 		struct malloc_mp_req *resp = (struct malloc_mp_req *)msg.param;
 
 		memset(&msg, 0, sizeof(msg));
@@ -465,7 +465,7 @@ handle_sync_response(const struct rte_mp_msg *request,
 	} else if (entry->user_req.t == REQ_TYPE_ALLOC &&
 			result == REQ_RESULT_SUCCESS) {
 		struct malloc_heap *heap = entry->alloc_state.heap;
-		struct rte_mp_msg msg;
+		alignas(8) struct rte_mp_msg msg;
 		struct malloc_mp_req *resp =
 				(struct malloc_mp_req *)msg.param;
 
@@ -489,7 +489,7 @@ handle_sync_response(const struct rte_mp_msg *request,
 		free(entry);
 	} else if (entry->user_req.t == REQ_TYPE_ALLOC &&
 			result == REQ_RESULT_FAIL) {
-		struct rte_mp_msg rb_msg;
+		alignas(8) struct rte_mp_msg rb_msg;
 		struct malloc_mp_req *rb =
 				(struct malloc_mp_req *)rb_msg.param;
 		struct timespec ts;
@@ -551,7 +551,7 @@ static int
 handle_rollback_response(const struct rte_mp_msg *request,
 		const struct rte_mp_reply *reply __rte_unused)
 {
-	struct rte_mp_msg msg;
+	alignas(8) struct rte_mp_msg msg;
 	struct malloc_mp_req *resp = (struct malloc_mp_req *)msg.param;
 	const struct malloc_mp_req *mpreq =
 			(const struct malloc_mp_req *)request->param;
@@ -628,7 +628,7 @@ handle_response(const struct rte_mp_msg *msg, const void *peer  __rte_unused)
 int
 request_sync(void)
 {
-	struct rte_mp_msg msg;
+	alignas(8) struct rte_mp_msg msg;
 	struct rte_mp_reply reply;
 	struct malloc_mp_req *req = (struct malloc_mp_req *)msg.param;
 	struct timespec ts;
@@ -697,7 +697,7 @@ request_sync(void)
 int
 request_to_primary(struct malloc_mp_req *user_req)
 {
-	struct rte_mp_msg msg;
+	alignas(8) struct rte_mp_msg msg;
 	struct malloc_mp_req *msg_req = (struct malloc_mp_req *)msg.param;
 	struct mp_request *entry;
 	struct timespec ts;
-- 
2.50.0

