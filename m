Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B4CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:49:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A2240A75;
	Mon, 19 Oct 2026 15:48:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C54EB406BB
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792417728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WguD4JUzn/1HwGHba9oaueY3eavWyhJFJkN0zwaUVx0=;
 b=AiL5WHE54siXYMmgysH1pyhNARUIqAkrZK84W6USAb2/WnuHrJL3tMxHJMze54fXxr57RM
 Vn7OQct5MCKgFzWSn7oNP4/jHkQ4df4J24zYgyaUzMSlSG9bF5y9LX5cz524048i/DXXOO
 S/E7NvpUNTC7oRdIUs54wdf/OmQmd8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-D_7fzaK_NVyP9K9-D4coAw-1; Mon,
 19 Oct 2026 13:48:45 +0000
X-MC-Unique: D_7fzaK_NVyP9K9-D4coAw-1
X-Mimecast-MFC-AGG-ID: D_7fzaK_NVyP9K9-D4coAw_1792417723
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABD8E195419A; Mon, 19 Oct 2026 13:48:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56B241803A40; Mon, 19 Oct 2026 13:48:40 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com,
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 7/9] vhost: add net status feature to VDUSE
Date: Mon, 19 Oct 2026 15:48:06 +0200
Message-ID: <20261019134808.192525-8-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-1-eperezma@redhat.com>
References: <20261019134808.192525-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jvEfyEYjvkROLzK0iXOi9vEfVSZCi7GshhXYS_L09kQ_1792417723
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
index daa41ee42761..02ea64ce0cbb 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -844,6 +844,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
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

