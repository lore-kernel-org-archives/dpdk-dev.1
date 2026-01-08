Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42AD185F9
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 13:50:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 506584066F;
	Thu,  8 Jan 2026 14:50:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 753654066C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 14:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767880208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpCFraQgR4GZImaWQ8T9Rv3UPFT6hU0+Fk46Hx70JiI=;
 b=TpwNALK9HCmAADvvyIcJgMvx9L4ZwTUwtb9pg5RVXrBtthv/FLKBwKabWitMVAX1o9jAUx
 ZSVbjz+H4cVlUexYNQtI/wzg1l+Z35gguAGapvhZWbRYu6Uns7m+1Er6RMGpKFtzDTb9ss
 Izrhc63Ul4tfJB6s164dehgQ/Vi6zeY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-BW22akf4PyqbBsSKkDWKdg-1; Thu,
 08 Jan 2026 08:50:04 -0500
X-MC-Unique: BW22akf4PyqbBsSKkDWKdg-1
X-Mimecast-MFC-AGG-ID: BW22akf4PyqbBsSKkDWKdg_1767880203
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 424B01954B0B; Thu,  8 Jan 2026 13:50:03 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECB0118001D5; Thu,  8 Jan 2026 13:50:00 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	chenbox@nvidia.com,
	david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH 1/3] vhost: fix virtqueue array size for control queue
Date: Thu,  8 Jan 2026 14:49:49 +0100
Message-ID: <20260108134951.3857110-2-maxime.coquelin@redhat.com>
In-Reply-To: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
References: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hVIwtRyUxMtVz3nrF6iwwEVFw04YA5mvuFb7ljBJFWE_1767880203
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

