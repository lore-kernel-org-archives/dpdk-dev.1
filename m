Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C8CC5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B758F40611;
	Thu,  5 Jun 2025 13:35:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 128D94026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749123341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CZb2AsY+sitHsHTeM/StzmjqsrBALLBpCCb+rkzPe3Y=;
 b=CKS6xPOefag62XvrcMKRcakV3M7EdQmULaBubiv2uGAkNdzmzVs78OptW1gEH3tpnzaMCR
 XigPQq6ggS9B1OWTJeQSkjlDLLGO9uMCBOQhyHmro0bznK9s2ySxOEEbJLtTMRex51BXEW
 G9PgLgfEHEoyUv8n/F6GkzQeQJKhY8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-u0zktMwBPni9rFDAVlzbpA-1; Thu,
 05 Jun 2025 07:35:40 -0400
X-MC-Unique: u0zktMwBPni9rFDAVlzbpA-1
X-Mimecast-MFC-AGG-ID: u0zktMwBPni9rFDAVlzbpA_1749123339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E26180035C; Thu,  5 Jun 2025 11:35:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BC12195E74A; Thu,  5 Jun 2025 11:35:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org
Subject: [PATCH] vhost: fix net control virtqueue used length
Date: Thu,  5 Jun 2025 13:35:34 +0200
Message-ID: <20250605113534.917903-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: paHbBvyZz7-wQ-Tk6zWR98GrcGwCbY6m2uRllWq9axw_1749123339
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

By the standard this is the number of bytes written.

Fixes: 474f4d7840ad ("vhost: add control virtqueue")
Cc: stable@dpdk.org

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/virtio_net_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
index 63c0a06b4f..603a8db728 100644
--- a/lib/vhost/virtio_net_ctrl.c
+++ b/lib/vhost/virtio_net_ctrl.c
@@ -229,7 +229,7 @@ virtio_net_ctrl_push(struct virtio_net *dev, struct virtio_net_ctrl_elem *ctrl_e
 
 	used_elem = &cvq->used->ring[cvq->last_used_idx & (cvq->size - 1)];
 	used_elem->id = ctrl_elem->head_idx;
-	used_elem->len = ctrl_elem->n_descs;
+	used_elem->len = sizeof(*ctrl_elem->desc_ack);
 
 	cvq->last_used_idx++;
 
-- 
2.49.0

