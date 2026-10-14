Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C00CC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:30:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 572594060C;
	Wed, 14 Oct 2026 10:30:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 06A84406B4
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791966612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19HlDYdgRzTZu1seCtZln/ZiPokAQ8lqjWKQWLd/Fwg=;
 b=H9JcRmr5dMLQG01qF6gE96ONPDz5RkZIqYXrxfFm3kTE//5+dU+AnVs1DH1wufkslup+R+
 HvkBcnRVvcQ/JkUXpIkggt4mWI/R6uqTKybSYUsxAyxs+1jEsNzgGyUljJU2kow7x3w4yW
 h/zuqM+UC71JqcWzqaNKB42Qxx+M8M0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-aOdsERwpNSGwUlhEa_ZXpw-1; Wed,
 14 Oct 2026 08:30:09 +0000
X-MC-Unique: aOdsERwpNSGwUlhEa_ZXpw-1
X-Mimecast-MFC-AGG-ID: aOdsERwpNSGwUlhEa_ZXpw_1791966607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCBCB19560AD; Wed, 14 Oct 2026 08:30:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.174])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5A6C1800347; Wed, 14 Oct 2026 08:30:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 chenbox@nvidia.com, david.marchand@redhat.com
Subject: [PATCH v4 9/9] vhost: Support vduse suspend feature
Date: Wed, 14 Oct 2026 10:29:30 +0200
Message-ID: <20261014082930.96261-10-eperezma@redhat.com>
In-Reply-To: <20261014082930.96261-1-eperezma@redhat.com>
References: <20261014082930.96261-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -JwCXwkBiu_aLvk1a8sq69GCeBy9Y9cC8FTYful3C9w_1791966607
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
v4: Add VDUSE_SUSPEND to lib/vhost/vduse.c:vduse_reqs_str
---
 lib/vhost/vduse.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 lib/vhost/vhost.h |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index bcbd9fcd6d52..321f15091f65 100644
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
@@ -537,6 +540,12 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
@@ -567,11 +576,43 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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
+
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
 	}
 
+out:
 	resp.request_id = req.request_id;
 
 	ret = write(dev->vduse_dev_fd, &resp, sizeof(resp));
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 4958932923d7..b16b8efe0625 100644
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

