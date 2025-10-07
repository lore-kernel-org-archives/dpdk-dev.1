Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEDCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 14:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A3E402DD;
	Tue,  7 Oct 2025 16:48:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F226C402D1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 16:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759848484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GS0heOGJwIp3YVRnFYSxGDlAUstJtg+jDkYmZ68AUMA=;
 b=TQWxxlNK/V5LSnR9tBuAHHihdr42RI+b/QJRYiLUYf5aVTNCZt25PLqJIa0MGAJJToU6U4
 KZIJTT3tQYDrEXVeL9f3i0J1MYctmyFN4O/GTwywybIaccd3E97px7uJ2zFYMmdnDyH21o
 hcXqIyJ1n48Vy9dYxiYg7HDeiq4+Qxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-50b6Rj0bPXKc5u6q2s2hfA-1; Tue,
 07 Oct 2025 10:48:02 -0400
X-MC-Unique: 50b6Rj0bPXKc5u6q2s2hfA-1
X-Mimecast-MFC-AGG-ID: 50b6Rj0bPXKc5u6q2s2hfA_1759848481
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CA9F18002C6; Tue,  7 Oct 2025 14:48:01 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 155CA180035E; Tue,  7 Oct 2025 14:47:57 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, amorenoz@redhat.com, david.marchand@redhat.com,
 chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2] net/virtio-user: fix used ring address calculation
Date: Tue,  7 Oct 2025 16:47:54 +0200
Message-ID: <20251007144754.1690606-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XVA_ggj1-EJy9MFVDIswjBQH_YhXarcqRG3hhIZietY_1759848481
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

This patch fixes the used ring address calculation, to
avoid Vhost-vDPA backends (such as VDUSE) to fail while
trying to translate it.

Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
Cc: stable@dpdk.org

Reported-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---

Changes in v2:
- Refactor addresses calculation (David)

---


 .../net/virtio/virtio_user/virtio_user_dev.c  | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index 187f81b066..f3df73c1f0 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -118,7 +118,7 @@ virtio_user_kick_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
 	struct vhost_vring_state state;
 	struct vring *vring = &dev->vrings.split[queue_sel];
 	struct vring_packed *pq_vring = &dev->vrings.packed[queue_sel];
-	uint64_t desc_addr, avail_addr, used_addr;
+	uint64_t desc_addr, desc_iova_addr, avail_addr, used_addr;
 	struct vhost_vring_addr addr = {
 		.index = queue_sel,
 		.log_guest_addr = 0,
@@ -138,25 +138,21 @@ virtio_user_kick_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
 	}

 	if (dev->features & (1ULL << VIRTIO_F_RING_PACKED)) {
-		desc_addr = pq_vring->desc_iova;
-		avail_addr = desc_addr + pq_vring->num * sizeof(struct vring_packed_desc);
-		used_addr =  RTE_ALIGN_CEIL(avail_addr + sizeof(struct vring_packed_desc_event),
-					    VIRTIO_VRING_ALIGN);
-
-		addr.desc_user_addr = desc_addr;
-		addr.avail_user_addr = avail_addr;
-		addr.used_user_addr = used_addr;
+		desc_iova_addr = pq_vring->desc_iova;
+		desc_addr = (uint64_t)(uintptr_t)pq_vring->desc;
+		avail_addr = (uint64_t)(uintptr_t)pq_vring->driver;
+		used_addr = (uint64_t)(uintptr_t)pq_vring->device;
 	} else {
-		desc_addr = vring->desc_iova;
-		avail_addr = desc_addr + vring->num * sizeof(struct vring_desc);
-		used_addr = RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
-					   VIRTIO_VRING_ALIGN);
-
-		addr.desc_user_addr = desc_addr;
-		addr.avail_user_addr = avail_addr;
-		addr.used_user_addr = used_addr;
+		desc_iova_addr = vring->desc_iova;
+		desc_addr = (uint64_t)(uintptr_t)vring->desc;
+		avail_addr = (uint64_t)(uintptr_t)vring->avail;
+		used_addr = (uint64_t)(uintptr_t)vring->used;
 	}

+	addr.desc_user_addr = desc_iova_addr;
+	addr.avail_user_addr = (desc_iova_addr - desc_addr) + avail_addr;
+	addr.used_user_addr = (desc_iova_addr - desc_addr) + used_addr;
+
 	state.index = queue_sel;
 	state.num = vring->num;
 	ret = dev->ops->set_vring_num(dev, &state);
--
2.51.0

