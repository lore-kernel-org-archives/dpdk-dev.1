Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E51CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87BF54060B;
	Mon, 19 Oct 2026 15:49:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5FF074028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792417741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcXZr6aI6ai8DErYRcp4qSNgoG7gvA7pCKTyXty0P4I=;
 b=MzeOINfdqDHxO1vJOyvNb1JRpNRNqdHMHRlYprfxAPD7CCO7i2DvXZJau/geOKfAcpvrA4
 KBR0VbfQpriwtG76KNqFqG5Mo6j6AGPK2MA72CoIn2VtzYavARxhrZOxLUv4UT6i14Huhn
 SVacH5JpTjbhsrnoCI13ZyB4/+05U/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-xoQzDDGHNIeQfMcTz4YKaw-1; Mon,
 19 Oct 2026 13:48:56 +0000
X-MC-Unique: xoQzDDGHNIeQfMcTz4YKaw-1
X-Mimecast-MFC-AGG-ID: xoQzDDGHNIeQfMcTz4YKaw_1792417735
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E016B1954B09; Mon, 19 Oct 2026 13:48:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB3F01803A59; Mon, 19 Oct 2026 13:48:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com,
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 9/9] vhost: Support vduse suspend feature
Date: Mon, 19 Oct 2026 15:48:08 +0200
Message-ID: <20261019134808.192525-10-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-1-eperezma@redhat.com>
References: <20261019134808.192525-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 98EAx-g0G_qUxyBT24MELTdaZNq1pT_b9xYIOQ83lzA_1792417735
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

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/vhost/vhost.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 784f103953dd..8ba3ec34a958 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -40,13 +40,15 @@ static const char * const vduse_reqs_str[] = {
 	"VDUSE_UPDATE_IOTLB",
 	"VDUSE_SET_VQ_GROUP_ASID",
 	"VDUSE_SET_VQ_READY",
+	"VDUSE_SUSPEND",
 };
 
 #define vduse_req_id_to_str(id) \
 	(id < RTE_DIM(vduse_reqs_str) ? \
 	vduse_reqs_str[id] : "Unknown")
 
-static const uint64_t supported_vduse_features = RTE_BIT64(VDUSE_F_QUEUE_READY);
+static const uint64_t supported_vduse_features =
+	RTE_BIT64(VDUSE_F_QUEUE_READY) | RTE_BIT64(VDUSE_F_SUSPEND);
 
 static uint64_t vduse_vq_to_group(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
@@ -416,6 +418,7 @@ vduse_device_stop(struct virtio_net *dev)
 	vhost_destroy_device_notify(dev);
 
 	dev->flags &= ~VIRTIO_DEV_READY;
+	dev->vduse_suspended = false;
 
 	for (i = 0; i < dev->nr_vring; i++)
 		vduse_vring_cleanup(dev, i);
@@ -563,6 +566,12 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
@@ -594,11 +603,45 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	}
+	case VDUSE_SUSPEND: {
+		uint32_t i;
+
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
+			ret = dev->notify_ops->vring_state_changed(dev->vid, i, false);
+			if (ret) {
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"Failed to disable VQ %u for suspend", i);
+				resp.result = VDUSE_REQ_RESULT_FAILED;
+				goto out;
+			}
+		}
+		dev->vduse_suspended = true;
+		resp.result = VDUSE_REQ_RESULT_OK;
+		break;
+	}
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
 	}
 
+out:
 	resp.request_id = req.request_id;
 
 	ret = write(dev->vduse_dev_fd, &resp, sizeof(resp));
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 9cdc2bb58d4b..bc6370623812 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -535,6 +535,7 @@ struct __rte_cache_aligned virtio_net {
 	int			vduse_dev_fd;
 	uint64_t		vduse_api_ver;
 	uint64_t		vduse_features;
+	bool			vduse_suspended;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.56.0

