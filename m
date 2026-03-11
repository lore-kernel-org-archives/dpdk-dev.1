Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84AFD063C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 06:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52C440ED0;
	Wed, 11 Mar 2026 07:56:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F3ECF40DD1
 for <dev@dpdk.org>; Wed, 11 Mar 2026 07:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773212184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lAXxQ2Wqe6vaeqdtdOuBc6YwbktQBiKZUuLY+QjtjU=;
 b=F8QTKRPxN3MWi1jaCGXtapyLTitEq34fqbRf9CE+d6Iu7U/0hgknA9JRI4XyIKyouVL5gv
 XxP0eIyqioxPFiYyMz56zX0qfg+3hKkpq3IX2ucmAhFD2mXp7TDqVJz9dJg3RmELCG2+Dw
 EZ51Iw90V1joCB7baHYLAI05D6aygIw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-2NXM9T37PgC10jdAGHGxmA-1; Wed,
 11 Mar 2026 02:56:21 -0400
X-MC-Unique: 2NXM9T37PgC10jdAGHGxmA-1
X-Mimecast-MFC-AGG-ID: 2NXM9T37PgC10jdAGHGxmA_1773212180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A1CC18005BF; Wed, 11 Mar 2026 06:56:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.190])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6591919560A6; Wed, 11 Mar 2026 06:56:17 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: chenbox@nvidia.com, jasowang@redhat.com, david.marchand@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com
Subject: [RFC v3 10/10] vhost: Support vduse suspend feature
Date: Wed, 11 Mar 2026 07:55:43 +0100
Message-ID: <20260311065543.1354037-11-eperezma@redhat.com>
In-Reply-To: <20260311065543.1354037-1-eperezma@redhat.com>
References: <20260311065543.1354037-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bjP6Z83rLzn1npiuNnFryn6600giq48Ik7Bxk5dxaQg_1773212180
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

From: Super User <root@wsfd-advnetlab45.anl.eng.rdu2.dc.redhat.com>

Add support for the VDUSE_F_SUSPEND feature.

The suspend feature allows the driver to stop the device from processing
the virtqueues.  This ensures that the virtqueue state can be fetched
reliably in a live migration.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2:
* Following latest comments on kernel series about VDUSE features, not
  checking API version but only check if VDUSE_GET_FEATURES success.
---
 lib/vhost/vduse.c | 33 ++++++++++++++++++++++++++++++++-
 lib/vhost/vhost.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index f84952ebf0c6..cb523bd80179 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -46,7 +46,8 @@ static const char * const vduse_reqs_str[] = {
 	(id < RTE_DIM(vduse_reqs_str) ? \
 	vduse_reqs_str[id] : "Unknown")
 
-static const uint64_t supported_vduse_features = RTE_BIT64(VDUSE_F_QUEUE_READY);
+static const uint64_t supported_vduse_features =
+	RTE_BIT64(VDUSE_F_QUEUE_READY) | RTE_BIT64(VDUSE_F_SUSPEND);
 
 static uint64_t vduse_vq_to_group(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
@@ -520,6 +521,12 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 			resp.result = VDUSE_REQ_RESULT_FAILED;
 			break;
 		}
+		if (dev->vduse_suspended) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"SET_VQ_READY received on suspended device");
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
 
 		i = req.vq_ready.num;
 		vq = dev->virtqueue[i];
@@ -543,6 +550,30 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		vq->enabled = req.vq_ready.ready;
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
+	case VDUSE_SUSPEND:
+		if (!(dev->vduse_features & RTE_BIT64(VDUSE_F_SUSPEND))) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Unnegotiated suspend message");
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+		if (!(dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Unexpected suspend message with no DRIVER_OK");
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+		for (i = 0; dev->notify_ops->vring_state_changed &&
+			    i < dev->nr_vring; i++) {
+			if (dev->virtqueue[i] == dev->cvq)
+				continue;
+
+			dev->notify_ops->vring_state_changed(dev->vid, i, false);
+		}
+		dev->vduse_suspended = true;
+		resp.result = VDUSE_REQ_RESULT_OK;
+		break;
+
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index ce2e1a271c6f..73f0c9397cd0 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -534,6 +534,7 @@ struct __rte_cache_aligned virtio_net {
 	int			vduse_dev_fd;
 	uint64_t		vduse_api_ver;
 	uint64_t		vduse_features;
+	bool			vduse_suspended;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.53.0

