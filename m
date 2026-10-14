Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C0CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47D7C4065A;
	Wed, 14 Oct 2026 17:01:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CF99E4065A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dr4q1gQLgcIrq7/3fLROUOgpuSMCzKxvRiXP1AaBSyw=;
 b=fuGGAhpsIsPWafnTzU4XVtH/wa5xOu5f8e3p4bfT0HnSsqGstopDuxX3UASw6BH4EHe6/K
 rhubFN+NObRNxLppNdkzdexWkZHQKE9Boh6QEXr9i41lJHQSpKKdZTyzhznHLft4FX90eR
 /y8mcrYyW6nABJCqDvPtoMoVRgDz1Rg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-9AoRUCnEP9e41bII5iyrig-1; Wed,
 14 Oct 2026 15:00:57 +0000
X-MC-Unique: 9AoRUCnEP9e41bII5iyrig-1
X-Mimecast-MFC-AGG-ID: 9AoRUCnEP9e41bII5iyrig_1791990057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95FF19560A6; Wed, 14 Oct 2026 15:00:56 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 978F51800495; Wed, 14 Oct 2026 15:00:55 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 Ivar Al-Safawi <hemo40047@gmail.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 03/14] vhost: fix double-fetch vulnerability in control queue
Date: Wed, 14 Oct 2026 17:00:38 +0200
Message-ID: <20261014150049.2540538-3-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oq22okmO6a_KDYpMVnzMsWKmRkH6WQEWj8c_piXOIDc_1791990057
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

Add bounds checking to prevent heap buffer overflow in
virtio_net_ctrl_pop(). The descriptor length is read twice from
guest-controlled shared memory - once to calculate allocation size
and once during memcpy. A malicious guest could modify the length
between reads to overflow the allocated buffer.

Track cumulative bytes copied and verify against allocated size
before each memcpy to ensure writes stay within bounds.

CVE-2026-86562
Bugzilla ID: 2003
Bugzilla ID: 2021

Cc: stable@dpdk.org

Reported-by: Ivar Al-Safawi <hemo40047@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/virtio_net_ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
index b059fe1f02..1e5034457c 100644
--- a/lib/vhost/virtio_net_ctrl.c
+++ b/lib/vhost/virtio_net_ctrl.c
@@ -138,6 +138,8 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 
 	ctrl_req = (uint8_t *)ctrl_elem->ctrl_req;
 
+	uint64_t copied = 0;
+
 	if (cvq->desc[desc_idx].flags & VRING_DESC_F_INDIRECT) {
 		desc_len = cvq->desc[desc_idx].len;
 		desc_iova = cvq->desc[desc_idx].addr;
@@ -175,8 +177,14 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 			goto free_err;
 		}
 
+		if (copied + desc_len > data_len) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR, "Descriptor length overflow detected");
+			goto free_err;
+		}
+
 		memcpy(ctrl_req, (void *)(uintptr_t)desc_addr, desc_len);
 		ctrl_req += desc_len;
+		copied += desc_len;
 
 		if (!(descs[desc_idx].flags & VRING_DESC_F_NEXT))
 			break;
-- 
2.56.0

