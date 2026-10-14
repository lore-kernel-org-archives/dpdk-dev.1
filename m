Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53947CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3910740A71;
	Wed, 14 Oct 2026 17:01:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4A886406FF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRUHO23M4ZS2avfLAEg0rDeOUsnFLPLIUsxpodvllIs=;
 b=P4oCVTMtAJ/2tCdzNuHsJh6FsvOVqsdKAX2f0XLJrhBzPrJo6qQPlkdZBxJBNWqW6BdjYI
 F/ISAMOffL5LwZ5ct+K2OhngKmcNgjmX/HLQVzwWizArUrnR3eKeu/e4jtzUBwQwWD/hmE
 IiILC1ifhHE/QnvVkcdOcO0+HbBQHL4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-4vlD3oR1PfCH5gW1O66lgA-1; Wed,
 14 Oct 2026 15:01:01 +0000
X-MC-Unique: 4vlD3oR1PfCH5gW1O66lgA-1
X-Mimecast-MFC-AGG-ID: 4vlD3oR1PfCH5gW1O66lgA_1791990060
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D8961800148; Wed, 14 Oct 2026 15:01:00 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CED001800495; Wed, 14 Oct 2026 15:00:58 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 Ivar Al-Safawi <hemo40047@gmail.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 05/14] vhost: fix VDUSE stale vring pointers after IOTLB
 invalidation
Date: Wed, 14 Oct 2026 17:00:40 +0200
Message-ID: <20261014150049.2540538-5-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gZcc9FbyHt96i4WvYVnTOjg8V7VwpJ08G3N3tkYsiXo_1791990060
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

When the VDUSE handler processes VDUSE_UPDATE_IOTLB, it removes the
IOTLB cache entry but fails to invalidate vring pointers that were
derived from that mapping. Since VDUSE also unmaps the memory via
munmap(), the vring pointers (vq->desc, vq->avail, vq->used) become
dangling while vq->access_ok remains true, causing use-after-free.

Add the missing vring invalidation logic to the VDUSE_UPDATE_IOTLB
handler, mirroring what the vhost-user path already does correctly
in VHOST_IOTLB_INVALIDATE handling. Move is_vring_iotlb() to vhost.c
so it can be shared by both vhost_user.c and vduse.c.

CVE-2026-86567
Bugzilla ID: 2029

Cc: stable@dpdk.org

Reported-by: Ivar Al-Safawi <hemo40047@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vduse.c      | 24 ++++++++++++-
 lib/vhost/vhost.c      | 76 ++++++++++++++++++++++++++++++++++++++++++
 lib/vhost/vhost.h      |  2 ++
 lib/vhost/vhost_user.c | 75 -----------------------------------------
 4 files changed, 101 insertions(+), 76 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index f8a4a8edcb..58c8f4090b 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -442,13 +442,35 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		dev->reconnect_log->status = dev->status;
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
-	case VDUSE_UPDATE_IOTLB:
+	case VDUSE_UPDATE_IOTLB: {
+		struct vhost_iotlb_msg imsg;
+		uint32_t i;
+
 		VHOST_CONFIG_LOG(dev->ifname, INFO, "\tIOVA range: %" PRIx64 " - %" PRIx64,
 				(uint64_t)req.iova.start, (uint64_t)req.iova.last);
 		vhost_user_iotlb_cache_remove(dev, req.iova.start,
 				req.iova.last - req.iova.start + 1);
+
+		/* Invalidate vring translations if affected by this range */
+		imsg.iova = req.iova.start;
+		imsg.size = req.iova.last - req.iova.start + 1;
+
+		for (i = 0; i < dev->nr_vring; i++) {
+			vq = dev->virtqueue[i];
+
+			if (!vq)
+				continue;
+
+			if (is_vring_iotlb(dev, vq, &imsg)) {
+				rte_rwlock_write_lock(&vq->access_lock);
+				vring_invalidate(dev, vq);
+				rte_rwlock_write_unlock(&vq->access_lock);
+			}
+		}
+
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
+	}
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index fde8acb00c..2d694d586e 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -566,6 +566,82 @@ vring_translate(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	return 0;
 }
 
+static int
+is_vring_iotlb_split(struct vhost_virtqueue *vq, struct vhost_iotlb_msg *imsg)
+{
+	struct vhost_vring_addr *ra;
+	uint64_t start, end, len;
+
+	start = imsg->iova;
+	end = start + imsg->size;
+
+	ra = &vq->ring_addrs;
+	len = sizeof(struct vring_desc) * vq->size;
+	if (ra->desc_user_addr < end && (ra->desc_user_addr + len) > start)
+		return 1;
+
+	len = sizeof(struct vring_avail) + sizeof(uint16_t) * vq->size;
+	if (ra->avail_user_addr < end && (ra->avail_user_addr + len) > start)
+		return 1;
+
+	len = sizeof(struct vring_used) +
+	       sizeof(struct vring_used_elem) * vq->size;
+	if (ra->used_user_addr < end && (ra->used_user_addr + len) > start)
+		return 1;
+
+	if (ra->flags & (1 << VHOST_VRING_F_LOG)) {
+		len = sizeof(uint64_t);
+		if (ra->log_guest_addr < end &&
+		    (ra->log_guest_addr + len) > start)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int
+is_vring_iotlb_packed(struct vhost_virtqueue *vq, struct vhost_iotlb_msg *imsg)
+{
+	struct vhost_vring_addr *ra;
+	uint64_t start, end, len;
+
+	start = imsg->iova;
+	end = start + imsg->size;
+
+	ra = &vq->ring_addrs;
+	len = sizeof(struct vring_packed_desc) * vq->size;
+	if (ra->desc_user_addr < end && (ra->desc_user_addr + len) > start)
+		return 1;
+
+	len = sizeof(struct vring_packed_desc_event);
+	if (ra->avail_user_addr < end && (ra->avail_user_addr + len) > start)
+		return 1;
+
+	len = sizeof(struct vring_packed_desc_event);
+	if (ra->used_user_addr < end && (ra->used_user_addr + len) > start)
+		return 1;
+
+	if (ra->flags & (1 << VHOST_VRING_F_LOG)) {
+		len = sizeof(uint64_t);
+		if (ra->log_guest_addr < end &&
+		    (ra->log_guest_addr + len) > start)
+			return 1;
+	}
+
+	return 0;
+}
+
+int
+is_vring_iotlb(struct virtio_net *dev,
+	       struct vhost_virtqueue *vq,
+	       struct vhost_iotlb_msg *imsg)
+{
+	if (vq_is_packed(dev))
+		return is_vring_iotlb_packed(vq, imsg);
+	else
+		return is_vring_iotlb_split(vq, imsg);
+}
+
 void
 vring_invalidate(struct virtio_net *dev __rte_unused, struct vhost_virtqueue *vq)
 {
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index bb4708aed5..6bed0b6717 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -909,6 +909,8 @@ uint64_t translate_log_addr(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	__rte_requires_shared_capability(&vq->iotlb_lock);
 void vring_invalidate(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	__rte_requires_capability(&vq->access_lock);
+int is_vring_iotlb(struct virtio_net *dev, struct vhost_virtqueue *vq,
+	struct vhost_iotlb_msg *imsg);
 
 static __rte_always_inline uint64_t
 vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 018adfe4b2..15f13ef443 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -2878,81 +2878,6 @@ vhost_user_set_req_fd(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 }
 
-static int
-is_vring_iotlb_split(struct vhost_virtqueue *vq, struct vhost_iotlb_msg *imsg)
-{
-	struct vhost_vring_addr *ra;
-	uint64_t start, end, len;
-
-	start = imsg->iova;
-	end = start + imsg->size;
-
-	ra = &vq->ring_addrs;
-	len = sizeof(struct vring_desc) * vq->size;
-	if (ra->desc_user_addr < end && (ra->desc_user_addr + len) > start)
-		return 1;
-
-	len = sizeof(struct vring_avail) + sizeof(uint16_t) * vq->size;
-	if (ra->avail_user_addr < end && (ra->avail_user_addr + len) > start)
-		return 1;
-
-	len = sizeof(struct vring_used) +
-	       sizeof(struct vring_used_elem) * vq->size;
-	if (ra->used_user_addr < end && (ra->used_user_addr + len) > start)
-		return 1;
-
-	if (ra->flags & (1 << VHOST_VRING_F_LOG)) {
-		len = sizeof(uint64_t);
-		if (ra->log_guest_addr < end &&
-		    (ra->log_guest_addr + len) > start)
-			return 1;
-	}
-
-	return 0;
-}
-
-static int
-is_vring_iotlb_packed(struct vhost_virtqueue *vq, struct vhost_iotlb_msg *imsg)
-{
-	struct vhost_vring_addr *ra;
-	uint64_t start, end, len;
-
-	start = imsg->iova;
-	end = start + imsg->size;
-
-	ra = &vq->ring_addrs;
-	len = sizeof(struct vring_packed_desc) * vq->size;
-	if (ra->desc_user_addr < end && (ra->desc_user_addr + len) > start)
-		return 1;
-
-	len = sizeof(struct vring_packed_desc_event);
-	if (ra->avail_user_addr < end && (ra->avail_user_addr + len) > start)
-		return 1;
-
-	len = sizeof(struct vring_packed_desc_event);
-	if (ra->used_user_addr < end && (ra->used_user_addr + len) > start)
-		return 1;
-
-	if (ra->flags & (1 << VHOST_VRING_F_LOG)) {
-		len = sizeof(uint64_t);
-		if (ra->log_guest_addr < end &&
-		    (ra->log_guest_addr + len) > start)
-			return 1;
-	}
-
-	return 0;
-}
-
-static int is_vring_iotlb(struct virtio_net *dev,
-			  struct vhost_virtqueue *vq,
-			  struct vhost_iotlb_msg *imsg)
-{
-	if (vq_is_packed(dev))
-		return is_vring_iotlb_packed(vq, imsg);
-	else
-		return is_vring_iotlb_split(vq, imsg);
-}
-
 static int
 vhost_user_get_config(struct virtio_net **pdev,
 			struct vhu_msg_context *ctx,
-- 
2.56.0

