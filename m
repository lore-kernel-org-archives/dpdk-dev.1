Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D1606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I2P1HxRH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 146EB4333E;
	Tue,  3 Nov 2026 16:28:34 +0100 (CET)
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
 by mails.dpdk.org (Postfix) with ESMTPS id BA77E4332A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:28:32 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=KQ0j5hpiIjIlsgqqInC+lgvnvTsIDxsrgdVLIBbuXak=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719712; v=1; x=1794324512;
 b=I2P1HxRHMQFD1G37kXiztxhK9hUKSIHoeXOARv+vhou12lBW4cdfxujZ/siDBuJYgRJCZLxW
 R0e8gjD3+Sh9i+g0kovgpCoBC7d+h764QUYeSah7tg6do5NU+gRFSzRpAxVyBkIXRVilpGmI632
 7ch9LJupoY1YojyANWlmeFVo=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 26413b576a03c41e;
 Tue, 03 Nov 2026 15:28:32 +0000
X-Mizu-Trace-ID: 26413b576a03c41e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 224/227] doc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:53:02 +0800
Message-ID: <20261103145306.487255-225-chengwen.feng@linux.dev>
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

Update the programming guide examples to use the NUMA node
APIs and field names introduced by the terminology renames.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/api/doxy-api.conf.in                           |  1 +
 doc/guides/prog_guide/bbdev.rst                    | 14 +++++++-------
 doc/guides/prog_guide/compressdev.rst              |  4 ++--
 .../prog_guide/eventdev/event_timer_adapter.rst    |  2 +-
 .../prog_guide/eventdev/event_vector_adapter.rst   |  2 +-
 doc/guides/prog_guide/eventdev/eventdev.rst        |  2 +-
 doc/guides/prog_guide/gpudev.rst                   |  2 +-
 doc/guides/prog_guide/ptr_compress_lib.rst         |  2 +-
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index 94096ee710..62e16cdc66 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -91,6 +91,7 @@ INPUT                   += @API_EXAMPLES@
 FILE_PATTERNS           = rte_*.h \
                           cmdline.h
 PREDEFINED              = __DOXYGEN__ \
+                         __rte_deprecated_msg(x)= \
                           RTE_ATOMIC \
                           RTE_HAS_CPUSET \
                           __rte_lockable= \
diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index aba10a7392..445574a62d 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -87,7 +87,7 @@ Configuration of a device has two different levels: configuration that applies
 to the whole device, and configuration that applies to a single queue.
 
 Device configuration is applied with
-``rte_bbdev_setup_queues(dev_id,num_queues,socket_id)``
+``rte_bbdev_setup_queues(dev_id,num_queues,numa_id)``
 and queue configuration is applied with
 ``rte_bbdev_queue_configure(dev_id,queue_id,conf)``. Note that, although all
 queues on a device support same capabilities, they can be configured differently
@@ -106,12 +106,12 @@ The ``rte_bbdev_setup_queues`` API is used to setup queues for a bbdev device.
 .. code-block:: c
 
    int rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues,
-            int socket_id);
+            int numa_id);
 
 - ``num_queues`` argument identifies the total number of queues to setup for
   this device.
 
-- ``socket_id`` specifies which socket will be used to allocate the memory.
+- ``numa_id`` specifies which NUMA node will be used to allocate the memory.
 
 
 The ``rte_bbdev_intr_enable`` API is used to enable interrupts for a bbdev
@@ -434,7 +434,7 @@ ranks for optimal processing.
     struct rte_mempool *
     rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
             unsigned int num_elements, unsigned int cache_size,
-            int socket_id)
+            int numa_id)
 
 ``rte_bbdev_*_op_alloc_bulk()`` and ``rte_bbdev_*_op_free_bulk()`` are used to
 allocate bbdev operations of a specific type from a given bbdev operation mempool.
@@ -1330,20 +1330,20 @@ buffers using (**sw_turbo**) bbdev PMD.
     /* Create bbdev op pools */
     bbdev_op_pool[RTE_BBDEV_OP_TURBO_ENC] =
             rte_bbdev_op_pool_create("bbdev_op_pool_enc",
-            RTE_BBDEV_OP_TURBO_ENC, NB_MBUF, 128, rte_socket_id());
+            RTE_BBDEV_OP_TURBO_ENC, NB_MBUF, 128, rte_numa_id());
 
     /* Get information for this device */
     rte_bbdev_info_get(dev_id, &info);
 
     /* Setup BBDEV device queues */
-    ret = rte_bbdev_setup_queues(dev_id, qs_nb, info.socket_id);
+    ret = rte_bbdev_setup_queues(dev_id, qs_nb, info.numa_id);
     if (ret < 0)
         rte_exit(EXIT_FAILURE,
                 "ERROR(%d): BBDEV %u not configured properly\n",
                 ret, dev_id);
 
     /* setup device queues */
-    qconf.socket = info.socket_id;
+    qconf.numa_id = info.numa_id;
     qconf.queue_size = info.drv.queue_size_lim;
     qconf.op_type = RTE_BBDEV_OP_TURBO_ENC;
 
diff --git a/doc/guides/prog_guide/compressdev.rst b/doc/guides/prog_guide/compressdev.rst
index 883d1369e9..1440f332fd 100644
--- a/doc/guides/prog_guide/compressdev.rst
+++ b/doc/guides/prog_guide/compressdev.rst
@@ -345,7 +345,7 @@ using priv_xform would look like:
         rte_exit(EXIT_FAILURE, "Failed to configure compressdev %u", cdev_id);
 
     if (rte_compressdev_queue_pair_setup(cdev_id, 0, NUM_MAX_INFLIGHT_OPS,
-                            socket_id()) < 0)
+                            numa_id()) < 0)
         rte_exit(EXIT_FAILURE, "Failed to setup queue pair\n");
 
     if (rte_compressdev_start(cdev_id) < 0)
@@ -493,7 +493,7 @@ with each chunk size of CHUNK_LEN, would look like:
         rte_exit(EXIT_FAILURE, "Failed to configure compressdev %u", cdev_id);
 
     if (rte_compressdev_queue_pair_setup(cdev_id, 0, NUM_MAX_INFLIGHT_OPS,
-                                    socket_id()) < 0)
+                                    numa_id()) < 0)
         rte_exit(EXIT_FAILURE, "Failed to setup queue pair\n");
 
     if (rte_compressdev_start(cdev_id) < 0)
diff --git a/doc/guides/prog_guide/eventdev/event_timer_adapter.rst b/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
index ea777c13cf..6ae4e80cca 100644
--- a/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
@@ -110,7 +110,7 @@ to ``rte_event_timer_adapter_create()``.
 	const struct rte_event_timer_adapter_conf adapter_config = {
                 .event_dev_id = event_dev_id,
                 .timer_adapter_id = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
                 .clk_src = RTE_EVENT_TIMER_ADAPTER_CPU_CLK,
                 .timer_tick_ns = NSECPERSEC / 10,
                 .max_tmo_ns = 180 * NSECPERSEC,
diff --git a/doc/guides/prog_guide/eventdev/event_vector_adapter.rst b/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
index a732885697..c575187c62 100644
--- a/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_vector_adapter.rst
@@ -79,7 +79,7 @@ and pass it to ``rte_event_vector_adapter_create()``.
 
 	const struct rte_event_vector_adapter_conf adapter_config = {
 		.event_dev_id = event_dev_id,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.ev = {
 			.queue_id = event_queue_id,
 			.sched_type = RTE_SCHED_TYPE_ATOMIC,
diff --git a/doc/guides/prog_guide/eventdev/eventdev.rst b/doc/guides/prog_guide/eventdev/eventdev.rst
index ea34f74032..9f8fceb2ce 100644
--- a/doc/guides/prog_guide/eventdev/eventdev.rst
+++ b/doc/guides/prog_guide/eventdev/eventdev.rst
@@ -97,7 +97,7 @@ cache size, number of elements in each ``rte_event_vector`` and socket id.
 .. code-block:: c
 
         rte_event_vector_pool_create("vector_pool", nb_event_vectors, cache_sz,
-                                     nb_elements_per_vector, socket_id);
+                                     nb_elements_per_vector, numa_id);
 
 The function ``rte_event_vector_pool_create`` creates mempool with the best
 platform mempool ops.
diff --git a/doc/guides/prog_guide/gpudev.rst b/doc/guides/prog_guide/gpudev.rst
index de246d2a4c..795a49a1f1 100644
--- a/doc/guides/prog_guide/gpudev.rst
+++ b/doc/guides/prog_guide/gpudev.rst
@@ -159,7 +159,7 @@ about how to use functions in this library in case of a CUDA application.
                ext_mem.buf_ptr, ext_mem.buf_iova, ext_mem.buf_len);
        mpool_payload = rte_pktmbuf_pool_create_extbuf("gpu_mempool", mbufs_num,
                                                       0, 0, ext_mem.elt_size,
-                                                      rte_socket_id(), &ext_mem, 1);
+                                                      rte_numa_id(), &ext_mem, 1);
 
        /*
         * Create CPU - device communication flag.
diff --git a/doc/guides/prog_guide/ptr_compress_lib.rst b/doc/guides/prog_guide/ptr_compress_lib.rst
index d08c52a503..5c3ec02a28 100644
--- a/doc/guides/prog_guide/ptr_compress_lib.rst
+++ b/doc/guides/prog_guide/ptr_compress_lib.rst
@@ -142,7 +142,7 @@ While this is a realistic use case the code is simplified for demonstration purp
     {
       ring = rte_ring_create_elem(
         "COMPR_PTRS", sizeof(uint32_t),
-        1024, rte_socket_id(),
+        1024, rte_numa_id(),
         RING_F_SP_ENQ | RING_F_SC_DEQ);
 
       rte_eal_remote_launch(send_compressed, NULL, CORE_SEND);
-- 
2.55.0

