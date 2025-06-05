Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275DC5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 028A64065E;
	Thu,  5 Jun 2025 13:36:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D9C3F4065E
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749123365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yb4N0fDjKhKiXCaAg4OlqLOt4Vsm/BdvwID8Q+rJYPA=;
 b=i6W6HSDYr6lP+IiHnZYSh97+kYUHu1aLJ4kiMgjt8SVXH9zpjKkkPWkTTa8BQIMd3JzOSc
 LO/xgntpIW6Htht+QFuK4GzosWvPaj/YVInJeA8QDK9Xzh5jyqUy2MNGSnTnriognL9KRb
 mg0LIccP13WNeWJgT42jJCgskc3kdVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-sLILBEVoMtyfoEror5oQCQ-1; Thu,
 05 Jun 2025 07:36:02 -0400
X-MC-Unique: sLILBEVoMtyfoEror5oQCQ-1
X-Mimecast-MFC-AGG-ID: sLILBEVoMtyfoEror5oQCQ_1749123361
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6886C18001D6; Thu,  5 Jun 2025 11:36:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FBD5195E74A; Thu,  5 Jun 2025 11:35:59 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 2/2] vhost: search the packed vq driver area in RO areas
Date: Thu,  5 Jun 2025 13:35:52 +0200
Message-ID: <20250605113552.918120-3-eperezma@redhat.com>
In-Reply-To: <20250605113552.918120-1-eperezma@redhat.com>
References: <20250605113552.918120-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OodabNC07YLH1m90J9VlhUxtn-uNLwp_ARk-X3UUTnI_1749123361
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

QEMU's shadow virtqueue and VDUSE exposes this as read-only. If we
don't change it, vhost_iova_to_vva do not consider them as valid and
returns that they're not found.

Fixes: 2d1541e2b6b3 ("vhost: add vring address setup for packed queues")
Cc: stable@dpdk.org

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 95a99bace6..a2e3e2635d 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -544,7 +544,7 @@ vring_translate_packed(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	size = req_size;
 	vq->driver_event = (struct vring_packed_desc_event *)(uintptr_t)
 		vhost_iova_to_vva(dev, vq, vq->ring_addrs.avail_user_addr,
-				&size, VHOST_ACCESS_RW);
+				&size, VHOST_ACCESS_RO);
 	if (!vq->driver_event || size != req_size)
 		return -1;
 
-- 
2.49.0

