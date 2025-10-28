Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBFCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 12:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817BE40612;
	Tue, 28 Oct 2025 13:35:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D81D9402D7
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:35:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761654904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bYKJYpIqh+sufAKUJaQqejLDWZX+Ick9E9nrP1n4cYk=;
 b=QuCROoOeRLX6ze6iDRfyh0sdP0rgxJUVCeMngWGLDYw/3cp/0qWvJ29b7nfRJA5usKjiHu
 qqvUy9xMCGnU70JqVRXKiuVubXhh36FdSwcHyiRer+ypSDo6HlXPC+kWyQQtYXQxsZ2Ro9
 hHD7cUcae+0T2xXcjKNd/Wwa+f1j3bw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-MyLGEwqzN9iI1DYGimZzPQ-1; Tue,
 28 Oct 2025 08:35:01 -0400
X-MC-Unique: MyLGEwqzN9iI1DYGimZzPQ-1
X-Mimecast-MFC-AGG-ID: MyLGEwqzN9iI1DYGimZzPQ_1761654900
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A1A18001E2; Tue, 28 Oct 2025 12:35:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDFBE1800451; Tue, 28 Oct 2025 12:34:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jmeng@redhat.com, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] vhost: fix external buffer in VDUSE
Date: Tue, 28 Oct 2025 13:34:53 +0100
Message-ID: <20251028123453.4127525-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bRadeavx0BJyI-GzDZVqyy69jJtDDXMCb71kwYWwd4c_1761654900
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

extbuf and linearbuf features are required for (enhanced) TSO support
in OVS.

VDUSE ports were generating multi-segments mbufs in case of "TSO"
buffers which resulted in OVS generating wrong packets after tunnel
encapsulation.

Enable the missing datapath features.

Fixes: 0adb8eccc6a6 ("vhost: add VDUSE device creation and destruction")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/socket.c | 3 ++-
 lib/vhost/vduse.c  | 8 +++++++-
 lib/vhost/vduse.h  | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..ae95e7e6b0 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -1194,7 +1194,8 @@ rte_vhost_driver_start(const char *path)
 		return -1;
 
 	if (vsocket->is_vduse)
-		return vduse_device_create(path, vsocket->net_compliant_ol_flags);
+		return vduse_device_create(path, vsocket->net_compliant_ol_flags,
+			vsocket->extbuf, vsocket->linearbuf);
 
 	if (vhost_user.fdset == NULL) {
 		vhost_user.fdset = fdset_init("vhost-evt");
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 68e56843fd..897dee9f1b 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -672,7 +672,7 @@ vduse_reconnect_start_device(struct virtio_net *dev)
 }
 
 int
-vduse_device_create(const char *path, bool compliant_ol_flags)
+vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf)
 {
 	int control_fd, dev_fd, vid, ret;
 	uint32_t i, max_queue_pairs, total_queues;
@@ -817,6 +817,12 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 
 	vhost_setup_virtio_net(dev->vid, true, compliant_ol_flags, true, true);
 
+	if (extbuf)
+		vhost_enable_extbuf(dev->vid);
+
+	if (linearbuf)
+		vhost_enable_linearbuf(dev->vid);
+
 	for (i = 0; i < total_queues; i++) {
 		struct vduse_vq_config vq_cfg = { 0 };
 		struct vhost_virtqueue *vq;
diff --git a/lib/vhost/vduse.h b/lib/vhost/vduse.h
index 47ca97a064..b2515bb9df 100644
--- a/lib/vhost/vduse.h
+++ b/lib/vhost/vduse.h
@@ -9,7 +9,7 @@
 
 #define VDUSE_NET_SUPPORTED_FEATURES VIRTIO_NET_SUPPORTED_FEATURES
 
-int vduse_device_create(const char *path, bool compliant_ol_flags);
+int vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf);
 int vduse_device_destroy(const char *path);
 
 #endif /* _VDUSE_H */
-- 
2.51.0

