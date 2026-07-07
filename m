Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57270C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0975C40696;
	Tue,  7 Jul 2026 14:45:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5096440B90
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deZmg72ve/axBgkYnfIX7QxBigGAVbRU9CUlsEafdg8=;
 b=DafQzxbslxl9Ywpy4kDGcpU4nbg0BPNKSiROiTLl0JdF5XcUR9sN6ZdA99YPUkaZ3TTJM6
 81HtkFK8VglWrwdzoGJFhVRx47P0/n9akolMH0TvYwzG/fldGlljOFQlb78PRnZC/7TzqS
 KTGqaOcwsrulHpKlokkM+KE6hjCPe+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-PNVCXLKdMoy9QWNAsg_IwQ-1; Tue,
 07 Jul 2026 08:45:44 -0400
X-MC-Unique: PNVCXLKdMoy9QWNAsg_IwQ-1
X-Mimecast-MFC-AGG-ID: PNVCXLKdMoy9QWNAsg_IwQ_1783428343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 395BB19540CC; Tue,  7 Jul 2026 12:45:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC6ED18005B3; Tue,  7 Jul 2026 12:45:40 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, david.marchand@redhat.com,
 dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com
Subject: [RFC v4 10/11] vhost: Support vduse suspend feature
Date: Tue,  7 Jul 2026 14:45:06 +0200
Message-ID: <20260707124507.251729-11-eperezma@redhat.com>
In-Reply-To: <20260707124507.251729-1-eperezma@redhat.com>
References: <20260707124507.251729-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KXz96ItfLSb5YccuRclOzt7ShzxvrYG4k7cn_1yU3zA_1783428343
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

Add support for the VDUSE_F_SUSPEND feature.

The suspend feature allows the driver to stop the device from processing
the virtqueues.  This ensures that the virtqueue state can be fetched
reliably in a live migration.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 35 ++++++++++++++++++++++++++++++++++-
 lib/vhost/vhost.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index cb0bbed96012..7156ec4facd7 100644
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
@@ -412,6 +413,7 @@ vduse_device_stop(struct virtio_net *dev)
 	vhost_destroy_device_notify(dev);
 
 	dev->flags &= ~VIRTIO_DEV_READY;
+	dev->vduse_suspended = false;
 
 	for (i = 0; i < dev->nr_vring; i++)
 		vduse_vring_cleanup(dev, i);
@@ -518,6 +520,12 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
 		if (i >= dev->nr_vring) {
@@ -548,6 +556,31 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
+		for (i = 0; dev->notify_ops != NULL &&
+			    dev->notify_ops->vring_state_changed != NULL &&
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
index c2b645c2d4b0..f0e7953e3bdc 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -534,6 +534,7 @@ struct __rte_cache_aligned virtio_net {
 	int			vduse_dev_fd;
 	uint64_t		vduse_api_ver;
 	uint64_t		vduse_features;
+	bool			vduse_suspended;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.55.0

