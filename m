Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9757ECD6C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFCA40A67;
	Wed, 11 Feb 2026 17:15:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A32B40A7F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omCLfhgSx1gSyf2Igs4SOsR3QZUF8aGPAJqCsoKjdCc=;
 b=UhTe6ntUyu05bXox2CU29LHudNwdFe7kSuPoDjrzw4OSwmh//AUAXnCvPp1DqlFAXLWjHK
 GSD4dGq6A6DQ0jraopuslZdK7OVX1kN75uf8+fGFqgCCjtwXxHp+dyUxEJczSqDgZSwLbl
 eW8U2ywGHPwPPit46QVMcjv8Vd1NklE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-Guv8XaB_OXaLXO0uYi56iQ-1; Wed,
 11 Feb 2026 11:15:24 -0500
X-MC-Unique: Guv8XaB_OXaLXO0uYi56iQ-1
X-Mimecast-MFC-AGG-ID: Guv8XaB_OXaLXO0uYi56iQ_1770826523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9013119560A7; Wed, 11 Feb 2026 16:15:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04A981800464; Wed, 11 Feb 2026 16:15:20 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, david.marchand@redhat.com, mst@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com
Subject: [RFC 07/10] vhost: add net status feature to VDUSE
Date: Wed, 11 Feb 2026 17:14:54 +0100
Message-ID: <20260211161457.2703686-8-eperezma@redhat.com>
In-Reply-To: <20260211161457.2703686-1-eperezma@redhat.com>
References: <20260211161457.2703686-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T1U2JOfffOC2OOX7aVG_7Q0N5A81YR3QTjo9uufsYus_1770826523
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Enable the VIRTIO_NET_F_STATUS feature for VDUSE devices.
This allows the device to report link status (e.g.,
VIRTIO_NET_S_LINK_UP). It also allows the device to signal the driver
that it needs to send gratuitous ARP with VIRTIO_NET_S_ANNOUNCE.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 32 ++++++++++++++++----------------
 lib/vhost/vduse.h |  3 ++-
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 80020d3d5413..04f397bac8b5 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -460,24 +460,23 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	case VDUSE_UPDATE_IOTLB:
-		{
-			uint64_t start, last;
-			uint32_t asid;
-
-			if (dev->vduse_api_ver < 1) {
-				start = req.iova.start;
-				last = req.iova.last;
-				asid = 0;
-			} else {
-				start = req.iova_v2.start;
-				last = req.iova_v2.last;
-				asid = req.iova_v2.asid;
-			}
+		uint64_t start, last;
+		uint32_t asid;
 
-			VHOST_CONFIG_LOG(dev->ifname, INFO, "\t(ASID %d) IOVA range: %" PRIx64 " - %" PRIx64,
-				asid, start, last);
-			vhost_user_iotlb_cache_remove(dev, asid, start, last - start + 1);
+		if (dev->vduse_api_ver < 1) {
+			start = req.iova.start;
+			last = req.iova.last;
+			asid = 0;
+		} else {
+			start = req.iova_v2.start;
+			last = req.iova_v2.last;
+			asid = req.iova_v2.asid;
 		}
+
+		VHOST_CONFIG_LOG(dev->ifname, INFO, "\t(ASID %d) IOVA range: %" PRIx64 " - %" PRIx64,
+			asid, start, last);
+		vhost_user_iotlb_cache_remove(dev, asid, start, last - start + 1);
+
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	case VDUSE_SET_VQ_GROUP_ASID:
@@ -801,6 +800,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 			goto out_ctrl_close;
 		}
 
+		vnet_config.status = VIRTIO_NET_S_LINK_UP;
 		vnet_config.max_virtqueue_pairs = max_queue_pairs;
 		memset(dev_config, 0, sizeof(struct vduse_dev_config));
 
diff --git a/lib/vhost/vduse.h b/lib/vhost/vduse.h
index b2515bb9df76..d697f85be5cc 100644
--- a/lib/vhost/vduse.h
+++ b/lib/vhost/vduse.h
@@ -7,7 +7,8 @@
 
 #include "vhost.h"
 
-#define VDUSE_NET_SUPPORTED_FEATURES VIRTIO_NET_SUPPORTED_FEATURES
+#define VDUSE_NET_SUPPORTED_FEATURES (VIRTIO_NET_SUPPORTED_FEATURES | \
+		(1ULL << VIRTIO_NET_F_STATUS))
 
 int vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf);
 int vduse_device_destroy(const char *path);
-- 
2.53.0

