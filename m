Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBFECD6C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D77040A80;
	Wed, 11 Feb 2026 17:15:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E3D6F40A67
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3IpC9XR7b/hOeVa4dSJzIBfxfc4ub4+4aA88Uh/Zf8=;
 b=db9gY/oRhszwPsBrjv2WUvUfcIA8edI/29szt2tuNKrZN6F7vGg5TaDCRYdhq8aD5c5zVd
 f5HkE9RU/PTSDSCXax1ea8ujkveW/ACWw8tucK/Z7Nkp0JA16ZEcnxuUhr4zqGoIYiZqeg
 qLWTu7NxohhURTXchVrX86veE2CGNjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-z62EsfCsMEmd7S6jIf2F-g-1; Wed,
 11 Feb 2026 11:15:21 -0500
X-MC-Unique: z62EsfCsMEmd7S6jIf2F-g-1
X-Mimecast-MFC-AGG-ID: z62EsfCsMEmd7S6jIf2F-g_1770826520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DD391800464; Wed, 11 Feb 2026 16:15:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D40BB1800464; Wed, 11 Feb 2026 16:15:17 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, david.marchand@redhat.com, mst@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com
Subject: [RFC 06/10] vhost: claim VDUSE support for API version 1
Date: Wed, 11 Feb 2026 17:14:53 +0100
Message-ID: <20260211161457.2703686-7-eperezma@redhat.com>
In-Reply-To: <20260211161457.2703686-1-eperezma@redhat.com>
References: <20260211161457.2703686-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5lVR5iuJHcv7Le675PYU6iVt-qlNvF2JjRJB_yLf1Ro_1770826520
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

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 4e1920f9441e..80020d3d5413 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -25,7 +25,7 @@
 #include "vhost.h"
 #include "virtio_net_ctrl.h"
 
-#define VHOST_VDUSE_API_VERSION 0ULL
+#define VHOST_VDUSE_API_VERSION 1ULL
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
 
 struct vduse {
-- 
2.53.0

