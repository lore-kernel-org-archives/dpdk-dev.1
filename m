Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF7C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78C1C40DD0;
	Fri, 17 Jul 2026 11:30:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DF57840684
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpDP+Xug5b1oUtRWUJ0jKK96wp2xYpoT5FpFktwcvgE=;
 b=b/Cul+cVc8LyJE5M2GgnjY7pgI04dTEBn1VHxQQf0N3LxHATuCwYfSmAKAV9FcbCGe/Dkj
 SBduLEu6nfFdzoGnTUXJt9Bm1q5IpVkQaORqmz6Uje1mvdsZTXtk84H/QQmzr0Cgk8503a
 ruxsjmytwICtNk3ubgTxpPv98eFsc/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-TUzzetulNRWjRQEU5RWSrw-1; Fri,
 17 Jul 2026 05:30:18 -0400
X-MC-Unique: TUzzetulNRWjRQEU5RWSrw-1
X-Mimecast-MFC-AGG-ID: TUzzetulNRWjRQEU5RWSrw_1784280617
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE00B1945CB2; Fri, 17 Jul 2026 09:30:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB9DC18002A0; Fri, 17 Jul 2026 09:30:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 01/10] bbdev: fix stats aggregation from queues
Date: Fri, 17 Jul 2026 11:29:56 +0200
Message-ID: <20260717093006.229370-2-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9roEh09op91d0GvQdkMyYwLmPyxXCNXZJ6457vpDNak_1784280617
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

The device stats retrieval was missing aggregation of
enqueue_status_count, acc_offload_cycles, and enqueue_depth_avail
from per-queue statistics.

Fixes: 4f08028c5e24 ("bbdev: expose queue related warning and status")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/bbdev/rte_bbdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ea644c1f9b..90095578cb 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -745,7 +745,7 @@ rte_bbdev_queue_stop(uint16_t dev_id, uint16_t queue_id)
 static void
 get_stats_from_queues(struct rte_bbdev *dev, struct rte_bbdev_stats *stats)
 {
-	unsigned int q_id;
+	unsigned int i, q_id;
 	for (q_id = 0; q_id < dev->data->num_queues; q_id++) {
 		struct rte_bbdev_stats *q_stats =
 				&dev->data->queues[q_id].queue_stats;
@@ -756,6 +756,10 @@ get_stats_from_queues(struct rte_bbdev *dev, struct rte_bbdev_stats *stats)
 		stats->dequeue_err_count += q_stats->dequeue_err_count;
 		stats->enqueue_warn_count += q_stats->enqueue_warn_count;
 		stats->dequeue_warn_count += q_stats->dequeue_warn_count;
+		for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
+			stats->enqueue_status_count[i] += q_stats->enqueue_status_count[i];
+		stats->acc_offload_cycles += q_stats->acc_offload_cycles;
+		stats->enqueue_depth_avail += q_stats->enqueue_depth_avail;
 	}
 	rte_bbdev_log_debug("Got stats on %u", dev->data->dev_id);
 }
-- 
2.54.0

