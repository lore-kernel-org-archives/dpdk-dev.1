Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D6C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 12:34:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF1FD40E24;
	Wed, 16 Apr 2025 14:34:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 840BB40E1C
 for <dev@dpdk.org>; Wed, 16 Apr 2025 14:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744806881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKzoqZOuJyeY8cwxxPUSbKFY6MKja5JtGlYZk2PC9jU=;
 b=YTtw8Akr6HeI73TA99yXxslsOMLHXTeQmMBbAHI4VXtomOxwN73WxmmFZtV/1pXdlk5Ge4
 /MY8ZjzG5ZiS8TWJwW12lBdXLtGdu/QgTG5qAsokdimpUbF3Lb+JV6Mdia6djQVSuN7ktb
 Q9ZnB3UCMbc5N231Bo+LDJkeMtOvlW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-EhOLb89-P-KrAo7N5ihW1w-1; Wed,
 16 Apr 2025 08:34:40 -0400
X-MC-Unique: EhOLb89-P-KrAo7N5ihW1w-1
X-Mimecast-MFC-AGG-ID: EhOLb89-P-KrAo7N5ihW1w_1744806879
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D6CF1800446; Wed, 16 Apr 2025 12:34:39 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02B661800362; Wed, 16 Apr 2025 12:34:37 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	thomas@monjalon.net
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 3/4] vhost: use imported VDUSE uAPI header
Date: Wed, 16 Apr 2025 14:34:25 +0200
Message-ID: <20250416123426.2638250-4-maxime.coquelin@redhat.com>
In-Reply-To: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
References: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFz2mavgRdvp7sdQ2Z1fWkbNsF36uED9H0tEupljQc4_1744806879
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

This patch makes use of the imported VDUSE uAPI header, and
remove VDUSE build dependency on the presence of the VDUSE
header on the system.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/meson.build |  5 +----
 lib/vhost/vduse.c     |  2 +-
 lib/vhost/vduse.h     | 22 ----------------------
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 33773b6d21..9c6325aa0e 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -33,16 +33,13 @@ sources = files(
         'iotlb.c',
         'socket.c',
         'vdpa.c',
+        'vduse.c',
         'vhost.c',
         'vhost_crypto.c',
         'vhost_user.c',
         'virtio_net.c',
         'virtio_net_ctrl.c',
 )
-if cc.has_header('linux/vduse.h')
-    sources += files('vduse.c')
-    cflags += '-DVHOST_HAS_VDUSE'
-endif
 headers = files(
         'rte_vdpa.h',
         'rte_vhost.h',
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 801674be42..a2a7d73388 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -8,7 +8,7 @@
 #include <fcntl.h>
 
 
-#include <linux/vduse.h>
+#include <uapi/linux/vduse.h>
 #include <linux/virtio_net.h>
 
 #include <sys/ioctl.h>
diff --git a/lib/vhost/vduse.h b/lib/vhost/vduse.h
index 0d8f3f1205..47ca97a064 100644
--- a/lib/vhost/vduse.h
+++ b/lib/vhost/vduse.h
@@ -9,29 +9,7 @@
 
 #define VDUSE_NET_SUPPORTED_FEATURES VIRTIO_NET_SUPPORTED_FEATURES
 
-#ifdef VHOST_HAS_VDUSE
-
 int vduse_device_create(const char *path, bool compliant_ol_flags);
 int vduse_device_destroy(const char *path);
 
-#else
-
-static inline int
-vduse_device_create(const char *path, bool compliant_ol_flags)
-{
-	RTE_SET_USED(compliant_ol_flags);
-
-	VHOST_CONFIG_LOG(path, ERR, "VDUSE support disabled at build time");
-	return -1;
-}
-
-static inline int
-vduse_device_destroy(const char *path)
-{
-	VHOST_CONFIG_LOG(path, ERR, "VDUSE support disabled at build time");
-	return -1;
-}
-
-#endif /* VHOST_HAS_VDUSE */
-
 #endif /* _VDUSE_H */
-- 
2.49.0

