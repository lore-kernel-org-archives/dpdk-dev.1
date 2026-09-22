Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49ADC982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8482542788;
	Tue, 22 Sep 2026 11:40:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E96940B91
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85WVWkHs7dYpMtJGTSLuT7BME/TTSuSRkZa7VxHVaUs=;
 b=SP3aHPIq5pSzRlwSXlZEZ7PHCbdz7ljVfURq+x2vwt9t7RaAIqKOtAou1n5m8mYIhbC0Xb
 +/glCw6ypt+C8s0qyEOeK6k1oLlphF5Gj1wBVU3DMfuhaqKWWWVbfklL+XetEodfzm8RAc
 oE3hCxWaPKYEDOPYu3j9RdT2LnRB8mA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-tP4m9z_0OsuGEBwotwLJEA-1; Tue,
 22 Sep 2026 05:40:34 -0400
X-MC-Unique: tP4m9z_0OsuGEBwotwLJEA-1
X-Mimecast-MFC-AGG-ID: tP4m9z_0OsuGEBwotwLJEA_1790070033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4EE18011E4; Tue, 22 Sep 2026 09:40:33 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59D811956041; Tue, 22 Sep 2026 09:40:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v4 1/9] bbdev: add per-queue statistics API
Date: Tue, 22 Sep 2026 11:40:17 +0200
Message-ID: <20260922094026.2636265-2-david.marchand@redhat.com>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ittFsbZ2tnMDuh_zthEoeV2WTTW_mwV9e-GiEXr8aK4_1790070033
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-bbdev/test_bbdev_perf.c       | 38 +++++---------------------
 doc/guides/rel_notes/release_26_11.rst |  5 ++++
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..4fb89ecb29 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added per-queue statistics API in bbdev.**
+
+  Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
+  for a specific queue, complementing the existing device-level statistics API.
+
 
 Removed Items
 -------------
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ea644c1f9b..ab570f2b0d 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -815,6 +815,26 @@ rte_bbdev_stats_reset(uint16_t dev_id)
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

