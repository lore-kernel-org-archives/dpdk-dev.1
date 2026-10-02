Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E8CA5FD9
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFAC427AF;
	Fri,  2 Oct 2026 09:45:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5324240144
 for <dev@dpdk.org>; Fri,  2 Oct 2026 09:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3V2XTJp1s+UnCNZufR/ibqGzJVRFu8bt3RbvGUqy7Ac=;
 b=QcFQFzHAxkxuJVlEjHuYn2MJR3+I5OgThz2XLPzTe1cLZQi05JmS2TyXIkERI6KSoPzSzk
 VocUdLli6oSnKWskPN9TvYdHvTXAJY+3Up245PpZbHS6D49pS6DpYTxlvXOLPbz96EfpMN
 nDOIt1NDLAtaPMDNNXJZwSLwP5t1VnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-M9n6MBOiOv2jU4204Nb99w-1; Fri,
 02 Oct 2026 03:45:04 -0400
X-MC-Unique: M9n6MBOiOv2jU4204Nb99w-1
X-Mimecast-MFC-AGG-ID: M9n6MBOiOv2jU4204Nb99w_1790927103
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4D941955EAA; Fri,  2 Oct 2026 07:45:03 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C998530000E4; Fri,  2 Oct 2026 07:45:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 4/6] vhost: drop async datapath
Date: Fri,  2 Oct 2026 09:44:38 +0200
Message-ID: <20261002074440.2551536-5-david.marchand@redhat.com>
In-Reply-To: <20261002074440.2551536-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261002074440.2551536-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zmalxseWQFqckmOEfy8ddZ9_uCbyUc1FMcP0a07nrWU_1790927103
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

All the API related to this feature is experimental, allowing us by the
project policy to drop the feature in one go.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- removed inflight async statistics,

Changes since v1:
- dropped dependency on PCI library,

Changes since RFC:
- kept mmap populate behavior for vhost_crypto,

---
 doc/guides/prog_guide/vhost_lib.rst    |  151 +-
 doc/guides/rel_notes/release_26_11.rst |   20 +
 lib/vhost/meson.build                  |    3 +-
 lib/vhost/rte_vhost.h                  |    3 +-
 lib/vhost/rte_vhost_async.h            |  293 ---
 lib/vhost/socket.c                     |    9 -
 lib/vhost/vhost.c                      |  436 ----
 lib/vhost/vhost.h                      |  117 -
 lib/vhost/vhost_user.c                 |  111 -
 lib/vhost/virtio_net.c                 | 3275 +++++-------------------
 10 files changed, 687 insertions(+), 3731 deletions(-)
 delete mode 100644 lib/vhost/rte_vhost_async.h

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 2bea814a62..81f6115483 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -103,21 +103,6 @@ The following is an overview of some key Vhost API functions:
 
     It is disabled by default.
 
-  - ``RTE_VHOST_USER_ASYNC_COPY``
-
-    Asynchronous data path will be enabled when this flag is set. Async
-    data path allows applications to enable DMA acceleration for vhost
-    queues. Vhost leverages the registered DMA channels to free CPU from
-    memory copy operations in data path. A set of async data path APIs are
-    defined for DPDK applications to make use of the async capability. Only
-    packets enqueued/dequeued by async APIs are processed through the async
-    data path.
-
-    Currently this feature is only implemented on split ring enqueue data
-    path.
-
-    It is disabled by default.
-
   - ``RTE_VHOST_USER_MAP_POPULATE``
 
     Guest memory regions will be mapped with ``MAP_POPULATE`` when this flag
@@ -236,76 +221,6 @@ The following is an overview of some key Vhost API functions:
 
   Enable or disable zero copy feature of the vhost crypto backend.
 
-* ``rte_vhost_async_dma_configure(dma_id, vchan_id)``
-
-  Tell vhost which DMA vChannel is going to use. This function needs to
-  be called before register async data-path for vring.
-
-* ``rte_vhost_async_channel_register(vid, queue_id)``
-
-  Register async DMA acceleration for a vhost queue after vring is enabled.
-
-* ``rte_vhost_async_channel_register_thread_unsafe(vid, queue_id)``
-
-  Register async DMA acceleration for a vhost queue without performing
-  any locking.
-
-  This function is only safe to call in vhost callback functions
-  (i.e., struct rte_vhost_device_ops).
-
-* ``rte_vhost_async_channel_unregister(vid, queue_id)``
-
-  Unregister the async DMA acceleration from a vhost queue.
-  Unregistration will fail, if the vhost queue has in-flight
-  packets that are not completed.
-
-  Unregister async DMA acceleration in vring_state_changed() may
-  fail, as this API tries to acquire the spinlock of vhost
-  queue. The recommended way is to unregister async copy
-  devices for all vhost queues in destroy_device(), when a
-  virtio device is paused or shut down.
-
-* ``rte_vhost_async_channel_unregister_thread_unsafe(vid, queue_id)``
-
-  Unregister async DMA acceleration for a vhost queue without performing
-  any locking.
-
-  This function is only safe to call in vhost callback functions
-  (i.e., struct rte_vhost_device_ops).
-
-* ``rte_vhost_submit_enqueue_burst(vid, queue_id, pkts, count, dma_id, vchan_id)``
-
-  Submit an enqueue request to transmit ``count`` packets from host to guest
-  by async data path. Applications must not free the packets submitted for
-  enqueue until the packets are completed.
-
-* ``rte_vhost_poll_enqueue_completed(vid, queue_id, pkts, count, dma_id, vchan_id)``
-
-  Poll enqueue completion status from async data path. Completed packets
-  are returned to applications through ``pkts``.
-
-* ``rte_vhost_async_get_inflight(vid, queue_id)``
-
-  This function returns the amount of in-flight packets for the vhost
-  queue using async acceleration.
-
- * ``rte_vhost_async_get_inflight_thread_unsafe(vid, queue_id)``
-
-  Get the number of inflight packets for a vhost queue without performing
-  any locking. It should only be used within the vhost ops, which already
-  holds the lock.
-
-* ``rte_vhost_clear_queue_thread_unsafe(vid, queue_id, **pkts, count, dma_id, vchan_id)``
-
-  Clear in-flight packets which are submitted to async channel in vhost
-  async data path without performing locking on virtqueue. Completed
-  packets are returned to applications through ``pkts``.
-
-* ``rte_vhost_clear_queue(vid, queue_id, **pkts, count, dma_id, vchan_id)``
-
-  Clear in-flight packets which are submitted to async channel in vhost async data
-  path. Completed packets are returned to applications through ``pkts``.
-
 * ``rte_vhost_vring_call_nonblock(int vid, uint16_t vring_idx)``
 
   Notify the guest that used descriptors have been added to the vring. This function
@@ -327,22 +242,11 @@ The following is an overview of some key Vhost API functions:
   This function resets the queue statistics. It requires statistics
   collection to be enabled at registration time.
 
-* ``rte_vhost_async_try_dequeue_burst(vid, queue_id, mbuf_pool, pkts, count,
-  nr_inflight, dma_id, vchan_id)``
-
-  Receive ``count`` packets from guest to host in async data path,
-  and store them at ``pkts``.
-
 * ``rte_vhost_driver_get_vdpa_dev_type(path, type)``
 
   Get device type of vDPA device, such as VDPA_DEVICE_TYPE_NET,
   VDPA_DEVICE_TYPE_BLK.
 
-* ``rte_vhost_async_dma_unconfigure(dma_id, vchan_id)``
-
-  Clean up a DMA vChannel after use is finished. After this function is called,
-  the specified DMA vChannel should no longer be used by the Vhost library.
-
 * ``rte_vhost_notify_guest(int vid, uint16_t queue_id)``
 
   Inject the offloaded interrupt received by the 'guest_notify' callback,
@@ -411,16 +315,11 @@ Guest memory requirement
 
 * Memory pre-allocation
 
-  For non-async data path guest memory pre-allocation is not a
-  must but can help save memory. To do this we can add option
-  ``-mem-prealloc`` when starting QEMU, or we can lock all memory at vhost
-  side which will force memory to be allocated when it calls mmap
-  (option --mlockall in ovs-dpdk is an example in hand).
-
-
-  For async data path, we force the VM memory to be pre-allocated at vhost
-  lib when mapping the guest memory; and also we need to lock the memory to
-  prevent pages being swapped out to disk.
+  Guest memory pre-allocation is not a must but can help save memory.
+  To do this we can add option ``-mem-prealloc`` when starting QEMU,
+  or we can lock all memory at vhost side which will force memory to
+  be allocated when it calls mmap (option --mlockall in ovs-dpdk is
+  an example in hand).
 
 * Memory sharing
 
@@ -491,43 +390,3 @@ Finally, a set of device ops is defined for device specific operations:
 * ``get_notify_area``
 
   Called to get the notify area info of the queue.
-
-Vhost asynchronous data path
-----------------------------
-
-Vhost asynchronous data path leverages DMA devices to offload memory
-copies from the CPU and it is implemented in an asynchronous way. It
-enables applications, like OVS, to save CPU cycles and hide memory copy
-overhead, thus achieving higher throughput.
-
-Vhost doesn't manage DMA devices and applications, like OVS, need to
-manage and configure DMA devices. Applications need to tell vhost what
-DMA devices to use in every data path function call. This design enables
-the flexibility for applications to dynamically use DMA channels in
-different function modules, not limited in vhost.
-
-In addition, vhost supports M:N mapping between vrings and DMA virtual
-channels. Specifically, one vring can use multiple different DMA channels
-and one DMA channel can be shared by multiple vrings at the same time.
-The reason of enabling one vring to use multiple DMA channels is that
-it's possible that more than one dataplane threads enqueue packets to
-the same vring with their own DMA virtual channels. Besides, the number
-of DMA devices is limited. For the purpose of scaling, it's necessary to
-support sharing DMA channels among vrings.
-
-* Async enqueue API usage
-
-  In async enqueue path, rte_vhost_poll_enqueue_completed() needs to be
-  called in time to notify the guest of DMA copy completed packets.
-  Moreover, calling rte_vhost_submit_enqueue_burst() all the time but
-  not poll completed will cause the DMA ring to be full, which will
-  result in packet loss eventually.
-
-* Recommended IOVA mode in async datapath
-
-  When DMA devices are bound to VFIO driver, VA mode is recommended.
-  For PA mode, page by page mapping may exceed IOMMU's max capability,
-  better to use 1G guest hugepage.
-
-  For UIO driver or kernel driver, any VFIO related error messages
-  can be ignored.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index ecc575ff09..1b23c43b0d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -197,6 +197,26 @@ Removed Items
   The only remaining method for detecting LLDP packets is by using
   the mbuf packet type in conjunction with the ``enable_lldp`` devarg.
 
+* Removed vhost async (DMA-accelerated) data path.
+
+  The experimental async data path APIs have been removed from the vhost library.
+  The following functions and flag are no longer available:
+
+  - ``rte_vhost_async_channel_register``
+  - ``rte_vhost_async_channel_register_thread_unsafe``
+  - ``rte_vhost_async_channel_unregister``
+  - ``rte_vhost_async_channel_unregister_thread_unsafe``
+  - ``rte_vhost_async_dma_configure``
+  - ``rte_vhost_async_dma_unconfigure``
+  - ``rte_vhost_submit_enqueue_burst``
+  - ``rte_vhost_poll_enqueue_completed``
+  - ``rte_vhost_async_try_dequeue_burst``
+  - ``rte_vhost_async_get_inflight``
+  - ``rte_vhost_async_get_inflight_thread_unsafe``
+  - ``rte_vhost_clear_queue``
+  - ``rte_vhost_clear_queue_thread_unsafe``
+  - ``RTE_VHOST_USER_ASYNC_COPY``
+
 
 API Changes
 -----------
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 6a24981d10..208992fa78 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -38,10 +38,9 @@ sources = files(
 headers = files(
         'rte_vdpa.h',
         'rte_vhost.h',
-        'rte_vhost_async.h',
         'rte_vhost_crypto.h',
 )
 driver_sdk_headers = files(
         'vdpa_driver.h',
 )
-deps += ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
+deps += ['ethdev', 'cryptodev', 'hash']
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 095f9b6d3c..79a4138c62 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -38,8 +38,7 @@ extern "C" {
 #define RTE_VHOST_USER_EXTBUF_SUPPORT	(1ULL << 5)
 /* support only linear buffers (no chained mbufs) */
 #define RTE_VHOST_USER_LINEARBUF_SUPPORT	(1ULL << 6)
-#define RTE_VHOST_USER_ASYNC_COPY	(1ULL << 7)
-#define RTE_VHOST_USER_MAP_POPULATE	RTE_VHOST_USER_ASYNC_COPY
+#define RTE_VHOST_USER_MAP_POPULATE	(1ULL << 7)
 #define RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS	(1ULL << 8)
 #define RTE_VHOST_USER_NET_STATS_ENABLE	(1ULL << 9)
 #define RTE_VHOST_USER_ASYNC_CONNECT	(1ULL << 10)
diff --git a/lib/vhost/rte_vhost_async.h b/lib/vhost/rte_vhost_async.h
deleted file mode 100644
index 60995e4e62..0000000000
--- a/lib/vhost/rte_vhost_async.h
+++ /dev/null
@@ -1,293 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2020 Intel Corporation
- */
-
-#ifndef _RTE_VHOST_ASYNC_H_
-#define _RTE_VHOST_ASYNC_H_
-
-#include <stdint.h>
-
-#include <rte_compat.h>
-#include <rte_mbuf.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/**
- * Register an async channel for a vhost queue
- *
- * @param vid
- *  vhost device id async channel to be attached to
- * @param queue_id
- *  vhost queue id async channel to be attached to
- * @return
- *  0 on success, -1 on failures
- */
-__rte_experimental
-int rte_vhost_async_channel_register(int vid, uint16_t queue_id);
-
-/**
- * Unregister an async channel for a vhost queue
- *
- * @param vid
- *  vhost device id async channel to be detached from
- * @param queue_id
- *  vhost queue id async channel to be detached from
- * @return
- *  0 on success, -1 on failures
- */
-__rte_experimental
-int rte_vhost_async_channel_unregister(int vid, uint16_t queue_id);
-
-/**
- * Register an async channel for a vhost queue without performing any
- * locking
- *
- * @note This function does not perform any locking, and is only safe to
- *       call in vhost callback functions.
- *
- * @param vid
- *  vhost device id async channel to be attached to
- * @param queue_id
- *  vhost queue id async channel to be attached to
- * @return
- *  0 on success, -1 on failures
- */
-__rte_experimental
-int rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id);
-
-/**
- * Unregister an async channel for a vhost queue without performing any
- * locking
- *
- * @note This function does not perform any locking, and is only safe to
- *       call in vhost callback functions.
- *
- * @param vid
- *  vhost device id async channel to be detached from
- * @param queue_id
- *  vhost queue id async channel to be detached from
- * @return
- *  0 on success, -1 on failures
- */
-__rte_experimental
-int rte_vhost_async_channel_unregister_thread_unsafe(int vid,
-		uint16_t queue_id);
-
-/**
- * This function submits enqueue packets to async copy engine. Users
- * need to poll transfer status by rte_vhost_poll_enqueue_completed()
- * for successfully enqueued packets.
- *
- * @param vid
- *  id of vhost device to enqueue data
- * @param queue_id
- *  queue id to enqueue data
- * @param pkts
- *  array of packets to be enqueued
- * @param count
- *  packets num to be enqueued
- * @param dma_id
- *  the identifier of DMA device
- * @param vchan_id
- *  the identifier of virtual DMA channel
- * @return
- *  num of packets enqueued
- */
-__rte_experimental
-uint16_t rte_vhost_submit_enqueue_burst(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id);
-
-/**
- * This function checks async completion status for a specific vhost
- * device queue. Packets which finish copying (enqueue) operation
- * will be returned in an array.
- *
- * @param vid
- *  id of vhost device to enqueue data
- * @param queue_id
- *  queue id to enqueue data
- * @param pkts
- *  blank array to get return packet pointer
- * @param count
- *  size of the packet array
- * @param dma_id
- *  the identifier of DMA device
- * @param vchan_id
- *  the identifier of virtual DMA channel
- * @return
- *  num of packets returned
- */
-__rte_experimental
-uint16_t rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id);
-
-/**
- * This function returns the amount of in-flight packets for the vhost
- * queue which uses async channel acceleration.
- *
- * @param vid
- *  id of vhost device to enqueue data
- * @param queue_id
- *  queue id to enqueue data
- * @return
- *  the amount of in-flight packets on success; -1 on failure
- */
-__rte_experimental
-int rte_vhost_async_get_inflight(int vid, uint16_t queue_id);
-
-/**
- * This function is lock-free version to return the amount of in-flight
- * packets for the vhost queue which uses async channel acceleration.
- *
- * @note This function does not perform any locking, it should only be
- * used within the vhost ops, which already holds the lock.
- *
- * @param vid
- * id of vhost device to enqueue data
- * @param queue_id
- * queue id to enqueue data
- * @return
- * the amount of in-flight packets on success; -1 on failure
- */
-__rte_experimental
-int rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id);
-
-/**
- * This function checks async completion status and clear packets for
- * a specific vhost device queue. Packets which are inflight will be
- * returned in an array.
- *
- * @note This function does not perform any locking
- *
- * @param vid
- *  ID of vhost device to clear data
- * @param queue_id
- *  Queue id to clear data
- * @param pkts
- *  Blank array to get return packet pointer
- * @param count
- *  Size of the packet array
- * @param dma_id
- *  the identifier of DMA device
- * @param vchan_id
- *  the identifier of virtual DMA channel
- * @return
- *  Number of packets returned
- */
-__rte_experimental
-uint16_t rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id);
-
-/**
- * This function checks async completion status and clear packets for
- * a specific vhost device queue. Packets which are inflight will be
- * returned in an array.
- *
- * @param vid
- *  ID of vhost device to clear data
- * @param queue_id
- *  Queue id to clear data
- * @param pkts
- *  Blank array to get return packet pointer
- * @param count
- *  Size of the packet array
- * @param dma_id
- *  The identifier of the DMA device
- * @param vchan_id
- *  The identifier of virtual DMA channel
- * @return
- *  Number of packets returned
- */
-__rte_experimental
-uint16_t rte_vhost_clear_queue(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id);
-
-/**
- * The DMA vChannels used in asynchronous data path must be configured
- * first. So this function needs to be called before enabling DMA
- * acceleration for vring. If this function fails, the given DMA vChannel
- * cannot be used in asynchronous data path.
- *
- * DMA devices used in data-path must belong to DMA devices given in this
- * function. Application is free to use DMA devices passed to this function
- * for non-vhost scenarios, but will have to ensure the Vhost library is not
- * using the channel at the same time.
- *
- * @param dma_id
- *  the identifier of DMA device
- * @param vchan_id
- *  the identifier of virtual DMA channel
- * @return
- *  0 on success, and -1 on failure
- */
-__rte_experimental
-int rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id);
-
-/**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
- * This function tries to receive packets from the guest with offloading
- * copies to the DMA vChannels. Successfully dequeued packets are returned
- * in "pkts". The other packets that their copies are submitted to
- * the DMA vChannels but not completed are called "in-flight packets".
- * This function will not return in-flight packets until their copies are
- * completed by the DMA vChannels.
- *
- * @param vid
- *  ID of vhost device to dequeue data
- * @param queue_id
- *  ID of virtqueue to dequeue data
- * @param mbuf_pool
- *  Mbuf_pool where host mbuf is allocated
- * @param pkts
- *  Blank array to keep successfully dequeued packets
- * @param count
- *  Size of the packet array
- * @param nr_inflight
- *  >= 0: The amount of in-flight packets
- *  -1: Meaningless, indicates failed lock acquisition or invalid queue_id/dma_id
- * @param dma_id
- *  The identifier of DMA device
- * @param vchan_id
- *  The identifier of virtual DMA channel
- * @return
- *  Number of successfully dequeued packets
- */
-__rte_experimental
-uint16_t
-rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
-	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-	int *nr_inflight, int16_t dma_id, uint16_t vchan_id);
-
-/**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
- * Unconfigure DMA vChannel in Vhost asynchronous data path.
- * This function should be called when the specified DMA vChannel is no longer
- * used by the Vhost library. Before this function is called, make sure there
- * does not exist in-flight packets in DMA vChannel.
- *
- * @param dma_id
- *  the identifier of DMA device
- * @param vchan_id
- *  the identifier of virtual DMA channel
- * @return
- *  0 on success, and -1 on failure
- */
-__rte_experimental
-int
-rte_vhost_async_dma_unconfigure(int16_t dma_id, uint16_t vchan_id);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _RTE_VHOST_ASYNC_H_ */
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 956f3b2d71..2d3fe1fd53 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -43,7 +43,6 @@ struct vhost_user_socket {
 	bool use_builtin_virtio_net;
 	bool extbuf;
 	bool linearbuf;
-	bool async_copy;
 	bool map_populate;
 	bool net_compliant_ol_flags;
 	bool stats_enabled;
@@ -240,13 +239,6 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 	if (vsocket->linearbuf)
 		vhost_enable_linearbuf(vid);
 
-	if (vsocket->async_copy) {
-		dev = get_device(vid);
-
-		if (dev)
-			dev->async_copy = 1;
-	}
-
 	if (vsocket->map_populate) {
 		dev = get_device(vid);
 
@@ -944,7 +936,6 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	vsocket->max_queue_pairs = VHOST_MAX_QUEUE_PAIRS;
 	vsocket->extbuf = flags & RTE_VHOST_USER_EXTBUF_SUPPORT;
 	vsocket->linearbuf = flags & RTE_VHOST_USER_LINEARBUF_SUPPORT;
-	vsocket->async_copy = flags & RTE_VHOST_USER_ASYNC_COPY;
 	vsocket->map_populate = flags & RTE_VHOST_USER_MAP_POPULATE;
 	vsocket->net_compliant_ol_flags = flags & RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 	vsocket->stats_enabled = flags & RTE_VHOST_USER_NET_STATS_ENABLE;
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index fde8acb00c..1c41438f20 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -25,7 +25,6 @@
 
 struct virtio_net *vhost_devices[RTE_MAX_VHOST_DEVICE];
 pthread_mutex_t vhost_dev_lock = PTHREAD_MUTEX_INITIALIZER;
-pthread_mutex_t vhost_dma_lock = PTHREAD_MUTEX_INITIALIZER;
 
 struct vhost_vq_stats_name_off {
 	char name[RTE_VHOST_STATS_NAME_SIZE];
@@ -54,8 +53,6 @@ static const struct vhost_vq_stats_name_off vhost_vq_stat_strings[] = {
 		stats.guest_notifications_suppressed)},
 	{"iotlb_hits",             offsetof(struct vhost_virtqueue, stats.iotlb_hits)},
 	{"iotlb_misses",           offsetof(struct vhost_virtqueue, stats.iotlb_misses)},
-	{"inflight_submitted",     offsetof(struct vhost_virtqueue, stats.inflight_submitted)},
-	{"inflight_completed",     offsetof(struct vhost_virtqueue, stats.inflight_completed)},
 	{"mbuf_alloc_failed",      offsetof(struct vhost_virtqueue, stats.mbuf_alloc_failed)},
 };
 
@@ -373,25 +370,6 @@ cleanup_device(struct virtio_net *dev, int destroy)
 	}
 }
 
-static void
-vhost_free_async_mem(struct vhost_virtqueue *vq)
-	__rte_requires_capability(&vq->access_lock)
-{
-	if (!vq->async)
-		return;
-
-	rte_free(vq->async->pkts_info);
-	rte_free(vq->async->pkts_cmpl_flag);
-
-	rte_free(vq->async->buffers_packed);
-	vq->async->buffers_packed = NULL;
-	rte_free(vq->async->descs_split);
-	vq->async->descs_split = NULL;
-
-	rte_free(vq->async);
-	vq->async = NULL;
-}
-
 void
 free_vq(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
@@ -400,9 +378,6 @@ free_vq(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	else
 		rte_free(vq->shadow_used_split);
 
-	rte_rwlock_write_lock(&vq->access_lock);
-	vhost_free_async_mem(vq);
-	rte_rwlock_write_unlock(&vq->access_lock);
 	rte_free(vq->batch_copy_elems);
 	rte_free(vq->log_cache);
 	rte_free(vq);
@@ -1779,363 +1754,6 @@ rte_vhost_extern_callback_register(int vid,
 	return 0;
 }
 
-static __rte_always_inline int
-async_channel_register(struct virtio_net *dev, struct vhost_virtqueue *vq)
-	__rte_requires_capability(&vq->access_lock)
-{
-	struct vhost_async *async;
-	int node = vq->numa_node;
-
-	if (unlikely(vq->async)) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"async register failed: already registered (qid: %d)",
-			vq->index);
-		return -1;
-	}
-
-	async = rte_zmalloc_socket(NULL, sizeof(struct vhost_async), 0, node);
-	if (!async) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"failed to allocate async metadata (qid: %d)",
-			vq->index);
-		return -1;
-	}
-
-	async->pkts_info = rte_malloc_socket(NULL, vq->size * sizeof(struct async_inflight_info),
-			RTE_CACHE_LINE_SIZE, node);
-	if (!async->pkts_info) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"failed to allocate async_pkts_info (qid: %d)",
-			vq->index);
-		goto out_free_async;
-	}
-
-	async->pkts_cmpl_flag = rte_zmalloc_socket(NULL, vq->size * sizeof(bool),
-			RTE_CACHE_LINE_SIZE, node);
-	if (!async->pkts_cmpl_flag) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"failed to allocate async pkts_cmpl_flag (qid: %d)",
-			vq->index);
-		goto out_free_async;
-	}
-
-	if (vq_is_packed(dev)) {
-		async->buffers_packed = rte_malloc_socket(NULL,
-				vq->size * sizeof(struct vring_used_elem_packed),
-				RTE_CACHE_LINE_SIZE, node);
-		if (!async->buffers_packed) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"failed to allocate async buffers (qid: %d)",
-				vq->index);
-			goto out_free_inflight;
-		}
-	} else {
-		async->descs_split = rte_malloc_socket(NULL,
-				vq->size * sizeof(struct vring_used_elem),
-				RTE_CACHE_LINE_SIZE, node);
-		if (!async->descs_split) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"failed to allocate async descs (qid: %d)",
-				vq->index);
-			goto out_free_inflight;
-		}
-	}
-
-	vq->async = async;
-
-	return 0;
-out_free_inflight:
-	rte_free(async->pkts_info);
-out_free_async:
-	rte_free(async);
-
-	return -1;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register, 20.08)
-int
-rte_vhost_async_channel_register(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-	int ret;
-
-	if (dev == NULL)
-		return -1;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return -1;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (unlikely(vq == NULL || !dev->async_copy || dev->vdpa_dev != NULL))
-		return -1;
-
-	rte_rwlock_write_lock(&vq->access_lock);
-
-	if (unlikely(!vq->access_ok)) {
-		ret = -1;
-		goto out_unlock;
-	}
-
-	ret = async_channel_register(dev, vq);
-
-out_unlock:
-	rte_rwlock_write_unlock(&vq->access_lock);
-
-	return ret;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register_thread_unsafe, 21.08)
-int
-rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-
-	if (dev == NULL)
-		return -1;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return -1;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (unlikely(vq == NULL || !dev->async_copy || dev->vdpa_dev != NULL))
-		return -1;
-
-	vq_assert_lock(dev, vq);
-
-	return async_channel_register(dev, vq);
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister, 20.08)
-int
-rte_vhost_async_channel_unregister(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-	int ret = -1;
-
-	if (dev == NULL)
-		return ret;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return ret;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (vq == NULL)
-		return ret;
-
-	if (rte_rwlock_write_trylock(&vq->access_lock)) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"failed to unregister async channel, virtqueue busy.");
-		return ret;
-	}
-
-	if (unlikely(!vq->access_ok)) {
-		ret = -1;
-		goto out_unlock;
-	}
-
-	if (!vq->async) {
-		ret = 0;
-	} else if (vq->async->pkts_inflight_n) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to unregister async channel.");
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"inflight packets must be completed before unregistration.");
-	} else {
-		vhost_free_async_mem(vq);
-		ret = 0;
-	}
-
-out_unlock:
-	rte_rwlock_write_unlock(&vq->access_lock);
-
-	return ret;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister_thread_unsafe, 21.08)
-int
-rte_vhost_async_channel_unregister_thread_unsafe(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-
-	if (dev == NULL)
-		return -1;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return -1;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (vq == NULL)
-		return -1;
-
-	vq_assert_lock(dev, vq);
-
-	if (!vq->async)
-		return 0;
-
-	if (vq->async->pkts_inflight_n) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to unregister async channel.");
-		VHOST_CONFIG_LOG(dev->ifname, ERR,
-			"inflight packets must be completed before unregistration.");
-		return -1;
-	}
-
-	vhost_free_async_mem(vq);
-
-	return 0;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_configure, 22.03)
-int
-rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
-{
-	struct rte_dma_info info;
-	void *pkts_cmpl_flag_addr;
-	uint16_t max_desc;
-
-	pthread_mutex_lock(&vhost_dma_lock);
-
-	if (!rte_dma_is_valid(dma_id)) {
-		VHOST_CONFIG_LOG("dma", ERR, "DMA %d is not found.", dma_id);
-		goto error;
-	}
-
-	if (rte_dma_info_get(dma_id, &info) != 0) {
-		VHOST_CONFIG_LOG("dma", ERR, "Fail to get DMA %d information.", dma_id);
-		goto error;
-	}
-
-	if (vchan_id >= info.max_vchans) {
-		VHOST_CONFIG_LOG("dma", ERR, "Invalid DMA %d vChannel %u.", dma_id, vchan_id);
-		goto error;
-	}
-
-	if (!dma_copy_track[dma_id].vchans) {
-		struct async_dma_vchan_info *vchans;
-
-		vchans = rte_zmalloc(NULL, sizeof(struct async_dma_vchan_info) * info.max_vchans,
-				RTE_CACHE_LINE_SIZE);
-		if (vchans == NULL) {
-			VHOST_CONFIG_LOG("dma", ERR,
-				"Failed to allocate vchans for DMA %d vChannel %u.",
-				dma_id, vchan_id);
-			goto error;
-		}
-
-		dma_copy_track[dma_id].vchans = vchans;
-	}
-
-	if (dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr) {
-		VHOST_CONFIG_LOG("dma", INFO, "DMA %d vChannel %u already registered.",
-			dma_id, vchan_id);
-		pthread_mutex_unlock(&vhost_dma_lock);
-		return 0;
-	}
-
-	max_desc = info.max_desc;
-	if (!rte_is_power_of_2(max_desc))
-		max_desc = rte_align32pow2(max_desc);
-
-	pkts_cmpl_flag_addr = rte_zmalloc(NULL, sizeof(bool *) * max_desc, RTE_CACHE_LINE_SIZE);
-	if (!pkts_cmpl_flag_addr) {
-		VHOST_CONFIG_LOG("dma", ERR,
-			"Failed to allocate pkts_cmpl_flag_addr for DMA %d vChannel %u.",
-			dma_id, vchan_id);
-
-		if (dma_copy_track[dma_id].nr_vchans == 0) {
-			rte_free(dma_copy_track[dma_id].vchans);
-			dma_copy_track[dma_id].vchans = NULL;
-		}
-		goto error;
-	}
-
-	dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr = pkts_cmpl_flag_addr;
-	dma_copy_track[dma_id].vchans[vchan_id].ring_size = max_desc;
-	dma_copy_track[dma_id].vchans[vchan_id].ring_mask = max_desc - 1;
-	dma_copy_track[dma_id].nr_vchans++;
-
-	pthread_mutex_unlock(&vhost_dma_lock);
-	return 0;
-
-error:
-	pthread_mutex_unlock(&vhost_dma_lock);
-	return -1;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight, 21.08)
-int
-rte_vhost_async_get_inflight(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-	int ret = -1;
-
-	if (dev == NULL)
-		return ret;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return ret;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (vq == NULL)
-		return ret;
-
-	if (rte_rwlock_write_trylock(&vq->access_lock)) {
-		VHOST_CONFIG_LOG(dev->ifname, DEBUG,
-			"failed to check in-flight packets. virtqueue busy.");
-		return ret;
-	}
-
-	if (unlikely(!vq->access_ok)) {
-		ret = -1;
-		goto out_unlock;
-	}
-
-	if (vq->async)
-		ret = vq->async->pkts_inflight_n;
-
-out_unlock:
-	rte_rwlock_write_unlock(&vq->access_lock);
-
-	return ret;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight_thread_unsafe, 22.07)
-int
-rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id)
-{
-	struct vhost_virtqueue *vq;
-	struct virtio_net *dev = get_device(vid);
-	int ret = -1;
-
-	if (dev == NULL)
-		return ret;
-
-	if (queue_id >= VHOST_MAX_VRING)
-		return ret;
-
-	vq = dev->virtqueue[queue_id];
-
-	if (vq == NULL)
-		return ret;
-
-	vq_assert_lock(dev, vq);
-
-	if (!vq->async)
-		return ret;
-
-	ret = vq->async->pkts_inflight_n;
-
-	return ret;
-}
-
 RTE_EXPORT_SYMBOL(rte_vhost_get_monitor_addr)
 int
 rte_vhost_get_monitor_addr(int vid, uint16_t queue_id,
@@ -2304,59 +1922,5 @@ int rte_vhost_vring_stats_reset(int vid, uint16_t queue_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_unconfigure, 22.11)
-int
-rte_vhost_async_dma_unconfigure(int16_t dma_id, uint16_t vchan_id)
-{
-	struct rte_dma_info info;
-	struct rte_dma_stats stats = { 0 };
-
-	pthread_mutex_lock(&vhost_dma_lock);
-
-	if (!rte_dma_is_valid(dma_id)) {
-		VHOST_CONFIG_LOG("dma", ERR, "DMA %d is not found.", dma_id);
-		goto error;
-	}
-
-	if (rte_dma_info_get(dma_id, &info) != 0) {
-		VHOST_CONFIG_LOG("dma", ERR, "Fail to get DMA %d information.", dma_id);
-		goto error;
-	}
-
-	if (vchan_id >= info.max_vchans || !dma_copy_track[dma_id].vchans ||
-		!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr) {
-		VHOST_CONFIG_LOG("dma", ERR, "Invalid channel %d:%u.", dma_id, vchan_id);
-		goto error;
-	}
-
-	if (rte_dma_stats_get(dma_id, vchan_id, &stats) != 0) {
-		VHOST_CONFIG_LOG("dma", ERR,
-				 "Failed to get stats for DMA %d vChannel %u.", dma_id, vchan_id);
-		goto error;
-	}
-
-	if (stats.submitted - stats.completed != 0) {
-		VHOST_CONFIG_LOG("dma", ERR,
-				 "Do not unconfigure when there are inflight packets.");
-		goto error;
-	}
-
-	rte_free(dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr);
-	dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr = NULL;
-	dma_copy_track[dma_id].nr_vchans--;
-
-	if (dma_copy_track[dma_id].nr_vchans == 0) {
-		rte_free(dma_copy_track[dma_id].vchans);
-		dma_copy_track[dma_id].vchans = NULL;
-	}
-
-	pthread_mutex_unlock(&vhost_dma_lock);
-	return 0;
-
-error:
-	pthread_mutex_unlock(&vhost_dma_lock);
-	return -1;
-}
-
 RTE_LOG_REGISTER_SUFFIX(vhost_config_log_level, config, INFO);
 RTE_LOG_REGISTER_SUFFIX(vhost_data_log_level, data, WARNING);
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 7b5c6ccbe2..888c2aba3e 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -18,13 +18,10 @@
 #include <rte_log.h>
 #include <rte_ether.h>
 #include <rte_malloc.h>
-#include <rte_dmadev.h>
 
 #include "rte_vhost.h"
 #include "vdpa_driver.h"
 
-#include "rte_vhost_async.h"
-
 /* Used to indicate that the device is running on a data core */
 #define VIRTIO_DEV_RUNNING ((uint32_t)1 << 0)
 /* Used to indicate that the device is ready to operate */
@@ -51,11 +48,7 @@
 
 #define MAX_PKT_BURST 32
 
-#define VHOST_MAX_ASYNC_IT (MAX_PKT_BURST)
-#define VHOST_MAX_ASYNC_VEC 2048
 #define VIRTIO_MAX_RX_PKTLEN 9728U
-#define VHOST_DMA_MAX_COPY_COMPLETE ((VIRTIO_MAX_RX_PKTLEN / RTE_MBUF_DEFAULT_DATAROOM) \
-		* MAX_PKT_BURST)
 
 #define PACKED_DESC_ENQUEUE_USED_FLAG(w)	\
 	((w) ? (VRING_DESC_F_AVAIL | VRING_DESC_F_USED | VRING_DESC_F_WRITE) : \
@@ -145,8 +138,6 @@ struct virtqueue_stats {
 	uint64_t size_bins[8];
 	uint64_t iotlb_hits;
 	uint64_t iotlb_misses;
-	uint64_t inflight_submitted;
-	uint64_t inflight_completed;
 	uint64_t mbuf_alloc_failed;
 	uint64_t guest_notifications_suppressed;
 	/* Counters below are atomic, and should be incremented as such. */
@@ -155,111 +146,6 @@ struct virtqueue_stats {
 	RTE_ATOMIC(uint64_t) guest_notifications_error;
 };
 
-/**
- * iovec
- */
-struct vhost_iovec {
-	void *src_addr;
-	void *dst_addr;
-	size_t len;
-};
-
-/**
- * iovec iterator
- */
-struct vhost_iov_iter {
-	/** pointer to the iovec array */
-	struct vhost_iovec *iov;
-	/** number of iovec in this iterator */
-	unsigned long nr_segs;
-};
-
-struct async_dma_vchan_info {
-	/* circular array to track if packet copy completes */
-	bool **pkts_cmpl_flag_addr;
-
-	/* max elements in 'pkts_cmpl_flag_addr' */
-	uint16_t ring_size;
-	/* ring index mask for 'pkts_cmpl_flag_addr' */
-	uint16_t ring_mask;
-
-	/**
-	 * DMA virtual channel lock. Although it is able to bind DMA
-	 * virtual channels to data plane threads, vhost control plane
-	 * thread could call data plane functions too, thus causing
-	 * DMA device contention.
-	 *
-	 * For example, in VM exit case, vhost control plane thread needs
-	 * to clear in-flight packets before disable vring, but there could
-	 * be anotther data plane thread is enqueuing packets to the same
-	 * vring with the same DMA virtual channel. As dmadev PMD functions
-	 * are lock-free, the control plane and data plane threads could
-	 * operate the same DMA virtual channel at the same time.
-	 */
-	rte_spinlock_t dma_lock;
-};
-
-struct async_dma_info {
-	struct async_dma_vchan_info *vchans;
-	/* number of registered virtual channels */
-	uint16_t nr_vchans;
-};
-
-extern struct async_dma_info dma_copy_track[RTE_DMADEV_DEFAULT_MAX];
-
-/**
- * inflight async packet information
- */
-struct async_inflight_info {
-	struct rte_mbuf *mbuf;
-	uint16_t descs; /* num of descs inflight */
-	uint16_t nr_buffers; /* num of buffers inflight for packed ring */
-	struct virtio_net_hdr nethdr;
-};
-
-struct vhost_async {
-	struct vhost_iov_iter iov_iter[VHOST_MAX_ASYNC_IT];
-	struct vhost_iovec iovec[VHOST_MAX_ASYNC_VEC];
-	uint16_t iter_idx;
-	uint16_t iovec_idx;
-
-	/* data transfer status */
-	struct async_inflight_info *pkts_info;
-	/**
-	 * Packet reorder array. "true" indicates that DMA device
-	 * completes all copies for the packet.
-	 *
-	 * Note that this array could be written by multiple threads
-	 * simultaneously. For example, in the case of thread0 and
-	 * thread1 RX packets from NIC and then enqueue packets to
-	 * vring0 and vring1 with own DMA device DMA0 and DMA1, it's
-	 * possible for thread0 to get completed copies belonging to
-	 * vring1 from DMA0, while thread0 is calling rte_vhost_poll
-	 * _enqueue_completed() for vring0 and thread1 is calling
-	 * rte_vhost_submit_enqueue_burst() for vring1. In this case,
-	 * vq->access_lock cannot protect pkts_cmpl_flag of vring1.
-	 *
-	 * However, since offloading is per-packet basis, each packet
-	 * flag will only be written by one thread. And single byte
-	 * write is atomic, so no lock for pkts_cmpl_flag is needed.
-	 */
-	bool *pkts_cmpl_flag;
-	uint16_t pkts_idx;
-	uint16_t pkts_inflight_n;
-	union {
-		struct vring_used_elem  *descs_split;
-		struct vring_used_elem_packed *buffers_packed;
-	};
-	union {
-		uint16_t desc_idx_split;
-		uint16_t buffer_idx_packed;
-	};
-	union {
-		uint16_t last_desc_idx_split;
-		uint16_t last_buffer_idx_packed;
-	};
-};
-
 #define VHOST_RECONNECT_VERSION		0x0
 #define VHOST_MAX_QUEUE_PAIRS		0x80
 /* Max vring count: 2 per queue pair plus 1 control queue */
@@ -352,8 +238,6 @@ struct __rte_cache_aligned vhost_virtqueue {
 	struct rte_vhost_resubmit_info *resubmit_inflight;
 	uint64_t		global_counter;
 
-	struct vhost_async	*async __rte_guarded_var;
-
 	int			notif_enable;
 #define VIRTIO_UNINITIALIZED_NOTIF	(-1)
 
@@ -498,7 +382,6 @@ struct __rte_cache_aligned virtio_net {
 	/* to tell if we need broadcast rarp packet */
 	RTE_ATOMIC(int16_t)	broadcast_rarp;
 	uint32_t		nr_vring;
-	int			async_copy;
 	int			map_populate;
 
 	int			extbuf;
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index e87ab82e63..e5bbe937c3 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -42,7 +42,6 @@
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
-#include <rte_vfio.h>
 #include <rte_errno.h>
 
 #include "iotlb.h"
@@ -174,80 +173,6 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
-static int
-async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
-{
-	uint32_t i;
-	int ret;
-	uint64_t reg_start = reg->host_user_addr;
-	uint64_t reg_end = reg_start + reg->size;
-
-	for (i = 0; i < dev->nr_guest_pages; i++) {
-		struct guest_page *page = &dev->guest_pages[i];
-
-		/* Only process pages belonging to this region */
-		if (page->host_user_addr < reg_start ||
-		    page->host_user_addr >= reg_end)
-			continue;
-
-		if (do_map) {
-			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
-					page->host_user_addr,
-					page->host_iova,
-					page->size);
-			if (ret) {
-				/*
-				 * DMA device may bind with kernel driver, in this case,
-				 * we don't need to program IOMMU manually. However, if no
-				 * device is bound with vfio/uio in DPDK, and vfio kernel
-				 * module is loaded, the API will still be called and return
-				 * with ENODEV.
-				 *
-				 * DPDK vfio only returns ENODEV in very similar situations
-				 * (vfio either unsupported, or supported but no devices found).
-				 * Either way, no mappings could be performed. We treat it as
-				 * normal case in async path. This is a workaround.
-				 */
-				if (rte_errno == ENODEV)
-					return 0;
-
-				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
-				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
-				return -1;
-			}
-		} else {
-			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
-					page->host_user_addr,
-					page->host_iova,
-					page->size);
-			if (ret) {
-				/* like DMA map, ignore the kernel driver case when unmap. */
-				if (rte_errno == EINVAL)
-					return 0;
-
-				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
-				return -1;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static void
-async_dma_map(struct virtio_net *dev, bool do_map)
-{
-	uint32_t i;
-	struct rte_vhost_mem_region *reg;
-
-	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
-		reg = &dev->mem->regions[i];
-		if (reg->host_user_addr == 0)
-			continue;
-		async_dma_map_region(dev, reg, do_map);
-	}
-}
-
 static void
 free_mem_region(struct rte_vhost_mem_region *reg)
 {
@@ -267,9 +192,6 @@ free_all_mem_regions(struct virtio_net *dev)
 	if (!dev || !dev->mem)
 		return;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map(dev, false);
-
 	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		reg = &dev->mem->regions[i];
 		if (reg->mmap_addr)
@@ -1490,7 +1412,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct rte_vhost_mem_region *reg;
 	uint64_t mmap_offset;
 	uint32_t i;
-	bool async_notify = false;
 
 	if (validate_msg_fds(dev, ctx, memory->nregions) != 0)
 		return RTE_VHOST_MSG_RESULT_ERR;
@@ -1519,15 +1440,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 			dev->flags &= ~VIRTIO_DEV_VDPA_CONFIGURED;
 		}
 
-		/* notify the vhost application to stop DMA transfers */
-		if (dev->async_copy && dev->notify_ops->vring_state_changed) {
-			for (i = 0; i < dev->nr_vring; i++) {
-				dev->notify_ops->vring_state_changed(dev->vid,
-						i, 0);
-			}
-			async_notify = true;
-		}
-
 		/* Flush IOTLB cache as previous HVAs are now invalid */
 		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 			vhost_user_iotlb_flush_all(dev);
@@ -1564,9 +1476,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 		dev->mem->nregions++;
 	}
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map(dev, true);
-
 	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
 		goto free_mem_table;
 
@@ -1594,11 +1503,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 
 	dump_guest_pages(dev);
 
-	if (async_notify) {
-		for (i = 0; i < dev->nr_vring; i++)
-			dev->notify_ops->vring_state_changed(dev->vid, i, 1);
-	}
-
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_mem_table:
@@ -1750,11 +1654,6 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 
 	dev->mem->nregions++;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
-		if (async_dma_map_region(dev, reg, true) < 0)
-			goto free_new_region_no_dma;
-	}
-
 	if (dev->postcopy_listening) {
 		/*
 		 * Cannot use vhost_user_postcopy_register() here because it
@@ -1791,9 +1690,6 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_new_region:
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map_region(dev, reg, false);
-free_new_region_no_dma:
 	remove_guest_pages(dev, reg);
 	free_mem_region(reg);
 	dev->mem->nregions--;
@@ -1827,8 +1723,6 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
 		if (region->userspace_addr == current_region->guest_user_addr
 			&& region->guest_phys_addr == current_region->guest_phys_addr
 			&& region->memory_size == current_region->size) {
-			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-				async_dma_map_region(dev, current_region, false);
 			if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 				vhost_user_iotlb_cache_remove(dev,
 					current_region->guest_phys_addr,
@@ -2613,11 +2507,6 @@ vhost_user_set_vring_enable(struct virtio_net **pdev,
 	if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
 		/* vhost_user_lock_all_queue_pairs locked all qps */
 		VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_SET_VRING_ENABLE);
-		if (enable && vq->async && vq->async->pkts_inflight_n) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"failed to enable vring. Inflight packets must be completed first");
-			return RTE_VHOST_MSG_RESULT_ERR;
-		}
 	}
 
 	vq->enabled = enable;
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 0658b81de5..9ad7fa3295 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -12,29 +12,18 @@
 #include <rte_net.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
-#include <rte_dmadev.h>
 #include <rte_vhost.h>
 #include <rte_tcp.h>
 #include <rte_udp.h>
 #include <rte_sctp.h>
 #include <rte_arp.h>
-#include <rte_spinlock.h>
 #include <rte_malloc.h>
-#include <rte_vhost_async.h>
 
 #include "iotlb.h"
 #include "vhost.h"
 
 #define MAX_BATCH_LEN 256
 
-static __rte_always_inline uint16_t
-async_poll_dequeue_completed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id, bool legacy_ol_flags);
-
-/* DMA device copy operation tracking array. */
-struct async_dma_info dma_copy_track[RTE_DMADEV_DEFAULT_MAX];
-
 static  __rte_always_inline bool
 rxvq_is_mergeable(struct virtio_net *dev)
 {
@@ -87,139 +76,6 @@ vhost_queue_stats_update(const struct virtio_net *dev, struct vhost_virtqueue *v
 	}
 }
 
-static __rte_always_inline int64_t
-vhost_async_dma_transfer_one(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		int16_t dma_id, uint16_t vchan_id, uint16_t flag_idx,
-		struct vhost_iov_iter *pkt)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct async_dma_vchan_info *dma_info = &dma_copy_track[dma_id].vchans[vchan_id];
-	uint16_t ring_mask = dma_info->ring_mask;
-	static bool vhost_async_dma_copy_log;
-
-
-	struct vhost_iovec *iov = pkt->iov;
-	int copy_idx = 0;
-	uint32_t nr_segs = pkt->nr_segs;
-	uint16_t i;
-
-	if (rte_dma_burst_capacity(dma_id, vchan_id) < nr_segs)
-		return -1;
-
-	for (i = 0; i < nr_segs; i++) {
-		copy_idx = rte_dma_copy(dma_id, vchan_id, (rte_iova_t)iov[i].src_addr,
-				(rte_iova_t)iov[i].dst_addr, iov[i].len, RTE_DMA_OP_FLAG_LLC);
-		/**
-		 * Since all memory is pinned and DMA vChannel
-		 * ring has enough space, failure should be a
-		 * rare case. If failure happens, it means DMA
-		 * device encounters serious errors; in this
-		 * case, please stop async data-path and check
-		 * what has happened to DMA device.
-		 */
-		if (unlikely(copy_idx < 0)) {
-			if (!vhost_async_dma_copy_log) {
-				VHOST_DATA_LOG(dev->ifname, ERR,
-					"DMA copy failed for channel %d:%u",
-					dma_id, vchan_id);
-				vhost_async_dma_copy_log = true;
-			}
-			return -1;
-		}
-	}
-
-	/**
-	 * Only store packet completion flag address in the last copy's
-	 * slot, and other slots are set to NULL.
-	 */
-	dma_info->pkts_cmpl_flag_addr[copy_idx & ring_mask] = &vq->async->pkts_cmpl_flag[flag_idx];
-
-	return nr_segs;
-}
-
-static __rte_always_inline uint16_t
-vhost_async_dma_transfer(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		int16_t dma_id, uint16_t vchan_id, uint16_t head_idx,
-		struct vhost_iov_iter *pkts, uint16_t nr_pkts)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct async_dma_vchan_info *dma_info = &dma_copy_track[dma_id].vchans[vchan_id];
-	int64_t ret, nr_copies = 0;
-	uint16_t pkt_idx;
-
-	rte_spinlock_lock(&dma_info->dma_lock);
-
-	for (pkt_idx = 0; pkt_idx < nr_pkts; pkt_idx++) {
-		ret = vhost_async_dma_transfer_one(dev, vq, dma_id, vchan_id, head_idx,
-				&pkts[pkt_idx]);
-		if (unlikely(ret < 0))
-			break;
-
-		nr_copies += ret;
-		head_idx++;
-		if (head_idx >= vq->size)
-			head_idx -= vq->size;
-	}
-
-	if (likely(nr_copies > 0))
-		rte_dma_submit(dma_id, vchan_id);
-
-	rte_spinlock_unlock(&dma_info->dma_lock);
-
-	return pkt_idx;
-}
-
-static __rte_always_inline uint16_t
-vhost_async_dma_check_completed(struct virtio_net *dev, int16_t dma_id, uint16_t vchan_id,
-		uint16_t max_pkts)
-{
-	struct async_dma_vchan_info *dma_info = &dma_copy_track[dma_id].vchans[vchan_id];
-	uint16_t ring_mask = dma_info->ring_mask;
-	uint16_t last_idx = 0;
-	uint16_t nr_copies;
-	uint16_t copy_idx;
-	uint16_t i;
-	bool has_error = false;
-	static bool vhost_async_dma_complete_log;
-
-	rte_spinlock_lock(&dma_info->dma_lock);
-
-	/**
-	 * Print error log for debugging, if DMA reports error during
-	 * DMA transfer. We do not handle error in vhost level.
-	 */
-	nr_copies = rte_dma_completed(dma_id, vchan_id, max_pkts, &last_idx, &has_error);
-	if (unlikely(!vhost_async_dma_complete_log && has_error)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"DMA completion failure on channel %d:%u",
-			dma_id, vchan_id);
-		vhost_async_dma_complete_log = true;
-	} else if (nr_copies == 0) {
-		goto out;
-	}
-
-	copy_idx = last_idx - nr_copies + 1;
-	for (i = 0; i < nr_copies; i++) {
-		bool *flag;
-
-		flag = dma_info->pkts_cmpl_flag_addr[copy_idx & ring_mask];
-		if (flag) {
-			/**
-			 * Mark the packet flag as received. The flag
-			 * could belong to another virtqueue but write
-			 * is atomic.
-			 */
-			*flag = true;
-			dma_info->pkts_cmpl_flag_addr[copy_idx & ring_mask] = NULL;
-		}
-		copy_idx++;
-	}
-
-out:
-	rte_spinlock_unlock(&dma_info->dma_lock);
-	return nr_copies;
-}
-
 static inline void
 do_data_copy_enqueue(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
@@ -423,43 +279,6 @@ vhost_flush_enqueue_batch_packed(struct virtio_net *dev,
 	vq_inc_last_used_packed(vq, PACKED_BATCH_SIZE);
 }
 
-static __rte_always_inline void
-vhost_async_shadow_enqueue_packed_batch(struct vhost_virtqueue *vq,
-				 uint64_t *lens,
-				 uint16_t *ids)
-	__rte_requires_capability(&vq->access_lock)
-{
-	uint16_t i;
-	struct vhost_async *async = vq->async;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		async->buffers_packed[async->buffer_idx_packed].id  = ids[i];
-		async->buffers_packed[async->buffer_idx_packed].len = lens[i];
-		async->buffers_packed[async->buffer_idx_packed].count = 1;
-		async->buffer_idx_packed++;
-		if (async->buffer_idx_packed >= vq->size)
-			async->buffer_idx_packed -= vq->size;
-	}
-}
-
-static __rte_always_inline void
-vhost_async_shadow_dequeue_packed_batch(struct vhost_virtqueue *vq, uint16_t *ids)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	uint16_t i;
-	struct vhost_async *async = vq->async;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		async->buffers_packed[async->buffer_idx_packed].id  = ids[i];
-		async->buffers_packed[async->buffer_idx_packed].len = 0;
-		async->buffers_packed[async->buffer_idx_packed].count = 1;
-
-		async->buffer_idx_packed++;
-		if (async->buffer_idx_packed >= vq->size)
-			async->buffer_idx_packed -= vq->size;
-	}
-}
-
 static __rte_always_inline void
 vhost_shadow_dequeue_batch_packed_inorder(struct vhost_virtqueue *vq,
 					  uint16_t id)
@@ -600,27 +419,6 @@ vhost_shadow_enqueue_packed(struct vhost_virtqueue *vq,
 	}
 }
 
-static __rte_always_inline void
-vhost_async_shadow_enqueue_packed(struct vhost_virtqueue *vq,
-				   uint32_t *len,
-				   uint16_t *id,
-				   uint16_t *count,
-				   uint16_t num_buffers)
-	__rte_requires_capability(&vq->access_lock)
-{
-	uint16_t i;
-	struct vhost_async *async = vq->async;
-
-	for (i = 0; i < num_buffers; i++) {
-		async->buffers_packed[async->buffer_idx_packed].id  = id[i];
-		async->buffers_packed[async->buffer_idx_packed].len = len[i];
-		async->buffers_packed[async->buffer_idx_packed].count = count[i];
-		async->buffer_idx_packed++;
-		if (async->buffer_idx_packed >= vq->size)
-			async->buffer_idx_packed -= vq->size;
-	}
-}
-
 static __rte_always_inline void
 vhost_shadow_enqueue_single_packed(struct virtio_net *dev,
 				   struct vhost_virtqueue *vq,
@@ -1045,120 +843,6 @@ copy_vnet_hdr_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	}
 }
 
-static __rte_always_inline int
-async_iter_initialize(struct virtio_net *dev, struct vhost_async *async)
-{
-	struct vhost_iov_iter *iter;
-
-	if (unlikely(async->iovec_idx >= VHOST_MAX_ASYNC_VEC)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "no more async iovec available");
-		return -1;
-	}
-
-	iter = async->iov_iter + async->iter_idx;
-	iter->iov = async->iovec + async->iovec_idx;
-	iter->nr_segs = 0;
-
-	return 0;
-}
-
-static __rte_always_inline int
-async_iter_add_iovec(struct virtio_net *dev, struct vhost_async *async,
-		void *src, void *dst, size_t len)
-{
-	struct vhost_iov_iter *iter;
-	struct vhost_iovec *iovec;
-
-	if (unlikely(async->iovec_idx >= VHOST_MAX_ASYNC_VEC)) {
-		static bool vhost_max_async_vec_log;
-
-		if (!vhost_max_async_vec_log) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "no more async iovec available");
-			vhost_max_async_vec_log = true;
-		}
-
-		return -1;
-	}
-
-	iter = async->iov_iter + async->iter_idx;
-	iovec = async->iovec + async->iovec_idx;
-
-	iovec->src_addr = src;
-	iovec->dst_addr = dst;
-	iovec->len = len;
-
-	iter->nr_segs++;
-	async->iovec_idx++;
-
-	return 0;
-}
-
-static __rte_always_inline void
-async_iter_finalize(struct vhost_async *async)
-{
-	async->iter_idx++;
-}
-
-static __rte_always_inline void
-async_iter_cancel(struct vhost_async *async)
-{
-	struct vhost_iov_iter *iter;
-
-	iter = async->iov_iter + async->iter_idx;
-	async->iovec_idx -= iter->nr_segs;
-	iter->nr_segs = 0;
-	iter->iov = NULL;
-}
-
-static __rte_always_inline void
-async_iter_reset(struct vhost_async *async)
-{
-	async->iter_idx = 0;
-	async->iovec_idx = 0;
-}
-
-static __rte_always_inline int
-async_fill_seg(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mbuf *m, uint32_t mbuf_offset,
-		uint64_t buf_iova, uint32_t cpy_len, bool to_desc)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	struct vhost_async *async = vq->async;
-	uint64_t mapped_len;
-	uint32_t buf_offset = 0;
-	void *src, *dst;
-	void *host_iova;
-
-	while (cpy_len) {
-		host_iova = (void *)(uintptr_t)gpa_to_first_hpa(dev,
-				buf_iova + buf_offset, cpy_len, &mapped_len);
-		if (unlikely(!host_iova)) {
-			VHOST_DATA_LOG(dev->ifname, ERR,
-				"%s: failed to get host iova.",
-				__func__);
-			return -1;
-		}
-
-		if (to_desc) {
-			src = (void *)(uintptr_t)rte_pktmbuf_iova_offset(m, mbuf_offset);
-			dst = host_iova;
-		} else {
-			src = host_iova;
-			dst = (void *)(uintptr_t)rte_pktmbuf_iova_offset(m, mbuf_offset);
-		}
-
-		if (unlikely(async_iter_add_iovec(dev, async, src, dst, (size_t)mapped_len)))
-			return -1;
-
-		cpy_len -= (uint32_t)mapped_len;
-		mbuf_offset += (uint32_t)mapped_len;
-		buf_offset += (uint32_t)mapped_len;
-	}
-
-	return 0;
-}
-
 static __rte_always_inline void
 sync_fill_seg(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		struct rte_mbuf *m, uint32_t mbuf_offset,
@@ -1200,7 +884,7 @@ sync_fill_seg(struct virtio_net *dev, struct vhost_virtqueue *vq,
 static __rte_always_inline int
 mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		struct rte_mbuf *m, struct buf_vector *buf_vec,
-		uint16_t nr_vec, uint16_t num_buffers, bool is_async)
+		uint16_t nr_vec, uint16_t num_buffers)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
@@ -1212,7 +896,6 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	uint64_t hdr_addr;
 	struct rte_mbuf *hdr_mbuf;
 	struct virtio_net_hdr_mrg_rxbuf tmp_hdr, *hdr = NULL;
-	struct vhost_async *async = vq->async;
 
 	if (unlikely(m == NULL))
 		return -1;
@@ -1249,17 +932,12 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	mbuf_avail  = rte_pktmbuf_data_len(m);
 	mbuf_offset = 0;
 
-	if (is_async) {
-		if (async_iter_initialize(dev, async))
-			return -1;
-	}
-
 	while (mbuf_avail != 0 || m->next != NULL) {
 		/* done with current buf, get the next one */
 		if (buf_avail == 0) {
 			vec_idx++;
 			if (unlikely(vec_idx >= nr_vec))
-				goto error;
+				return -1;
 
 			buf_addr = buf_vec[vec_idx].buf_addr;
 			buf_iova = buf_vec[vec_idx].buf_iova;
@@ -1298,15 +976,9 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 
 		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
 
-		if (is_async) {
-			if (async_fill_seg(dev, vq, m, mbuf_offset,
-					   buf_iova + buf_offset, cpy_len, true) < 0)
-				goto error;
-		} else {
-			sync_fill_seg(dev, vq, m, mbuf_offset,
-				      buf_addr + buf_offset,
-				      buf_iova + buf_offset, cpy_len, true);
-		}
+		sync_fill_seg(dev, vq, m, mbuf_offset,
+			      buf_addr + buf_offset,
+			      buf_iova + buf_offset, cpy_len, true);
 
 		mbuf_avail  -= cpy_len;
 		mbuf_offset += cpy_len;
@@ -1314,15 +986,7 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		buf_offset += cpy_len;
 	}
 
-	if (is_async)
-		async_iter_finalize(async);
-
 	return 0;
-error:
-	if (is_async)
-		async_iter_cancel(async);
-
-	return -1;
 }
 
 static __rte_always_inline int
@@ -1381,7 +1045,7 @@ vhost_enqueue_single_packed(struct virtio_net *dev,
 			avail_idx -= vq->size;
 	}
 
-	if (mbuf_to_desc(dev, vq, pkt, buf_vec, nr_vec, num_buffers, false) < 0)
+	if (mbuf_to_desc(dev, vq, pkt, buf_vec, nr_vec, num_buffers) < 0)
 		return -1;
 
 	vhost_shadow_enqueue_single_packed(dev, vq, buffer_len, buffer_buf_id,
@@ -1427,8 +1091,7 @@ virtio_dev_rx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
 			"current index %d | end index %d",
 			vq->last_avail_idx, vq->last_avail_idx + num_buffers);
 
-		if (mbuf_to_desc(dev, vq, pkts[pkt_idx], buf_vec, nr_vec,
-					num_buffers, false) < 0) {
+		if (mbuf_to_desc(dev, vq, pkts[pkt_idx], buf_vec, nr_vec, num_buffers) < 0) {
 			vq->shadow_used_idx -= num_buffers;
 			break;
 		}
@@ -1499,58 +1162,6 @@ virtio_dev_rx_sync_batch_check(struct virtio_net *dev,
 	return 0;
 }
 
-static __rte_always_inline int
-virtio_dev_rx_async_batch_check(struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts,
-			   uint64_t *desc_addrs,
-			   uint64_t *lens,
-			   int16_t dma_id,
-			   uint16_t vchan_id)
-{
-	bool wrap_counter = vq->avail_wrap_counter;
-	struct vring_packed_desc *descs = vq->desc_packed;
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	uint16_t i;
-
-	if (unlikely(avail_idx & PACKED_BATCH_MASK))
-		return -1;
-
-	if (unlikely((avail_idx + PACKED_BATCH_SIZE) > vq->size))
-		return -1;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(pkts[i]->next != NULL))
-			return -1;
-		if (unlikely(!desc_is_avail(&descs[avail_idx + i],
-					    wrap_counter)))
-			return -1;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		lens[i] = descs[avail_idx + i].len;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(pkts[i]->pkt_len > (lens[i] - buf_offset)))
-			return -1;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		desc_addrs[i] =  descs[avail_idx + i].addr;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(!desc_addrs[i]))
-			return -1;
-		if (unlikely(lens[i] != descs[avail_idx + i].len))
-			return -1;
-	}
-
-	if (rte_dma_burst_capacity(dma_id, vchan_id) < PACKED_BATCH_SIZE)
-		return -1;
-
-	return 0;
-}
-
 static __rte_always_inline void
 virtio_dev_rx_batch_packed_copy(struct virtio_net *dev,
 			   struct vhost_virtqueue *vq,
@@ -1767,995 +1378,161 @@ rte_vhost_enqueue_burst(int vid, uint16_t queue_id,
 	return virtio_dev_rx(dev, dev->virtqueue[queue_id], pkts, count);
 }
 
-static __rte_always_inline uint16_t
-async_get_first_inflight_pkt_idx(struct vhost_virtqueue *vq)
-	__rte_requires_shared_capability(&vq->access_lock)
+static inline bool
+virtio_net_with_host_offload(struct virtio_net *dev)
 {
-	struct vhost_async *async = vq->async;
+	if (dev->features &
+			((1ULL << VIRTIO_NET_F_CSUM) |
+			 (1ULL << VIRTIO_NET_F_HOST_ECN) |
+			 (1ULL << VIRTIO_NET_F_HOST_TSO4) |
+			 (1ULL << VIRTIO_NET_F_HOST_TSO6) |
+			 (1ULL << VIRTIO_NET_F_HOST_UFO)))
+		return true;
 
-	if (async->pkts_idx >= async->pkts_inflight_n)
-		return async->pkts_idx - async->pkts_inflight_n;
-	else
-		return vq->size - async->pkts_inflight_n + async->pkts_idx;
+	return false;
 }
 
-static __rte_always_inline void
-store_dma_desc_info_split(struct vring_used_elem *s_ring, struct vring_used_elem *d_ring,
-		uint16_t ring_size, uint16_t s_idx, uint16_t d_idx, uint16_t count)
+static int
+parse_headers(struct rte_mbuf *m, uint8_t *l4_proto)
 {
-	size_t elem_size = sizeof(struct vring_used_elem);
-
-	if (d_idx + count <= ring_size) {
-		rte_memcpy(d_ring + d_idx, s_ring + s_idx, count * elem_size);
-	} else {
-		uint16_t size = ring_size - d_idx;
+	struct rte_ipv4_hdr *ipv4_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_ether_hdr *eth_hdr;
+	uint16_t ethertype;
+	uint16_t data_len = rte_pktmbuf_data_len(m);
 
-		rte_memcpy(d_ring + d_idx, s_ring + s_idx, size * elem_size);
-		rte_memcpy(d_ring, s_ring + s_idx + size, (count - size) * elem_size);
-	}
-}
+	if (data_len < sizeof(struct rte_ether_hdr))
+		return -EINVAL;
 
-static __rte_noinline uint32_t
-virtio_dev_rx_async_submit_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
-	struct rte_mbuf **pkts, uint32_t count, int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	struct buf_vector buf_vec[BUF_VECTOR_MAX];
-	uint32_t pkt_idx = 0;
-	uint16_t num_buffers;
-	uint16_t avail_head;
+	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	uint32_t pkt_err = 0;
-	uint16_t n_xfer;
-	uint16_t slot_idx = 0;
+	m->l2_len = sizeof(struct rte_ether_hdr);
+	ethertype = rte_be_to_cpu_16(eth_hdr->ether_type);
 
-	/*
-	 * The ordering between avail index and desc reads need to be enforced.
-	 */
-	avail_head = rte_atomic_load_explicit((unsigned short __rte_atomic *)&vq->avail->idx,
-		rte_memory_order_acquire);
+	if (ethertype == RTE_ETHER_TYPE_VLAN) {
+		if (data_len < sizeof(struct rte_ether_hdr) +
+				sizeof(struct rte_vlan_hdr))
+			goto error;
 
-	rte_prefetch0(&vq->avail->ring[vq->last_avail_idx & (vq->size - 1)]);
+		struct rte_vlan_hdr *vlan_hdr =
+			(struct rte_vlan_hdr *)(eth_hdr + 1);
 
-	async_iter_reset(async);
+		m->l2_len += sizeof(struct rte_vlan_hdr);
+		ethertype = rte_be_to_cpu_16(vlan_hdr->eth_proto);
+	}
 
-	for (pkt_idx = 0; pkt_idx < count; pkt_idx++) {
-		uint64_t pkt_len = pkts[pkt_idx]->pkt_len + dev->vhost_hlen;
-		uint16_t nr_vec = 0;
-
-		if (unlikely(reserve_avail_buf_split(dev, vq, pkt_len, buf_vec,
-						&num_buffers, avail_head, &nr_vec) < 0)) {
-			VHOST_DATA_LOG(dev->ifname, DEBUG,
-				"failed to get enough desc from vring");
-			vq->shadow_used_idx -= num_buffers;
-			break;
-		}
-
-		VHOST_DATA_LOG(dev->ifname, DEBUG,
-			"current index %d | end index %d",
-			vq->last_avail_idx, vq->last_avail_idx + num_buffers);
-
-		if (mbuf_to_desc(dev, vq, pkts[pkt_idx], buf_vec, nr_vec, num_buffers, true) < 0) {
-			vq->shadow_used_idx -= num_buffers;
-			break;
-		}
-
-		slot_idx = (async->pkts_idx + pkt_idx) & (vq->size - 1);
-		pkts_info[slot_idx].descs = num_buffers;
-		pkts_info[slot_idx].mbuf = pkts[pkt_idx];
-
-		vq->last_avail_idx += num_buffers;
-		vhost_virtqueue_reconnect_log_split(vq);
-	}
-
-	if (unlikely(pkt_idx == 0))
-		return 0;
-
-	n_xfer = vhost_async_dma_transfer(dev, vq, dma_id, vchan_id, async->pkts_idx,
-			async->iov_iter, pkt_idx);
-
-	pkt_err = pkt_idx - n_xfer;
-	if (unlikely(pkt_err)) {
-		uint16_t num_descs = 0;
-
-		VHOST_DATA_LOG(dev->ifname, DEBUG,
-			"%s: failed to transfer %u packets for queue %u.",
-			__func__, pkt_err, vq->index);
-
-		/* update number of completed packets */
-		pkt_idx = n_xfer;
-
-		/* calculate the sum of descriptors to revert */
-		while (pkt_err-- > 0) {
-			num_descs += pkts_info[slot_idx & (vq->size - 1)].descs;
-			slot_idx--;
-		}
-
-		/* recover shadow used ring and available ring */
-		vq->shadow_used_idx -= num_descs;
-		vq->last_avail_idx -= num_descs;
-		vhost_virtqueue_reconnect_log_split(vq);
+	switch (ethertype) {
+	case RTE_ETHER_TYPE_IPV4:
+		if (data_len < m->l2_len + sizeof(struct rte_ipv4_hdr))
+			goto error;
+		ipv4_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ipv4_hdr *,
+				m->l2_len);
+		m->l3_len = rte_ipv4_hdr_len(ipv4_hdr);
+		if (data_len < m->l2_len + m->l3_len)
+			goto error;
+		m->ol_flags |= RTE_MBUF_F_TX_IPV4;
+		*l4_proto = ipv4_hdr->next_proto_id;
+		break;
+	case RTE_ETHER_TYPE_IPV6:
+		if (data_len < m->l2_len + sizeof(struct rte_ipv6_hdr))
+			goto error;
+		ipv6_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ipv6_hdr *,
+				m->l2_len);
+		m->l3_len = sizeof(struct rte_ipv6_hdr);
+		m->ol_flags |= RTE_MBUF_F_TX_IPV6;
+		*l4_proto = ipv6_hdr->proto;
+		break;
+	default:
+		/* a valid L3 header is needed for further L4 parsing */
+		goto error;
 	}
 
-	/* keep used descriptors */
-	if (likely(vq->shadow_used_idx)) {
-		uint16_t to = async->desc_idx_split & (vq->size - 1);
-
-		store_dma_desc_info_split(vq->shadow_used_split,
-				async->descs_split, vq->size, 0, to,
-				vq->shadow_used_idx);
-
-		async->desc_idx_split += vq->shadow_used_idx;
-
-		async->pkts_idx += pkt_idx;
-		if (async->pkts_idx >= vq->size)
-			async->pkts_idx -= vq->size;
-
-		async->pkts_inflight_n += pkt_idx;
-		vq->shadow_used_idx = 0;
+	/* both CSUM and GSO need a valid L4 header */
+	switch (*l4_proto) {
+	case IPPROTO_TCP:
+		if (data_len < m->l2_len + m->l3_len +
+				sizeof(struct rte_tcp_hdr))
+			goto error;
+		break;
+	case IPPROTO_UDP:
+		if (data_len < m->l2_len + m->l3_len +
+				sizeof(struct rte_udp_hdr))
+			goto error;
+		break;
+	case IPPROTO_SCTP:
+		if (data_len < m->l2_len + m->l3_len +
+				sizeof(struct rte_sctp_hdr))
+			goto error;
+		break;
+	default:
+		goto error;
 	}
 
-	return pkt_idx;
-}
-
-
-static __rte_always_inline int
-vhost_enqueue_async_packed(struct virtio_net *dev,
-			    struct vhost_virtqueue *vq,
-			    struct rte_mbuf *pkt,
-			    struct buf_vector *buf_vec,
-			    uint16_t *nr_descs,
-			    uint16_t *nr_buffers)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint16_t nr_vec = 0;
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint16_t max_tries, tries = 0;
-	uint16_t buf_id = 0;
-	uint32_t len = 0;
-	uint16_t desc_count = 0;
-	uint64_t size = pkt->pkt_len + sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	uint32_t buffer_len[vq->size];
-	uint16_t buffer_buf_id[vq->size];
-	uint16_t buffer_desc_count[vq->size];
-
-	if (rxvq_is_mergeable(dev))
-		max_tries = vq->size - 1;
-	else
-		max_tries = 1;
-
-	do {
-		/*
-		 * if we tried all available ring items, and still
-		 * can't get enough buf, it means something abnormal
-		 * happened.
-		 */
-		if (unlikely(++tries > max_tries))
-			return -1;
-
-		if (unlikely(fill_vec_buf_packed(dev, vq,
-						avail_idx, &desc_count,
-						buf_vec, &nr_vec,
-						&buf_id, &len,
-						VHOST_ACCESS_RW) < 0))
-			return -1;
-
-		len = RTE_MIN(len, size);
-		size -= len;
-
-		buffer_len[*nr_buffers] = len;
-		buffer_buf_id[*nr_buffers] = buf_id;
-		buffer_desc_count[*nr_buffers] = desc_count;
-		*nr_buffers += 1;
-		*nr_descs += desc_count;
-		avail_idx += desc_count;
-		if (avail_idx >= vq->size)
-			avail_idx -= vq->size;
-	} while (size > 0);
-
-	if (unlikely(mbuf_to_desc(dev, vq, pkt, buf_vec, nr_vec, *nr_buffers, true) < 0))
-		return -1;
-
-	vhost_async_shadow_enqueue_packed(vq, buffer_len, buffer_buf_id,
-					buffer_desc_count, *nr_buffers);
-
 	return 0;
-}
-
-static __rte_always_inline int16_t
-virtio_dev_rx_async_packed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-			    struct rte_mbuf *pkt, uint16_t *nr_descs, uint16_t *nr_buffers)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	struct buf_vector buf_vec[BUF_VECTOR_MAX];
 
-	if (unlikely(vhost_enqueue_async_packed(dev, vq, pkt, buf_vec,
-					nr_descs, nr_buffers) < 0)) {
-		VHOST_DATA_LOG(dev->ifname, DEBUG, "failed to get enough desc from vring");
-		return -1;
-	}
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG,
-		"current index %d | end index %d",
-		vq->last_avail_idx, vq->last_avail_idx + *nr_descs);
-
-	return 0;
+error:
+	m->l2_len = 0;
+	m->l3_len = 0;
+	m->ol_flags = 0;
+	return -EINVAL;
 }
 
 static __rte_always_inline void
-virtio_dev_rx_async_packed_batch_enqueue(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts,
-			   uint64_t *desc_addrs,
-			   uint64_t *lens)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
+vhost_dequeue_offload_legacy(struct virtio_net *dev, struct virtio_net_hdr *hdr,
+		struct rte_mbuf *m)
 {
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	struct virtio_net_hdr_mrg_rxbuf *hdrs[PACKED_BATCH_SIZE];
-	struct vring_packed_desc *descs = vq->desc_packed;
-	struct vhost_async *async = vq->async;
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint32_t mbuf_offset = 0;
-	uint16_t ids[PACKED_BATCH_SIZE];
-	uint64_t mapped_len[PACKED_BATCH_SIZE];
-	void *host_iova[PACKED_BATCH_SIZE];
-	uintptr_t desc;
-	uint16_t i;
+	uint8_t l4_proto = 0;
+	struct rte_tcp_hdr *tcp_hdr = NULL;
+	uint16_t tcp_len;
+	uint16_t data_len = rte_pktmbuf_data_len(m);
 
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		rte_prefetch0((void *)(uintptr_t)desc_addrs[i]);
-		desc = vhost_iova_to_vva(dev, vq, desc_addrs[i], &lens[i], VHOST_ACCESS_RW);
-		hdrs[i] = (struct virtio_net_hdr_mrg_rxbuf *)(uintptr_t)desc;
-		lens[i] = pkts[i]->pkt_len +
-			sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	}
+	if (parse_headers(m, &l4_proto) < 0)
+		return;
 
-	if (rxvq_is_mergeable(dev)) {
-		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-			ASSIGN_UNLESS_EQUAL(hdrs[i]->num_buffers, 1);
+	if (hdr->flags == VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		if (hdr->csum_start == (m->l2_len + m->l3_len)) {
+			switch (hdr->csum_offset) {
+			case (offsetof(struct rte_tcp_hdr, cksum)):
+				if (l4_proto != IPPROTO_TCP)
+					goto error;
+				m->ol_flags |= RTE_MBUF_F_TX_TCP_CKSUM;
+				break;
+			case (offsetof(struct rte_udp_hdr, dgram_cksum)):
+				if (l4_proto != IPPROTO_UDP)
+					goto error;
+				m->ol_flags |= RTE_MBUF_F_TX_UDP_CKSUM;
+				break;
+			case (offsetof(struct rte_sctp_hdr, cksum)):
+				if (l4_proto != IPPROTO_SCTP)
+					goto error;
+				m->ol_flags |= RTE_MBUF_F_TX_SCTP_CKSUM;
+				break;
+			default:
+				goto error;
+			}
+		} else {
+			goto error;
 		}
 	}
 
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		virtio_enqueue_offload(pkts[i], &hdrs[i]->hdr);
-
-	vq_inc_last_avail_packed(vq, PACKED_BATCH_SIZE);
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		host_iova[i] = (void *)(uintptr_t)gpa_to_first_hpa(dev,
-			desc_addrs[i] + buf_offset, lens[i], &mapped_len[i]);
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		async_iter_initialize(dev, async);
-		async_iter_add_iovec(dev, async,
-				(void *)(uintptr_t)rte_pktmbuf_iova_offset(pkts[i], mbuf_offset),
-				host_iova[i],
-				mapped_len[i]);
-		async->iter_idx++;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		vhost_log_cache_write_iova(dev, vq, descs[avail_idx + i].addr, lens[i]);
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		ids[i] = descs[avail_idx + i].id;
-
-	vhost_async_shadow_enqueue_packed_batch(vq, lens, ids);
-}
-
-static __rte_always_inline int
-virtio_dev_rx_async_packed_batch(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts,
-			   int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint64_t desc_addrs[PACKED_BATCH_SIZE];
-	uint64_t lens[PACKED_BATCH_SIZE];
-
-	if (virtio_dev_rx_async_batch_check(vq, pkts, desc_addrs, lens, dma_id, vchan_id) == -1)
-		return -1;
-
-	virtio_dev_rx_async_packed_batch_enqueue(dev, vq, pkts, desc_addrs, lens);
-
-	return 0;
-}
-
-static __rte_always_inline void
-dma_error_handler_packed(struct vhost_virtqueue *vq, uint16_t slot_idx,
-			uint32_t nr_err, uint32_t *pkt_idx)
-	__rte_requires_capability(&vq->access_lock)
-{
-	uint16_t descs_err = 0;
-	uint16_t buffers_err = 0;
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = vq->async->pkts_info;
-
-	*pkt_idx -= nr_err;
-	/* calculate the sum of buffers and descs of DMA-error packets. */
-	while (nr_err-- > 0) {
-		descs_err += pkts_info[slot_idx % vq->size].descs;
-		buffers_err += pkts_info[slot_idx % vq->size].nr_buffers;
-		slot_idx--;
-	}
-
-	if (vq->last_avail_idx >= descs_err) {
-		vq->last_avail_idx -= descs_err;
-	} else {
-		vq->last_avail_idx = vq->last_avail_idx + vq->size - descs_err;
-		vq->avail_wrap_counter ^= 1;
-	}
-	vhost_virtqueue_reconnect_log_packed(vq);
-
-	if (async->buffer_idx_packed >= buffers_err)
-		async->buffer_idx_packed -= buffers_err;
-	else
-		async->buffer_idx_packed = async->buffer_idx_packed + vq->size - buffers_err;
-}
-
-static __rte_noinline uint32_t
-virtio_dev_rx_async_submit_packed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-	struct rte_mbuf **pkts, uint32_t count, int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint32_t pkt_idx = 0;
-	uint16_t n_xfer;
-	uint16_t num_buffers;
-	uint16_t num_descs;
-
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	uint32_t pkt_err = 0;
-	uint16_t slot_idx = 0;
-	uint16_t i;
-
-	do {
-		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		if (hdr->gso_size == 0)
+			goto error;
 
-		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_rx_async_packed_batch(dev, vq, &pkts[pkt_idx],
-					dma_id, vchan_id)) {
-				for (i = 0; i < PACKED_BATCH_SIZE; i++) {
-					slot_idx = (async->pkts_idx + pkt_idx) % vq->size;
-					pkts_info[slot_idx].descs = 1;
-					pkts_info[slot_idx].nr_buffers = 1;
-					pkts_info[slot_idx].mbuf = pkts[pkt_idx];
-					pkt_idx++;
-				}
-				continue;
-			}
-		}
-
-		num_buffers = 0;
-		num_descs = 0;
-		if (unlikely(virtio_dev_rx_async_packed(dev, vq, pkts[pkt_idx],
-						&num_descs, &num_buffers) < 0))
-			break;
-
-		slot_idx = (async->pkts_idx + pkt_idx) % vq->size;
-
-		pkts_info[slot_idx].descs = num_descs;
-		pkts_info[slot_idx].nr_buffers = num_buffers;
-		pkts_info[slot_idx].mbuf = pkts[pkt_idx];
-
-		pkt_idx++;
-		vq_inc_last_avail_packed(vq, num_descs);
-	} while (pkt_idx < count);
-
-	if (unlikely(pkt_idx == 0))
-		return 0;
-
-	n_xfer = vhost_async_dma_transfer(dev, vq, dma_id, vchan_id, async->pkts_idx,
-			async->iov_iter, pkt_idx);
-
-	async_iter_reset(async);
-
-	pkt_err = pkt_idx - n_xfer;
-	if (unlikely(pkt_err)) {
-		VHOST_DATA_LOG(dev->ifname, DEBUG,
-			"%s: failed to transfer %u packets for queue %u.",
-			__func__, pkt_err, vq->index);
-		dma_error_handler_packed(vq, slot_idx, pkt_err, &pkt_idx);
-	}
-
-	async->pkts_idx += pkt_idx;
-	if (async->pkts_idx >= vq->size)
-		async->pkts_idx -= vq->size;
-
-	async->pkts_inflight_n += pkt_idx;
-
-	return pkt_idx;
-}
-
-static __rte_always_inline void
-write_back_completed_descs_split(struct vhost_virtqueue *vq, uint16_t n_descs)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct vhost_async *async = vq->async;
-	uint16_t nr_left = n_descs;
-	uint16_t nr_copy;
-	uint16_t to, from;
-
-	do {
-		from = async->last_desc_idx_split & (vq->size - 1);
-		nr_copy = nr_left + from <= vq->size ? nr_left : vq->size - from;
-		to = vq->last_used_idx & (vq->size - 1);
-
-		if (to + nr_copy <= vq->size) {
-			rte_memcpy(&vq->used->ring[to], &async->descs_split[from],
-					nr_copy * sizeof(struct vring_used_elem));
-		} else {
-			uint16_t size = vq->size - to;
-
-			rte_memcpy(&vq->used->ring[to], &async->descs_split[from],
-					size * sizeof(struct vring_used_elem));
-			rte_memcpy(&vq->used->ring[0], &async->descs_split[from + size],
-					(nr_copy - size) * sizeof(struct vring_used_elem));
-		}
-
-		async->last_desc_idx_split += nr_copy;
-		vq->last_used_idx += nr_copy;
-		nr_left -= nr_copy;
-	} while (nr_left > 0);
-}
-
-static __rte_always_inline void
-write_back_completed_descs_packed(struct vhost_virtqueue *vq,
-				uint16_t n_buffers)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct vhost_async *async = vq->async;
-	uint16_t from = async->last_buffer_idx_packed;
-	uint16_t used_idx = vq->last_used_idx;
-	uint16_t head_idx = vq->last_used_idx;
-	uint16_t head_flags = 0;
-	uint16_t i;
-
-	/* Split loop in two to save memory barriers */
-	for (i = 0; i < n_buffers; i++) {
-		vq->desc_packed[used_idx].id = async->buffers_packed[from].id;
-		vq->desc_packed[used_idx].len = async->buffers_packed[from].len;
-
-		used_idx += async->buffers_packed[from].count;
-		if (used_idx >= vq->size)
-			used_idx -= vq->size;
-
-		from++;
-		if (from >= vq->size)
-			from = 0;
-	}
-
-	/* The ordering for storing desc flags needs to be enforced. */
-	rte_atomic_thread_fence(rte_memory_order_release);
-
-	from = async->last_buffer_idx_packed;
-
-	for (i = 0; i < n_buffers; i++) {
-		uint16_t flags;
-
-		if (async->buffers_packed[from].len)
-			flags = VRING_DESC_F_WRITE;
-		else
-			flags = 0;
-
-		if (vq->used_wrap_counter) {
-			flags |= VRING_DESC_F_USED;
-			flags |= VRING_DESC_F_AVAIL;
-		} else {
-			flags &= ~VRING_DESC_F_USED;
-			flags &= ~VRING_DESC_F_AVAIL;
-		}
-
-		if (i > 0) {
-			vq->desc_packed[vq->last_used_idx].flags = flags;
-		} else {
-			head_idx = vq->last_used_idx;
-			head_flags = flags;
-		}
-
-		vq_inc_last_used_packed(vq, async->buffers_packed[from].count);
-
-		from++;
-		if (from == vq->size)
-			from = 0;
-	}
-
-	vq->desc_packed[head_idx].flags = head_flags;
-	async->last_buffer_idx_packed = from;
-}
-
-static __rte_always_inline uint16_t
-vhost_poll_enqueue_completed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-	struct rte_mbuf **pkts, uint16_t count, int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	uint16_t nr_cpl_pkts = 0;
-	uint16_t n_descs = 0, n_buffers = 0;
-	uint16_t start_idx, from, i;
-
-	/* Check completed copies for the given DMA vChannel */
-	vhost_async_dma_check_completed(dev, dma_id, vchan_id, VHOST_DMA_MAX_COPY_COMPLETE);
-
-	start_idx = async_get_first_inflight_pkt_idx(vq);
-	/**
-	 * Calculate the number of copy completed packets.
-	 * Note that there may be completed packets even if
-	 * no copies are reported done by the given DMA vChannel,
-	 * as it's possible that a virtqueue uses multiple DMA
-	 * vChannels.
-	 */
-	from = start_idx;
-	while (vq->async->pkts_cmpl_flag[from] && count--) {
-		vq->async->pkts_cmpl_flag[from] = false;
-		from++;
-		if (from >= vq->size)
-			from -= vq->size;
-		nr_cpl_pkts++;
-	}
-
-	if (nr_cpl_pkts == 0)
-		return 0;
-
-	for (i = 0; i < nr_cpl_pkts; i++) {
-		from = (start_idx + i) % vq->size;
-		/* Only used with packed ring */
-		n_buffers += pkts_info[from].nr_buffers;
-		/* Only used with split ring */
-		n_descs += pkts_info[from].descs;
-		pkts[i] = pkts_info[from].mbuf;
-	}
-
-	async->pkts_inflight_n -= nr_cpl_pkts;
-
-	if (likely(vq->enabled && vq->access_ok)) {
-		if (vq_is_packed(dev)) {
-			write_back_completed_descs_packed(vq, n_buffers);
-			vhost_vring_call_packed(dev, vq);
-		} else {
-			write_back_completed_descs_split(vq, n_descs);
-			rte_atomic_fetch_add_explicit(
-				(unsigned short __rte_atomic *)&vq->used->idx,
-				n_descs, rte_memory_order_release);
-			vhost_vring_call_split(dev, vq);
-		}
-	} else {
-		if (vq_is_packed(dev)) {
-			async->last_buffer_idx_packed += n_buffers;
-			if (async->last_buffer_idx_packed >= vq->size)
-				async->last_buffer_idx_packed -= vq->size;
-		} else {
-			async->last_desc_idx_split += n_descs;
-		}
-	}
-
-	return nr_cpl_pkts;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_poll_enqueue_completed, 20.08)
-uint16_t
-rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id)
-{
-	struct virtio_net *dev = get_device(vid);
-	struct vhost_virtqueue *vq;
-	uint16_t n_pkts_cpl = 0;
-
-	if (unlikely(!dev))
-		return 0;
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
-	if (unlikely(!is_valid_virt_queue_idx(queue_id, 0, dev->nr_vring))) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid virtqueue idx %d.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(!dma_copy_track[dma_id].vchans ||
-				!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid channel %d:%u.",
-			__func__, dma_id, vchan_id);
-		return 0;
-	}
-
-	vq = dev->virtqueue[queue_id];
-
-	if (rte_rwlock_read_trylock(&vq->access_lock)) {
-		VHOST_DATA_LOG(dev->ifname, DEBUG,
-			"%s: virtqueue %u is busy.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(!vq->async)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: async not registered for virtqueue %d.",
-			__func__, queue_id);
-		goto out;
-	}
-
-	n_pkts_cpl = vhost_poll_enqueue_completed(dev, vq, pkts, count, dma_id, vchan_id);
-
-	vhost_queue_stats_update(dev, vq, pkts, n_pkts_cpl);
-	vq->stats.inflight_completed += n_pkts_cpl;
-
-out:
-	rte_rwlock_read_unlock(&vq->access_lock);
-
-	return n_pkts_cpl;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue_thread_unsafe, 21.08)
-uint16_t
-rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id)
-{
-	struct virtio_net *dev = get_device(vid);
-	struct vhost_virtqueue *vq;
-	uint16_t n_pkts_cpl = 0;
-
-	if (!dev)
-		return 0;
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
-	if (unlikely(queue_id >= dev->nr_vring)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid virtqueue idx %d.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(dma_id < 0 || dma_id >= RTE_DMADEV_DEFAULT_MAX)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid dma id %d.",
-			__func__, dma_id);
-		return 0;
-	}
-
-	vq = dev->virtqueue[queue_id];
-
-	vq_assert_lock(dev, vq);
-
-	if (unlikely(!vq->async)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: async not registered for virtqueue %d.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(!dma_copy_track[dma_id].vchans ||
-				!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid channel %d:%u.",
-			__func__, dma_id, vchan_id);
-		return 0;
-	}
-
-	if ((queue_id & 1) == 0)
-		n_pkts_cpl = vhost_poll_enqueue_completed(dev, vq, pkts, count,
-			dma_id, vchan_id);
-	else
-		n_pkts_cpl = async_poll_dequeue_completed(dev, vq, pkts, count,
-			dma_id, vchan_id, dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS);
-
-	vhost_queue_stats_update(dev, vq, pkts, n_pkts_cpl);
-	vq->stats.inflight_completed += n_pkts_cpl;
-
-	return n_pkts_cpl;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue, 22.07)
-uint16_t
-rte_vhost_clear_queue(int vid, uint16_t queue_id, struct rte_mbuf **pkts,
-		uint16_t count, int16_t dma_id, uint16_t vchan_id)
-{
-	struct virtio_net *dev = get_device(vid);
-	struct vhost_virtqueue *vq;
-	uint16_t n_pkts_cpl = 0;
-
-	if (!dev)
-		return 0;
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
-	if (unlikely(queue_id >= dev->nr_vring)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid virtqueue idx %u.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(dma_id < 0 || dma_id >= RTE_DMADEV_DEFAULT_MAX)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid dma id %d.",
-			__func__, dma_id);
-		return 0;
-	}
-
-	vq = dev->virtqueue[queue_id];
-
-	if (rte_rwlock_read_trylock(&vq->access_lock)) {
-		VHOST_DATA_LOG(dev->ifname, DEBUG, "%s: virtqueue %u is busy.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	if (unlikely(!vq->async)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: async not registered for queue id %u.",
-			__func__, queue_id);
-		goto out_access_unlock;
-	}
-
-	if (unlikely(!dma_copy_track[dma_id].vchans ||
-				!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid channel %d:%u.",
-			__func__, dma_id, vchan_id);
-		goto out_access_unlock;
-	}
-
-	if ((queue_id & 1) == 0)
-		n_pkts_cpl = vhost_poll_enqueue_completed(dev, vq, pkts, count,
-			dma_id, vchan_id);
-	else
-		n_pkts_cpl = async_poll_dequeue_completed(dev, vq, pkts, count,
-			dma_id, vchan_id, dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS);
-
-	vhost_queue_stats_update(dev, vq, pkts, n_pkts_cpl);
-	vq->stats.inflight_completed += n_pkts_cpl;
-
-out_access_unlock:
-	rte_rwlock_read_unlock(&vq->access_lock);
-
-	return n_pkts_cpl;
-}
-
-static __rte_always_inline uint32_t
-virtio_dev_rx_async_submit(struct virtio_net *dev, struct vhost_virtqueue *vq,
-	struct rte_mbuf **pkts, uint32_t count, int16_t dma_id, uint16_t vchan_id)
-{
-	uint32_t nb_tx = 0;
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
-
-	if (unlikely(!dma_copy_track[dma_id].vchans ||
-				!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr)) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid channel %d:%u.",
-			 __func__, dma_id, vchan_id);
-		return 0;
-	}
-
-	rte_rwlock_write_lock(&vq->access_lock);
-
-	if (unlikely(!vq->enabled || !vq->async))
-		goto out_access_unlock;
-
-	vhost_user_iotlb_rd_lock(vq);
-
-	if (unlikely(!vq->access_ok)) {
-		vhost_user_iotlb_rd_unlock(vq);
-		rte_rwlock_write_unlock(&vq->access_lock);
-
-		virtio_dev_vring_translate(dev, vq);
-		goto out_no_unlock;
-	}
-
-	count = RTE_MIN((uint32_t)MAX_PKT_BURST, count);
-	if (count == 0)
-		goto out;
-
-	if (vq_is_packed(dev))
-		nb_tx = virtio_dev_rx_async_submit_packed(dev, vq, pkts, count,
-			dma_id, vchan_id);
-	else
-		nb_tx = virtio_dev_rx_async_submit_split(dev, vq, pkts, count,
-			dma_id, vchan_id);
-
-	vq->stats.inflight_submitted += nb_tx;
-
-out:
-	vhost_user_iotlb_rd_unlock(vq);
-
-out_access_unlock:
-	rte_rwlock_write_unlock(&vq->access_lock);
-
-out_no_unlock:
-	return nb_tx;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_submit_enqueue_burst, 20.08)
-uint16_t
-rte_vhost_submit_enqueue_burst(int vid, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id)
-{
-	struct virtio_net *dev = get_device(vid);
-
-	if (!dev)
-		return 0;
-
-	if (unlikely(!(dev->flags & VIRTIO_DEV_BUILTIN_VIRTIO_NET))) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: built-in vhost net backend is disabled.",
-			__func__);
-		return 0;
-	}
-
-	if (unlikely(!is_valid_virt_queue_idx(queue_id, 0, dev->nr_vring))) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid virtqueue idx %d.",
-			__func__, queue_id);
-		return 0;
-	}
-
-	return virtio_dev_rx_async_submit(dev, dev->virtqueue[queue_id], pkts, count,
-		dma_id, vchan_id);
-}
-
-static inline bool
-virtio_net_with_host_offload(struct virtio_net *dev)
-{
-	if (dev->features &
-			((1ULL << VIRTIO_NET_F_CSUM) |
-			 (1ULL << VIRTIO_NET_F_HOST_ECN) |
-			 (1ULL << VIRTIO_NET_F_HOST_TSO4) |
-			 (1ULL << VIRTIO_NET_F_HOST_TSO6) |
-			 (1ULL << VIRTIO_NET_F_HOST_UFO)))
-		return true;
-
-	return false;
-}
-
-static int
-parse_headers(struct rte_mbuf *m, uint8_t *l4_proto)
-{
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	struct rte_ether_hdr *eth_hdr;
-	uint16_t ethertype;
-	uint16_t data_len = rte_pktmbuf_data_len(m);
-
-	if (data_len < sizeof(struct rte_ether_hdr))
-		return -EINVAL;
-
-	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
-
-	m->l2_len = sizeof(struct rte_ether_hdr);
-	ethertype = rte_be_to_cpu_16(eth_hdr->ether_type);
-
-	if (ethertype == RTE_ETHER_TYPE_VLAN) {
-		if (data_len < sizeof(struct rte_ether_hdr) +
-				sizeof(struct rte_vlan_hdr))
-			goto error;
-
-		struct rte_vlan_hdr *vlan_hdr =
-			(struct rte_vlan_hdr *)(eth_hdr + 1);
-
-		m->l2_len += sizeof(struct rte_vlan_hdr);
-		ethertype = rte_be_to_cpu_16(vlan_hdr->eth_proto);
-	}
-
-	switch (ethertype) {
-	case RTE_ETHER_TYPE_IPV4:
-		if (data_len < m->l2_len + sizeof(struct rte_ipv4_hdr))
-			goto error;
-		ipv4_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ipv4_hdr *,
-				m->l2_len);
-		m->l3_len = rte_ipv4_hdr_len(ipv4_hdr);
-		if (data_len < m->l2_len + m->l3_len)
-			goto error;
-		m->ol_flags |= RTE_MBUF_F_TX_IPV4;
-		*l4_proto = ipv4_hdr->next_proto_id;
-		break;
-	case RTE_ETHER_TYPE_IPV6:
-		if (data_len < m->l2_len + sizeof(struct rte_ipv6_hdr))
-			goto error;
-		ipv6_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ipv6_hdr *,
-				m->l2_len);
-		m->l3_len = sizeof(struct rte_ipv6_hdr);
-		m->ol_flags |= RTE_MBUF_F_TX_IPV6;
-		*l4_proto = ipv6_hdr->proto;
-		break;
-	default:
-		/* a valid L3 header is needed for further L4 parsing */
-		goto error;
-	}
-
-	/* both CSUM and GSO need a valid L4 header */
-	switch (*l4_proto) {
-	case IPPROTO_TCP:
-		if (data_len < m->l2_len + m->l3_len +
-				sizeof(struct rte_tcp_hdr))
-			goto error;
-		break;
-	case IPPROTO_UDP:
-		if (data_len < m->l2_len + m->l3_len +
-				sizeof(struct rte_udp_hdr))
-			goto error;
-		break;
-	case IPPROTO_SCTP:
-		if (data_len < m->l2_len + m->l3_len +
-				sizeof(struct rte_sctp_hdr))
-			goto error;
-		break;
-	default:
-		goto error;
-	}
-
-	return 0;
-
-error:
-	m->l2_len = 0;
-	m->l3_len = 0;
-	m->ol_flags = 0;
-	return -EINVAL;
-}
-
-static __rte_always_inline void
-vhost_dequeue_offload_legacy(struct virtio_net *dev, struct virtio_net_hdr *hdr,
-		struct rte_mbuf *m)
-{
-	uint8_t l4_proto = 0;
-	struct rte_tcp_hdr *tcp_hdr = NULL;
-	uint16_t tcp_len;
-	uint16_t data_len = rte_pktmbuf_data_len(m);
-
-	if (parse_headers(m, &l4_proto) < 0)
-		return;
-
-	if (hdr->flags == VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-		if (hdr->csum_start == (m->l2_len + m->l3_len)) {
-			switch (hdr->csum_offset) {
-			case (offsetof(struct rte_tcp_hdr, cksum)):
-				if (l4_proto != IPPROTO_TCP)
-					goto error;
-				m->ol_flags |= RTE_MBUF_F_TX_TCP_CKSUM;
-				break;
-			case (offsetof(struct rte_udp_hdr, dgram_cksum)):
-				if (l4_proto != IPPROTO_UDP)
-					goto error;
-				m->ol_flags |= RTE_MBUF_F_TX_UDP_CKSUM;
-				break;
-			case (offsetof(struct rte_sctp_hdr, cksum)):
-				if (l4_proto != IPPROTO_SCTP)
-					goto error;
-				m->ol_flags |= RTE_MBUF_F_TX_SCTP_CKSUM;
-				break;
-			default:
-				goto error;
-			}
-		} else {
-			goto error;
-		}
-	}
-
-	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		if (hdr->gso_size == 0)
-			goto error;
-
-		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
-		case VIRTIO_NET_HDR_GSO_TCPV4:
-		case VIRTIO_NET_HDR_GSO_TCPV6:
-			if (l4_proto != IPPROTO_TCP)
-				goto error;
-			tcp_hdr = rte_pktmbuf_mtod_offset(m,
-					struct rte_tcp_hdr *,
-					m->l2_len + m->l3_len);
-			tcp_len = (tcp_hdr->data_off & 0xf0) >> 2;
-			if (data_len < m->l2_len + m->l3_len + tcp_len)
-				goto error;
-			m->ol_flags |= RTE_MBUF_F_TX_TCP_SEG;
-			m->tso_segsz = hdr->gso_size;
-			m->l4_len = tcp_len;
+		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		case VIRTIO_NET_HDR_GSO_TCPV4:
+		case VIRTIO_NET_HDR_GSO_TCPV6:
+			if (l4_proto != IPPROTO_TCP)
+				goto error;
+			tcp_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_tcp_hdr *,
+					m->l2_len + m->l3_len);
+			tcp_len = (tcp_hdr->data_off & 0xf0) >> 2;
+			if (data_len < m->l2_len + m->l3_len + tcp_len)
+				goto error;
+			m->ol_flags |= RTE_MBUF_F_TX_TCP_SEG;
+			m->tso_segsz = hdr->gso_size;
+			m->l4_len = tcp_len;
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
 			if (l4_proto != IPPROTO_UDP)
@@ -2766,1451 +1543,741 @@ vhost_dequeue_offload_legacy(struct virtio_net *dev, struct virtio_net_hdr *hdr,
 			break;
 		default:
 			VHOST_DATA_LOG(dev->ifname, WARNING,
-				"unsupported gso type %u.",
-				hdr->gso_type);
-			goto error;
-		}
-	}
-	return;
-
-error:
-	m->l2_len = 0;
-	m->l3_len = 0;
-	m->ol_flags = 0;
-}
-
-static __rte_always_inline void
-vhost_dequeue_offload(struct virtio_net *dev, struct virtio_net_hdr *hdr,
-		struct rte_mbuf *m, bool legacy_ol_flags)
-{
-	struct rte_net_hdr_lens hdr_lens;
-	int l4_supported = 0;
-	uint32_t ptype;
-
-	if (hdr->flags == 0 && hdr->gso_type == VIRTIO_NET_HDR_GSO_NONE)
-		return;
-
-	if (legacy_ol_flags) {
-		vhost_dequeue_offload_legacy(dev, hdr, m);
-		return;
-	}
-
-	m->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN;
-
-	ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
-	m->packet_type = ptype;
-	if ((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP ||
-	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP ||
-	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_SCTP)
-		l4_supported = 1;
-
-	/* According to Virtio 1.1 spec, the device only needs to look at
-	 * VIRTIO_NET_HDR_F_NEEDS_CSUM in the packet transmission path.
-	 * This differs from the processing incoming packets path where the
-	 * driver could rely on VIRTIO_NET_HDR_F_DATA_VALID flag set by the
-	 * device.
-	 *
-	 * 5.1.6.2.1 Driver Requirements: Packet Transmission
-	 * The driver MUST NOT set the VIRTIO_NET_HDR_F_DATA_VALID and
-	 * VIRTIO_NET_HDR_F_RSC_INFO bits in flags.
-	 *
-	 * 5.1.6.2.2 Device Requirements: Packet Transmission
-	 * The device MUST ignore flag bits that it does not recognize.
-	 */
-	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-		uint32_t hdrlen;
-
-		hdrlen = hdr_lens.l2_len + hdr_lens.l3_len + hdr_lens.l4_len;
-		if (hdr->csum_start <= hdrlen && l4_supported != 0) {
-			m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_NONE;
-		} else {
-			/* Unknown proto or tunnel, do sw cksum. We can assume
-			 * the cksum field is in the first segment since the
-			 * buffers we provided to the host are large enough.
-			 * In case of SCTP, this will be wrong since it's a CRC
-			 * but there's nothing we can do.
-			 */
-			uint16_t csum = 0, off;
-
-			if (hdr->csum_start >= rte_pktmbuf_pkt_len(m))
-				return;
-
-			if (rte_raw_cksum_mbuf(m, hdr->csum_start,
-					rte_pktmbuf_pkt_len(m) - hdr->csum_start, &csum) < 0)
-				return;
-			if (likely(csum != 0xffff))
-				csum = ~csum;
-			off = hdr->csum_offset + hdr->csum_start;
-			if (rte_pktmbuf_data_len(m) >= off + 1)
-				*rte_pktmbuf_mtod_offset(m, uint16_t *, off) = csum;
-		}
-	}
-
-	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		if (hdr->gso_size == 0)
-			return;
-
-		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
-		case VIRTIO_NET_HDR_GSO_TCPV4:
-		case VIRTIO_NET_HDR_GSO_TCPV6:
-			if ((ptype & RTE_PTYPE_L4_MASK) != RTE_PTYPE_L4_TCP)
-				break;
-			m->ol_flags |= RTE_MBUF_F_RX_LRO | RTE_MBUF_F_RX_L4_CKSUM_NONE;
-			m->tso_segsz = hdr->gso_size;
-			break;
-		case VIRTIO_NET_HDR_GSO_UDP:
-			if ((ptype & RTE_PTYPE_L4_MASK) != RTE_PTYPE_L4_UDP)
-				break;
-			m->ol_flags |= RTE_MBUF_F_RX_LRO | RTE_MBUF_F_RX_L4_CKSUM_NONE;
-			m->tso_segsz = hdr->gso_size;
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-static __rte_always_inline int
-copy_vnet_hdr_from_desc(struct virtio_net_hdr *hdr,
-			const struct buf_vector *buf_vec,
-			uint16_t nr_vec)
-{
-	size_t remain = sizeof(struct virtio_net_hdr);
-	uint8_t *dst = (uint8_t *)hdr;
-
-	while (remain > 0) {
-		size_t len = RTE_MIN(remain, buf_vec->buf_len);
-		const void *src = (const void *)(uintptr_t)buf_vec->buf_addr;
-
-		if (unlikely(nr_vec == 0))
-			return -1;
-
-		memcpy(dst, src, len);
-		remain -= len;
-		dst += len;
-		buf_vec++;
-		--nr_vec;
-	}
-	return 0;
-}
-
-static __rte_always_inline int
-desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		  struct buf_vector *buf_vec, uint16_t nr_vec,
-		  struct rte_mbuf *m, struct rte_mempool *mbuf_pool,
-		  bool legacy_ol_flags, uint16_t slot_idx, bool is_async)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint32_t buf_avail, buf_offset, buf_len;
-	uint64_t buf_addr, buf_iova;
-	uint32_t mbuf_avail, mbuf_offset;
-	uint32_t hdr_remain = dev->vhost_hlen;
-	uint32_t cpy_len;
-	struct rte_mbuf *cur = m, *prev = m;
-	struct virtio_net_hdr tmp_hdr;
-	struct virtio_net_hdr *hdr = NULL;
-	uint16_t vec_idx;
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info;
-
-	/*
-	 * The caller has checked the descriptors chain is larger than the
-	 * header size.
-	 */
-
-	if (virtio_net_with_host_offload(dev)) {
-		if (unlikely(copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec, nr_vec) != 0))
-			return -1;
-
-		/* ensure that compiler does not delay copy */
-		rte_compiler_barrier();
-		hdr = &tmp_hdr;
-	}
-
-	for (vec_idx = 0; vec_idx < nr_vec; vec_idx++) {
-		if (buf_vec[vec_idx].buf_len > hdr_remain)
-			break;
-
-		hdr_remain -= buf_vec[vec_idx].buf_len;
-	}
-
-	buf_addr = buf_vec[vec_idx].buf_addr;
-	buf_iova = buf_vec[vec_idx].buf_iova;
-	buf_len = buf_vec[vec_idx].buf_len;
-	buf_offset = hdr_remain;
-	buf_avail = buf_vec[vec_idx].buf_len - hdr_remain;
-
-	PRINT_PACKET(dev,
-			(uintptr_t)(buf_addr + buf_offset),
-			(uint32_t)buf_avail, 0);
-
-	mbuf_offset = 0;
-	mbuf_avail  = m->buf_len - RTE_PKTMBUF_HEADROOM;
-
-	if (is_async) {
-		pkts_info = async->pkts_info;
-		if (async_iter_initialize(dev, async))
-			return -1;
-	}
-
-	while (1) {
-		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
-
-		if (is_async) {
-			if (async_fill_seg(dev, vq, cur, mbuf_offset,
-					   buf_iova + buf_offset, cpy_len, false) < 0)
-				goto error;
-		} else if (likely(hdr && cur == m)) {
-			rte_memcpy(rte_pktmbuf_mtod_offset(cur, void *, mbuf_offset),
-				(void *)((uintptr_t)(buf_addr + buf_offset)),
-				cpy_len);
-		} else {
-			sync_fill_seg(dev, vq, cur, mbuf_offset,
-				      buf_addr + buf_offset,
-				      buf_iova + buf_offset, cpy_len, false);
-		}
-
-		mbuf_avail  -= cpy_len;
-		mbuf_offset += cpy_len;
-		buf_avail -= cpy_len;
-		buf_offset += cpy_len;
-
-		/* This buf reaches to its end, get the next one */
-		if (buf_avail == 0) {
-			if (++vec_idx >= nr_vec)
-				break;
-
-			buf_addr = buf_vec[vec_idx].buf_addr;
-			buf_iova = buf_vec[vec_idx].buf_iova;
-			buf_len = buf_vec[vec_idx].buf_len;
-
-			buf_offset = 0;
-			buf_avail  = buf_len;
-
-			PRINT_PACKET(dev, (uintptr_t)buf_addr,
-					(uint32_t)buf_avail, 0);
-		}
-
-		/*
-		 * This mbuf reaches to its end, get a new one
-		 * to hold more data.
-		 */
-		if (mbuf_avail == 0) {
-			cur = rte_pktmbuf_alloc(mbuf_pool);
-			if (unlikely(cur == NULL)) {
-				vq->stats.mbuf_alloc_failed++;
-				VHOST_DATA_LOG(dev->ifname, ERR,
-					"failed to allocate memory for mbuf.");
-				goto error;
-			}
-
-			prev->next = cur;
-			prev->data_len = mbuf_offset;
-			m->nb_segs += 1;
-			m->pkt_len += mbuf_offset;
-			prev = cur;
-
-			mbuf_offset = 0;
-			mbuf_avail  = cur->buf_len - RTE_PKTMBUF_HEADROOM;
-		}
-	}
-
-	prev->data_len = mbuf_offset;
-	m->pkt_len    += mbuf_offset;
-
-	if (is_async) {
-		async_iter_finalize(async);
-		if (hdr)
-			pkts_info[slot_idx].nethdr = *hdr;
-	} else if (hdr) {
-		vhost_dequeue_offload(dev, hdr, m, legacy_ol_flags);
-	}
-
-	return 0;
-error:
-	if (is_async)
-		async_iter_cancel(async);
-
-	return -1;
-}
-
-static void
-virtio_dev_extbuf_free(void *addr __rte_unused, void *opaque)
-{
-	rte_free(opaque);
-}
-
-static int
-virtio_dev_extbuf_alloc(struct virtio_net *dev, struct rte_mbuf *pkt, uint32_t size)
-{
-	struct rte_mbuf_ext_shared_info *shinfo = NULL;
-	uint32_t total_len = RTE_PKTMBUF_HEADROOM + size;
-	uint16_t buf_len;
-	rte_iova_t iova;
-	void *buf;
-
-	total_len += sizeof(*shinfo) + sizeof(uintptr_t);
-	total_len = RTE_ALIGN_CEIL(total_len, sizeof(uintptr_t));
-
-	if (unlikely(total_len > UINT16_MAX))
-		return -ENOSPC;
-
-	buf_len = total_len;
-	buf = rte_malloc(NULL, buf_len, RTE_CACHE_LINE_SIZE);
-	if (unlikely(buf == NULL))
-		return -ENOMEM;
-
-	/* Initialize shinfo */
-	shinfo = rte_pktmbuf_ext_shinfo_init_helper(buf, &buf_len,
-						virtio_dev_extbuf_free, buf);
-	if (unlikely(shinfo == NULL)) {
-		rte_free(buf);
-		VHOST_DATA_LOG(dev->ifname, ERR, "failed to init shinfo");
-		return -1;
-	}
-
-	iova = rte_malloc_virt2iova(buf);
-	rte_pktmbuf_attach_extbuf(pkt, buf, iova, buf_len, shinfo);
-	rte_pktmbuf_reset_headroom(pkt);
-
-	return 0;
-}
-
-/*
- * Prepare a host supported pktmbuf.
- */
-static __rte_always_inline int
-virtio_dev_pktmbuf_prep(struct virtio_net *dev, struct rte_mbuf *pkt,
-			 uint32_t data_len)
-{
-	if (rte_pktmbuf_tailroom(pkt) >= data_len)
-		return 0;
-
-	/* attach an external buffer if supported */
-	if (dev->extbuf && !virtio_dev_extbuf_alloc(dev, pkt, data_len))
-		return 0;
-
-	/* check if chained buffers are allowed */
-	if (!dev->linearbuf)
-		return 0;
-
-	return -1;
-}
-
-__rte_always_inline
-static uint16_t
-virtio_dev_tx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
-	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-	bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint16_t i;
-	uint16_t avail_entries;
-	static bool allocerr_warned;
-
-	/*
-	 * The ordering between avail index and
-	 * desc reads needs to be enforced.
-	 */
-	avail_entries = rte_atomic_load_explicit((unsigned short __rte_atomic *)&vq->avail->idx,
-		rte_memory_order_acquire) - vq->last_avail_idx;
-	if (avail_entries == 0)
-		return 0;
-
-	rte_prefetch0(&vq->avail->ring[vq->last_avail_idx & (vq->size - 1)]);
-
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
-
-	count = RTE_MIN(count, MAX_PKT_BURST);
-	count = RTE_MIN(count, avail_entries);
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "about to dequeue %u buffers", count);
-
-	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts, count)) {
-		vq->stats.mbuf_alloc_failed += count;
-		return 0;
-	}
-
-	for (i = 0; i < count; i++) {
-		struct buf_vector buf_vec[BUF_VECTOR_MAX];
-		uint16_t head_idx;
-		uint32_t buf_len;
-		uint16_t nr_vec = 0;
-		int err;
-
-		if (unlikely(fill_vec_buf_split(dev, vq,
-						vq->last_avail_idx + i,
-						&nr_vec, buf_vec,
-						&head_idx, &buf_len,
-						VHOST_ACCESS_RO) < 0))
-			break;
-
-		update_shadow_used_ring_split(vq, head_idx, 0);
-
-		if (unlikely(buf_len <= dev->vhost_hlen))
-			break;
-
-		buf_len -= dev->vhost_hlen;
-
-		err = virtio_dev_pktmbuf_prep(dev, pkts[i], buf_len);
-		if (unlikely(err)) {
-			/*
-			 * mbuf allocation fails for jumbo packets when external
-			 * buffer allocation is not allowed and linear buffer
-			 * is required. Drop this packet.
-			 */
-			if (!allocerr_warned) {
-				VHOST_DATA_LOG(dev->ifname, ERR,
-					"failed mbuf alloc of size %d from %s.",
-					buf_len, mbuf_pool->name);
-				allocerr_warned = true;
-			}
-			break;
-		}
-
-		err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkts[i],
-				   mbuf_pool, legacy_ol_flags, 0, false);
-		if (unlikely(err)) {
-			if (!allocerr_warned) {
-				VHOST_DATA_LOG(dev->ifname, ERR, "failed to copy desc to mbuf.");
-				allocerr_warned = true;
-			}
-			break;
-		}
-	}
-
-	if (unlikely(count != i))
-		rte_pktmbuf_free_bulk(&pkts[i], count - i);
-
-	if (likely(vq->shadow_used_idx)) {
-		vq->last_avail_idx += vq->shadow_used_idx;
-		vhost_virtqueue_reconnect_log_split(vq);
-		do_data_copy_dequeue(vq);
-		flush_shadow_used_ring_split(dev, vq);
-		vhost_vring_call_split(dev, vq);
-	}
-
-	return i;
-}
-
-__rte_noinline
-static uint16_t
-virtio_dev_tx_split_legacy(struct virtio_net *dev,
-	struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
-	struct rte_mbuf **pkts, uint16_t count)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	return virtio_dev_tx_split(dev, vq, mbuf_pool, pkts, count, true);
-}
-
-__rte_noinline
-static uint16_t
-virtio_dev_tx_split_compliant(struct virtio_net *dev,
-	struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
-	struct rte_mbuf **pkts, uint16_t count)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	return virtio_dev_tx_split(dev, vq, mbuf_pool, pkts, count, false);
-}
-
-static __rte_always_inline int
-vhost_reserve_avail_batch_packed(struct virtio_net *dev,
-				 struct vhost_virtqueue *vq,
-				 struct rte_mbuf **pkts,
-				 uint16_t avail_idx,
-				 uintptr_t *desc_addrs,
-				 uint16_t *ids)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	bool wrap = vq->avail_wrap_counter;
-	struct vring_packed_desc *descs = vq->desc_packed;
-	uint64_t lens[PACKED_BATCH_SIZE];
-	uint64_t buf_lens[PACKED_BATCH_SIZE];
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	uint16_t flags, i;
-
-	if (unlikely(avail_idx & PACKED_BATCH_MASK))
-		return -1;
-	if (unlikely((avail_idx + PACKED_BATCH_SIZE) > vq->size))
-		return -1;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		flags = descs[avail_idx + i].flags;
-		if (unlikely((wrap != !!(flags & VRING_DESC_F_AVAIL)) ||
-			     (wrap == !!(flags & VRING_DESC_F_USED))  ||
-			     (flags & PACKED_DESC_SINGLE_DEQUEUE_FLAG)))
-			return -1;
-	}
-
-	rte_atomic_thread_fence(rte_memory_order_acquire);
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		lens[i] = descs[avail_idx + i].len;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		desc_addrs[i] = vhost_iova_to_vva(dev, vq,
-						  descs[avail_idx + i].addr,
-						  &lens[i], VHOST_ACCESS_RW);
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(!desc_addrs[i]))
-			return -1;
-		if (unlikely((lens[i] != descs[avail_idx + i].len)))
-			return -1;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (virtio_dev_pktmbuf_prep(dev, pkts[i], lens[i]))
-			goto err;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		buf_lens[i] = pkts[i]->buf_len - pkts[i]->data_off;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(buf_lens[i] < (lens[i] - buf_offset)))
-			goto err;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		pkts[i]->pkt_len = lens[i] - buf_offset;
-		pkts[i]->data_len = pkts[i]->pkt_len;
-		ids[i] = descs[avail_idx + i].id;
-	}
-
-	return 0;
-
-err:
-	return -1;
-}
-
-static __rte_always_inline int
-vhost_async_tx_batch_packed_check(struct virtio_net *dev,
-				 struct vhost_virtqueue *vq,
-				 struct rte_mbuf **pkts,
-				 uint16_t avail_idx,
-				 uintptr_t *desc_addrs,
-				 uint64_t *lens,
-				 uint16_t *ids,
-				 int16_t dma_id,
-				 uint16_t vchan_id)
-{
-	bool wrap = vq->avail_wrap_counter;
-	struct vring_packed_desc *descs = vq->desc_packed;
-	uint64_t buf_lens[PACKED_BATCH_SIZE];
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	uint16_t flags, i;
-
-	if (unlikely(avail_idx & PACKED_BATCH_MASK))
-		return -1;
-	if (unlikely((avail_idx + PACKED_BATCH_SIZE) > vq->size))
-		return -1;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		flags = descs[avail_idx + i].flags;
-		if (unlikely((wrap != !!(flags & VRING_DESC_F_AVAIL)) ||
-			     (wrap == !!(flags & VRING_DESC_F_USED))  ||
-			     (flags & PACKED_DESC_SINGLE_DEQUEUE_FLAG)))
-			return -1;
-	}
-
-	rte_atomic_thread_fence(rte_memory_order_acquire);
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		lens[i] = descs[avail_idx + i].len;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		desc_addrs[i] = descs[avail_idx + i].addr;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(!desc_addrs[i]))
-			return -1;
-		if (unlikely((lens[i] != descs[avail_idx + i].len)))
-			return -1;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (virtio_dev_pktmbuf_prep(dev, pkts[i], lens[i]))
-			goto err;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		buf_lens[i] = pkts[i]->buf_len - pkts[i]->data_off;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		if (unlikely(buf_lens[i] < (lens[i] - buf_offset)))
-			goto err;
-	}
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		pkts[i]->pkt_len = lens[i] - buf_offset;
-		pkts[i]->data_len = pkts[i]->pkt_len;
-		ids[i] = descs[avail_idx + i].id;
-	}
-
-	if (rte_dma_burst_capacity(dma_id, vchan_id) < PACKED_BATCH_SIZE)
-		return -1;
-
-	return 0;
-
-err:
-	return -1;
-}
-
-static __rte_always_inline int
-virtio_dev_tx_batch_packed(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts,
-			   bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
-	uint16_t ids[PACKED_BATCH_SIZE];
-	uint16_t i;
-
-	if (vhost_reserve_avail_batch_packed(dev, vq, pkts, avail_idx,
-					     desc_addrs, ids))
-		return -1;
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		rte_prefetch0((void *)(uintptr_t)desc_addrs[i]);
-
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		rte_memcpy(rte_pktmbuf_mtod_offset(pkts[i], void *, 0),
-			   (void *)(uintptr_t)(desc_addrs[i] + buf_offset),
-			   pkts[i]->pkt_len);
-
-	if (virtio_net_with_host_offload(dev)) {
-		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-			struct virtio_net_hdr hdr;
-
-			memcpy(&hdr, (void *)desc_addrs[i], sizeof(struct virtio_net_hdr));
-			rte_compiler_barrier();
-
-			vhost_dequeue_offload(dev, &hdr, pkts[i], legacy_ol_flags);
-		}
-	}
-
-	if (virtio_net_is_inorder(dev))
-		vhost_shadow_dequeue_batch_packed_inorder(vq,
-			ids[PACKED_BATCH_SIZE - 1]);
-	else
-		vhost_shadow_dequeue_batch_packed(dev, vq, ids);
-
-	vq_inc_last_avail_packed(vq, PACKED_BATCH_SIZE);
-
-	return 0;
-}
-
-static __rte_always_inline int
-vhost_dequeue_single_packed(struct virtio_net *dev,
-			    struct vhost_virtqueue *vq,
-			    struct rte_mempool *mbuf_pool,
-			    struct rte_mbuf *pkts,
-			    uint16_t *buf_id,
-			    uint16_t *desc_count,
-			    bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	struct buf_vector buf_vec[BUF_VECTOR_MAX];
-	uint32_t buf_len;
-	uint16_t nr_vec = 0;
-	int err;
-	static bool allocerr_warned;
-
-	if (unlikely(fill_vec_buf_packed(dev, vq,
-					 vq->last_avail_idx, desc_count,
-					 buf_vec, &nr_vec,
-					 buf_id, &buf_len,
-					 VHOST_ACCESS_RO) < 0))
-		return -1;
-
-	if (unlikely(buf_len <= dev->vhost_hlen))
-		return -1;
-
-	buf_len -= dev->vhost_hlen;
-
-	if (unlikely(virtio_dev_pktmbuf_prep(dev, pkts, buf_len))) {
-		if (!allocerr_warned) {
-			VHOST_DATA_LOG(dev->ifname, ERR,
-				"failed mbuf alloc of size %d from %s.",
-				buf_len, mbuf_pool->name);
-			allocerr_warned = true;
-		}
-		return -1;
-	}
-
-	err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkts,
-			   mbuf_pool, legacy_ol_flags, 0, false);
-	if (unlikely(err)) {
-		if (!allocerr_warned) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "failed to copy desc to mbuf.");
-			allocerr_warned = true;
-		}
-		return -1;
-	}
-
-	return 0;
-}
-
-static __rte_always_inline int
-virtio_dev_tx_single_packed(struct virtio_net *dev,
-			    struct vhost_virtqueue *vq,
-			    struct rte_mempool *mbuf_pool,
-			    struct rte_mbuf *pkts,
-			    bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-
-	uint16_t buf_id, desc_count = 0;
-	int ret;
-
-	ret = vhost_dequeue_single_packed(dev, vq, mbuf_pool, pkts, &buf_id,
-					&desc_count, legacy_ol_flags);
-
-	if (likely(desc_count > 0)) {
-		if (virtio_net_is_inorder(dev))
-			vhost_shadow_dequeue_single_packed_inorder(vq, buf_id,
-								   desc_count);
-		else
-			vhost_shadow_dequeue_single_packed(vq, buf_id,
-					desc_count);
-
-		vq_inc_last_avail_packed(vq, desc_count);
-	}
-
-	return ret;
-}
-
-static __rte_always_inline uint16_t
-get_nb_avail_entries_packed(const struct vhost_virtqueue *__rte_restrict vq,
-			    uint16_t max_nb_avail_entries)
-{
-	const struct vring_packed_desc *descs = vq->desc_packed;
-	bool avail_wrap = vq->avail_wrap_counter;
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint16_t nb_avail_entries = 0;
-	uint16_t flags;
-
-	while (nb_avail_entries < max_nb_avail_entries) {
-		flags = descs[avail_idx].flags;
-
-		if ((avail_wrap != !!(flags & VRING_DESC_F_AVAIL)) ||
-		    (avail_wrap == !!(flags & VRING_DESC_F_USED)))
-			return nb_avail_entries;
-
-		if (!(flags & VRING_DESC_F_NEXT))
-			++nb_avail_entries;
-
-		if (unlikely(++avail_idx >= vq->size)) {
-			avail_idx -= vq->size;
-			avail_wrap = !avail_wrap;
+				"unsupported gso type %u.",
+				hdr->gso_type);
+			goto error;
 		}
 	}
+	return;
 
-	return nb_avail_entries;
+error:
+	m->l2_len = 0;
+	m->l3_len = 0;
+	m->ol_flags = 0;
 }
 
-__rte_always_inline
-static uint16_t
-virtio_dev_tx_packed(struct virtio_net *dev,
-		     struct vhost_virtqueue *__rte_restrict vq,
-		     struct rte_mempool *mbuf_pool,
-		     struct rte_mbuf **__rte_restrict pkts,
-		     uint32_t count,
-		     bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
+static __rte_always_inline void
+vhost_dequeue_offload(struct virtio_net *dev, struct virtio_net_hdr *hdr,
+		struct rte_mbuf *m, bool legacy_ol_flags)
 {
-	uint32_t pkt_idx = 0;
+	struct rte_net_hdr_lens hdr_lens;
+	int l4_supported = 0;
+	uint32_t ptype;
 
-	count = get_nb_avail_entries_packed(vq, count);
-	if (count == 0)
-		return 0;
+	if (hdr->flags == 0 && hdr->gso_type == VIRTIO_NET_HDR_GSO_NONE)
+		return;
 
-	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts, count)) {
-		vq->stats.mbuf_alloc_failed += count;
-		return 0;
+	if (legacy_ol_flags) {
+		vhost_dequeue_offload_legacy(dev, hdr, m);
+		return;
 	}
 
-	do {
-		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
+	m->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN;
 
-		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_tx_batch_packed(dev, vq,
-							&pkts[pkt_idx],
-							legacy_ol_flags)) {
-				pkt_idx += PACKED_BATCH_SIZE;
-				continue;
-			}
-		}
+	ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+	m->packet_type = ptype;
+	if ((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP ||
+	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP ||
+	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_SCTP)
+		l4_supported = 1;
 
-		if (virtio_dev_tx_single_packed(dev, vq, mbuf_pool,
-						pkts[pkt_idx],
-						legacy_ol_flags))
-			break;
-		pkt_idx++;
-	} while (pkt_idx < count);
+	/* According to Virtio 1.1 spec, the device only needs to look at
+	 * VIRTIO_NET_HDR_F_NEEDS_CSUM in the packet transmission path.
+	 * This differs from the processing incoming packets path where the
+	 * driver could rely on VIRTIO_NET_HDR_F_DATA_VALID flag set by the
+	 * device.
+	 *
+	 * 5.1.6.2.1 Driver Requirements: Packet Transmission
+	 * The driver MUST NOT set the VIRTIO_NET_HDR_F_DATA_VALID and
+	 * VIRTIO_NET_HDR_F_RSC_INFO bits in flags.
+	 *
+	 * 5.1.6.2.2 Device Requirements: Packet Transmission
+	 * The device MUST ignore flag bits that it does not recognize.
+	 */
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		uint32_t hdrlen;
 
-	if (pkt_idx != count)
-		rte_pktmbuf_free_bulk(&pkts[pkt_idx], count - pkt_idx);
+		hdrlen = hdr_lens.l2_len + hdr_lens.l3_len + hdr_lens.l4_len;
+		if (hdr->csum_start <= hdrlen && l4_supported != 0) {
+			m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_NONE;
+		} else {
+			/* Unknown proto or tunnel, do sw cksum. We can assume
+			 * the cksum field is in the first segment since the
+			 * buffers we provided to the host are large enough.
+			 * In case of SCTP, this will be wrong since it's a CRC
+			 * but there's nothing we can do.
+			 */
+			uint16_t csum = 0, off;
 
-	if (vq->shadow_used_idx) {
-		do_data_copy_dequeue(vq);
+			if (hdr->csum_start >= rte_pktmbuf_pkt_len(m))
+				return;
 
-		vhost_flush_dequeue_shadow_packed(dev, vq);
-		vhost_vring_call_packed(dev, vq);
+			if (rte_raw_cksum_mbuf(m, hdr->csum_start,
+					rte_pktmbuf_pkt_len(m) - hdr->csum_start, &csum) < 0)
+				return;
+			if (likely(csum != 0xffff))
+				csum = ~csum;
+			off = hdr->csum_offset + hdr->csum_start;
+			if (rte_pktmbuf_data_len(m) >= off + 1)
+				*rte_pktmbuf_mtod_offset(m, uint16_t *, off) = csum;
+		}
 	}
 
-	return pkt_idx;
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		if (hdr->gso_size == 0)
+			return;
+
+		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		case VIRTIO_NET_HDR_GSO_TCPV4:
+		case VIRTIO_NET_HDR_GSO_TCPV6:
+			if ((ptype & RTE_PTYPE_L4_MASK) != RTE_PTYPE_L4_TCP)
+				break;
+			m->ol_flags |= RTE_MBUF_F_RX_LRO | RTE_MBUF_F_RX_L4_CKSUM_NONE;
+			m->tso_segsz = hdr->gso_size;
+			break;
+		case VIRTIO_NET_HDR_GSO_UDP:
+			if ((ptype & RTE_PTYPE_L4_MASK) != RTE_PTYPE_L4_UDP)
+				break;
+			m->ol_flags |= RTE_MBUF_F_RX_LRO | RTE_MBUF_F_RX_L4_CKSUM_NONE;
+			m->tso_segsz = hdr->gso_size;
+			break;
+		default:
+			break;
+		}
+	}
 }
 
-__rte_noinline
-static uint16_t
-virtio_dev_tx_packed_legacy(struct virtio_net *dev,
-	struct vhost_virtqueue *__rte_restrict vq, struct rte_mempool *mbuf_pool,
-	struct rte_mbuf **__rte_restrict pkts, uint32_t count)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
+static __rte_always_inline int
+copy_vnet_hdr_from_desc(struct virtio_net_hdr *hdr,
+			const struct buf_vector *buf_vec,
+			uint16_t nr_vec)
 {
-	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, true);
+	size_t remain = sizeof(struct virtio_net_hdr);
+	uint8_t *dst = (uint8_t *)hdr;
+
+	while (remain > 0) {
+		size_t len = RTE_MIN(remain, buf_vec->buf_len);
+		const void *src = (const void *)(uintptr_t)buf_vec->buf_addr;
+
+		if (unlikely(nr_vec == 0))
+			return -1;
+
+		memcpy(dst, src, len);
+		remain -= len;
+		dst += len;
+		buf_vec++;
+		--nr_vec;
+	}
+	return 0;
 }
 
-__rte_noinline
-static uint16_t
-virtio_dev_tx_packed_compliant(struct virtio_net *dev,
-	struct vhost_virtqueue *__rte_restrict vq, struct rte_mempool *mbuf_pool,
-	struct rte_mbuf **__rte_restrict pkts, uint32_t count)
+static __rte_always_inline int
+desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
+		  struct buf_vector *buf_vec, uint16_t nr_vec,
+		  struct rte_mbuf *m, struct rte_mempool *mbuf_pool,
+		  bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, false);
-}
+	uint32_t buf_avail, buf_offset, buf_len;
+	uint64_t buf_addr, buf_iova;
+	uint32_t mbuf_avail, mbuf_offset;
+	uint32_t hdr_remain = dev->vhost_hlen;
+	uint32_t cpy_len;
+	struct rte_mbuf *cur = m, *prev = m;
+	struct virtio_net_hdr tmp_hdr;
+	struct virtio_net_hdr *hdr = NULL;
+	uint16_t vec_idx;
 
-RTE_EXPORT_SYMBOL(rte_vhost_dequeue_burst)
-uint16_t
-rte_vhost_dequeue_burst(int vid, uint16_t queue_id,
-	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count)
-{
-	struct virtio_net *dev;
-	struct vhost_virtqueue *vq;
-	int16_t success = 1;
-	uint16_t nb_rx = 0;
+	/*
+	 * The caller has checked the descriptors chain is larger than the
+	 * header size.
+	 */
 
-	dev = get_device(vid);
-	if (!dev)
-		return 0;
+	if (virtio_net_with_host_offload(dev)) {
+		if (unlikely(copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec, nr_vec) != 0))
+			return -1;
 
-	if (unlikely(!(dev->flags & VIRTIO_DEV_BUILTIN_VIRTIO_NET))) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: built-in vhost net backend is disabled.",
-			__func__);
-		goto out_no_unlock;
+		/* ensure that compiler does not delay copy */
+		rte_compiler_barrier();
+		hdr = &tmp_hdr;
 	}
 
-	if (unlikely(!is_valid_virt_queue_idx(queue_id, 1, dev->nr_vring))) {
-		VHOST_DATA_LOG(dev->ifname, ERR,
-			"%s: invalid virtqueue idx %d.",
-			__func__, queue_id);
-		goto out_no_unlock;
+	for (vec_idx = 0; vec_idx < nr_vec; vec_idx++) {
+		if (buf_vec[vec_idx].buf_len > hdr_remain)
+			break;
+
+		hdr_remain -= buf_vec[vec_idx].buf_len;
 	}
 
-	vq = dev->virtqueue[queue_id];
+	buf_addr = buf_vec[vec_idx].buf_addr;
+	buf_iova = buf_vec[vec_idx].buf_iova;
+	buf_len = buf_vec[vec_idx].buf_len;
+	buf_offset = hdr_remain;
+	buf_avail = buf_vec[vec_idx].buf_len - hdr_remain;
 
-	if (unlikely(rte_rwlock_read_trylock(&vq->access_lock) != 0))
-		goto out_no_unlock;
+	PRINT_PACKET(dev,
+			(uintptr_t)(buf_addr + buf_offset),
+			(uint32_t)buf_avail, 0);
 
-	if (unlikely(!vq->enabled))
-		goto out_access_unlock;
+	mbuf_offset = 0;
+	mbuf_avail  = m->buf_len - RTE_PKTMBUF_HEADROOM;
 
-	vhost_user_iotlb_rd_lock(vq);
+	while (1) {
+		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
 
-	if (unlikely(!vq->access_ok)) {
-		vhost_user_iotlb_rd_unlock(vq);
-		rte_rwlock_read_unlock(&vq->access_lock);
+		if (likely(hdr && cur == m)) {
+			rte_memcpy(rte_pktmbuf_mtod_offset(cur, void *, mbuf_offset),
+				(void *)((uintptr_t)(buf_addr + buf_offset)),
+				cpy_len);
+		} else {
+			sync_fill_seg(dev, vq, cur, mbuf_offset,
+				      buf_addr + buf_offset,
+				      buf_iova + buf_offset, cpy_len, false);
+		}
 
-		virtio_dev_vring_translate(dev, vq);
+		mbuf_avail  -= cpy_len;
+		mbuf_offset += cpy_len;
+		buf_avail -= cpy_len;
+		buf_offset += cpy_len;
+
+		/* This buf reaches to its end, get the next one */
+		if (buf_avail == 0) {
+			if (++vec_idx >= nr_vec)
+				break;
+
+			buf_addr = buf_vec[vec_idx].buf_addr;
+			buf_iova = buf_vec[vec_idx].buf_iova;
+			buf_len = buf_vec[vec_idx].buf_len;
+
+			buf_offset = 0;
+			buf_avail  = buf_len;
 
-		goto out_no_unlock;
-	}
+			PRINT_PACKET(dev, (uintptr_t)buf_addr,
+					(uint32_t)buf_avail, 0);
+		}
 
-	/*
-	 * Construct a RARP broadcast packet, and inject it to the "pkts"
-	 * array, to looks like that guest actually send such packet.
-	 *
-	 * Check user_send_rarp() for more information.
-	 *
-	 * broadcast_rarp shares a cacheline in the virtio_net structure
-	 * with some fields that are accessed during enqueue and
-	 * rte_atomic_compare_exchange_strong_explicit causes a write if performed compare
-	 * and exchange. This could result in false sharing between enqueue
-	 * and dequeue.
-	 *
-	 * Prevent unnecessary false sharing by reading broadcast_rarp first
-	 * and only performing compare and exchange if the read indicates it
-	 * is likely to be set.
-	 */
-	if (unlikely(rte_atomic_load_explicit(&dev->broadcast_rarp, rte_memory_order_acquire) &&
-			rte_atomic_compare_exchange_strong_explicit(&dev->broadcast_rarp,
-			&success, 0, rte_memory_order_release, rte_memory_order_relaxed))) {
 		/*
-		 * Inject the RARP packet to the head of "pkts" array,
-		 * so that switch's mac learning table will get updated first.
+		 * This mbuf reaches to its end, get a new one
+		 * to hold more data.
 		 */
-		pkts[nb_rx] = rte_net_make_rarp_packet(mbuf_pool, &dev->mac);
-		if (pkts[nb_rx] == NULL) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "failed to make RARP packet.");
-			goto out;
-		}
-		nb_rx += 1;
-	}
+		if (mbuf_avail == 0) {
+			cur = rte_pktmbuf_alloc(mbuf_pool);
+			if (unlikely(cur == NULL)) {
+				vq->stats.mbuf_alloc_failed++;
+				VHOST_DATA_LOG(dev->ifname, ERR,
+					"failed to allocate memory for mbuf.");
+				return -1;
+			}
 
-	if (vq_is_packed(dev)) {
-		if (dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS)
-			nb_rx += virtio_dev_tx_packed_legacy(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx);
-		else
-			nb_rx += virtio_dev_tx_packed_compliant(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx);
-	} else {
-		if (dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS)
-			nb_rx += virtio_dev_tx_split_legacy(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx);
-		else
-			nb_rx += virtio_dev_tx_split_compliant(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx);
+			prev->next = cur;
+			prev->data_len = mbuf_offset;
+			m->nb_segs += 1;
+			m->pkt_len += mbuf_offset;
+			prev = cur;
+
+			mbuf_offset = 0;
+			mbuf_avail  = cur->buf_len - RTE_PKTMBUF_HEADROOM;
+		}
 	}
 
-	vhost_queue_stats_update(dev, vq, pkts, nb_rx);
+	prev->data_len = mbuf_offset;
+	m->pkt_len    += mbuf_offset;
 
-out:
-	vhost_user_iotlb_rd_unlock(vq);
+	if (hdr)
+		vhost_dequeue_offload(dev, hdr, m, legacy_ol_flags);
 
-out_access_unlock:
-	rte_rwlock_read_unlock(&vq->access_lock);
+	return 0;
+}
 
-out_no_unlock:
-	return nb_rx;
+static void
+virtio_dev_extbuf_free(void *addr __rte_unused, void *opaque)
+{
+	rte_free(opaque);
 }
 
-static __rte_always_inline uint16_t
-async_poll_dequeue_completed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
-		uint16_t vchan_id, bool legacy_ol_flags)
-	__rte_requires_shared_capability(&vq->access_lock)
+static int
+virtio_dev_extbuf_alloc(struct virtio_net *dev, struct rte_mbuf *pkt, uint32_t size)
 {
-	uint16_t start_idx, from, i;
-	uint16_t nr_cpl_pkts = 0;
-	struct async_inflight_info *pkts_info = vq->async->pkts_info;
+	struct rte_mbuf_ext_shared_info *shinfo = NULL;
+	uint32_t total_len = RTE_PKTMBUF_HEADROOM + size;
+	uint16_t buf_len;
+	rte_iova_t iova;
+	void *buf;
+
+	total_len += sizeof(*shinfo) + sizeof(uintptr_t);
+	total_len = RTE_ALIGN_CEIL(total_len, sizeof(uintptr_t));
 
-	vhost_async_dma_check_completed(dev, dma_id, vchan_id, VHOST_DMA_MAX_COPY_COMPLETE);
+	if (unlikely(total_len > UINT16_MAX))
+		return -ENOSPC;
 
-	start_idx = async_get_first_inflight_pkt_idx(vq);
+	buf_len = total_len;
+	buf = rte_malloc(NULL, buf_len, RTE_CACHE_LINE_SIZE);
+	if (unlikely(buf == NULL))
+		return -ENOMEM;
 
-	from = start_idx;
-	while (vq->async->pkts_cmpl_flag[from] && count--) {
-		vq->async->pkts_cmpl_flag[from] = false;
-		from = (from + 1) % vq->size;
-		nr_cpl_pkts++;
+	/* Initialize shinfo */
+	shinfo = rte_pktmbuf_ext_shinfo_init_helper(buf, &buf_len,
+						virtio_dev_extbuf_free, buf);
+	if (unlikely(shinfo == NULL)) {
+		rte_free(buf);
+		VHOST_DATA_LOG(dev->ifname, ERR, "failed to init shinfo");
+		return -1;
 	}
 
-	if (nr_cpl_pkts == 0)
-		return 0;
+	iova = rte_malloc_virt2iova(buf);
+	rte_pktmbuf_attach_extbuf(pkt, buf, iova, buf_len, shinfo);
+	rte_pktmbuf_reset_headroom(pkt);
 
-	for (i = 0; i < nr_cpl_pkts; i++) {
-		from = (start_idx + i) % vq->size;
-		pkts[i] = pkts_info[from].mbuf;
+	return 0;
+}
 
-		if (virtio_net_with_host_offload(dev))
-			vhost_dequeue_offload(dev, &pkts_info[from].nethdr, pkts[i],
-					      legacy_ol_flags);
-	}
+/*
+ * Prepare a host supported pktmbuf.
+ */
+static __rte_always_inline int
+virtio_dev_pktmbuf_prep(struct virtio_net *dev, struct rte_mbuf *pkt,
+			 uint32_t data_len)
+{
+	if (rte_pktmbuf_tailroom(pkt) >= data_len)
+		return 0;
 
-	/* write back completed descs to used ring and update used idx */
-	if (vq_is_packed(dev)) {
-		write_back_completed_descs_packed(vq, nr_cpl_pkts);
-		vhost_vring_call_packed(dev, vq);
-	} else {
-		write_back_completed_descs_split(vq, nr_cpl_pkts);
-		rte_atomic_fetch_add_explicit((unsigned short __rte_atomic *)&vq->used->idx,
-			nr_cpl_pkts, rte_memory_order_release);
-		vhost_vring_call_split(dev, vq);
-	}
-	vq->async->pkts_inflight_n -= nr_cpl_pkts;
+	/* attach an external buffer if supported */
+	if (dev->extbuf && !virtio_dev_extbuf_alloc(dev, pkt, data_len))
+		return 0;
+
+	/* check if chained buffers are allowed */
+	if (!dev->linearbuf)
+		return 0;
 
-	return nr_cpl_pkts;
+	return -1;
 }
 
-static __rte_always_inline uint16_t
-virtio_dev_tx_async_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-		int16_t dma_id, uint16_t vchan_id, bool legacy_ol_flags)
+__rte_always_inline
+static uint16_t
+virtio_dev_tx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
+	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
+	bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	static bool allocerr_warned;
-	bool dropped = false;
+	uint16_t i;
 	uint16_t avail_entries;
-	uint16_t pkt_idx, slot_idx = 0;
-	uint16_t nr_done_pkts = 0;
-	uint16_t pkt_err = 0;
-	uint16_t n_xfer;
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	struct rte_mbuf *pkts_prealloc[MAX_PKT_BURST];
-	uint16_t pkts_size = count;
-
-	/**
+	static bool allocerr_warned;
+
+	/*
 	 * The ordering between avail index and
 	 * desc reads needs to be enforced.
 	 */
 	avail_entries = rte_atomic_load_explicit((unsigned short __rte_atomic *)&vq->avail->idx,
 		rte_memory_order_acquire) - vq->last_avail_idx;
 	if (avail_entries == 0)
-		goto out;
+		return 0;
 
 	rte_prefetch0(&vq->avail->ring[vq->last_avail_idx & (vq->size - 1)]);
 
-	async_iter_reset(async);
+	VHOST_DATA_LOG(dev->ifname, DEBUG, "%s", __func__);
 
 	count = RTE_MIN(count, MAX_PKT_BURST);
 	count = RTE_MIN(count, avail_entries);
 	VHOST_DATA_LOG(dev->ifname, DEBUG, "about to dequeue %u buffers", count);
 
-	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts_prealloc, count)) {
+	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts, count)) {
 		vq->stats.mbuf_alloc_failed += count;
-		goto out;
+		return 0;
 	}
 
-	for (pkt_idx = 0; pkt_idx < count; pkt_idx++) {
-		uint16_t head_idx = 0;
-		uint16_t nr_vec = 0;
-		uint16_t to;
+	for (i = 0; i < count; i++) {
+		struct buf_vector buf_vec[BUF_VECTOR_MAX];
+		uint16_t head_idx;
 		uint32_t buf_len;
+		uint16_t nr_vec = 0;
 		int err;
-		struct buf_vector buf_vec[BUF_VECTOR_MAX];
-		struct rte_mbuf *pkt = pkts_prealloc[pkt_idx];
 
-		if (unlikely(fill_vec_buf_split(dev, vq, vq->last_avail_idx,
+		if (unlikely(fill_vec_buf_split(dev, vq,
+						vq->last_avail_idx + i,
 						&nr_vec, buf_vec,
 						&head_idx, &buf_len,
-						VHOST_ACCESS_RO) < 0)) {
-			dropped = true;
+						VHOST_ACCESS_RO) < 0))
 			break;
-		}
 
-		if (unlikely(buf_len <= dev->vhost_hlen)) {
-			dropped = true;
+		update_shadow_used_ring_split(vq, head_idx, 0);
+
+		if (unlikely(buf_len <= dev->vhost_hlen))
 			break;
-		}
 
 		buf_len -= dev->vhost_hlen;
 
-		err = virtio_dev_pktmbuf_prep(dev, pkt, buf_len);
+		err = virtio_dev_pktmbuf_prep(dev, pkts[i], buf_len);
 		if (unlikely(err)) {
-			/**
+			/*
 			 * mbuf allocation fails for jumbo packets when external
 			 * buffer allocation is not allowed and linear buffer
 			 * is required. Drop this packet.
 			 */
 			if (!allocerr_warned) {
 				VHOST_DATA_LOG(dev->ifname, ERR,
-					"%s: Failed mbuf alloc of size %d from %s",
-					__func__, buf_len, mbuf_pool->name);
+					"failed mbuf alloc of size %d from %s.",
+					buf_len, mbuf_pool->name);
 				allocerr_warned = true;
 			}
-			dropped = true;
-			slot_idx--;
 			break;
 		}
 
-		slot_idx = (async->pkts_idx + pkt_idx) & (vq->size - 1);
-		err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkt, mbuf_pool,
-					legacy_ol_flags, slot_idx, true);
+		err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkts[i], mbuf_pool, legacy_ol_flags);
 		if (unlikely(err)) {
 			if (!allocerr_warned) {
-				VHOST_DATA_LOG(dev->ifname, ERR,
-					"%s: Failed to offload copies to async channel.",
-					__func__);
+				VHOST_DATA_LOG(dev->ifname, ERR, "failed to copy desc to mbuf.");
 				allocerr_warned = true;
 			}
-			dropped = true;
-			slot_idx--;
 			break;
 		}
+	}
 
-		pkts_info[slot_idx].mbuf = pkt;
-
-		/* store used descs */
-		to = async->desc_idx_split & (vq->size - 1);
-		async->descs_split[to].id = head_idx;
-		async->descs_split[to].len = 0;
-		async->desc_idx_split++;
+	if (unlikely(count != i))
+		rte_pktmbuf_free_bulk(&pkts[i], count - i);
 
-		vq->last_avail_idx++;
+	if (likely(vq->shadow_used_idx)) {
+		vq->last_avail_idx += vq->shadow_used_idx;
 		vhost_virtqueue_reconnect_log_split(vq);
+		do_data_copy_dequeue(vq);
+		flush_shadow_used_ring_split(dev, vq);
+		vhost_vring_call_split(dev, vq);
+	}
+
+	return i;
+}
+
+__rte_noinline
+static uint16_t
+virtio_dev_tx_split_legacy(struct virtio_net *dev,
+	struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
+	struct rte_mbuf **pkts, uint16_t count)
+	__rte_requires_shared_capability(&vq->access_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
+{
+	return virtio_dev_tx_split(dev, vq, mbuf_pool, pkts, count, true);
+}
+
+__rte_noinline
+static uint16_t
+virtio_dev_tx_split_compliant(struct virtio_net *dev,
+	struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
+	struct rte_mbuf **pkts, uint16_t count)
+	__rte_requires_shared_capability(&vq->access_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
+{
+	return virtio_dev_tx_split(dev, vq, mbuf_pool, pkts, count, false);
+}
+
+static __rte_always_inline int
+vhost_reserve_avail_batch_packed(struct virtio_net *dev,
+				 struct vhost_virtqueue *vq,
+				 struct rte_mbuf **pkts,
+				 uint16_t avail_idx,
+				 uintptr_t *desc_addrs,
+				 uint16_t *ids)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
+{
+	bool wrap = vq->avail_wrap_counter;
+	struct vring_packed_desc *descs = vq->desc_packed;
+	uint64_t lens[PACKED_BATCH_SIZE];
+	uint64_t buf_lens[PACKED_BATCH_SIZE];
+	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	uint16_t flags, i;
+
+	if (unlikely(avail_idx & PACKED_BATCH_MASK))
+		return -1;
+	if (unlikely((avail_idx + PACKED_BATCH_SIZE) > vq->size))
+		return -1;
+
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		flags = descs[avail_idx + i].flags;
+		if (unlikely((wrap != !!(flags & VRING_DESC_F_AVAIL)) ||
+			     (wrap == !!(flags & VRING_DESC_F_USED))  ||
+			     (flags & PACKED_DESC_SINGLE_DEQUEUE_FLAG)))
+			return -1;
+	}
+
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
+		lens[i] = descs[avail_idx + i].len;
+
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		desc_addrs[i] = vhost_iova_to_vva(dev, vq,
+						  descs[avail_idx + i].addr,
+						  &lens[i], VHOST_ACCESS_RW);
+	}
+
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		if (unlikely(!desc_addrs[i]))
+			return -1;
+		if (unlikely((lens[i] != descs[avail_idx + i].len)))
+			return -1;
 	}
 
-	if (unlikely(dropped))
-		rte_pktmbuf_free_bulk(&pkts_prealloc[pkt_idx], count - pkt_idx);
-
-	n_xfer = vhost_async_dma_transfer(dev, vq, dma_id, vchan_id, async->pkts_idx,
-					  async->iov_iter, pkt_idx);
-
-	async->pkts_inflight_n += n_xfer;
-
-	pkt_err = pkt_idx - n_xfer;
-	if (unlikely(pkt_err)) {
-		VHOST_DATA_LOG(dev->ifname, DEBUG, "%s: failed to transfer data.",
-			__func__);
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		if (virtio_dev_pktmbuf_prep(dev, pkts[i], lens[i]))
+			goto err;
+	}
 
-		pkt_idx = n_xfer;
-		/* recover available ring */
-		vq->last_avail_idx -= pkt_err;
-		vhost_virtqueue_reconnect_log_split(vq);
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
+		buf_lens[i] = pkts[i]->buf_len - pkts[i]->data_off;
 
-		/**
-		 * recover async channel copy related structures and free pktmbufs
-		 * for error pkts.
-		 */
-		async->desc_idx_split -= pkt_err;
-		while (pkt_err-- > 0) {
-			rte_pktmbuf_free(pkts_info[slot_idx & (vq->size - 1)].mbuf);
-			slot_idx--;
-		}
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		if (unlikely(buf_lens[i] < (lens[i] - buf_offset)))
+			goto err;
 	}
 
-	async->pkts_idx += pkt_idx;
-	if (async->pkts_idx >= vq->size)
-		async->pkts_idx -= vq->size;
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+		pkts[i]->pkt_len = lens[i] - buf_offset;
+		pkts[i]->data_len = pkts[i]->pkt_len;
+		ids[i] = descs[avail_idx + i].id;
+	}
 
-out:
-	/* DMA device may serve other queues, unconditionally check completed. */
-	nr_done_pkts = async_poll_dequeue_completed(dev, vq, pkts, pkts_size,
-							dma_id, vchan_id, legacy_ol_flags);
+	return 0;
 
-	return nr_done_pkts;
+err:
+	return -1;
 }
 
-__rte_noinline
-static uint16_t
-virtio_dev_tx_async_split_legacy(struct virtio_net *dev,
-		struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
-		struct rte_mbuf **pkts, uint16_t count,
-		int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_shared_capability(&vq->access_lock)
+static __rte_always_inline int
+virtio_dev_tx_batch_packed(struct virtio_net *dev,
+			   struct vhost_virtqueue *vq,
+			   struct rte_mbuf **pkts,
+			   bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	return virtio_dev_tx_async_split(dev, vq, mbuf_pool,
-				pkts, count, dma_id, vchan_id, true);
-}
+	uint16_t avail_idx = vq->last_avail_idx;
+	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
+	uint16_t ids[PACKED_BATCH_SIZE];
+	uint16_t i;
 
-__rte_noinline
-static uint16_t
-virtio_dev_tx_async_split_compliant(struct virtio_net *dev,
-		struct vhost_virtqueue *vq, struct rte_mempool *mbuf_pool,
-		struct rte_mbuf **pkts, uint16_t count,
-		int16_t dma_id, uint16_t vchan_id)
-	__rte_requires_shared_capability(&vq->access_lock)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	return virtio_dev_tx_async_split(dev, vq, mbuf_pool,
-				pkts, count, dma_id, vchan_id, false);
-}
+	if (vhost_reserve_avail_batch_packed(dev, vq, pkts, avail_idx,
+					     desc_addrs, ids))
+		return -1;
 
-static __rte_always_inline void
-vhost_async_shadow_dequeue_single_packed(struct vhost_virtqueue *vq,
-				uint16_t buf_id, uint16_t count)
-	__rte_requires_shared_capability(&vq->access_lock)
-{
-	struct vhost_async *async = vq->async;
-	uint16_t idx = async->buffer_idx_packed;
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
+		rte_prefetch0((void *)(uintptr_t)desc_addrs[i]);
+
+	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
+		rte_memcpy(rte_pktmbuf_mtod_offset(pkts[i], void *, 0),
+			   (void *)(uintptr_t)(desc_addrs[i] + buf_offset),
+			   pkts[i]->pkt_len);
+
+	if (virtio_net_with_host_offload(dev)) {
+		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+			struct virtio_net_hdr hdr;
+
+			memcpy(&hdr, (void *)desc_addrs[i], sizeof(struct virtio_net_hdr));
+			rte_compiler_barrier();
+
+			vhost_dequeue_offload(dev, &hdr, pkts[i], legacy_ol_flags);
+		}
+	}
 
-	async->buffers_packed[idx].id = buf_id;
-	async->buffers_packed[idx].len = 0;
-	async->buffers_packed[idx].count = count;
+	if (virtio_net_is_inorder(dev))
+		vhost_shadow_dequeue_batch_packed_inorder(vq,
+			ids[PACKED_BATCH_SIZE - 1]);
+	else
+		vhost_shadow_dequeue_batch_packed(dev, vq, ids);
 
-	async->buffer_idx_packed++;
-	if (async->buffer_idx_packed >= vq->size)
-		async->buffer_idx_packed -= vq->size;
+	vq_inc_last_avail_packed(vq, PACKED_BATCH_SIZE);
 
+	return 0;
 }
 
 static __rte_always_inline int
-virtio_dev_tx_async_single_packed(struct virtio_net *dev,
-			struct vhost_virtqueue *vq,
-			struct rte_mempool *mbuf_pool,
-			struct rte_mbuf *pkts,
-			uint16_t slot_idx,
-			bool legacy_ol_flags)
+vhost_dequeue_single_packed(struct virtio_net *dev,
+			    struct vhost_virtqueue *vq,
+			    struct rte_mempool *mbuf_pool,
+			    struct rte_mbuf *pkts,
+			    uint16_t *buf_id,
+			    uint16_t *desc_count,
+			    bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	int err;
-	uint16_t buf_id, desc_count = 0;
-	uint16_t nr_vec = 0;
-	uint32_t buf_len;
 	struct buf_vector buf_vec[BUF_VECTOR_MAX];
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
+	uint32_t buf_len;
+	uint16_t nr_vec = 0;
+	int err;
 	static bool allocerr_warned;
 
-	if (unlikely(fill_vec_buf_packed(dev, vq, vq->last_avail_idx, &desc_count,
-					 buf_vec, &nr_vec, &buf_id, &buf_len,
+	if (unlikely(fill_vec_buf_packed(dev, vq,
+					 vq->last_avail_idx, desc_count,
+					 buf_vec, &nr_vec,
+					 buf_id, &buf_len,
 					 VHOST_ACCESS_RO) < 0))
 		return -1;
 
-	if (unlikely(buf_len <= dev->vhost_hlen)) {
-		if (!allocerr_warned) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "Invalid buffer length.");
-			allocerr_warned = true;
-		}
+	if (unlikely(buf_len <= dev->vhost_hlen))
 		return -1;
-	}
 
 	buf_len -= dev->vhost_hlen;
 
 	if (unlikely(virtio_dev_pktmbuf_prep(dev, pkts, buf_len))) {
 		if (!allocerr_warned) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "Failed mbuf alloc of size %d from %s.",
+			VHOST_DATA_LOG(dev->ifname, ERR, "failed mbuf alloc of size %d from %s.",
 				buf_len, mbuf_pool->name);
-
 			allocerr_warned = true;
 		}
 		return -1;
 	}
 
-	err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkts, mbuf_pool,
-		legacy_ol_flags, slot_idx, true);
+	err = desc_to_mbuf(dev, vq, buf_vec, nr_vec, pkts, mbuf_pool, legacy_ol_flags);
 	if (unlikely(err)) {
-		rte_pktmbuf_free(pkts);
 		if (!allocerr_warned) {
-			VHOST_DATA_LOG(dev->ifname, ERR, "Failed to copy desc to mbuf on.");
+			VHOST_DATA_LOG(dev->ifname, ERR, "failed to copy desc to mbuf.");
 			allocerr_warned = true;
 		}
 		return -1;
 	}
 
-	pkts_info[slot_idx].descs = desc_count;
-
-	/* update async shadow packed ring */
-	vhost_async_shadow_dequeue_single_packed(vq, buf_id, desc_count);
-
-	vq_inc_last_avail_packed(vq, desc_count);
-
-	return err;
+	return 0;
 }
 
 static __rte_always_inline int
-virtio_dev_tx_async_packed_batch(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts, uint16_t slot_idx,
-			   uint16_t dma_id, uint16_t vchan_id)
+virtio_dev_tx_single_packed(struct virtio_net *dev,
+			    struct vhost_virtqueue *vq,
+			    struct rte_mempool *mbuf_pool,
+			    struct rte_mbuf *pkts,
+			    bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	uint16_t avail_idx = vq->last_avail_idx;
-	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	struct virtio_net_hdr *hdr;
-	uint32_t mbuf_offset = 0;
-	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
-	uint64_t desc_vva;
-	uint64_t lens[PACKED_BATCH_SIZE];
-	void *host_iova[PACKED_BATCH_SIZE];
-	uint64_t mapped_len[PACKED_BATCH_SIZE];
-	uint16_t ids[PACKED_BATCH_SIZE];
-	uint16_t i;
 
-	if (vhost_async_tx_batch_packed_check(dev, vq, pkts, avail_idx,
-					     desc_addrs, lens, ids, dma_id, vchan_id))
-		return -1;
+	uint16_t buf_id, desc_count = 0;
+	int ret;
 
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-		rte_prefetch0((void *)(uintptr_t)desc_addrs[i]);
+	ret = vhost_dequeue_single_packed(dev, vq, mbuf_pool, pkts, &buf_id,
+					&desc_count, legacy_ol_flags);
 
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		host_iova[i] = (void *)(uintptr_t)gpa_to_first_hpa(dev,
-			desc_addrs[i] + buf_offset, pkts[i]->pkt_len, &mapped_len[i]);
-	}
+	if (likely(desc_count > 0)) {
+		if (virtio_net_is_inorder(dev))
+			vhost_shadow_dequeue_single_packed_inorder(vq, buf_id,
+								   desc_count);
+		else
+			vhost_shadow_dequeue_single_packed(vq, buf_id,
+					desc_count);
 
-	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-		async_iter_initialize(dev, async);
-		async_iter_add_iovec(dev, async,
-		host_iova[i],
-		(void *)(uintptr_t)rte_pktmbuf_iova_offset(pkts[i], mbuf_offset),
-		mapped_len[i]);
-		async->iter_idx++;
+		vq_inc_last_avail_packed(vq, desc_count);
 	}
 
-	if (virtio_net_with_host_offload(dev)) {
-		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-			desc_vva = vhost_iova_to_vva(dev, vq, desc_addrs[i],
-						&lens[i], VHOST_ACCESS_RO);
-			hdr = (struct virtio_net_hdr *)(uintptr_t)desc_vva;
-			pkts_info[slot_idx + i].nethdr = *hdr;
-		}
-	}
+	return ret;
+}
 
-	vq_inc_last_avail_packed(vq, PACKED_BATCH_SIZE);
+static __rte_always_inline uint16_t
+get_nb_avail_entries_packed(const struct vhost_virtqueue *__rte_restrict vq,
+			    uint16_t max_nb_avail_entries)
+{
+	const struct vring_packed_desc *descs = vq->desc_packed;
+	bool avail_wrap = vq->avail_wrap_counter;
+	uint16_t avail_idx = vq->last_avail_idx;
+	uint16_t nb_avail_entries = 0;
+	uint16_t flags;
 
-	vhost_async_shadow_dequeue_packed_batch(vq, ids);
+	while (nb_avail_entries < max_nb_avail_entries) {
+		flags = descs[avail_idx].flags;
 
-	return 0;
+		if ((avail_wrap != !!(flags & VRING_DESC_F_AVAIL)) ||
+		    (avail_wrap == !!(flags & VRING_DESC_F_USED)))
+			return nb_avail_entries;
+
+		if (!(flags & VRING_DESC_F_NEXT))
+			++nb_avail_entries;
+
+		if (unlikely(++avail_idx >= vq->size)) {
+			avail_idx -= vq->size;
+			avail_wrap = !avail_wrap;
+		}
+	}
+
+	return nb_avail_entries;
 }
 
-static __rte_always_inline uint16_t
-virtio_dev_tx_async_packed(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts,
-		uint16_t count, uint16_t dma_id, uint16_t vchan_id, bool legacy_ol_flags)
+__rte_always_inline
+static uint16_t
+virtio_dev_tx_packed(struct virtio_net *dev,
+		     struct vhost_virtqueue *__rte_restrict vq,
+		     struct rte_mempool *mbuf_pool,
+		     struct rte_mbuf **__rte_restrict pkts,
+		     uint32_t count,
+		     bool legacy_ol_flags)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	uint32_t pkt_idx = 0;
-	uint16_t slot_idx = 0;
-	uint16_t nr_done_pkts = 0;
-	uint16_t pkt_err = 0;
-	uint32_t n_xfer;
-	uint16_t i;
-	struct vhost_async *async = vq->async;
-	struct async_inflight_info *pkts_info = async->pkts_info;
-	struct rte_mbuf *pkts_prealloc[MAX_PKT_BURST];
 
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "(%d) about to dequeue %u buffers", dev->vid, count);
-
-	async_iter_reset(async);
+	count = get_nb_avail_entries_packed(vq, count);
+	if (count == 0)
+		return 0;
 
-	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts_prealloc, count)) {
+	if (rte_pktmbuf_alloc_bulk(mbuf_pool, pkts, count)) {
 		vq->stats.mbuf_alloc_failed += count;
-		goto out;
+		return 0;
 	}
 
 	do {
-		struct rte_mbuf *pkt = pkts_prealloc[pkt_idx];
-
 		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
 
-		slot_idx = (async->pkts_idx + pkt_idx) % vq->size;
 		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_tx_async_packed_batch(dev, vq, &pkts_prealloc[pkt_idx],
-						slot_idx, dma_id, vchan_id)) {
-				for (i = 0; i < PACKED_BATCH_SIZE; i++) {
-					slot_idx = (async->pkts_idx + pkt_idx) % vq->size;
-					pkts_info[slot_idx].descs = 1;
-					pkts_info[slot_idx].nr_buffers = 1;
-					pkts_info[slot_idx].mbuf = pkts_prealloc[pkt_idx];
-					pkt_idx++;
-				}
+			if (!virtio_dev_tx_batch_packed(dev, vq,
+							&pkts[pkt_idx],
+							legacy_ol_flags)) {
+				pkt_idx += PACKED_BATCH_SIZE;
 				continue;
 			}
 		}
 
-		if (unlikely(virtio_dev_tx_async_single_packed(dev, vq, mbuf_pool, pkt,
-				slot_idx, legacy_ol_flags))) {
-			rte_pktmbuf_free_bulk(&pkts_prealloc[pkt_idx], count - pkt_idx);
-
-			if (slot_idx == 0)
-				slot_idx = vq->size - 1;
-			else
-				slot_idx--;
-
+		if (virtio_dev_tx_single_packed(dev, vq, mbuf_pool,
+						pkts[pkt_idx],
+						legacy_ol_flags))
 			break;
-		}
-
-		pkts_info[slot_idx].mbuf = pkt;
 		pkt_idx++;
 	} while (pkt_idx < count);
 
-	n_xfer = vhost_async_dma_transfer(dev, vq, dma_id, vchan_id, async->pkts_idx,
-					async->iov_iter, pkt_idx);
-
-	async->pkts_inflight_n += n_xfer;
-
-	pkt_err = pkt_idx - n_xfer;
-
-	if (unlikely(pkt_err)) {
-		uint16_t descs_err = 0;
-
-		pkt_idx -= pkt_err;
-
-		/**
-		 * recover DMA-copy related structures and free pktmbuf for DMA-error pkts.
-		 */
-		if (async->buffer_idx_packed >= pkt_err)
-			async->buffer_idx_packed -= pkt_err;
-		else
-			async->buffer_idx_packed += vq->size - pkt_err;
-
-		while (pkt_err-- > 0) {
-			rte_pktmbuf_free(pkts_info[slot_idx].mbuf);
-			descs_err += pkts_info[slot_idx].descs;
+	if (pkt_idx != count)
+		rte_pktmbuf_free_bulk(&pkts[pkt_idx], count - pkt_idx);
 
-			if (slot_idx == 0)
-				slot_idx = vq->size - 1;
-			else
-				slot_idx--;
-		}
+	if (vq->shadow_used_idx) {
+		do_data_copy_dequeue(vq);
 
-		/* recover available ring */
-		if (vq->last_avail_idx >= descs_err) {
-			vq->last_avail_idx -= descs_err;
-		} else {
-			vq->last_avail_idx += vq->size - descs_err;
-			vq->avail_wrap_counter ^= 1;
-		}
-		vhost_virtqueue_reconnect_log_packed(vq);
+		vhost_flush_dequeue_shadow_packed(dev, vq);
+		vhost_vring_call_packed(dev, vq);
 	}
 
-	async->pkts_idx += pkt_idx;
-	if (async->pkts_idx >= vq->size)
-		async->pkts_idx -= vq->size;
-
-out:
-	nr_done_pkts = async_poll_dequeue_completed(dev, vq, pkts, count,
-					dma_id, vchan_id, legacy_ol_flags);
-
-	return nr_done_pkts;
+	return pkt_idx;
 }
 
 __rte_noinline
 static uint16_t
-virtio_dev_tx_async_packed_legacy(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts,
-		uint16_t count, uint16_t dma_id, uint16_t vchan_id)
+virtio_dev_tx_packed_legacy(struct virtio_net *dev,
+	struct vhost_virtqueue *__rte_restrict vq, struct rte_mempool *mbuf_pool,
+	struct rte_mbuf **__rte_restrict pkts, uint32_t count)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	return virtio_dev_tx_async_packed(dev, vq, mbuf_pool,
-				pkts, count, dma_id, vchan_id, true);
+	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, true);
 }
 
 __rte_noinline
 static uint16_t
-virtio_dev_tx_async_packed_compliant(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts,
-		uint16_t count, uint16_t dma_id, uint16_t vchan_id)
+virtio_dev_tx_packed_compliant(struct virtio_net *dev,
+	struct vhost_virtqueue *__rte_restrict vq, struct rte_mempool *mbuf_pool,
+	struct rte_mbuf **__rte_restrict pkts, uint32_t count)
 	__rte_requires_shared_capability(&vq->access_lock)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	return virtio_dev_tx_async_packed(dev, vq, mbuf_pool,
-				pkts, count, dma_id, vchan_id, false);
+	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, false);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_try_dequeue_burst, 22.07)
+RTE_EXPORT_SYMBOL(rte_vhost_dequeue_burst)
 uint16_t
-rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
-	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-	int *nr_inflight, int16_t dma_id, uint16_t vchan_id)
+rte_vhost_dequeue_burst(int vid, uint16_t queue_id,
+	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count)
 {
 	struct virtio_net *dev;
 	struct vhost_virtqueue *vq;
@@ -4218,10 +2285,8 @@ rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
 	uint16_t nb_rx = 0;
 
 	dev = get_device(vid);
-	if (!dev || !nr_inflight)
-		goto out_no_unlock;
-
-	*nr_inflight = -1;
+	if (!dev)
+		return 0;
 
 	if (unlikely(!(dev->flags & VIRTIO_DEV_BUILTIN_VIRTIO_NET))) {
 		VHOST_DATA_LOG(dev->ifname, ERR, "%s: built-in vhost net backend is disabled.",
@@ -4235,36 +2300,17 @@ rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
 		goto out_no_unlock;
 	}
 
-	if (unlikely(dma_id < 0 || dma_id >= RTE_DMADEV_DEFAULT_MAX)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid dma id %d.",
-			__func__, dma_id);
-		goto out_no_unlock;
-	}
-
-	if (unlikely(!dma_copy_track[dma_id].vchans ||
-				!dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: invalid channel %d:%u.",
-			__func__, dma_id, vchan_id);
-		goto out_no_unlock;
-	}
-
 	vq = dev->virtqueue[queue_id];
 
 	if (unlikely(rte_rwlock_read_trylock(&vq->access_lock) != 0))
 		goto out_no_unlock;
 
-	if (unlikely(vq->enabled == 0))
-		goto out_access_unlock;
-
-	if (unlikely(!vq->async)) {
-		VHOST_DATA_LOG(dev->ifname, ERR, "%s: async not registered for queue id %d.",
-			__func__, queue_id);
+	if (unlikely(!vq->enabled))
 		goto out_access_unlock;
-	}
 
 	vhost_user_iotlb_rd_lock(vq);
 
-	if (unlikely(vq->access_ok == 0)) {
+	if (unlikely(!vq->access_ok)) {
 		vhost_user_iotlb_rd_unlock(vq);
 		rte_rwlock_read_unlock(&vq->access_lock);
 
@@ -4305,21 +2351,20 @@ rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
 
 	if (vq_is_packed(dev)) {
 		if (dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS)
-			nb_rx += virtio_dev_tx_async_packed_legacy(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx, dma_id, vchan_id);
+			nb_rx += virtio_dev_tx_packed_legacy(dev, vq, mbuf_pool,
+					pkts + nb_rx, count - nb_rx);
 		else
-			nb_rx += virtio_dev_tx_async_packed_compliant(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx, dma_id, vchan_id);
+			nb_rx += virtio_dev_tx_packed_compliant(dev, vq, mbuf_pool,
+					pkts + nb_rx, count - nb_rx);
 	} else {
 		if (dev->flags & VIRTIO_DEV_LEGACY_OL_FLAGS)
-			nb_rx += virtio_dev_tx_async_split_legacy(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx, dma_id, vchan_id);
+			nb_rx += virtio_dev_tx_split_legacy(dev, vq, mbuf_pool,
+					pkts + nb_rx, count - nb_rx);
 		else
-			nb_rx += virtio_dev_tx_async_split_compliant(dev, vq, mbuf_pool,
-					pkts + nb_rx, count - nb_rx, dma_id, vchan_id);
+			nb_rx += virtio_dev_tx_split_compliant(dev, vq, mbuf_pool,
+					pkts + nb_rx, count - nb_rx);
 	}
 
-	*nr_inflight = vq->async->pkts_inflight_n;
 	vhost_queue_stats_update(dev, vq, pkts, nb_rx);
 
 out:
-- 
2.54.0

