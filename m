Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81679C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 06:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F26402B5;
	Wed,  2 Apr 2025 08:54:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E12FD4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 08:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743576846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHpy1QnQImOOAJLYuRWm5Jh2Ksdo0ugFd1Erk99PneM=;
 b=QoetctOwiX07+E8MLenvEqTs2sKQuZkmJBJgqMteWBAwdoWIg9lWeWDkGEvIFisTj+Pcoq
 Tl6CzdgMi6Sw8PqwHxt5cESU5rh+gVKBqYSTBD9syVw6fyR102Bd+HwDKEnaTG5U4mCpIJ
 HTINr70kq7CvJ8EZG+hMzQiSKhZKBu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-1sTRu2iyPzSikaGmcxi0ww-1; Wed,
 02 Apr 2025 02:54:05 -0400
X-MC-Unique: 1sTRu2iyPzSikaGmcxi0ww-1
X-Mimecast-MFC-AGG-ID: 1sTRu2iyPzSikaGmcxi0ww_1743576844
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79DF1180899B; Wed,  2 Apr 2025 06:54:04 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51815180A803; Wed,  2 Apr 2025 06:54:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] vhost: fix wrapping on control virtqueue rings
Date: Wed,  2 Apr 2025 08:53:58 +0200
Message-ID: <20250402065358.3612788-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H9j8ny2J_ccgPU_nz2_3cX5zQSirtJ8J6-V-B_ltJwQ_1743576844
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

The idx field of a virtqueue available ring is increased by the driver
regardless of the ring size. It is for the device to mask this index
modulo the ring size (2.7.6 of the virtio 1.3 specification).
The same applies to the used ring.

Failing to mask triggers:
- crashes when popping message received on the cvq,
- system lockups (in the case of VDUSE) when the virtio-net driver waits
  infinitely,

Fixes: 474f4d7840ad ("vhost: add control virtqueue")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/virtio_net_ctrl.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
index 999e84db7c..63c0a06b4f 100644
--- a/lib/vhost/virtio_net_ctrl.c
+++ b/lib/vhost/virtio_net_ctrl.c
@@ -40,7 +40,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 		return 0;
 	}
 
-	desc_idx = cvq->avail->ring[cvq->last_avail_idx];
+	desc_idx = cvq->avail->ring[cvq->last_avail_idx & (cvq->size - 1)];
 	if (desc_idx >= cvq->size) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "Out of range desc index, dropping");
 		goto err;
@@ -167,8 +167,6 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 	}
 
 	cvq->last_avail_idx++;
-	if (cvq->last_avail_idx >= cvq->size)
-		cvq->last_avail_idx -= cvq->size;
 	vhost_virtqueue_reconnect_log_split(cvq);
 
 	if (dev->features & (1ULL << VIRTIO_RING_F_EVENT_IDX))
@@ -180,8 +178,6 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 	free(ctrl_elem->ctrl_req);
 err:
 	cvq->last_avail_idx++;
-	if (cvq->last_avail_idx >= cvq->size)
-		cvq->last_avail_idx -= cvq->size;
 	vhost_virtqueue_reconnect_log_split(cvq);
 
 	if (dev->features & (1ULL << VIRTIO_RING_F_EVENT_IDX))
@@ -231,13 +227,11 @@ virtio_net_ctrl_push(struct virtio_net *dev, struct virtio_net_ctrl_elem *ctrl_e
 	struct vhost_virtqueue *cvq = dev->cvq;
 	struct vring_used_elem *used_elem;
 
-	used_elem = &cvq->used->ring[cvq->last_used_idx];
+	used_elem = &cvq->used->ring[cvq->last_used_idx & (cvq->size - 1)];
 	used_elem->id = ctrl_elem->head_idx;
 	used_elem->len = ctrl_elem->n_descs;
 
 	cvq->last_used_idx++;
-	if (cvq->last_used_idx >= cvq->size)
-		cvq->last_used_idx -= cvq->size;
 
 	rte_atomic_store_explicit((unsigned short __rte_atomic *)&cvq->used->idx,
 		cvq->last_used_idx, rte_memory_order_release);
-- 
2.48.1

