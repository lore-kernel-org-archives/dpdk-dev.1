Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C2FD4F19
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0F2406FF;
	Tue, 10 Mar 2026 20:17:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DBE7240E34
 for <dev@dpdk.org>; Tue, 10 Mar 2026 20:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773170235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07dOCpVM2ah8ECixJONDsQjlawNkTVNqIprcTlkvnmU=;
 b=Z0SMYGyQtKc0D1Spt+kXCyjNKLvvYAD5/3Z2nJRPfVpd27makAkrkFKDxqVQZeX6uaGHQw
 4b0wx9SrOaRte4MtQpZpErCv4gYkenV2hc8UpQKRwhrJQn39xmzAuM1KBB9MVdNOzOviox
 hjPzm0d3ogjw1ukQpizgL4vUmIVm5Cs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-5CODTPC7OhuR1ydOANFSew-1; Tue,
 10 Mar 2026 15:17:13 -0400
X-MC-Unique: 5CODTPC7OhuR1ydOANFSew-1
X-Mimecast-MFC-AGG-ID: 5CODTPC7OhuR1ydOANFSew_1773170233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E612819560A3; Tue, 10 Mar 2026 19:17:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85C7C1954111; Tue, 10 Mar 2026 19:17:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: david.marchand@redhat.com, mst@redhat.com, chenbox@nvidia.com,
 Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, dev@dpdk.org
Subject: [RFC v2 07/10] vhost: add net status feature to VDUSE
Date: Tue, 10 Mar 2026 20:16:42 +0100
Message-ID: <20260310191645.1104892-8-eperezma@redhat.com>
In-Reply-To: <20260310191645.1104892-1-eperezma@redhat.com>
References: <20260310191645.1104892-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pQsawmAvuOKfsMc0snk1TU6JXw-MkluhOJIgUn0Kq4s_1773170233
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
v2:
* Move the start and last declarations in the braces as gcc 8 does not
  like them interleaved with statements. Actually, I think the move was
  a mistake in the first version.
  https://mails.dpdk.org/archives/test-report/2026-February/958175.html
---
 lib/vhost/vduse.c | 1 +
 lib/vhost/vduse.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 80020d3d5413..54fe6cf35bc6 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -801,6 +801,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
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

