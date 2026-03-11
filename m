Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DADBFD0636
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 06:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A33E840E45;
	Wed, 11 Mar 2026 07:56:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F77340E4F
 for <dev@dpdk.org>; Wed, 11 Mar 2026 07:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773212172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3IpC9XR7b/hOeVa4dSJzIBfxfc4ub4+4aA88Uh/Zf8=;
 b=B/LUphL7aHyVKKMr9SL+0/ajEXT3CsnkZNaJM12E2VTVRj2h94O38nj/GT2tr+kxV524Pm
 DqnkV7fs/kOKMmEtlQ1n6I62c/sL1LEZ71nRF+/YTsi1Tw5nKWuqVfJwbBfzNZu41sLu9q
 dQLl4xFx02cFrVEl4p7/9a4Yob5o6Tk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-kcro0MWYNHWk7fOGu7ke_g-1; Wed,
 11 Mar 2026 02:56:08 -0400
X-MC-Unique: kcro0MWYNHWk7fOGu7ke_g-1
X-Mimecast-MFC-AGG-ID: kcro0MWYNHWk7fOGu7ke_g_1773212167
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C18A18002CD; Wed, 11 Mar 2026 06:56:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.190])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC7BB19560A6; Wed, 11 Mar 2026 06:56:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: chenbox@nvidia.com, jasowang@redhat.com, david.marchand@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com
Subject: [RFC v3 06/10] vhost: claim VDUSE support for API version 1
Date: Wed, 11 Mar 2026 07:55:39 +0100
Message-ID: <20260311065543.1354037-7-eperezma@redhat.com>
In-Reply-To: <20260311065543.1354037-1-eperezma@redhat.com>
References: <20260311065543.1354037-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jfjI_fFktOGyKfxuaUOx9x91nkk70zVXkErzoL26yb0_1773212167
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

