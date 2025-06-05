Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D9CC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C92D40668;
	Thu,  5 Jun 2025 13:36:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D34AC40649
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749123363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAu7hqoRCgt0nSnuiuVHQHDmfddhsPJGrCkBEgwwW+I=;
 b=VF+JeD1D9xED9JdRuEc1kw6qHH9vpkN/utdZvcP888CHHfdM3FLdvKVQFpctKO0hUgbW5u
 ReFY20U9qMzNTMiAZ6Ri8zCOAbeXXiCGfJAYeB66JWyQpiWUdjViTDdOcCJvzkd44tCCkS
 8tavjZTypONXU1DEoTOiMbOljXMjGEQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-vxUbXY__O7ClnNcWeHWYeA-1; Thu,
 05 Jun 2025 07:35:59 -0400
X-MC-Unique: vxUbXY__O7ClnNcWeHWYeA-1
X-Mimecast-MFC-AGG-ID: vxUbXY__O7ClnNcWeHWYeA_1749123359
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED4A21800BF3; Thu,  5 Jun 2025 11:35:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FC00195E74A; Thu,  5 Jun 2025 11:35:56 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 1/2] vhost: search the split vq desc and avail in RO areas
Date: Thu,  5 Jun 2025 13:35:51 +0200
Message-ID: <20250605113552.918120-2-eperezma@redhat.com>
In-Reply-To: <20250605113552.918120-1-eperezma@redhat.com>
References: <20250605113552.918120-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tjuUKtaP5s74XSrnAsAJ9Pvl5bn_fp6NnvBXIBfQPEk_1749123359
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

QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. If
we don't change it, vhost_iova_to_vva do not consider them as valid and
returns that they're not found.

Fixes: eefac9536a90 ("vhost: postpone device creation until rings are mapped")
Cc: stable@dpdk.org

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 0353a04dc8..95a99bace6 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -497,7 +497,7 @@ vring_translate_split(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	size = req_size;
 	vq->desc = (struct vring_desc *)(uintptr_t)vhost_iova_to_vva(dev, vq,
 						vq->ring_addrs.desc_user_addr,
-						&size, VHOST_ACCESS_RW);
+						&size, VHOST_ACCESS_RO);
 	if (!vq->desc || size != req_size)
 		return -1;
 
@@ -508,7 +508,7 @@ vring_translate_split(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	size = req_size;
 	vq->avail = (struct vring_avail *)(uintptr_t)vhost_iova_to_vva(dev, vq,
 						vq->ring_addrs.avail_user_addr,
-						&size, VHOST_ACCESS_RW);
+						&size, VHOST_ACCESS_RO);
 	if (!vq->avail || size != req_size)
 		return -1;
 
-- 
2.49.0

