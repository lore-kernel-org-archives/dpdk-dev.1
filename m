Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D9C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4984069F;
	Tue,  7 Jul 2026 14:45:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 96E3B4069F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWGzyPkMROm5RCY2tZcwaUduwrqL4c/uG96PdVEbPiM=;
 b=gEBhrS0ViSwfIFw9J+k5IJEi7KSt8SfUDk4ipEla67aL+XN2sLUvsDtrl4y6vynp8TjW+q
 BwGbY9aIRAxxfDnJEZ7ofRYpRHzPrZSe+wjyQqC1XoDBQoFQyReuxAbegWc5h1hXhTjGB0
 IOtpj9JRV5swza2iRhPY+Pe6wl6t4mg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-L5A67Sz1N_yJzCQAXoel8g-1; Tue,
 07 Jul 2026 08:45:29 -0400
X-MC-Unique: L5A67Sz1N_yJzCQAXoel8g-1
X-Mimecast-MFC-AGG-ID: L5A67Sz1N_yJzCQAXoel8g_1783428328
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84BA71954232; Tue,  7 Jul 2026 12:45:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D3EA18005B3; Tue,  7 Jul 2026 12:45:24 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, david.marchand@redhat.com,
 dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com
Subject: [RFC v4 05/11] vhost: add ASID support to VDUSE IOTLB operations
Date: Tue,  7 Jul 2026 14:45:01 +0200
Message-ID: <20260707124507.251729-6-eperezma@redhat.com>
In-Reply-To: <20260707124507.251729-1-eperezma@redhat.com>
References: <20260707124507.251729-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uHb2G3XdC1TBXo7Eq22lAF3mvrp0JnznMI03POzfsWY_1783428328
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
 lib/vhost/vduse.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 5cfe569f7d2a..27609f28c1a3 100644
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
@@ -79,8 +79,9 @@ vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm _
 
 	entry.start = iova;
 	entry.last = iova + 1;
+	entry.asid = asid;
 
-	ret = ioctl(dev->vduse_dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+	ret = ioctl(dev->vduse_dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
 	if (ret < 0) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to get IOTLB entry for 0x%" PRIx64,
 				iova);
@@ -90,6 +91,7 @@ vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm _
 	fd = ret;
 
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "New IOTLB entry:");
+	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\tASID: %d", entry.asid);
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\tIOVA: %" PRIx64 " - %" PRIx64,
 			(uint64_t)entry.start, (uint64_t)entry.last);
 	VHOST_CONFIG_LOG(dev->ifname, DEBUG, "\toffset: %" PRIx64, (uint64_t)entry.offset);
@@ -458,10 +460,24 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	case VDUSE_UPDATE_IOTLB:
-		VHOST_CONFIG_LOG(dev->ifname, INFO, "\tIOVA range: %" PRIx64 " - %" PRIx64,
-				(uint64_t)req.iova.start, (uint64_t)req.iova.last);
-		vhost_user_iotlb_cache_remove(dev, 0, req.iova.start,
-				req.iova.last - req.iova.start + 1);
+		{
+			uint64_t start, last;
+			uint32_t asid;
+
+			if (dev->vduse_api_ver < 1) {
+				start = req.iova.start;
+				last = req.iova.last;
+				asid = 0;
+			} else {
+				start = req.iova_v2.start;
+				last = req.iova_v2.last;
+				asid = req.iova_v2.asid;
+			}
+
+			VHOST_CONFIG_LOG(dev->ifname, INFO, "\t(ASID %d) IOVA range: %" PRIx64 " - %" PRIx64,
+				asid, start, last);
+			vhost_user_iotlb_cache_remove(dev, asid, start, last - start + 1);
+		}
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	case VDUSE_SET_VQ_GROUP_ASID:
-- 
2.55.0

