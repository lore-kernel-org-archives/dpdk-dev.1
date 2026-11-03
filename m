Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09243606B272
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U76XpQCl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25CD6427A0;
	Tue,  3 Nov 2026 16:08:29 +0100 (CET)
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
 by mails.dpdk.org (Postfix) with ESMTPS id A3E3040616
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:27 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=A9TgHR+c34jSgwzwgVNkO8xqdxztSEQDvMPH/QI1wX4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718507; v=1; x=1794323307;
 b=U76XpQClXWhPite2LqDm8xzqfWnK2wzWoUT9tBM7Av0s05XZWyn7FBbQtDR5uJUMy+V5Fyx5
 +5Grev4yf+yPnFrWX5LkETCZ6nkSioDR1iSyIeZ2LnrRNvHG7zK+vKZac7LGDH15lVS1Qm83aEC
 ArB3wQRz+1okxkeOvxsexIeU=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 6067fbdd4f100610;
 Tue, 03 Nov 2026 15:08:27 +0000
X-Mizu-Trace-ID: 6067fbdd4f100610
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 095/227] event/octeontx: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:53 +0800
Message-ID: <20261103145306.487255-96-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/event/octeontx/ssovf_evdev.c          | 4 ++--
 drivers/event/octeontx/ssovf_evdev_selftest.c | 2 +-
 drivers/event/octeontx/ssovf_worker.c         | 2 +-
 drivers/event/octeontx/timvf_evdev.c          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/event/octeontx/ssovf_evdev.c b/drivers/event/octeontx/ssovf_evdev.c
index 1e5818569b..ba9e92fd99 100644
--- a/drivers/event/octeontx/ssovf_evdev.c
+++ b/drivers/event/octeontx/ssovf_evdev.c
@@ -254,7 +254,7 @@ ssovf_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	}
 
 	/* Allocate event port memory */
-	ws = rte_zmalloc_socket("eventdev ssows",
+	ws = rte_zmalloc_numa("eventdev ssows",
 			sizeof(struct ssows), RTE_CACHE_LINE_SIZE,
 			dev->data->numa_id);
 	if (ws == NULL) {
@@ -893,7 +893,7 @@ ssovf_vdev_probe(struct rte_vdev_device *vdev)
 	}
 
 	eventdev = rte_event_pmd_vdev_init(name, sizeof(struct ssovf_evdev),
-				rte_socket_id(), vdev);
+				rte_numa_id(), vdev);
 	if (eventdev == NULL) {
 		ssovf_log_err("Failed to create eventdev vdev %s", name);
 		return -ENOMEM;
diff --git a/drivers/event/octeontx/ssovf_evdev_selftest.c b/drivers/event/octeontx/ssovf_evdev_selftest.c
index df8e710b57..45ff890780 100644
--- a/drivers/event/octeontx/ssovf_evdev_selftest.c
+++ b/drivers/event/octeontx/ssovf_evdev_selftest.c
@@ -159,7 +159,7 @@ _eventdev_setup(int mode)
 					0 /*MBUF_CACHE_SIZE*/,
 					0,
 					512, /* Use very small mbufs */
-					rte_socket_id());
+					rte_numa_id());
 	if (!eventdev_test_mempool) {
 		ssovf_log_dbg("ERROR creating mempool");
 		return -1;
diff --git a/drivers/event/octeontx/ssovf_worker.c b/drivers/event/octeontx/ssovf_worker.c
index f3c6a0da5c..fe7031b6c5 100644
--- a/drivers/event/octeontx/ssovf_worker.c
+++ b/drivers/event/octeontx/ssovf_worker.c
@@ -463,7 +463,7 @@ octeontx_fastpath_lookup_mem_get(void)
 
 	/* Request for the first time */
 	mz = rte_memzone_reserve_aligned(name, LOOKUP_ARRAY_SZ,
-					 SOCKET_ID_ANY, 0, OCCTX_ALIGN);
+					 RTE_NUMA_ID_ANY, 0, OCCTX_ALIGN);
 	if (mz != NULL) {
 		mem = mz->addr;
 		/* Form the rx ol_flags based on errcode */
diff --git a/drivers/event/octeontx/timvf_evdev.c b/drivers/event/octeontx/timvf_evdev.c
index b404b1db61..5eaf580c7f 100644
--- a/drivers/event/octeontx/timvf_evdev.c
+++ b/drivers/event/octeontx/timvf_evdev.c
@@ -323,7 +323,7 @@ timvf_ring_create(struct rte_event_timer_adapter *adptr)
 	snprintf(pool_name, sizeof(pool_name), "timvf_chunk_pool%d",
 			timr->tim_ring_id);
 	timr->chunk_pool = (void *)rte_mempool_create_empty(pool_name,
-			timr->nb_chunks, TIM_CHUNK_SIZE, 0, 0, rte_socket_id(),
+			timr->nb_chunks, TIM_CHUNK_SIZE, 0, 0, rte_numa_id(),
 			mp_flags);
 
 	if (!timr->chunk_pool) {
-- 
2.55.0

