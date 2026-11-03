Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B606C838
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MsSx/ZAP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF019427A8;
	Tue,  3 Nov 2026 15:58:43 +0100 (CET)
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
 by mails.dpdk.org (Postfix) with ESMTPS id 32CBF410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:42 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=dNmpqSGLKCcXuQRkaIHjWRVO1+TnAu15RqNhXKecSTM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717921; v=1; x=1794322721;
 b=MsSx/ZAPPlz+k2+9/oTIu0J3csPLYTTf3jKqiPPkM3HPQmqa1WS2fkJGiz28RosbMpzkV3IK
 CUoWr0hjix4podU05oNZOHup8sfJCKcKYsNDOdTuTYMWxKEESww2qECpnDEvV/jDTPaUNAmwkWs
 BVidB0tXXjIl7HUNLhljaXtQ=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 9114739070263c8c;
 Tue, 03 Nov 2026 14:58:41 +0000
X-Mizu-Trace-ID: 9114739070263c8c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 037/227] dispatcher: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:55 +0800
Message-ID: <20261103145306.487255-38-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/dispatcher/rte_dispatcher.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dispatcher/rte_dispatcher.c b/lib/dispatcher/rte_dispatcher.c
index a35967f7b7..3f33a03de1 100644
--- a/lib/dispatcher/rte_dispatcher.c
+++ b/lib/dispatcher/rte_dispatcher.c
@@ -54,7 +54,7 @@ struct __rte_cache_aligned rte_dispatcher_lcore {
 
 struct rte_dispatcher {
 	uint8_t event_dev_id;
-	int socket_id;
+	int numa_id;
 	uint32_t service_id;
 	struct rte_dispatcher_lcore lcores[RTE_MAX_LCORE];
 	uint16_t num_finalizers;
@@ -239,7 +239,7 @@ evd_service_register(struct rte_dispatcher *dispatcher)
 		.callback = evd_process,
 		.callback_userdata = dispatcher,
 		.capabilities = RTE_SERVICE_CAP_MT_SAFE,
-		.socket_id = dispatcher->socket_id
+		.socket_id = dispatcher->numa_id
 	};
 	int rc;
 
@@ -271,15 +271,15 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_create, 23.11)
 struct rte_dispatcher *
 rte_dispatcher_create(uint8_t event_dev_id)
 {
-	int socket_id;
+	int numa_id;
 	struct rte_dispatcher *dispatcher;
 	int rc;
 
-	socket_id = rte_event_dev_socket_id(event_dev_id);
+	numa_id = rte_event_dev_numa_id(event_dev_id);
 
 	dispatcher =
 		rte_malloc_socket("dispatcher", sizeof(struct rte_dispatcher),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (dispatcher == NULL) {
 		RTE_EDEV_LOG_ERR("Unable to allocate memory for dispatcher");
@@ -289,7 +289,7 @@ rte_dispatcher_create(uint8_t event_dev_id)
 
 	*dispatcher = (struct rte_dispatcher) {
 		.event_dev_id = event_dev_id,
-		.socket_id = socket_id
+		.numa_id = numa_id
 	};
 
 	rc = evd_service_register(dispatcher);
-- 
2.55.0

