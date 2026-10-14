Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BECC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F5EE4069D;
	Wed, 14 Oct 2026 10:30:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0CDDE40693
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791966603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JL4wmXrfDozJsqbom3xMTu2a+o14txK7wcFyeG5s5ro=;
 b=dP5cAug4lMsE6ERy/5eyrPov+ua2aPiRm6Yi/Ltziq7ji0xLl34XcfUkvIkt9oI6LmR5Cr
 5xAJCu63r2WKJkTe98hS7qS4HJfqiy/dsS3KJ76FmXMtosUEem0hyHgNHikvwVdwRhh2zk
 gwrHu8BrupFBjoowAetKx/Cf1DJeCU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-gLyowZbTPl-L8LiE8EsnXg-1; Wed,
 14 Oct 2026 08:30:02 +0000
X-MC-Unique: gLyowZbTPl-L8LiE8EsnXg-1
X-Mimecast-MFC-AGG-ID: gLyowZbTPl-L8LiE8EsnXg_1791966601
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28908180057A; Wed, 14 Oct 2026 08:30:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.174])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 557E31800347; Wed, 14 Oct 2026 08:29:58 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 chenbox@nvidia.com, david.marchand@redhat.com
Subject: [PATCH v4 7/9] vhost: add net status feature to VDUSE
Date: Wed, 14 Oct 2026 10:29:28 +0200
Message-ID: <20261014082930.96261-8-eperezma@redhat.com>
In-Reply-To: <20261014082930.96261-1-eperezma@redhat.com>
References: <20261014082930.96261-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _0w1lZZL7pD3VOcqGIsVWynItzg3_o44u8GpqcQgyCU_1791966601
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

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 1 +
 lib/vhost/vduse.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 4950a5da01dd..b51776cf3ff4 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -820,6 +820,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
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
2.56.0

