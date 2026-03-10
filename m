Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74453FD4F19
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14CA640E2E;
	Tue, 10 Mar 2026 20:17:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA32840E2E
 for <dev@dpdk.org>; Tue, 10 Mar 2026 20:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773170224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHmI/tLCo3pa+yy+jscLQeitRQNnATVc7oGocjdiHpQ=;
 b=P+rW4x2U+QZy1eW18QbaHq2Hyms4WatxKZ90T+H9Apijn981z7plfS3a84IgpgPzRkDT1d
 sF58MEJ+ryrZuy9ZBHegJEsmfJp2kIfbh2wPgILplcd7IvqR/VG+eU1D2CetP8pvAUCD45
 W9uAMzz/MVxgos79ImodrgFIyekExqo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-QW9lNThHPbeBh1g2xH2xng-1; Tue,
 10 Mar 2026 15:17:01 -0400
X-MC-Unique: QW9lNThHPbeBh1g2xH2xng-1
X-Mimecast-MFC-AGG-ID: QW9lNThHPbeBh1g2xH2xng_1773170220
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7FA1800371; Tue, 10 Mar 2026 19:17:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88D051956095; Tue, 10 Mar 2026 19:16:57 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: david.marchand@redhat.com, mst@redhat.com, chenbox@nvidia.com,
 Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, dev@dpdk.org
Subject: [RFC v2 03/10] vhost: add VDUSE API version negotiation
Date: Tue, 10 Mar 2026 20:16:38 +0100
Message-ID: <20260310191645.1104892-4-eperezma@redhat.com>
In-Reply-To: <20260310191645.1104892-1-eperezma@redhat.com>
References: <20260310191645.1104892-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: whLVsAPmVEm62RqBmM_h3kO_xzMpw-5rv9bNh0qlaNg_1773170220
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

