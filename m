Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25717CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21A5140B9E;
	Wed, 14 Oct 2026 17:01:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2FE40B94
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83ci8b1jsVMfX71ckQfIwRNq0ye1UV9uVN5EiJnnFy4=;
 b=VovLaQv5MyeL4O2/28imdjN/brCzrTuw/v5gvAxtdfXP7W67gIXtwGJh0iTYrLdrgFVEwS
 I6Aw+nbXieAkxyFG/DtaLhuxjThUhjKzumSwVpu7YgDOoRt1Uv2g6T40CKvE1iDkA/WAQZ
 WR1s69ByAc4u+FLpnIiHg4ArPGZbvUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-o2eCzYP4MhyIdDIjdiTfpw-1; Wed,
 14 Oct 2026 15:01:10 +0000
X-MC-Unique: o2eCzYP4MhyIdDIjdiTfpw-1
X-Mimecast-MFC-AGG-ID: o2eCzYP4MhyIdDIjdiTfpw_1791990069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79C5B1955F6F; Wed, 14 Oct 2026 15:01:09 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3460E1800677; Wed, 14 Oct 2026 15:01:08 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 Stephen Haruna <syberstevelabs@gmail.com>,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 11/14] vhost: fix out-of-bounds read in control virtqueue
 handler
Date: Wed, 14 Oct 2026 17:00:46 +0200
Message-ID: <20261014150049.2540538-11-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fdckgHK1vdvMwvBDl-XPzCij1y860wjN-f8PyjlH0nM_1791990069
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

Add request length validation before accessing command_data in the
control virtqueue handler. The request buffer size was only validated
against the 2-byte header (class + command), but the MQ_VQ_PAIRS_SET
handler reads a 2-byte queue_pairs field from command_data without
verifying those bytes exist.

A malicious guest could submit a 2-byte control request causing an
out-of-bounds heap read of bytes [2..3] beyond the allocation.

Propagate data_len through virtio_net_ctrl_elem and validate the
minimum required size (4 bytes) before dereferencing command_data.

CVE-2026-86562
Bugzilla ID: 2007

Cc: stable@dpdk.org

Reported-by: Stephen Haruna <syberstevelabs@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/virtio_net_ctrl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
index 1e5034457c..51a3baf78e 100644
--- a/lib/vhost/virtio_net_ctrl.c
+++ b/lib/vhost/virtio_net_ctrl.c
@@ -20,6 +20,7 @@ struct virtio_net_ctrl_elem {
 	struct virtio_net_ctrl *ctrl_req;
 	uint16_t head_idx;
 	uint16_t n_descs;
+	uint32_t data_len;
 	uint8_t *desc_ack;
 };
 
@@ -135,6 +136,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to alloc ctrl request");
 		goto err;
 	}
+	ctrl_elem->data_len = data_len;
 
 	ctrl_req = (uint8_t *)ctrl_elem->ctrl_req;
 
@@ -213,7 +215,8 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
 }
 
 static uint8_t
-virtio_net_ctrl_handle_req(struct virtio_net *dev, struct virtio_net_ctrl *ctrl_req)
+virtio_net_ctrl_handle_req(struct virtio_net *dev, struct virtio_net_ctrl *ctrl_req,
+		uint32_t data_len)
 {
 	uint8_t ret = VIRTIO_NET_ERR;
 
@@ -222,6 +225,12 @@ virtio_net_ctrl_handle_req(struct virtio_net *dev, struct virtio_net_ctrl *ctrl_
 		uint16_t queue_pairs;
 		uint32_t i;
 
+		if (data_len < sizeof(*ctrl_req) + sizeof(queue_pairs)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"Invalid MQ control request size");
+			return VIRTIO_NET_ERR;
+		}
+
 		queue_pairs = *(uint16_t *)(uintptr_t)ctrl_req->command_data;
 		VHOST_CONFIG_LOG(dev->ifname, INFO, "Ctrl req: MQ %u queue pairs", queue_pairs);
 		ret = VIRTIO_NET_OK;
@@ -296,7 +305,8 @@ virtio_net_ctrl_handle(struct virtio_net *dev)
 		if (ret <= 0)
 			break;
 
-		*ctrl_elem.desc_ack = virtio_net_ctrl_handle_req(dev, ctrl_elem.ctrl_req);
+		*ctrl_elem.desc_ack = virtio_net_ctrl_handle_req(dev, ctrl_elem.ctrl_req,
+				ctrl_elem.data_len);
 
 		ret = virtio_net_ctrl_push(dev, &ctrl_elem);
 		if (ret < 0)
-- 
2.56.0

