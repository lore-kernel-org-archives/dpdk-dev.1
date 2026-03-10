Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B43FD4F16
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:18:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA6F340E3E;
	Tue, 10 Mar 2026 20:17:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5C8F740E1C
 for <dev@dpdk.org>; Tue, 10 Mar 2026 20:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773170244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmoIA9ffWPFVLbW1uL4ysz5e+B+vmTd+XyXMDdt/dxg=;
 b=FB2HtsjoYeWOTLKAtMRKmu45hYYKzybxHPhmxbtqtpvr544+4gJJBlKtB8gt3amksJO7Kb
 /jSW++7OMr9yBqRj+8BHj3YvpP3lLkuXpX36oXLnwUduMinq6orLIZciZ1uHIhMXCCUoL6
 JPdbsmgb2ZZuRYPMhqcRj1GE/fFBZQM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-pl9DdfJvNIyjqgBNTgPq6w-1; Tue,
 10 Mar 2026 15:17:23 -0400
X-MC-Unique: pl9DdfJvNIyjqgBNTgPq6w-1
X-Mimecast-MFC-AGG-ID: pl9DdfJvNIyjqgBNTgPq6w_1773170242
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4509C1955DD1; Tue, 10 Mar 2026 19:17:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CDB31955D71; Tue, 10 Mar 2026 19:17:19 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: david.marchand@redhat.com, mst@redhat.com, chenbox@nvidia.com,
 Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, dev@dpdk.org
Subject: [RFC v2 10/10] vhost: Support vduse suspend feature
Date: Tue, 10 Mar 2026 20:16:45 +0100
Message-ID: <20260310191645.1104892-11-eperezma@redhat.com>
In-Reply-To: <20260310191645.1104892-1-eperezma@redhat.com>
References: <20260310191645.1104892-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZAN6eI2ClgnmsSNv7NWNzIllgxLXnfjjMOOwlKgmMEo_1773170242
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
index f62cc3189076..10de13f05277 100644
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

