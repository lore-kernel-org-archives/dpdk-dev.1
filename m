Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DAC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:30:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE6F40E13;
	Fri, 17 Jul 2026 11:30:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E6FB40684
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rh0zWV9Fa/SPQgxMpwAyH+Tnqg1O/4h7gA3oaPCX4I=;
 b=c8VI1IVd3p7w/7LxzKntGCtYIXLqW7JOQXhqgw3TUNf6mzBXD4Fm0uRSjZpOSd8jB/j4GJ
 LyfdOws7uOADmnw1vpFR2oxmhWxwjtzr5Zub2UYPvxBi1iDQR8v4TyeVx0x1CtSmxTm4aF
 /sZ+L7DIFq9B5jgNIdzxZMlhFaY9wXE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-4Bw9Rue-MqG_NuEgDd30iQ-1; Fri,
 17 Jul 2026 05:30:21 -0400
X-MC-Unique: 4Bw9Rue-MqG_NuEgDd30iQ-1
X-Mimecast-MFC-AGG-ID: 4Bw9Rue-MqG_NuEgDd30iQ_1784280620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 709AE1800756; Fri, 17 Jul 2026 09:30:20 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F15D3004180; Fri, 17 Jul 2026 09:30:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 02/10] bbdev: add per-queue statistics API
Date: Fri, 17 Jul 2026 11:29:57 +0200
Message-ID: <20260717093006.229370-3-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Be7Wzm7Jh9Pd4sl6EEU34moa9RCYrHFUVDvEPeFRKPA_1784280620
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

Add rte_bbdev_queue_stats_get() to retrieve statistics for a specific
queue. This allows applications to get per-queue stats without
accessing internal data structures.

Update test-bbdev to use the new API.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test-bbdev/test_bbdev_perf.c       | 38 +++++---------------------
 doc/guides/rel_notes/release_26_07.rst |  5 ++++
 lib/bbdev/rte_bbdev.c                  | 20 ++++++++++++++
 lib/bbdev/rte_bbdev.h                  | 20 ++++++++++++++
 4 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index 9fb0a25948..b75d8387bd 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -5849,30 +5849,6 @@ validation_test(struct active_device *ad, struct test_op_params *op_params)
 	return validation_latency_test(ad, op_params, false);
 }
 
-static int
-get_bbdev_queue_stats(uint16_t dev_id, uint16_t queue_id,
-		struct rte_bbdev_stats *stats)
-{
-	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
-	struct rte_bbdev_stats *q_stats;
-
-	if (queue_id >= dev->data->num_queues)
-		return -1;
-
-	q_stats = &dev->data->queues[queue_id].queue_stats;
-
-	stats->enqueued_count = q_stats->enqueued_count;
-	stats->dequeued_count = q_stats->dequeued_count;
-	stats->enqueue_err_count = q_stats->enqueue_err_count;
-	stats->dequeue_err_count = q_stats->dequeue_err_count;
-	stats->enqueue_warn_count = q_stats->enqueue_warn_count;
-	stats->dequeue_warn_count = q_stats->dequeue_warn_count;
-	stats->acc_offload_cycles = q_stats->acc_offload_cycles;
-	stats->enqueue_depth_avail = q_stats->enqueue_depth_avail;
-
-	return 0;
-}
-
 static int
 offload_latency_test_fft(struct rte_mempool *mempool, struct test_buffers *bufs,
 		struct rte_bbdev_fft_op *ref_op, uint16_t dev_id,
@@ -5906,7 +5882,7 @@ offload_latency_test_fft(struct rte_mempool *mempool, struct test_buffers *bufs,
 					&ops_enq[enq], burst_sz - enq);
 		} while (unlikely(burst_sz != enq));
 
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -5988,7 +5964,7 @@ offload_latency_test_mldts(struct rte_mempool *mempool, struct test_buffers *buf
 					&ops_enq[enq], burst_sz - enq);
 		} while (unlikely(burst_sz != enq));
 
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -6069,7 +6045,7 @@ offload_latency_test_dec(struct rte_mempool *mempool, struct test_buffers *bufs,
 					&ops_enq[enq], burst_sz - enq);
 		} while (unlikely(burst_sz != enq));
 
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -6163,7 +6139,7 @@ offload_latency_test_ldpc_dec(struct rte_mempool *mempool,
 		} while (unlikely(burst_sz != enq));
 
 		enq_sw_last_time = rte_rdtsc_precise() - enq_start_time;
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -6251,7 +6227,7 @@ offload_latency_test_enc(struct rte_mempool *mempool, struct test_buffers *bufs,
 
 		enq_sw_last_time = rte_rdtsc_precise() - enq_start_time;
 
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -6332,7 +6308,7 @@ offload_latency_test_ldpc_enc(struct rte_mempool *mempool,
 		} while (unlikely(burst_sz != enq));
 
 		enq_sw_last_time = rte_rdtsc_precise() - enq_start_time;
-		ret = get_bbdev_queue_stats(dev_id, queue_id, &stats);
+		ret = rte_bbdev_queue_stats_get(dev_id, queue_id, &stats);
 		TEST_ASSERT_SUCCESS(ret,
 				"Failed to get stats for queue (%u) of device (%u)",
 				queue_id, dev_id);
@@ -6482,7 +6458,7 @@ offload_cost_test(struct active_device *ad,
 			rte_get_tsc_hz());
 
 	struct rte_bbdev_stats stats = {0};
-	ret = get_bbdev_queue_stats(ad->dev_id, queue_id, &stats);
+	ret = rte_bbdev_queue_stats_get(ad->dev_id, queue_id, &stats);
 	TEST_ASSERT_SUCCESS(ret,
 			"Failed to get stats for queue (%u) of device (%u)",
 			queue_id, ad->dev_id);
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..dbad975d8c 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -190,6 +190,11 @@ New Features
   * Added ``eof`` devarg to use link state to signal end of receive file input.
   * Added unit test suite.
 
+* **Added per-queue statistics API in bbdev.**
+
+  Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
+  for a specific queue, complementing the existing device-level statistics API.
+
 * **Updated Marvell cnxk crypto driver.**
 
   * Added support for ML-KEM and ML-DSA on CN20K platform.
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index 90095578cb..3f032a8e32 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -819,6 +819,26 @@ rte_bbdev_stats_reset(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_queue_stats_get, 26.07)
+int rte_bbdev_queue_stats_get(uint16_t dev_id, uint16_t queue_id, struct rte_bbdev_stats *stats)
+{
+	struct rte_bbdev *dev = get_dev(dev_id);
+
+	VALID_DEV_OR_RET_ERR(dev, dev_id);
+	VALID_QUEUE_OR_RET_ERR(queue_id, dev);
+
+	if (stats == NULL) {
+		rte_bbdev_log(ERR, "NULL stats structure");
+		return -EINVAL;
+	}
+
+	*stats = dev->data->queues[queue_id].queue_stats;
+
+	rte_bbdev_log_debug("Retrieved stats for queue %u of device %u",
+			    queue_id, dev_id);
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_bbdev_info_get)
 int
 rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
index 36dabf8fa6..9fcfbf4c69 100644
--- a/lib/bbdev/rte_bbdev.h
+++ b/lib/bbdev/rte_bbdev.h
@@ -316,6 +316,26 @@ rte_bbdev_stats_get(uint16_t dev_id, struct rte_bbdev_stats *stats);
 int
 rte_bbdev_stats_reset(uint16_t dev_id);
 
+/**
+ * Retrieve the statistics of a specific queue.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param queue_id
+ *   The index of the queue.
+ * @param stats
+ *   Pointer to structure to where statistics will be copied. On error, this
+ *   location may or may not have been modified.
+ *
+ * @return
+ *   - 0 on success
+ *   - -ENODEV if dev_id is invalid
+ *   - -EINVAL if stats is NULL
+ *   - -ERANGE if queue_id is out of range
+ */
+__rte_experimental
+int rte_bbdev_queue_stats_get(uint16_t dev_id, uint16_t queue_id, struct rte_bbdev_stats *stats);
+
 /** Device information supplied by the device's driver */
 
 /* Structure rte_bbdev_driver_info 8< */
-- 
2.54.0

