Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FAD37E4E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E7F40685;
	Wed, 14 Jan 2026 16:34:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 185B9400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768404896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOgdLU/remfsEJtcsbwGR99nynrW/56km526nNcdCgY=;
 b=YLwAzN1v6HvhD4IMA3vDToXrJX7bBNL7+WfddTrz4N8rojoU0CsViferGqJLh2xPPROpQf
 KKTDOn5s+cd7HxvwxxiZqengXGpTSA1WvVnk9v6PVuJU89le4bZ43QIUFfX037emM2hI1u
 nbV/jL2aEU7e0gWe7Hs2SLkVavCuNbc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-1FdEryLpMAWp4axjDUxwiA-1; Wed,
 14 Jan 2026 10:34:55 -0500
X-MC-Unique: 1FdEryLpMAWp4axjDUxwiA-1
X-Mimecast-MFC-AGG-ID: 1FdEryLpMAWp4axjDUxwiA_1768404894
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DE4D1800357; Wed, 14 Jan 2026 15:34:54 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E33FC1800240; Wed, 14 Jan 2026 15:34:51 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	chenbox@nvidia.com,
	david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2 1/3] vhost: fix virtqueue array size for control queue
Date: Wed, 14 Jan 2026 16:34:43 +0100
Message-ID: <20260114153445.2751895-2-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iH8tY7QbS6M07GVEZEQsnVrCODP0osNSJnb0C54hWlM_1768404894
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

When max_queue_pairs is set to VHOST_MAX_QUEUE_PAIRS (128), VDUSE
calculates total_queues as max_queue_pairs * 2 + 1 = 257 to account
for the control queue. However, the virtqueue array was sized as
VHOST_MAX_QUEUE_PAIRS * 2, causing an out-of-bounds array access.

Fix by defining VHOST_MAX_VRING to explicitly account for the control
queue (VHOST_MAX_QUEUE_PAIRS * 2 + 1) and using it for the virtqueue
array size.

Fixes: f0a37cc6a1e2 ("vhost: add multiqueue support to VDUSE")
Cc: stable@dpdk.org

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index e9e71c1707..ee61f7415e 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -261,8 +261,9 @@ struct vhost_async {
 };
 
 #define VHOST_RECONNECT_VERSION		0x0
-#define VHOST_MAX_VRING			0x100
 #define VHOST_MAX_QUEUE_PAIRS		0x80
+/* Max vring count: 2 per queue pair plus 1 control queue */
+#define VHOST_MAX_VRING			(VHOST_MAX_QUEUE_PAIRS * 2 + 1)
 
 struct __rte_cache_aligned vhost_reconnect_vring {
 	uint16_t last_avail_idx;
@@ -501,7 +502,7 @@ struct __rte_cache_aligned virtio_net {
 
 	int			extbuf;
 	int			linearbuf;
-	struct vhost_virtqueue	*virtqueue[VHOST_MAX_QUEUE_PAIRS * 2];
+	struct vhost_virtqueue	*virtqueue[VHOST_MAX_VRING];
 
 	rte_rwlock_t	iotlb_pending_lock;
 	struct vhost_iotlb_entry *iotlb_pool;
-- 
2.52.0

