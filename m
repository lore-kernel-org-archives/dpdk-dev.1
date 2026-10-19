Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73676CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 958CA409FA;
	Mon, 19 Oct 2026 15:48:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D53D40658
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792417720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBwrRyh9zf0k0lfKQDRj8VlCRV4czPOfhb1GU7mL9+0=;
 b=EE6L1zCo6cwok4dtsdkcTXxilCuEiyK1u13ghiRVEc6/tqlLb1ApIyMsC9v87T2W8L5jKM
 n41ppuVK9tLCZOsAA0QZaf1u7eJ8fCwzkKKmqG9dbSaTr+R+Dx2yiOyunaO/nW8imO8LaD
 Ayp2uNOWXkuEQz8TBmRK8MlbfI2i6xg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-YGd3MFCAM5CN54ynD7khhA-1; Mon,
 19 Oct 2026 13:48:37 +0000
X-MC-Unique: YGd3MFCAM5CN54ynD7khhA-1
X-Mimecast-MFC-AGG-ID: YGd3MFCAM5CN54ynD7khhA_1792417716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D596518007EC; Mon, 19 Oct 2026 13:48:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B06311800446; Mon, 19 Oct 2026 13:48:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com,
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 5/9] vhost: add ASID support to VDUSE IOTLB operations
Date: Mon, 19 Oct 2026 15:48:04 +0200
Message-ID: <20261019134808.192525-6-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-1-eperezma@redhat.com>
References: <20261019134808.192525-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yxjGtiDRiT1MfhpZFisKgd9vTAUL2EdEPa1hKosNtdY_1792417716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Make use of the newly introduced address space ID when
calling Vhost IOTLB API.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v5: Merge vring_invalidate call conflict to invalidate vrings.
---
 lib/vhost/vduse.c | 51 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 80b9be89b6b4..34ed6fce88ee 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -71,7 +71,7 @@ vduse_iotlb_remove_notify(uint64_t addr, uint64_t offset, uint64_t size)
 static int
 vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm __rte_unused)
 {
-	struct vduse_iotlb_entry entry;
+	struct vduse_iotlb_entry_v2 entry = {};
 	uint64_t size, page_size;
 	struct stat stat;
 	void *mmap_addr;
@@ -79,8 +79,13 @@ vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm _
 
 	entry.start = iova;
 	entry.last = iova + 1;
+	entry.asid = asid;
 
-	ret = ioctl(dev->vduse_dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+	if (dev->vduse_api_ver < 1) {
+		ret = ioctl(dev->vduse_dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+	} else {
+		ret = ioctl(dev->vduse_dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
+	}
 	if (ret < 0) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to get IOTLB entry for 0x%" PRIx64,
 				iova);
@@ -90,6 +95,7 @@ vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm _
 	fd = ret;
 
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "New IOTLB entry:");
+	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\tASID: %d", entry.asid);
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\tIOVA: %" PRIx64 " - %" PRIx64,
 			(uint64_t)entry.start, (uint64_t)entry.last);
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\toffset: %" PRIx64, (uint64_t)entry.offset);
@@ -458,27 +464,48 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		break;
 	case VDUSE_UPDATE_IOTLB: {
 		struct vhost_iotlb_msg imsg;
+		uint64_t start, last;
+		uint32_t asid;
 		uint32_t i;
 
-		VHOST_CONFIG_LOG(dev->ifname, INFO, "\tIOVA range: %" PRIx64 " - %" PRIx64,
-				(uint64_t)req.iova.start, (uint64_t)req.iova.last);
-		vhost_user_iotlb_cache_remove(dev, 0, req.iova.start,
-				req.iova.last - req.iova.start + 1);
+		if (dev->vduse_api_ver < 1) {
+			start = req.iova.start;
+			last = req.iova.last;
+			asid = 0;
+		} else {
+			start = req.iova_v2.start;
+			last = req.iova_v2.last;
+			asid = req.iova_v2.asid;
+		}
+
+		if (asid >= RTE_DIM(dev->iotlb)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Invalid ASID %u in IOTLB update", asid);
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		VHOST_CONFIG_LOG(dev->ifname, INFO, "\t(ASID %d) IOVA range: %" PRIx64 " - %" PRIx64,
+			asid, start, last);
+		vhost_user_iotlb_cache_remove(dev, asid, start, last - start + 1);
 
 		/* Invalidate vring translations if affected by this range */
-		imsg.iova = req.iova.start;
-		imsg.size = req.iova.last - req.iova.start + 1;
+		imsg.iova = start;
+		imsg.size = last - start + 1;
 
 		for (i = 0; i < dev->nr_vring; i++) {
-			vq = dev->virtqueue[i];
+		        vq = dev->virtqueue[i];
 
 			if (!vq)
 				continue;
 
+			if ((uint32_t)vq->asid != asid)
+				continue;
+
 			if (is_vring_iotlb(dev, vq, &imsg)) {
-				rte_rwlock_write_lock(&vq->access_lock);
-				vring_invalidate(dev, vq);
-				rte_rwlock_write_unlock(&vq->access_lock);
+			        rte_rwlock_write_lock(&vq->access_lock);
+			        vring_invalidate(dev, vq);
+			        rte_rwlock_write_unlock(&vq->access_lock);
 			}
 		}
 
-- 
2.56.0

