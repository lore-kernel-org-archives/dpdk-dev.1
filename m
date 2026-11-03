Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829C606B25C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U/Pa805N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB0FF4279D;
	Tue,  3 Nov 2026 16:08:41 +0100 (CET)
Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
 by mails.dpdk.org (Postfix) with ESMTPS id 5510D40616
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=XFKTrTcxvmQ0mnT72D27oy6Tnflr/NuAPGuT0LP/iTY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718520; v=1; x=1794323320;
 b=U/Pa805Nb0meiHqU8JF/YZsJ3lp6WCjyMHKSXlQKlJKstvDkTdWqgR3vIFL0j9A6v2QJm1Hz
 eSCpoY2r4uWX+9aQSVn8OG1yWJaCnzl6lOjQ8bNNbWo7u1LFM/i8pCIoj1Jka5PWJyKJB/mKil4
 4tDHjOKWmG2jYA9XiehyO0nk=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b38debda63f33bb6;
 Tue, 03 Nov 2026 15:08:40 +0000
X-Mizu-Trace-ID: b38debda63f33bb6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 096/227] event/opdl: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:54 +0800
Message-ID: <20261103145306.487255-97-chengwen.feng@linux.dev>
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
 drivers/event/opdl/opdl_evdev.c | 16 ++++++++--------
 drivers/event/opdl/opdl_ring.c  |  6 +++---
 drivers/event/opdl/opdl_ring.h  |  2 +-
 drivers/event/opdl/opdl_test.c  |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index 44a648a11a..d5396fda4f 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -581,9 +581,9 @@ opdl_close(struct rte_eventdev *dev)
 static int
 assign_numa_node(const char *key __rte_unused, const char *value, void *opaque)
 {
-	int *socket_id = opaque;
-	*socket_id = atoi(value);
-	if (*socket_id >= RTE_MAX_NUMA_NODES)
+	int *numa_id = opaque;
+	*numa_id = atoi(value);
+	if (*numa_id >= RTE_MAX_NUMA_NODES)
 		return -1;
 	return 0;
 }
@@ -647,7 +647,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 	const char *params;
 	struct rte_eventdev *dev;
 	struct opdl_evdev *opdl;
-	int socket_id = rte_socket_id();
+	int numa_id = rte_numa_id();
 	int do_validation = 0;
 	int do_test = 0;
 	int str_len;
@@ -664,7 +664,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 					name);
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
-					assign_numa_node, &socket_id);
+					assign_numa_node, &numa_id);
 			if (ret != 0) {
 				PMD_DRV_LOG(ERR,
 						"%s: Error parsing numa node parameter",
@@ -698,7 +698,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 		}
 	}
 	dev = rte_event_pmd_vdev_init(name,
-			sizeof(struct opdl_evdev), socket_id, vdev);
+			sizeof(struct opdl_evdev), numa_id, vdev);
 
 	if (dev == NULL) {
 		PMD_DRV_LOG(ERR, "eventdev vdev init() failed");
@@ -710,7 +710,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 			  " , self_test:[%s]",
 		      dev->data->dev_id,
 		      name,
-		      socket_id,
+		      numa_id,
 		      (do_validation ? "true" : "false"),
 			  (do_test ? "true" : "false"));
 
@@ -726,7 +726,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 
 	opdl = dev->data->dev_private;
 	opdl->data = dev->data;
-	opdl->socket = socket_id;
+	opdl->socket = numa_id;
 	opdl->do_validation = do_validation;
 	opdl->do_test = do_test;
 	str_len = strlen(name);
diff --git a/drivers/event/opdl/opdl_ring.c b/drivers/event/opdl/opdl_ring.c
index 60991c4b03..d1e8cdb048 100644
--- a/drivers/event/opdl/opdl_ring.c
+++ b/drivers/event/opdl/opdl_ring.c
@@ -805,13 +805,13 @@ init_stage(struct opdl_ring *t, struct opdl_stage *s, bool threadsafe,
 	s->shared.stage = s;
 
 	/* Alloc memory for deps */
-	s->dep_tracking = rte_zmalloc_socket(LIB_NAME,
+	s->dep_tracking = rte_zmalloc_numa(LIB_NAME,
 			t->max_num_stages * sizeof(enum dep_type),
 			0, t->socket);
 	if (s->dep_tracking == NULL)
 		return -ENOMEM;
 
-	s->deps = rte_zmalloc_socket(LIB_NAME,
+	s->deps = rte_zmalloc_numa(LIB_NAME,
 			t->max_num_stages * sizeof(struct shared_state *),
 			0, t->socket);
 	if (s->deps == NULL) {
@@ -923,7 +923,7 @@ opdl_ring_create(const char *name, uint32_t num_slots, uint32_t slot_size,
 	}
 
 	/* Alloc memory for stages */
-	st = rte_zmalloc_socket(LIB_NAME,
+	st = rte_zmalloc_numa(LIB_NAME,
 		max_num_stages * sizeof(struct opdl_stage),
 		RTE_CACHE_LINE_SIZE, socket);
 	if (st == NULL)
diff --git a/drivers/event/opdl/opdl_ring.h b/drivers/event/opdl/opdl_ring.h
index 14ababe0bb..c055dd4f7d 100644
--- a/drivers/event/opdl/opdl_ring.h
+++ b/drivers/event/opdl/opdl_ring.h
@@ -69,7 +69,7 @@ struct opdl_stage;
  * @param max_num_stages
  *   Maximum number of stages.
  * @param socket
- *   The NUMA socket (or SOCKET_ID_ANY) to allocate the memory used for this
+ *   The NUMA socket (or RTE_NUMA_ID_ANY) to allocate the memory used for this
  *   opdl_ring instance.
  * @param threadsafe
  *   Whether to support multiple threads inputting to the opdl_ring or not.
diff --git a/drivers/event/opdl/opdl_test.c b/drivers/event/opdl/opdl_test.c
index 9b0c4db5ce..daa07f52e2 100644
--- a/drivers/event/opdl/opdl_test.c
+++ b/drivers/event/opdl/opdl_test.c
@@ -1017,7 +1017,7 @@ opdl_selftest(void)
 				32 /*MBUF_CACHE_SIZE*/,
 				0,
 				512, /* use very small mbufs */
-				rte_socket_id());
+				rte_numa_id());
 		if (!eventdev_func_mempool) {
 			PMD_DRV_LOG(ERR, "ERROR creating mempool");
 			free(t);
-- 
2.55.0

