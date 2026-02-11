Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E530ECD6C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F0D7406BC;
	Wed, 11 Feb 2026 17:15:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7123E40698
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHmI/tLCo3pa+yy+jscLQeitRQNnATVc7oGocjdiHpQ=;
 b=UeBmXe4ASaHFUEg0ln5EIQfoL7CEfbwl7ai3mszXVdhoL4/Z1MjZ7/uUArX0ruVgcnS/w/
 kbKLW/wlBe+J24ERCJZbyjcE36mA4pYArJD5eWDe6BlyrxUlP63REbt9x6v2+IWPsdLxLJ
 3V2gDiqDwEz7wsnqEjt67n2DtDjGAUY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-2E8L2-GzNxC6YcGQiHSNIQ-1; Wed,
 11 Feb 2026 11:15:12 -0500
X-MC-Unique: 2E8L2-GzNxC6YcGQiHSNIQ-1
X-Mimecast-MFC-AGG-ID: 2E8L2-GzNxC6YcGQiHSNIQ_1770826511
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619D0180025F; Wed, 11 Feb 2026 16:15:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F010018004AD; Wed, 11 Feb 2026 16:15:08 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, david.marchand@redhat.com, mst@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com
Subject: [RFC 03/10] vhost: add VDUSE API version negotiation
Date: Wed, 11 Feb 2026 17:14:50 +0100
Message-ID: <20260211161457.2703686-4-eperezma@redhat.com>
In-Reply-To: <20260211161457.2703686-1-eperezma@redhat.com>
References: <20260211161457.2703686-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BnYgYnt3C4ajGkX2vzvoCO2lnqp95CIMioA5_e1X1f8_1770826511
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

As preliminary step to support new VDUSE API version
introducing ASID support, this patch adds API version
negotiation to keep compatibility with older kernels.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 14 ++++++++++++--
 lib/vhost/vhost.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 49f2f23b9703..fc52b4cd0703 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -25,7 +25,7 @@
 #include "vhost.h"
 #include "virtio_net_ctrl.h"
 
-#define VHOST_VDUSE_API_VERSION 0
+#define VHOST_VDUSE_API_VERSION 0ULL
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
 
 struct vduse {
@@ -680,7 +680,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	uint32_t i, max_queue_pairs, total_queues;
 	struct virtio_net *dev;
 	struct virtio_net_config vnet_config = {{ 0 }};
-	uint64_t ver = VHOST_VDUSE_API_VERSION;
+	uint64_t ver;
 	uint64_t features;
 	const char *name = path + strlen("/dev/vduse/");
 	bool reconnect = false;
@@ -700,6 +700,15 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 		return -1;
 	}
 
+	if (ioctl(control_fd, VDUSE_GET_API_VERSION, &ver)) {
+		VHOST_CONFIG_LOG(name, ERR, "Failed to get API version: %s", strerror(errno));
+		ret = -1;
+		goto out_ctrl_close;
+	}
+
+	ver = RTE_MIN(ver, VHOST_VDUSE_API_VERSION);
+	VHOST_CONFIG_LOG(name, INFO, "Using VDUSE API version %" PRIu64 "", ver);
+
 	if (ioctl(control_fd, VDUSE_SET_API_VERSION, &ver)) {
 		VHOST_CONFIG_LOG(name, ERR, "Failed to set API version: %" PRIu64 ": %s",
 				ver, strerror(errno));
@@ -800,6 +809,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	strncpy(dev->ifname, path, IF_NAME_SZ - 1);
 	dev->vduse_ctrl_fd = control_fd;
 	dev->vduse_dev_fd = dev_fd;
+	dev->vduse_api_ver = ver;
 
 	ret = vduse_reconnect_log_map(dev, !reconnect);
 	if (ret < 0)
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index fef493016df5..50b09da5ecf7 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -532,6 +532,7 @@ struct __rte_cache_aligned virtio_net {
 	int			postcopy_listening;
 	int			vduse_ctrl_fd;
 	int			vduse_dev_fd;
+	uint64_t		vduse_api_ver;
 
 	struct vhost_virtqueue	*cvq;
 
-- 
2.53.0

