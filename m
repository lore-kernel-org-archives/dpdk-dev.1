Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E6ECD6C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9708240DCA;
	Wed, 11 Feb 2026 17:15:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0747540B97
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVgnbd5VS8xwFh6YFyYhTUiZUN0dztGNFSPrp5lHs7o=;
 b=GBDi+VwSEEanOZ06FT/Xupl8I6zRIyyltr9rMqsAckGUwtBBlp5cJnwUj0OSqG/eSyV7pB
 xEmeQkmDoO8sd8x3ta6hgm+yPa9mV6YC0MWkbbQMOu/8RLHh+GyY4cP3poi9H5gRtT2IzG
 RbSlL83SCeVDVQ8jy7ehtEFX7kxFZcE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-zRAHBMN9OJWtb90woFcw-g-1; Wed,
 11 Feb 2026 11:15:31 -0500
X-MC-Unique: zRAHBMN9OJWtb90woFcw-g-1
X-Mimecast-MFC-AGG-ID: zRAHBMN9OJWtb90woFcw-g_1770826529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720821800578; Wed, 11 Feb 2026 16:15:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 174C7180066F; Wed, 11 Feb 2026 16:15:26 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, david.marchand@redhat.com, mst@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com
Subject: [RFC 09/10] vhost: Support VDUSE QUEUE_READY feature
Date: Wed, 11 Feb 2026 17:14:56 +0100
Message-ID: <20260211161457.2703686-10-eperezma@redhat.com>
In-Reply-To: <20260211161457.2703686-1-eperezma@redhat.com>
References: <20260211161457.2703686-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UBWQPvJClpYffZCkNht_cB9aWDXeib7LDH9osPgGfrU_1770826529
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

Add support for the VDUSE_F_QUEUE_READY feature.

In VDUSE, the dataplane is enabled only after control virtqueue so the
device is fully configured in the destination of a live migration before
the dataplane starts.  This message signals the VDUSE device when the
dataplane queues should be enabled.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 79 +++++++++++++++++++++++++++++++++++++++++++++--
 lib/vhost/vhost.h |  1 +
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 04f397bac8b5..9c0801453605 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -25,7 +25,7 @@
 #include "vhost.h"
 #include "virtio_net_ctrl.h"
 
-#define VHOST_VDUSE_API_VERSION 1ULL
+#define VHOST_VDUSE_API_VERSION 2ULL
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
 
 struct vduse {
@@ -39,12 +39,15 @@ static const char * const vduse_reqs_str[] = {
 	"VDUSE_SET_STATUS",
 	"VDUSE_UPDATE_IOTLB",
 	"VDUSE_SET_VQ_GROUP_ASID",
+	"VDUSE_SET_VQ_READY",
 };
 
 #define vduse_req_id_to_str(id) \
 	(id < RTE_DIM(vduse_reqs_str) ? \
 	vduse_reqs_str[id] : "Unknown")
 
+static const uint64_t supported_vduse_features = RTE_BIT64(VDUSE_F_QUEUE_READY);
+
 static uint64_t vduse_vq_to_group(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
 	if (dev->vduse_api_ver < 1)
@@ -499,6 +502,48 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		}
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
+	case VDUSE_SET_VQ_READY:
+		if (!(dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK)) {
+			/*
+			 * dev->notify_ops is NULL if !S_DRIVER_OK,
+			 * vduse_device_start will check the queue readiness.
+			 */
+			resp.result = VDUSE_REQ_RESULT_OK;
+			break;
+		}
+		if (dev->vduse_api_ver < 2 ||
+		    !(dev->vduse_features & RTE_BIT64(VDUSE_F_QUEUE_READY))) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Unexpected message ver %"PRIu64" ready feature %d",
+				dev->vduse_api_ver,
+				!!(dev->vduse_features &
+				   RTE_BIT64(VDUSE_F_QUEUE_READY)));
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		i = req.vq_ready.num;
+		vq = dev->virtqueue[i];
+		if (!dev->notify_ops || !dev->notify_ops->vring_state_changed) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+					 "No ops->vring_state_changed");
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		ret = dev->notify_ops->vring_state_changed(dev->vid, i,
+				req.vq_ready.ready);
+		VHOST_CONFIG_LOG(dev->ifname, INFO,
+				"\t\t VQ %d gets ready %d ok %d", i,
+				req.vq_ready.ready, ret);
+		if (ret != 0) {
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		vq->enabled = req.vq_ready.ready;
+		resp.result = VDUSE_REQ_RESULT_OK;
+		break;
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
@@ -516,7 +561,8 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 	if ((old_status ^ dev->status) & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
 		if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
 			/* Poll virtqueues ready states before starting device */
-			ret = vduse_wait_for_virtqueues_ready(dev);
+			ret = dev->vduse_features & RTE_BIT64(VDUSE_F_QUEUE_READY) ? 0
+				: vduse_wait_for_virtqueues_ready(dev);
 			if (ret < 0) {
 				VHOST_CONFIG_LOG(dev->ifname, ERR,
 					"Failed to wait for virtqueues ready, aborting device start");
@@ -722,6 +768,27 @@ vduse_reconnect_start_device(struct virtio_net *dev)
 	return ret;
 }
 
+/* If some error occurs just continue as if the kernel exposed no features */
+static uint64_t
+vduse_device_get_vduse_features(int control_fd, const char *log_name)
+{
+	uint64_t vduse_kernel_features;
+	int ret;
+
+	ret = ioctl(control_fd, VDUSE_GET_FEATURES, &vduse_kernel_features);
+	if (ret < 0) {
+		VHOST_CONFIG_LOG(log_name, ERR,
+				 "Failed to get kernel VDUSE features: %d(%s)",
+				 errno, strerror(errno));
+		return 0;
+	}
+
+	VHOST_CONFIG_LOG(log_name, DEBUG,
+			"Setting vhost kernel features: %lx",
+			vduse_kernel_features & supported_vduse_features);
+	return vduse_kernel_features & supported_vduse_features;
+}
+
 int
 vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf)
 {
@@ -730,7 +797,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	struct virtio_net *dev;
 	struct virtio_net_config vnet_config = {{ 0 }};
 	uint64_t ver;
-	uint64_t features;
+	uint64_t features, vduse_features = 0;
 	const char *name = path + strlen("/dev/vduse/");
 	bool reconnect = false;
 
@@ -814,6 +881,11 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 			dev_config->ngroups = 2;
 			dev_config->nas = 2;
 		}
+
+		if (ver >= 2) {
+			vduse_features = vduse_device_get_vduse_features(control_fd, name);
+			dev_config->vduse_features = vduse_features;
+		}
 		dev_config->config_size = sizeof(struct virtio_net_config);
 		memcpy(dev_config->config, &vnet_config, sizeof(vnet_config));
 
@@ -864,6 +936,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	dev->vduse_ctrl_fd = control_fd;
 	dev->vduse_dev_fd = dev_fd;
 	dev->vduse_api_ver = ver;
+	dev->vduse_features = vduse_features;
 
 	ret = vduse_reconnect_log_map(dev, !reconnect);
 	if (ret < 0)
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 50b09da5ecf7..ce2e1a271c6f 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -533,6 +533,7 @@ struct __rte_cache_aligned virtio_net {
 	int			vduse_ctrl_fd;
 	int			vduse_dev_fd;
 	uint64_t		vduse_api_ver;
+	uint64_t		vduse_features;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.53.0

