Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60AC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBD9C42F89;
	Thu, 24 Sep 2026 12:15:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E572A42FA3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790244938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIlNUwcK0NN/Ys6uReZb+IG8EJDCdWgE4K2onuya5Hw=;
 b=F7DDyPYSF41780GMOu7+Mt5hCuokEO81+7im3ATtw8m2z8UCXSi4AA4mSnmx7Y4rkYbIPV
 aAuqxzRcC+xFdWyOzRbmkYy85njxt+4Od0OlnOxLnIgNzJUif+AO111A1fePBDBmLkj11H
 bpbuKUX6ybanSA6skeotv/M6FJZTN+A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-p1_Q1qUiNAS26OwNJ5A9FQ-1; Thu,
 24 Sep 2026 06:15:37 -0400
X-MC-Unique: p1_Q1qUiNAS26OwNJ5A9FQ-1
X-Mimecast-MFC-AGG-ID: p1_Q1qUiNAS26OwNJ5A9FQ_1790244936
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB1181955F12; Thu, 24 Sep 2026 10:15:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90C5B18005B5; Thu, 24 Sep 2026 10:15:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, Yongji Xie <xieyongji@bytedance.com>,
 mst@redhat.com, jasowangio@gmail.com, david.marchand@redhat.com
Subject: [PATCH 8/9] vhost: Support VDUSE QUEUE_READY feature
Date: Thu, 24 Sep 2026 12:15:03 +0200
Message-ID: <20260924101504.810315-9-eperezma@redhat.com>
In-Reply-To: <20260924101504.810315-1-eperezma@redhat.com>
References: <20260924101504.810315-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V4qtspT6gdh2JZobn4ebdoI2gJwh_hmXQNYOVrC3mao_1790244936
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

Add support for the VDUSE_F_QUEUE_READY feature.

In VDUSE, the dataplane is enabled only after control virtqueue so the
device is fully configured in the destination of a live migration before
the dataplane starts.  This message signals the VDUSE device when the
dataplane queues should be enabled.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
 lib/vhost/vhost.h |  1 +
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 9a7db29b4a98..8f45e905b4b4 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
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
@@ -519,6 +522,51 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
+		if (!(dev->vduse_features & RTE_BIT64(VDUSE_F_QUEUE_READY))) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Unexpected ready message with no ready feature acked");
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		i = req.vq_ready.num;
+		if (i >= dev->nr_vring) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"Invalid virtqueue index: %u", i);
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		vq = dev->virtqueue[i];
+		if (dev->notify_ops == NULL || dev->notify_ops->vring_state_changed == NULL) {
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
@@ -536,7 +584,8 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 	if ((old_status ^ dev->status) & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
 		if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
 			/* Poll virtqueues ready states before starting device */
-			ret = vduse_wait_for_virtqueues_ready(dev);
+			ret = dev->vduse_features & RTE_BIT64(VDUSE_F_QUEUE_READY) ? 0
+				: vduse_wait_for_virtqueues_ready(dev);
 			if (ret < 0) {
 				VHOST_CONFIG_LOG(dev->ifname, ERR,
 					"Failed to wait for virtqueues ready, aborting device start");
@@ -742,6 +791,26 @@ vduse_reconnect_start_device(struct virtio_net *dev)
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
+		VHOST_CONFIG_LOG(log_name, INFO,
+			"Failed to get kernel VDUSE features, assuming not supported: %d(%s)",
+			errno, strerror(errno));
+		return 0;
+	}
+
+	VHOST_CONFIG_LOG(log_name, DEBUG, "Setting vhost kernel features: %"PRIx64,
+			vduse_kernel_features & supported_vduse_features);
+	return vduse_kernel_features & supported_vduse_features;
+}
+
 int
 vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf)
 {
@@ -750,7 +819,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	struct virtio_net *dev;
 	struct virtio_net_config vnet_config = {{ 0 }};
 	uint64_t ver;
-	uint64_t features;
+	uint64_t features, vduse_features = 0;
 	const char *name = path + strlen("/dev/vduse/");
 	bool reconnect = false;
 
@@ -834,6 +903,18 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 			dev_config->ngroups = 2;
 			dev_config->nas = 2;
 		}
+
+		vduse_features = vduse_device_get_vduse_features(control_fd, name);
+		if (vduse_features) {
+			ret = ioctl(control_fd, VDUSE_SET_FEATURES, &vduse_features);
+			if (ret < 0) {
+				VHOST_CONFIG_LOG(name, ERR, "Failed to set VDUSE features: %s",
+						strerror(errno));
+				free(dev_config);
+				goto out_ctrl_close;
+			}
+		}
+
 		dev_config->config_size = sizeof(struct virtio_net_config);
 		memcpy(dev_config->config, &vnet_config, sizeof(vnet_config));
 
@@ -884,6 +965,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	dev->vduse_ctrl_fd = control_fd;
 	dev->vduse_dev_fd = dev_fd;
 	dev->vduse_api_ver = ver;
+	dev->vduse_features = vduse_features;
 
 	ret = vduse_reconnect_log_map(dev, !reconnect);
 	if (ret < 0)
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 5cbd64d539b9..c2b645c2d4b0 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -533,6 +533,7 @@ struct __rte_cache_aligned virtio_net {
 	int			vduse_ctrl_fd;
 	int			vduse_dev_fd;
 	uint64_t		vduse_api_ver;
+	uint64_t		vduse_features;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.55.0

