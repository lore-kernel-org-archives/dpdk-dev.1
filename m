Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6ED37E4E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:35:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E88524069D;
	Wed, 14 Jan 2026 16:35:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB8F400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768404901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E12/leIQwq/E+DV+vDkgwGpm/ClAWTx3Td+N0Ust/Sw=;
 b=AaGtDTzOH4jzSreOHguWl50Nb4sWxVk931+Lu1FzVeLC16j31M/aziJ3Fh1ST0ixyVlinl
 LGXRrzEilfBz1ipjNA5kjb7GNpXgS81QwGxT1yM+aEx9KDSY9s7Rd0lyAPSKTcL/F9diTq
 BKj/RAHRxfbD5LwryBtp2UGXQiQvmBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-BJsuzUHiN32J4IV4L-93dw-1; Wed,
 14 Jan 2026 10:34:58 -0500
X-MC-Unique: BJsuzUHiN32J4IV4L-93dw-1
X-Mimecast-MFC-AGG-ID: BJsuzUHiN32J4IV4L-93dw_1768404897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B9DD1954B1B; Wed, 14 Jan 2026 15:34:57 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E80E71800240; Wed, 14 Jan 2026 15:34:54 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	chenbox@nvidia.com,
	david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2 2/3] vhost: fix descriptor chain bounds check in control
 queue
Date: Wed, 14 Jan 2026 16:34:44 +0100
Message-ID: <20260114153445.2751895-3-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MU5cm6GxbU-ydVWdh28QiLEz0jSPGIYX0kCXE0yfLBw_1768404897
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

The virtio_net_ctrl_pop() function traverses descriptor chains from
guest-controlled memory without validating that the descriptor index
stays within bounds and without a counter to prevent infinite loops
from circular chains.

A malicious guest could craft descriptors with a next field pointing
out of bounds causing memory corruption, or create circular descriptor
chains causing an infinite loop and denial of service.

Add bounds checking and a loop counter to both descriptor chain
traversal loops, similar to the existing protection in virtio_net.c
fill_vec_buf_split().

Fixes: 474f4d7840ad ("vhost: add control virtqueue")
Cc: stable@dpdk.org

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
index 603a8db728..b059fe1f02 100644
--- a/lib/vhost/virtio_net_ctrl.c
+++ b/lib/vhost/virtio_net_ctrl.c
@@ -28,7 +28,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 		struct virtio_net_ctrl_elem *ctrl_elem)
 	__rte_requires_shared_capability(&cvq->iotlb_lock)
 {
-	uint16_t avail_idx, desc_idx, n_descs = 0;
+	uint16_t avail_idx, desc_idx, n_descs = 0, nr_descs, cnt = 0;
 	uint64_t desc_len, desc_addr, desc_iova, data_len = 0;
 	uint8_t *ctrl_req;
 	struct vring_desc *descs;
@@ -59,12 +59,19 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 			goto err;
 		}
 
+		nr_descs = desc_len / sizeof(struct vring_desc);
 		desc_idx = 0;
 	} else {
 		descs = cvq->desc;
+		nr_descs = cvq->size;
 	}
 
 	while (1) {
+		if (unlikely(desc_idx >= nr_descs || cnt++ >= nr_descs)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl descriptor chain");
+			goto err;
+		}
+
 		desc_len = descs[desc_idx].len;
 		desc_iova = descs[desc_idx].addr;
 
@@ -142,12 +149,23 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 			goto free_err;
 		}
 
+		nr_descs = desc_len / sizeof(struct vring_desc);
 		desc_idx = 0;
 	} else {
 		descs = cvq->desc;
+		nr_descs = cvq->size;
 	}
 
-	while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE)) {
+	cnt = 0;
+	while (1) {
+		if (unlikely(desc_idx >= nr_descs || cnt++ >= nr_descs)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl descriptor chain");
+			goto free_err;
+		}
+
+		if (descs[desc_idx].flags & VRING_DESC_F_WRITE)
+			break;
+
 		desc_len = descs[desc_idx].len;
 		desc_iova = descs[desc_idx].addr;
 
-- 
2.52.0

